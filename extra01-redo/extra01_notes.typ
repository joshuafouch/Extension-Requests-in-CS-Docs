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

#text(weight: "bold")[OLD Raw Values Summary]
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


#pagebreak()

#text(weight: "bold")[#highlight[NEWWW Raw Values Summary]]
+ A Range (3.5 - 4.0) who used 0 extensions had an average exam score of $102$ and an average final grade of $102$ (count: $15$)
+ A Range (3.5 - 4.0) who used 1 extension had an average exam score of $98.5$ and an average final grade of $100$ (count: $16$)
+ A Range (3.5 - 4.0) who used 2 extensions had an average exam score of $95.6$ and an average final grade of $101$ (count: $19$)
+ B Range (3.0 - 3.49) who used 0 extensions had an average exam score of $117$ and an average final grade of $103$ (count: $1$)
+ B Range (3.0 - 3.49) who used 1 extension had an average exam score of $79.1$ and an average final grade of $95.6$ (count: $4$)
+ B Range (3.0 - 3.49) who used 2 extensions had an average exam score of $80.4$ and an average final grade of $93.8$ (count: $19$)
+ C/D Range (< 3.0) who used 0 extensions had an average exam score of $84.1$ and an average final grade of $89.3$ (count: $2$)
+ C/D Range (< 3.0) who used 1 extension had an average exam score of $69.9$ and an average final grade of $88.2$ (count: $4$)
+ C/D Range (< 3.0) who used 2 extensions had an average exam score of $77.2$ and an average final grade of $89.8$ (count: $11$)


`
  GPA_Range            num_exts_Requested Avg_Exam_Score Avg_Final_Grade Student_Count
1 A Range (3.5 - 4.0)  0                           102.            102.             15
2 A Range (3.5 - 4.0)  1                            98.5           100.             16
3 A Range (3.5 - 4.0)  2                            95.6           101.             19
4 B Range (3.0 - 3.49) 0                           117             103.              1
5 B Range (3.0 - 3.49) 1                            79.1            95.6             4
6 B Range (3.0 - 3.49) 2                            80.4            83.8            19
7 C/D Range (< 3.0)    0                            84.1            89.3             2
8 C/D Range (< 3.0)    1                            69.9            88.2             4
9 C/D Range (< 3.0)    2                            77.2            89.8            11
                                                                                    Total: 91
`


#v(0.8em)
