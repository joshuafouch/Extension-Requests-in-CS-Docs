#set document(title: "RQ10 — Achievement Gap")
#set page(margin: 1.2in)
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true)

#align(center)[
  #text(size: 16pt, weight: "bold")[Research Question 10]
  #v(0.2em)
  #text(size: 12pt, style: "italic")[Achievement Gap]
  #v(0.4em)
  #line(length: 100%)
]

#v(0.8em)

#text(weight: "bold")[Question]
#v(0.3em)
Does the policy help close the gap between students with lower prior GPAs and
high achievers?

#v(0.8em)

#text(weight: "bold")[Hypothesis]
#v(0.3em)
_[ Write your hypothesis here ]_

#v(0.8em)

// ── Graph 1 ──────────────────────────────────────────────────────────────────
#text(weight: "bold")[Graph 1 — Extensions by GPA]
#v(0.3em)
#figure(
  image("rq10_graph1.png", width: 100%),
  caption: [Average extensions used per GPA range.]
)

#v(0.4em)
Bar chart — Average number of extensions used per GPA range. \
*X-axis:* Self-reported GPA (ascending) \
*Y-axis:* Average extensions used

#v(0.8em)

// ── Graph 2 ──────────────────────────────────────────────────────────────────
#text(weight: "bold")[Graph 2 — Final Grade by GPA]
#v(0.3em)
#figure(
  image("rq10_graph2.png", width: 100%),
  caption: [Final course grade (%) per GPA range, with failure threshold.]
)

#v(0.4em)
Boxplot with jitter — Final course grade (%) per GPA range. \
*X-axis:* Self-reported GPA \
*Y-axis:* Final course grade (%) \
Mean score labels shown above each box. Red dashed line at y = 70 (failure threshold).

#v(0.8em)

#text(weight: "bold")[Raw Values Summary]
#v(0.3em)
#rect(width: 100%, stroke: 0.5pt, inset: 10pt)[
  _[ paste raw values here ]_
]

#v(0.8em)

#text(weight: "bold")[Statistical Note]
#v(0.3em)
*Test used:* Spearman Correlation (Graph 1) \
*Result:* _[ paste rho and p-value here ]_

#v(0.8em)

#text(weight: "bold")[Conclusion]
#v(0.3em)
_[ Write your conclusion here ]_
