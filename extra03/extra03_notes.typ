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
#text(weight: "bold")[Graph]
#v(0.3em)
#figure(
  image("extra03_graph.png", width: 100%),
  caption: [Average final exam score by GPA range and extension usage.]
)

#v(0.8em)

// ─ Graph Description ────────────────────────────────────────────────────────
#text(weight: "bold")[Graph Description]
#v(0.3em)
Grouped bar chart — Average final exam score by GPA range, grouped by extensions used. \
*X-axis:* GPA range (A / B / C–D) \
*Y-axis:* Average final exam score (%) — range 60–130 \
Grouped bars per GPA range, colored by extension count (0 / 1 / 2). \
Score % labels above each bar; n= labels inside each bar.

#pagebreak()

// ── Raw Values Summary ─────────────────────────────────────────────────────────

#text(weight: "bold")[#highlight[Raw Values Summary]]
#v(0.3em)
+ A Range (3.5 - 4.0) who used 0 extensions (count: 16) got a mean exam score of 103.04
+ A Range (3.5 - 4.0) who used 1 extension (count: 17) got a mean exam score of 100.66
+ A Range (3.5 - 4.0) who used 2 extensions (count: 19) got a mean exam score of 97.87
+ B Range (3.0 - 3.49) who used 0 extensions (count: 1) got a mean exam score of 117
+ B Range (3.0 - 3.49) who used 1 extension (count: 4) got a mean exam score of 88.57
+ B Range (3.0 - 3.49) who used 2 extensions (count: 12) got a mean exam score of 89.15
+ C/D Range (< 3.0) who used 0 extensions (count: 1) got a mean exam score of 82.69
+ C/D Range (< 3.0) who used 1 extension (count: 1) got a mean exam score of 92
+ C/D Range (< 3.0) who used 2 extensions (count: 9) got a mean exam score of 75.36

#v(0.8em)
