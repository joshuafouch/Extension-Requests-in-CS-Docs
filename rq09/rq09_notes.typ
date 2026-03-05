#set document(title: "RQ09 — Achievement Gap")
#set page(margin: 1.2in)
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true)

// ── Title ────────────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold")[Research Question 9]
  #v(0.2em)
  #text(size: 12pt, style: "italic")[Achievement Gap]
  #v(0.4em)
  #line(length: 100%)
]

#v(0.8em)

// ── Question ─────────────────────────────────────────────────────────────────
#text(weight: "bold")[Question]
#v(0.3em)
Does the policy help close the gap between students with lower prior GPAs and
high achievers?

#v(0.8em)

// ── Graph 1 ──────────────────────────────────────────────────────────────────
#text(weight: "bold")[Graph 1 — Extensions by GPA]
#v(0.3em)
#figure(
  image("rq09_graph.png", width: 100%),
  caption: [Average extensions used per GPA range.]
)

#v(0.8em)

// ─ Graph Description ────────────────────────────────────────────────────────
#text(weight: "bold")[Graph 1 Description]
#v(0.3em)
Bar chart — Average number of extensions used per GPA range. \
*X-axis:* Self-reported GPA (ascending) \
*Y-axis:* Average extensions used

#pagebreak()

// ── Graph 2 ──────────────────────────────────────────────────────────────────
#text(weight: "bold")[Graph 2 — Final Grade by GPA]
#v(0.3em)
#figure(
  image("rq09_graph2.png", width: 100%),
  caption: [Final course grade (%) per GPA range, with failure threshold.]
)

#v(0.8em)

// ─ Graph Description ────────────────────────────────────────────────────────
#text(weight: "bold")[Graph Description]
#v(0.3em)
Boxplot with jitter — Final course grade (%) per GPA range. \
*X-axis:* Self-reported GPA \
*Y-axis:* Final course grade (%) \
Mean score labels shown above each box. Red dashed line at y = 70 (failure threshold).


#v(0.8em)

// ── Statistical Note ─────────────────────────────────────────────────────────
#text(weight: "bold")[Statistical Note]
#v(0.3em)
*Test used:* Spearman Correlation (Graph 1) \
*Result:* $ p < 0.005, r = -0.325 $

#v(0.8em)

// ── Conclusion ───────────────────────────────────────────────────────────────
#text(weight: "bold")[Conclusion]
#v(0.3em)
A significant correlation is shown: as a student’s self-report of their GPA lowers, the higher amount of extensions they will use. Due to our smaller amount of data (n = 147), the graph does not seem to show much of a difference. To prove that the extension policy helps students who have a lower self-reported GPA, the second graph shows that the 2 lower GPA groups still got around an 85% as their Final Grade, which is still a good grade in our University.
