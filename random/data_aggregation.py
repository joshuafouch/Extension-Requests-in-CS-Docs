########### This script was used to aggregate specific course gradebooks with the survey data ###########
########### PYTHON DATA AGGREGATION ############

import os

import pandas as pd


def merge_gradebook_and_survey(gradebook_file, survey_file):
    # Load CSVs
    gradebook = pd.read_csv(gradebook_file)
    survey = pd.read_csv(survey_file)

    # Identify ID columns
    id_col_gradebook = next(
        (col for col in gradebook.columns if "id" in col.lower()), None
    )
    id_col_survey = next((col for col in survey.columns if "id" in col.lower()), None)

    if not id_col_gradebook or not id_col_survey:
        raise ValueError("Couldn't find an ID column in one of the CSVs.")

    # Convert IDs to string and clean
    gradebook[id_col_gradebook] = gradebook[id_col_gradebook].astype(str).str.strip()
    survey[id_col_survey] = survey[id_col_survey].astype(str).str.strip()

    # Drop the "Points Possible" row and fake IDs
    gradebook = gradebook[
        (gradebook[id_col_gradebook].str.lower() != "points possible")
        & (~gradebook[id_col_gradebook].str.lower().isin(["xxxxx", "xxxxx"]))
    ]

    # Merge only matching IDs (inner join)
    merged = pd.merge(
        survey,
        gradebook,
        left_on=id_col_survey,
        right_on=id_col_gradebook,
        how="inner",  # only IDs that appear in both
    )

    # Output file
    base_name = os.path.splitext(os.path.basename(gradebook_file))[0]
    out_file = f"{base_name}_paired.csv"
    merged.to_csv(out_file, index=False)

    print(f"Created: {out_file}")


# Example usage
# merge_gradebook_and_survey("CSC171A.csv", "SurveyData.csv")
