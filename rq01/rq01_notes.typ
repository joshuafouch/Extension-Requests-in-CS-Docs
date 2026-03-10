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

#pagebreak()

// ─ Graph Description ────────────────────────────────────────────────────────
#text(weight: "bold")[Graph Description]
#v(0.3em)
Bar chart — Average number of extensions requested per GPA group. \
*X-axis:* Estimated GPA range \
*Y-axis:* Average number of extensions \
n counts displayed inside each bar.

#v(0.8em)

// ── Raw Values Summary ─────────────────────────────────────────────────────────

#text(weight: "bold")[#highlight[Raw Values Summary]]
#v(0.3em)
+ GPA Group $2.0 - 2.49$ (with a count of $3$) has $1.3333$ average extensions used
+ GPA Group $2.5 - 2.99$ (with a count of $8$) has $1.875$ average extensions used
+ GPA Group $3.0 - 3.49$ (with a count of $17$) has $1.6471$ average extensions used
+ GPA Group $3.5 - 4.0$ (with a count of $41$) has $1.122$ average extensions used
+ GPA Group $4.0+$ (with a count of $8$) has $0.625$ average extensions used

#v(0.8em)

// ── Statistical Note ─────────────────────────────────────────────────────────
#text(weight: "bold")[Statistical Note]
#v(0.3em)
*Test used:* Spearman Correlation \

*Result:* 
$
rho = -0.42, p < 0.0001 $

#v(0.8em)

// ── Conclusion ───────────────────────────────────────────────────────────────
#text(weight: "bold")[Conclusion]
#v(0.3em)
Using a Spearman Correlation with a rho value of -0.42 and a P-value of < 0.0001. This means there is a moderate negative correlation; as the GPA increases, the number of extensions requested decreases. The bar graph shows a clear downward trend. The reason there are no entries for the “1.5 - 1.99” rank is due to no IRB approved students answering this.
