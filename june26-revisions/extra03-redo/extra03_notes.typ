#set document(title: "Extra 03 — Exam Scores Controlled for GPA")
#set page(margin: 1.2in)
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true)

// ── Title ────────────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold")[Extra 03]
  #v(0.2em)
  #text(size: 12pt, style: "italic")[Exam Scores Controlled for GPA]
  #v(0.4em)
  #line(length: 100%)
]

#v(0.8em)

// ── Purpose ──────────────────────────────────────────────────────────────────
#text(weight: "bold")[Purpose]
#v(0.3em)
Does extension usage predict lower exam scores even after controlling for
prior GPA?

#v(0.8em)

// ── Graph ────────────────────────────────────────────────────────────────────
//#text(weight: "bold")[Graph]
//#v(0.3em)
//#figure(
//  image("extra03_graph.png", width: 100%),
//  caption: [Average final exam score by GPA range and extension usage.]
//)
//
//#v(0.8em)
//
//// ─ Graph Description ────────────────────────────────────────────────────────
//#text(weight: "bold")[Graph Description]
//#v(0.3em)
//Grouped bar chart — Average final exam score by GPA range, grouped by extensions used. \
//*X-axis:* GPA range (A / B / C–D) \
//*Y-axis:* Average final exam score (%) — range 60–130 \
//Grouped bars per GPA range, colored by extension count (0 / 1 / 2). \
//Score % labels above each bar; n= labels inside each bar.
//
//#pagebreak()

// ── Raw Values Summary ─────────────────────────────────────────────────────────
just look at extra01
`
GPA_Range num_exts_Requested Avg_Exam_Score Avg_Final_Grade Student_Count SE_Grade
<fct>     <fct>                       <dbl>           <dbl>         <int>    <dbl>
1 A Range   0 Ext.                      102.            102.             15     2.43
2 A Range   1 Ext.                       98.5           100.             16     1.85
3 A Range   2 Ext.                       95.6           101.             19     1.34
4 B Range   0 Ext.                      117             103.              1     0
5 B Range   1 Ext.                       79.1            95.6             4     5.42
6 B Range   2 Ext.                       80.4            83.8            19     5.17
7 C/D Range 0 Ext.                       84.1            89.3             2     1.46
8 C/D Range 1 Ext.                       69.9            88.2             4     4.17
9 C/D Range 2 Ext.                       77.2            89.8            11     3.28
`
