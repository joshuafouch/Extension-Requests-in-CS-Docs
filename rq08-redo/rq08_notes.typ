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

*#highlight(fill: rgb("e2f8e1"))[NEW RESULT]* $ p = 0.091 $
`
            Df Sum Sq Mean Sq F value Pr(>F)  
Year         3   4.27  1.4232   2.219 0.0911 .
Residuals   93  59.65  0.6414                 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
`

#text(weight: "bold")[#highlight[PUT THIS ON PAPER]]

$ (F(3, 93) = 2.22, p < 0.1) $

* Year(3) comes from (\# of groups) - 1 * \
* Residuals(93) comes from (\# of rows) - (\# of groups) *

F = 2.22 means that there is some difference between extension usage and years, _however_, the p-value (0.0911) shows that there is a 9% chance this happened by chance, so basically this means its not significant.


// ── Graph ────────────────────────────────────────────────────────────────────
//#text(weight: "bold")[Graph]
//#v(0.3em)
//#figure(
//  image("rq08_graph.png", width: 100%),
//  caption: [Average extension usage by academic year level.]
//)

#v(0.8em)

// ─ Graph Description ────────────────────────────────────────────────────────
//#text(weight: "bold")[Graph Description]
//#v(0.3em)
//Bar chart — Average extensions used per academic year level. \
//*X-axis:* Year level (Freshman / Sophomore / Junior / Senior) \
//*Y-axis:* Average extensions used \
//n counts displayed above each bar.


// ── Raw Values Summary ─────────────────────────────────────────────────────────

#text(weight: "bold")[Raw Values Summary]
#v(0.3em)

#text(weight: "bold")[OLD DATA]
+ The Freshmen (Count: 18) had an mean of 0.89 extensions used.
+ The Sophomores (Count: 29) had an mean of 1.24 extensions used.
+ The Juniors (Count: 20) had an mean of 1.25 extensions used.
+ The Seniors (Count: 18) had an mean of 1.44 extensions used.

#text(weight: "bold")[#highlight(fill: rgb("e2f8e1"))[NEW DATA]]
+ The Freshmen (Count: 17) had an mean of 0.94 extensions used.
+ The Sophomores (Count: 35) had an mean of 1.20 extensions used.
+ The Juniors (Count: 23) had an mean of 1.44 extensions used.
+ The Seniors (Count: 22) had an mean of 1.55 extensions used.

`
       Year  n Mean_Extensions
1  Freshman 17          0.9412
2 Sophomore 35          1.2000
3    Junior 23          1.4348
4    Senior 22          1.5455
`

#v(0.8em)

// ── Statistical Note ─────────────────────────────────────────────────────────
#text(weight: "bold")[Statistical Note]
#v(0.3em)
*Test used:* One-way ANOVA \
*OLD Result:* $p = 0.243$ \

#v(0.8em)

// ── Conclusion ───────────────────────────────────────────────────────────────
#text(weight: "bold")[Conclusion]
#v(0.3em)
*OLD CONCLUSION*:
Though the data is not significant (p > 0.05), this still tells us something. Our data shows a positive correlation: as grade level increases, the amount of extensions used increases slightly. Our extensions policy is helpful for all students and is not necessarily a “safety net” or a “holding hand” for lowerclassmen students who just began college. Despite this, due to the insignificance proven, our extension policy can help all students alike without hindering performance or drastically changing performance.
