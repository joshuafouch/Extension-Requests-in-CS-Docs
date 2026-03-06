#set document(title: "Extra 01 — Exam Grade Table")
#set page(margin: 1.2in)
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true)

// ── Title ────────────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold")[Extra 01]
  #v(0.2em)
  #text(size: 12pt, style: "italic")[Exam Grade Table]
  #v(0.4em)
  #line(length: 100%)
]

#v(0.8em)

// ── Purpose ──────────────────────────────────────────────────────────────────
#text(weight: "bold")[Purpose]
#v(0.3em)
Summary table of exam scores, final grades, and average extensions broken down
by GPA range and number of extensions used.

#v(0.8em)

// ── Output Description ───────────────────────────────────────────────────────
#text(weight: "bold")[Output Description]
#v(0.3em)
Tabular output — printed to console and exported as a CSV. \
*Rows grouped by:* GPA Range × Extensions Used \
*Columns:* Avg Exam Score | Avg Final Grade | Student Count (n) \
*CSV output:* GPA_Extension_Analysis.csv


// ── Raw Values Summary! ─────────────────────────────────────────────────────────

#text(weight: "bold")[#highlight[Raw Values Summary]]
#v(0.3em)
+ A Range (3.5 - 4.0) who used 0 extensions had an average exam score of $104.74$ and an average final grade of $102.15$ (count: $15$)
+ A Range (3.5 - 4.0) who used 1 extension had an average exam score of $100.66$ and an average final grade of $100.64$ (count: $17$)
+ A Range (3.5 - 4.0) who used 2 extensions had an average exam score of $99.11$ and an average final grade of $101.02$ (count: $17$)
+ B Range (3.0 - 3.49) who used 0 extensions had an average exam score of $117$ and an average final grade of $103.27$ (count: $1$)
+ B Range (3.0 - 3.49) who used 1 extension had an average exam score of $88.57$ and an average final grade of $96.6$ (count: $4$)
+ B Range (3.0 - 3.49) who used 2 extensions had an average exam score of $89.15$ and an average final grade of $92.48$ (count: $12$)
+ C/D Range (< 3.0) who used 0 extensions had an average exam score of $82.69$ and an average final grade of $84.59$ (count: $1$)
+ C/D Range (< 3.0) who used 1 extension had an average exam score of $92$ and an average final grade of $86.94$ (count: $1$)
+ C/D Range (< 3.0) who used 2 extensions had an average exam score of $75.36$ and an average final grade of $88.25$ (count: $9$)

#v(0.8em)
