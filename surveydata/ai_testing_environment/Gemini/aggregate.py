import glob

import pandas as pd


def main():
    # 1. Load Data
    survey = pd.read_csv("SurveyData.csv")
    gb = pd.concat([pd.read_csv(f) for f in glob.glob("CSC-*.csv")], ignore_index=True)

    # 2. Process Survey Sections to match Gradebook formatting (e.g., "CSC 145" -> "CSC-145")
    survey["Original_Section"] = survey["Section"]
    survey["Section"] = (
        survey["Section"].str.extract(r"(CSC \d+)")[0].str.replace(" ", "-")
    )

    # 3. Handle Survey Duplicates (coalesce to the most recent submission)
    survey["Completion_time_dt"] = pd.to_datetime(survey["Completion_time"])
    survey = survey.sort_values("Completion_time_dt")

    # Capture survey duplicates for the issues log
    dupes = survey[survey.duplicated(subset=["ID", "Section"], keep=False)].copy()
    dupes["Issue_Type"] = "Survey Duplicate"

    # Remove duplicates, keeping the most recent
    survey_coalesced = survey.drop_duplicates(
        subset=["ID", "Section"], keep="last"
    ).copy()
    survey_coalesced.drop(columns=["Completion_time_dt"], inplace=True)

    # 4. Handle Specific Gradebook Mistakes
    # (gb_id, gb_sec) -> (sv_id, sv_sec)
    mistakes_mapping = [
        {"gb_id": "BENKL", "gb_sec": "CSC-144", "sv_id": "BETKL", "sv_sec": "CSC-144"},
        {"gb_id": "NANMO", "gb_sec": "CSC-144", "sv_id": "NALMO", "sv_sec": "CSC-144"},
        {"gb_id": "BENKL", "gb_sec": "CSC-145", "sv_id": "BETKL", "sv_sec": "CSC-145"},
        {"gb_id": "JOYST", "gb_sec": "CSC-145", "sv_id": "JONST", "sv_sec": "CSC-145"},
        {
            "gb_id": "BRNO'",
            "gb_sec": "CSC-261",
            "sv_id": "BRNON",
            "sv_sec": "CSC-145",
        },  # Section also changes here
        {"gb_id": "JOENO", "gb_sec": "CSC-261", "sv_id": "JOHNO", "sv_sec": "CSC-261"},
    ]

    mistakes_gb_list = []

    # Loop through list and apply corrections to the gradebook DataFrame
    for m in mistakes_mapping:
        mask = (gb["ID"] == m["gb_id"]) & (gb["Section"] == m["gb_sec"])
        mistake_rows = gb[mask].copy()

        if not mistake_rows.empty:
            # Save a copy of the mistake row for the Issues Log
            mistake_rows["Issue_Type"] = "Gradebook Mistake (Original)"
            mistakes_gb_list.append(mistake_rows)

            # Apply the fix directly to the Gradebook
            gb.loc[mask, "ID"] = m["sv_id"]
            gb.loc[mask, "Section"] = m["sv_sec"]

    # Combine captured mistakes into a single DataFrame
    mistakes_gb = (
        pd.concat(mistakes_gb_list, ignore_index=True)
        if mistakes_gb_list
        else pd.DataFrame()
    )

    # 5. Merge Data
    merged = pd.merge(
        survey_coalesced, gb, on=["ID", "Section"], how="outer", indicator=True
    )

    # --- CREATE AGGREGATED DATA CSV ---
    # Keep matches and survey rows that didn't find a corresponding gradebook row
    aggregated_data = merged[merged["_merge"].isin(["both", "left_only"])].drop(
        columns=["_merge"]
    )
    aggregated_data.to_csv("Aggregated_Data.csv", index=False)
    print("Successfully updated Aggregated_Data.csv")

    # --- CREATE ISSUES LOG CSV ---
    # Unmatched Survey
    survey_no_gb = merged[merged["_merge"] == "left_only"].copy()
    survey_no_gb["Issue_Type"] = "Survey w/o Gradebook"
    survey_no_gb = survey_no_gb.drop(columns=["_merge"])

    # Unmatched Gradebook
    gb_no_survey = merged[merged["_merge"] == "right_only"].copy()
    gb_no_survey["Issue_Type"] = "Gradebook w/o Survey"
    gb_no_survey = gb_no_survey.drop(columns=["_merge"])

    # Combine all issues into one DataFrame
    issues_list = [dupes.drop(columns=["Completion_time_dt"])]
    if not mistakes_gb.empty:
        issues_list.append(mistakes_gb)
    issues_list.extend([survey_no_gb, gb_no_survey])

    issues_df = pd.concat(issues_list, ignore_index=True)

    # Reorder columns to put Issue_Type, ID, and Section up front
    cols = ["Issue_Type", "ID", "Section"] + [
        c for c in issues_df.columns if c not in ["Issue_Type", "ID", "Section"]
    ]
    issues_df = issues_df[cols]

    issues_df.to_csv("Issues_Log.csv", index=False)
    print("Successfully updated Issues_Log.csv")


if __name__ == "__main__":
    main()
