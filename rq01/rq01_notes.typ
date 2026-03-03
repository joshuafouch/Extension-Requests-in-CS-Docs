#set document(title: "RQ01 — GPA & Extension Requests")
#set page(margin: 1.2in)
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true)

// ── Title ────────────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold")[Research Question 1]
  #v(0.2em)
  #text(size: 12pt, style: "italic")[GPA & Extension Requests]
  #v(0.4em)
  #line(length: 100%)
]

#v(0.8em)

// ── Question ─────────────────────────────────────────────────────────────────
#text(weight: "bold")[Question]
#v(0.3em)
Will students with lower starting GPAs more likely request extensions than
students with higher starting GPAs?

#v(0.8em)

// ── Hypothesis ───────────────────────────────────────────────────────────────
#text(weight: "bold")[Hypothesis]
#v(0.3em)
Students with lower starting GPAs are more likely to request extensions than
students with higher starting GPAs.

#v(0.8em)

// ── Graph ────────────────────────────────────────────────────────────────────
#text(weight: "bold")[Graph]
#v(0.3em)
#figure(
  image("rq01_graph.png", width: 100%),
  caption: [Average extensions requested by estimated GPA group.]
)

#v(0.8em)

// ── Graph Description ────────────────────────────────────────────────────────
#text(weight: "bold")[Graph Description]
#v(0.3em)
Bar chart — Average number of extensions requested per GPA group. \
*X-axis:* Estimated GPA range \
*Y-axis:* Average number of extensions \
n counts displayed inside each bar.

#v(0.8em)

// ── Raw Values Summary ───────────────────────────────────────────────────────
#text(weight: "bold")[Raw Values Summary]
#v(0.3em)
#rect(width: 100%, stroke: 0.5pt, inset: 10pt)[
  // Paste key values from raw_rq01_gpa_extensions.r output below,
  // or reference rq01_raw_output.txt for the full table.

  _[ paste raw values here ]_
]

#v(0.8em)

// ── Statistical Note ─────────────────────────────────────────────────────────
#text(weight: "bold")[Statistical Note]
#v(0.3em)
*Test used:* Spearman Correlation \
*Result:* _[ paste rho and p-value here ]_

#v(0.8em)

// ── Conclusion ───────────────────────────────────────────────────────────────
#text(weight: "bold")[Conclusion]
#v(0.3em)
_[ Write your conclusion here ]_
