#set document(title: "Extra 02 — Exam Scores vs Extensions Used")
#set page(margin: 1.2in)
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true)

// ── Title ────────────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold")[Extra 02]
  #v(0.2em)
  #text(size: 12pt, style: "italic")[Exam Scores vs Extensions Used]
  #v(0.4em)
  #line(length: 100%)
]

#v(0.8em)

// ── Purpose ──────────────────────────────────────────────────────────────────
#text(weight: "bold")[Purpose]
#v(0.3em)
Does the number of extensions used correlate with final exam performance?

#v(0.8em)

// ── Graph ────────────────────────────────────────────────────────────────────
#text(weight: "bold")[Graph]
#v(0.3em)
#figure(
  image("extra02_graph.png", width: 100%),
  caption: [Average final exam score by number of extensions used.]
)

#v(0.8em)

// ─ Graph Description ────────────────────────────────────────────────────────
#text(weight: "bold")[Graph Description]
#v(0.3em)
Bar chart — Average final exam score per extension usage group. \
*X-axis:* Extension group (0 / 1 / 2 Extensions) \
*Y-axis:* Average final exam score (%) \
n counts shown inside bars; mean % shown above bars. \
Significance star (\*) annotated on the graph.

#pagebreak()

// ── Raw Values Summary ─────────────────────────────────────────────────────────

#text(weight: "bold")[#highlight[Raw Values Summary]]
#v(0.3em)
+ Those who took no extensions (count: 23) got a mean exam score of 103.2
+ Those who took 1 extensions (count: 23) got a mean exam score of 97.8
+ Those who took 2 extensions (count: 42) got a mean exam score of 88.7

#v(0.8em)

// ── Statistical Note ─────────────────────────────────────────────────────────
#text(weight: "bold")[Statistical Note]
#v(0.3em)
*Test used:* One-way ANOVA \
*Result:* $ p = 0.017 $

#v(0.8em)
