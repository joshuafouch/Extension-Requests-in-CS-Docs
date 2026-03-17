"""
aggregate.py

Joins gradebook CSVs (CSC-*.csv) with SurveyData.csv on (ID, Section).

Unique key: (ID, Section) where Section is normalised to the short form
"CSC-NNN" for both sources.

Known gradebook ID corrections (survey is authoritative):
  - BENKL CSC-144  -> BETKL
  - NANMO CSC-144  -> NALMO
  - BENKL CSC-145  -> BETKL
  - JOYST CSC-145  -> JONST
  - BRNO' CSC-261  -> BRNON
  - JOENO CSC-261  -> JOHNO

Outputs
-------
aggregated.csv   - All survey rows (deduplicated, corrected) with gradebook
                   columns joined where a match exists.
issues.csv       - One row per anomaly with a Type column describing what
                   happened:
                     "ID typo fixed"          - corrected gradebook ID
                     "Duplicate survey row"   - the row that was dropped
                     "Gradebook only"         - gradebook row with no survey row
                     "Survey only"            - survey row with no gradebook row
"""

import csv
import os
import re
from collections import defaultdict

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
SURVEY_FILE = "SurveyData.csv"
GRADEBOOK_FILES = [
    "CSC-144.csv",
    "CSC-145.csv",
    "CSC-261.csv",
    "CSC-310.csv",
    "CSC-344.csv",
]

OUTPUT_MERGED = "aggregated.csv"
OUTPUT_ISSUES = "issues.csv"

# Known ID fixes: (original_id, source, section_short) -> corrected_id
# All fixes are in the gradebook; survey is the authority.
ID_FIXES = {
    ("BENKL", "gradebook", "CSC-144"): "BETKL",
    ("NANMO", "gradebook", "CSC-144"): "NALMO",
    ("BENKL", "gradebook", "CSC-145"): "BETKL",
    ("JOYST", "gradebook", "CSC-145"): "JONST",
    ("BRNO'", "gradebook", "CSC-261"): "BRNON",
    ("JOENO", "gradebook", "CSC-261"): "JOHNO",
}

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
SECTION_RE = re.compile(r"CSC[- ](\d+)", re.IGNORECASE)


def normalise_section(raw: str) -> str:
    """Convert any Section string to 'CSC-NNN' short form."""
    m = SECTION_RE.search(raw)
    if m:
        return f"CSC-{m.group(1)}"
    return raw.strip()


def load_gradebook() -> tuple[list[dict], list[dict]]:
    """
    Load all gradebook CSVs.
    Returns (rows, issue_rows).
    rows: list of dicts with normalised/corrected ID & Section.
    issue_rows: issue records for typo fixes.
    """
    rows = []
    issue_rows = []

    for fname in GRADEBOOK_FILES:
        if not os.path.exists(fname):
            print(f"WARNING: {fname} not found, skipping.")
            continue
        with open(fname, newline="", encoding="utf-8") as f:
            reader = csv.DictReader(f)
            for row in reader:
                # Skip blank / note rows (CSC-145 has trailing empties)
                if not row.get("ID", "").strip():
                    continue
                # Skip rows whose ID starts with something other than letters
                # (catches stray note rows like "Positive Value: ...")
                if not re.match(r"[A-Z]", row["ID"].strip(), re.IGNORECASE):
                    continue

                section = normalise_section(row.get("Section", ""))
                original_id = row["ID"].strip()

                fix_key = (original_id, "gradebook", section)
                if fix_key in ID_FIXES:
                    corrected_id = ID_FIXES[fix_key]
                    issue_rows.append(
                        {
                            "Type": "ID typo fixed",
                            "Source": "gradebook",
                            "Original_ID": original_id,
                            "Corrected_ID": corrected_id,
                            "Section": section,
                            "Detail": (
                                f"Gradebook had '{original_id}' in {section}; "
                                f"corrected to '{corrected_id}'"
                            ),
                            **{
                                k: v
                                for k, v in row.items()
                                if k not in ("ID", "Section")
                            },
                        }
                    )
                    row["ID"] = corrected_id

                row["ID"] = row["ID"].strip()
                row["Section"] = section
                rows.append(row)

    return rows, issue_rows


def load_survey() -> tuple[list[dict], list[dict], list[str]]:
    """
    Load SurveyData.csv.
    Returns (rows, issue_rows, fieldnames).
    Applies ID fixes, deduplicates (keeping most recent Completion_time).
    issue_rows: records for typo fixes and dropped duplicate rows.
    """
    raw_rows = []
    issue_rows = []
    survey_cols: list[str] = []

    with open(SURVEY_FILE, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        survey_cols = list(reader.fieldnames or [])
        for row in reader:
            section = normalise_section(row.get("Section", ""))
            original_id = row["ID"].strip()

            fix_key = (original_id, "survey", section)
            if fix_key in ID_FIXES:
                corrected_id = ID_FIXES[fix_key]
                issue_rows.append(
                    {
                        "Type": "ID typo fixed",
                        "Source": "survey",
                        "Original_ID": original_id,
                        "Corrected_ID": corrected_id,
                        "Section": section,
                        "Detail": (
                            f"Survey had '{original_id}' in {section}; "
                            f"corrected to '{corrected_id}'"
                        ),
                        **{k: v for k, v in row.items() if k not in ("ID", "Section")},
                    }
                )
                row["ID"] = corrected_id

            row["ID"] = row["ID"].strip()
            row["Section"] = section
            raw_rows.append(row)

    # Deduplicate: group by (ID, Section), keep latest Completion_time
    groups: dict[tuple, list[dict]] = defaultdict(list)
    for row in raw_rows:
        key = (row["ID"], row["Section"])
        groups[key].append(row)

    deduped = []
    for key, group in groups.items():
        if len(group) == 1:
            deduped.append(group[0])
        else:
            # Sort by Completion_time descending; keep first (most recent)
            group_sorted = sorted(
                group,
                key=lambda r: r.get("Completion_time", ""),
                reverse=True,
            )
            kept = group_sorted[0]
            deduped.append(kept)
            for dropped in group_sorted[1:]:
                issue_rows.append(
                    {
                        "Type": "Duplicate survey row",
                        "Source": "survey",
                        "Original_ID": dropped["ID"],
                        "Corrected_ID": "",
                        "Section": dropped["Section"],
                        "Detail": (
                            f"Duplicate survey submission for {dropped['ID']} "
                            f"in {dropped['Section']}; "
                            f"kept completion_time={kept.get('Completion_time')}; "
                            f"dropped completion_time={dropped.get('Completion_time')}"
                        ),
                        **{
                            k: v
                            for k, v in dropped.items()
                            if k not in ("ID", "Section")
                        },
                    }
                )

    return deduped, issue_rows, survey_cols


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
def main():
    gradebook_rows, gb_issue_rows = load_gradebook()
    survey_rows, sv_issue_rows, survey_cols = load_survey()

    # Build gradebook lookup: (ID, Section) -> gradebook row
    gb_lookup: dict[tuple, dict] = {}
    for row in gradebook_rows:
        key = (row["ID"], row["Section"])
        gb_lookup[key] = row

    # Gradebook columns (excluding ID & Section, already in survey)
    gb_extra_cols = [
        "Final_Exam_Score",
        "Course_Grade",
        "num_valid_Extensions",
        "num_exts_Requested",
        "assignment_ext_1_reqd_correctly",
        "assignment_ext_2_reqd_correctly",
        "days_after_assignment_ext_1_sub",
        "days_after_assignment_ext_2_sub",
    ]

    # Build merged rows + track which gradebook rows were matched
    merged_rows = []
    matched_gb_keys = set()

    for srow in survey_rows:
        key = (srow["ID"], srow["Section"])
        gb_row = gb_lookup.get(key)
        merged = dict(srow)
        if gb_row:
            matched_gb_keys.add(key)
            for col in gb_extra_cols:
                merged[col] = gb_row.get(col, "")
        else:
            for col in gb_extra_cols:
                merged[col] = ""
        merged_rows.append(merged)

    # Collect unmatched gradebook rows
    unmatched_gb_issue_rows = []
    for key, gb_row in gb_lookup.items():
        if key not in matched_gb_keys:
            unmatched_gb_issue_rows.append(
                {
                    "Type": "Gradebook only",
                    "Source": "gradebook",
                    "Original_ID": gb_row["ID"],
                    "Corrected_ID": "",
                    "Section": gb_row["Section"],
                    "Detail": (
                        f"Gradebook row for {gb_row['ID']} in {gb_row['Section']} "
                        f"has no corresponding survey row."
                    ),
                    **{k: v for k, v in gb_row.items() if k not in ("ID", "Section")},
                }
            )

    # Survey rows that had no gradebook match
    survey_only_issue_rows = []
    for srow in survey_rows:
        key = (srow["ID"], srow["Section"])
        if key not in gb_lookup:
            survey_only_issue_rows.append(
                {
                    "Type": "Survey only",
                    "Source": "survey",
                    "Original_ID": srow["ID"],
                    "Corrected_ID": "",
                    "Section": srow["Section"],
                    "Detail": (
                        f"Survey row for {srow['ID']} in {srow['Section']} "
                        f"has no corresponding gradebook row."
                    ),
                    **{k: v for k, v in srow.items() if k not in ("ID", "Section")},
                }
            )

    # ------------------------------------------------------------------
    # Write aggregated.csv
    # ------------------------------------------------------------------
    out_cols = list(survey_cols) + gb_extra_cols
    # survey_cols already has ID and Section; normalise column list
    # (avoid duplicates if survey_cols accidentally included gb cols)
    seen = set()
    final_cols = []
    for c in out_cols:
        if c not in seen:
            final_cols.append(c)
            seen.add(c)

    with open(OUTPUT_MERGED, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=final_cols, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(merged_rows)

    print(f"Wrote {len(merged_rows)} rows to {OUTPUT_MERGED}")

    # ------------------------------------------------------------------
    # Write issues.csv
    # ------------------------------------------------------------------
    all_issues = (
        gb_issue_rows + sv_issue_rows + unmatched_gb_issue_rows + survey_only_issue_rows
    )

    # Collect all columns present across all issue rows
    issue_cols_ordered = [
        "Type",
        "Source",
        "Original_ID",
        "Corrected_ID",
        "Section",
        "Detail",
    ]
    extra_issue_cols = []
    seen_ic = set(issue_cols_ordered)
    for row in all_issues:
        for k in row:
            if k not in seen_ic:
                extra_issue_cols.append(k)
                seen_ic.add(k)
    issue_fieldnames = issue_cols_ordered + extra_issue_cols

    with open(OUTPUT_ISSUES, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f, fieldnames=issue_fieldnames, extrasaction="ignore", restval=""
        )
        writer.writeheader()
        writer.writerows(all_issues)

    print(f"Wrote {len(all_issues)} issue rows to {OUTPUT_ISSUES}")
    print()

    # ------------------------------------------------------------------
    # Summary
    # ------------------------------------------------------------------
    def count_type(issues, t):
        return sum(1 for r in issues if r["Type"] == t)

    print("=== Issue Summary ===")
    print(
        f"  ID typos fixed (gradebook):   {count_type(gb_issue_rows, 'ID typo fixed')}"
    )
    print(
        f"  ID typos fixed (survey):      {count_type(sv_issue_rows, 'ID typo fixed')}"
    )
    print(
        f"  Duplicate survey rows dropped:{count_type(sv_issue_rows, 'Duplicate survey row')}"
    )
    print(f"  Gradebook-only rows:          {len(unmatched_gb_issue_rows)}")
    print(f"  Survey-only rows:             {len(survey_only_issue_rows)}")


if __name__ == "__main__":
    main()
