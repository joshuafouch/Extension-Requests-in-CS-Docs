#set document(title: "RQ05 — Assignment Value Perception")
#set page(margin: 1.2in)
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true)

// ── Title ────────────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold")[Research Question 5]
  #v(0.2em)
  #text(size: 12pt, style: "italic")[Assignment Value Perception]
  #v(0.4em)
  #line(length: 100%)
]

#v(0.8em)

// ── Question ─────────────────────────────────────────────────────────────────
#text(weight: "bold")[Question]
#v(0.3em)
Will students who use extensions perceive assignments as less valuable to their education than students who do not?

#v(0.8em)

// ── Hypothesis ───────────────────────────────────────────────────────────────
#text(weight: "bold")[Hypothesis]
#v(0.3em)
Students who use extensions will *not* perceive assignments as less valuable to their education than students who do not.

#v(0.8em)

// ── Graph ────────────────────────────────────────────────────────────────────
#text(weight: "bold")[Graph]
#v(0.3em)
#figure(
  image("rq05_graph.png", width: 100%),
  caption: [Perceived homework importance by extension user group.]
)

#pagebreak()

// ─ Graph Description ────────────────────────────────────────────────────────
#text(weight: "bold")[Graph Description]
#v(0.3em)
Stacked proportional bar chart — Perceived homework importance by student group. \
*X-axis:* Student group (Extension User / Non-User) \
*Y-axis:* Percentage of students \
*Fill:* Response level (not at all / not really / yes, a little bit / yes, definitely)


// ── Raw Values Summary ─────────────────────────────────────────────────────────
#v(0.8em)

#text(weight: "bold")[#highlight[Raw Values Summary]]
#v(0.3em)
Group sizes: Extension User $n = 63$, Non-User $n = 22$.

*Extension User* ($n = 63$):
+ "not at all" — $40$ students ($63.5%$)
+ "not really" — $14$ students ($22.2%$)
+ "yes, a little bit" — $5$ students ($7.9%$)
+ "yes, definitely" — $4$ students ($6.3%$)

*Non-User* ($n = 23$):
+ "not at all" — $8$ students ($36.4%$)
+ "not really" — $13$ students ($59.1%$)
+ "yes, definitely" — $1$ student ($4.5%$)

#v(0.8em)

// ── Statistical Note ─────────────────────────────────────────────────────────
#text(weight: "bold")[Statistical Note]
#v(0.3em)
*Test used:* Mann-Whitney U (Wilcoxon) \
*Result:* $ p = 0.1174 $

#v(0.8em)

// ── Conclusion ───────────────────────────────────────────────────────────────
#text(weight: "bold")[Conclusion]
#v(0.3em)
A Mann-Whitney U test was conducted to determine if utilizing the extension policy led students to devalue the importance of their assignments. The analysis revealed no statistically significant difference in perceived assignment value between students who used extensions and those who did not (p > 0.05). Despite this, the data shows a shared consensus that the vast majority of students think that the policy’s flexibility does not directly impact their appreciation of the coursework.
