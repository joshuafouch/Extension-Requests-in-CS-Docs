#set document(title: "RQ04 — Fairness & Psychological Safety")
#set page(margin: 1.2in)
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true)

// ── Title ────────────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold")[Research Question 4]
  #v(0.2em)
  #text(size: 12pt, style: "italic")[Fairness & Psychological Safety]
  #v(0.4em)
  #line(length: 100%)
]

#v(0.8em)

// ── Question ─────────────────────────────────────────────────────────────────
#text(weight: "bold")[Question]
#v(0.3em)
Will the availability of automated, no-questions-asked extensions increase students' overall sense of fairness and psychological safety in the course?
#v(0.8em)

// ── Hypothesis ───────────────────────────────────────────────────────────────
#text(weight: "bold")[Hypothesis]
#v(0.3em)
The availability of automated, no-questions-asked extensions will increase students' overall sense of fairness and psychological safety in the course.

#v(0.8em)

// ── Graph ────────────────────────────────────────────────────────────────────
#text(weight: "bold")[Graph]
#v(0.3em)
#figure(
  image("rq04_graph.png", width: 100%),
  caption: [Student perceptions of the extension policy's impact on the course.]
)

#pagebreak()

// ─ Graph Description ────────────────────────────────────────────────────────
#text(weight: "bold")[Graph Description]
#v(0.3em)
Bar chart — Student opinions on whether the extension policy improved the course. \
*X-axis:* Opinion category (Made Course Better / No Impact / Made Course Worse / Did Not Answer) \
*Y-axis:* Number of students \
Labels show n= count and percentage for each bar.

#v(0.8em)

// ── Raw Values Summary ─────────────────────────────────────────────────────────

#text(weight: "bold")[#highlight[Raw Values Summary]]
#v(0.3em)
+ 46.9% (n = 69) of respondents didn’t answer (oddly)
+ 34.7% (n=51) of respondents stated it made the course better
+ 0.7% (n=1) stated it made the course worse
+ 17.7% (n=26) stated the policy had no impact on course quality

#v(0.8em)

// ── Statistical Note ─────────────────────────────────────────────────────────
#text(weight: "bold")[Statistical Note]
#v(0.3em)
*Test used:* Descriptive / frequency count / proportions test \
*Result:*  $ p < 0.01 $

#v(0.8em)

// ── Conclusion ───────────────────────────────────────────────────────────────
#text(weight: "bold")[Conclusion]
#v(0.3em)
*AI*: "A one-sample proportion test resulted in a p-value of 0.0046. Because this p-value is well below the standard significance threshold of 0.05, we reject the null hypothesis that student opinions are evenly divided. This statistically significant result indicates that the overwhelming positive feedback is not due to random chance, allowing us to confidently conclude that the automated extension policy significantly increases students' overall sense of fairness and psychological safety in the course."
