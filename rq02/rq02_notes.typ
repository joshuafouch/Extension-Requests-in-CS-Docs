#set document(title: "RQ02 — Course Level & Extension Requests")
#set page(margin: 1.2in)
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true)

// ── Title ────────────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold")[Research Question 2]
  #v(0.2em)
  #text(size: 12pt, style: "italic")[Course Level & Extension Requests]
  #v(0.4em)
  #line(length: 100%)
]

#v(0.8em)

// ── Question ─────────────────────────────────────────────────────────────────
#text(weight: "bold")[Question]
#v(0.3em)
Will students in lower-division (freshman/sophomore) courses request extensions more frequently than those in upper-division (junior) courses?

#v(0.8em)

// ── Hypothesis ───────────────────────────────────────────────────────────────
#text(weight: "bold")[Hypothesis]
#v(0.3em)
Students in lower-division (freshman/sophomore) courses will request extensions more frequently than those in upper-division (junior) courses.

#v(0.8em)

// ── Graph ────────────────────────────────────────────────────────────────────
#text(weight: "bold")[Graph]
#v(0.3em)
#figure(
  image("rq02_graph.png", width: 100%),
  caption: [Average extension requests by course.]
)

#v(0.8em)
#pagebreak()

// ─ Graph Description ────────────────────────────────────────────────────────
#text(weight: "bold")[Graph Description]
#v(0.3em)
Bar chart — Average number of extensions requested per course. \
*X-axis:* Course code \
*Y-axis:* Average number of extensions \
Error bars shown. n counts displayed at the bottom of each bar.

#v(0.8em)

// ── Raw Values Summary ─────────────────────────────────────────────────────────

#text(weight: "bold")[#highlight[Raw Values Summary]]
#v(0.3em)
+ Course CSC-144 (count: 26) had a mean of 0.9231 extensions used
+ Course CSC-145 (count: 14) had a mean of 1.7857 extensions used
+ Course CSC-171 (count: 2) had a mean of 1 extensions used
+ Course CSC-261 (count: 29) had a mean of 1.1379 extensions used
+ Course CSC-310 (count: 8) had a mean of 1.25 extensions used
+ Course CSC-344 (count: 9) had a mean of 1.4444 extensions used

#v(0.8em)

// ── Statistical Note ─────────────────────────────────────────────────────────
#text(weight: "bold")[Statistical Note]
#v(0.3em)
*Test used:* One-way ANOVA \
*Result:* 
$ F(5, 82) = 2.31, p > 0.05 $

#v(0.8em)

// ── Conclusion ───────────────────────────────────────────────────────────────
#text(weight: "bold")[Conclusion]
#v(0.3em)
Based on our tests, there is no significant correlation between extension usage and the courses, either upper or lower level. In CSC 145, there is a higher amount of extensions used, however, this could be due to the amount of assignments in the class. The line on CSC 171 is due to the small count size of said class (n=2). I was not satisfied with this conclusion, so I decided to perform another correlation between the grade level and the number of extensions used (see Research Question 9)

*AI*:
"A one-way ANOVA was conducted to determine if the number of extension requests differed significantly across the different courses. The results indicated a marginally significant difference between the courses ($F(5, 82) = 2.31, p = 0.051$). While the p-value sits just above the strict 0.05 threshold for statistical significance, the data suggests a strong trending variance in extension usage depending on the specific class a student is taking.
