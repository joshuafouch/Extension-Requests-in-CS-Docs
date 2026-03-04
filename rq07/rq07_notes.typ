#set document(title: "RQ07 — Protocol Compliance")
#set page(margin: 1.2in)
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true)

// ── Title ────────────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold")[Research Question 7]
  #v(0.2em)
  #text(size: 12pt, style: "italic")[Protocol Compliance]
  #v(0.4em)
  #line(length: 100%)
]

#v(0.8em)

// ── Question ─────────────────────────────────────────────────────────────────
#text(weight: "bold")[Question]
#v(0.3em)
How many extension requests were submitted correctly and on time according to
the protocol?

#v(0.8em)

// ── Graph ────────────────────────────────────────────────────────────────────
#text(weight: "bold")[Graph]
#v(0.3em)
#figure(
  image("rq07_graph.png", width: 100%),
  caption: [Timing of extension requests relative to the deadline.]
)

#v(0.8em)

#pagebreak()

// ─ Graph Description ────────────────────────────────────────────────────────
#text(weight: "bold")[Graph Description]
#v(0.3em)
Histogram — Timing of extension requests relative to deadline. \
*X-axis:* Days before deadline (negative = late / after deadline) \
*Y-axis:* Number of requests \
Bars colored by compliance (Correct = In Advance / Incorrect = After Deadline). \
Vertical dashed line at x = 0. Bin width: 1 day.

#v(0.8em)

// ── Raw Values Summary ─────────────────────────────────────────────────────────

#text(weight: "bold")[#highlight[Raw Values Summary]]
#v(0.3em)
Of the 88 students with recorded extension request timing, 85 (96.6%) submitted
correctly in advance and 3 (3.4%) submitted after the deadline.

Among the 85 correct requests: 22 submitted on the day of the deadline (0 days
before), 5 submitted 1 day before, 5 submitted 2 days before, 23 submitted
3 days before, 14 submitted 4 days before, 10 submitted 5 days before, 5
submitted 6 days before, and 1 submitted 8 days before.

Among the 3 incorrect requests: 2 were submitted 4 days after the deadline and
1 was submitted 5 days after the deadline.

The mean request timing across all 88 students was 2.44 days before the
deadline (median: 3.00 days; range: −5 to +8 days).

#v(0.8em)

// ── Conclusion ───────────────────────────────────────────────────────────────
#text(weight: "bold")[Conclusion]
#v(0.3em)
Almost all of the extension requests were submitted correctly and *on time* before or right on the deadline. According to the graph, the students on the right of ‘0’ correctly submitted the extension x amount of days before the deadline. The students on the left of ‘0’ are the ones that submitted it incorrectly. There are significantly more blue bars which represent the amount of students who submitted correctly. This displays that our extension policy does not encourage laziness in class, but provides a way for students to excel while giving them more freedom in the course load.
