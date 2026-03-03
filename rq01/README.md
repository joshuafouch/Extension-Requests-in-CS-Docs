# RQ01 — GPA & Extension Requests

**Research Question:** Will students with lower starting GPAs more likely request extensions than students with higher starting GPAs?

---

## Files

| File | Description |
|---|---|
| `rq01_gpa_extensions.r` | Main analysis script. Produces the bar chart of average extensions requested per GPA group. Also runs the Spearman correlation statistical test. |
| `raw_rq01_gpa_extensions.r` | Raw values script. Prints the exact x/y values and n counts that appear in the graph — grouped mean extensions and student count per GPA band. Filters match exactly what `stat_summary` uses in the graph script. |
| `raw_rq01_output.csv` | Exported CSV of the raw values table produced by `raw_rq01_gpa_extensions.r`. |
| `rq01_graph.png` | Exported graph image from RStudio. Bar chart of average extensions by GPA group. |
| `rq01_notes.typ` | Typst document template for this question. Contains the research question, hypothesis, embedded graph, graph description, raw values summary, statistical note, and conclusion. Fill in the conclusion and paste stat results as you go. |
| `rq01_notes.pdf` | Compiled PDF output of `rq01_notes.typ`. Re-compile after editing the `.typ` file. |

---

## Workflow

1. Run `rq01_gpa_extensions.r` in RStudio → export the plot as `rq01_graph.png` into this directory.
2. Run `raw_rq01_gpa_extensions.r` → paste the console output into `rq01_raw_output.txt` (or export as CSV).
3. Fill in `rq01_notes.typ` with your conclusion and statistical results.
4. Compile `rq01_notes.typ` with Typst to regenerate `rq01_notes.pdf`.

---

## Statistical Test

**Spearman Correlation** — tests whether GPA rank and number of extensions are monotonically related.
