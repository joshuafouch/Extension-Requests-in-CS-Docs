#set document(title: "RQ08 — Year Level & Extension Usage")
#set page(margin: 1.2in)
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true)

// ── Title ────────────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold")[Research Question 8]
  #v(0.2em)
  #text(size: 12pt, style: "italic")[Year Level & Extension Usage]
  #v(0.4em)
  #line(length: 100%)
]

#v(0.8em)

// ── Question ─────────────────────────────────────────────────────────────────
#text(weight: "bold")[Question]
#v(0.3em)
Is there a correlation between grade level and the amount of extensions used?

#v(0.8em)

// ── Graph ────────────────────────────────────────────────────────────────────
#text(weight: "bold")[Graph]
#v(0.3em)
#figure(
  image("rq08_graph.png", width: 100%),
  caption: [Average extension usage by academic year level.]
)

#v(0.8em)

// ─ Graph Description ────────────────────────────────────────────────────────
#text(weight: "bold")[Graph Description]
#v(0.3em)
Bar chart — Average extensions used per academic year level. \
*X-axis:* Year level (Freshman / Sophomore / Junior / Senior) \
*Y-axis:* Average extensions used \
n counts displayed above each bar.

#pagebreak()

// ── Raw Values Summary ─────────────────────────────────────────────────────────

#text(weight: "bold")[#highlight[Raw Values Summary]]
#v(0.3em)

+ The Freshmen (Count: 18) had an mean of 0.89 extensions used.
+ The Sophomores (Count: 29) had an mean of 1.24 extensions used.
+ The Juniors (Count: 20) had an mean of 1.25 extensions used.
+ The Seniors (Count: 18) had an mean of 1.44 extensions used.

#v(0.8em)

// ── Statistical Note ─────────────────────────────────────────────────────────
#text(weight: "bold")[Statistical Note]
#v(0.3em)
*Test used:* One-way ANOVA \
*Result:* $ p = 0.243 $

#v(0.8em)

// ── Conclusion ───────────────────────────────────────────────────────────────
#text(weight: "bold")[Conclusion]
#v(0.3em)
Though the data is not significant (p > 0.05), this still tells us something. Our data shows a positive correlation: as grade level increases, the amount of extensions used increases slightly. Our extensions policy is helpful for all students and is not necessarily a “safety net” or a “holding hand” for lowerclassmen students who just began college. Despite this, due to the insignificance proven, our extension policy can help all students alike without hindering performance or drastically changing performance.
