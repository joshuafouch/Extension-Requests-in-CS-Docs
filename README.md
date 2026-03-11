# Extension Requests in CS Docs

Research project analyzing student extension request behavior and outcomes
across multiple CS/SE courses. Data collected via student survey; analyses
performed in R and documented in Typst.

---

## Repository Structure

```
Extension-Requests-in-CS-Docs/
├── 00_setup.r          # Shared R setup — libraries and data import (source at top of each script)
├── surveydata/
│   ├── surveydata.csv          # Raw survey data (147 respondents)
│   ├── newheadernames.csv      # Maps original question text → short column names
│   └── counts.txt              # Per-question response counts (generated)
├── rq01/ … rq09/       # Research question folders (see below)
└── extra01/ … extra03/ # Supplementary analyses (see below)
```

Each `rq*/` and `extra*/` folder contains:

| File                     | Description                                              |
| :----------------------- | :------------------------------------------------------- |
| `README.md`              | Folder-level file index and descriptions                 |
| `*_notes.typ`            | Typst document — question, hypothesis, graph, analysis   |
| `*_notes.pdf`            | Compiled PDF output of the Typst document                |
| `*_<topic>.r`            | Primary R analysis script (produces the graph)           |
| `raw_*_<topic>.r`        | Raw values R script (prints exact counts/values/n)       |
| `*_graph.png`            | Output graph image (embedded in the Typst document)      |

---

## Research Questions

| Folder  | Title                          | Question                                                                                          |
| :------ | :----------------------------- | :------------------------------------------------------------------------------------------------ |
| `rq01`  | GPA & Extension Requests       | Will students with lower starting GPAs more likely request extensions than higher-GPA students?   |
| `rq02`  | Course Level & Extensions      | Will students in lower-division courses request extensions more frequently than upper-division?   |
| `rq03`  | Extension Reasons              | What will be the most common reason students request extensions?                                  |
| `rq04`  | Fairness & Psychological Safety | Will no-questions-asked extensions increase students' sense of fairness and psychological safety? |
| `rq05`  | Assignment Value Perception    | Will extension users perceive assignments as less valuable than non-users?                        |
| `rq06`  | Submission Completion Rate     | Of students who requested extensions, what percentage were never submitted vs. submitted?         |
| `rq07`  | Protocol Compliance            | How many extension requests were submitted correctly and on time per the protocol?                |
| `rq08`  | Year Level & Extension Usage   | Is there a correlation between academic year level and number of extensions used?                 |
| `rq09`  | Achievement Gap                | Does the extension policy help close the grade gap between lower- and higher-GPA students?        |

---

## Supplementary Analyses

| Folder    | Title                          | Purpose                                                                              |
| :-------- | :----------------------------- | :----------------------------------------------------------------------------------- |
| `extra01` | Exam Grade Table               | Summary table of exam scores and final grades broken down by GPA range and extensions used |
| `extra02` | Exam Scores vs Extensions Used | Does the number of extensions used correlate with final exam performance?            |
| `extra03` | Exam Scores Controlled for GPA | Does extension usage predict lower exam scores after controlling for prior GPA?      |


---

## Workflow

1. Open RStudio and run `00_setup.r` (or `source("00_setup.r")` at the top of any script).
2. Run a `rq*/` or `extra*/` analysis script to produce the graph.
3. Run the corresponding `raw_*` script to print exact values for the Raw Values Summary.
4. Compile `*_notes.typ` with Typst to regenerate the PDF.
