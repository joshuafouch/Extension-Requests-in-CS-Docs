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

#text(weight: "bold")[#highlight[PUT THIS ON THE PAPER!!!]]

$ p = 0.0001 $
$ rho = -0.38 $

*This means there is a significant moderate negative correlation between GPA and Extensions Requested*

// ── Graph ────────────────────────────────────────────────────────────────────
//#text(weight: "bold")[Graph]
//#v(0.3em)
//#figure(
//  image("rq01_graph.png", width: 100%),
//  caption: [Average extensions requested by estimated GPA group.]
//)
//
//#pagebreak()
//
//// ─ Graph Description ────────────────────────────────────────────────────────
//#text(weight: "bold")[Graph Description]
//#v(0.3em)
//Bar chart — Average number of extensions requested per GPA group. \
//*X-axis:* Estimated GPA range \
//*Y-axis:* Average number of extensions \
//n counts displayed inside each bar.

#v(0.8em)

// ── Raw Values Summary ─────────────────────────────────────────────────────────

#text(weight: "bold")[Raw Values Summary]
#v(0.3em)

#text(weight: "bold")[OLD DATA]
+ GPA Group $2.0 - 2.49$ (with a count of $3$) has $1.3333$ average extensions used
+ GPA Group $2.5 - 2.99$ (with a count of $8$) has $1.875$ average extensions used
+ GPA Group $3.0 - 3.49$ (with a count of $17$) has $1.6471$ average extensions used
+ GPA Group $3.5 - 4.0$ (with a count of $41$) has $1.122$ average extensions used
+ GPA Group $4.0+$ (with a count of $8$) has $0.625$ average extensions used

#text(weight: "bold")[#highlight(fill: rgb("e2f8e1"))[NEW DATA]]
+ GPA Group $2.0 - 2.49$ (with a count of $5$) has $1.6000$ average extensions used
+ GPA Group $2.5 - 2.99$ (with a count of $12$) has $1.5000$ average extensions used
+ GPA Group $3.0 - 3.49$ (with a count of $24$) has $1.7500$ average extensions used
+ GPA Group $3.5 - 4.0$ (with a count of $42$) has $1.1905$ average extensions used
+ GPA Group $4.0+$ (with a count of $8$) has $0.500$ average extensions used

`
   GPA_Group  n Mean_Extensions
1 2.0 - 2.49  5          1.6000
2 2.5 - 2.99 12          1.5000
3 3.0 - 3.49 24          1.7500
4  3.5 - 4.0 42          1.1905
5       4.0+  8          0.5000
`

#v(0.8em)

// ── Statistical Note ─────────────────────────────────────────────────────────
#text(weight: "bold")[Statistical Note]
#v(0.3em)
*Test used:* Spearman Correlation \

*Result:* 
*OLD:* $rho = -0.43, p < 0.0001 $

*#highlight(fill: rgb("e2f8e1"))[NEW RESULT]* $ rho = -0.38, p = 0.00018 < 0.001 $

`
	Spearman's rank correlation rho

data:  Cleaned_RQ01_Data$GPA_Rank and Cleaned_RQ01_Data$num_exts_Requested
S = 173702, p-value = 0.0001775
alternative hypothesis: true rho is not equal to 0
sample estimates:
       rho 
-0.3831952
`


#v(0.8em)

// ── Conclusion ───────────────────────────────────────────────────────────────
#text(weight: "bold")[Conclusion]
#v(0.3em)
*OLD CONCLUSION:* Using a Spearman Correlation with a rho value of -0.43 and a P-value of < 0.0001. This means there is a moderate negative correlation; as the GPA increases, the number of extensions requested decreases. The bar graph shows a clear downward trend. The reason there are no entries for the “1.5 - 1.99” rank is due to no IRB approved students answering this. \

*NEW CONCLUSION:* Using a Spearman Correlation with a rho value of -0.38 and a P-value of < 0.001. This means there is a moderate negative correlation; as the GPA increases, the number of extensions requested decreases. The bar graph shows a clear downward trend. The reason there are no entries for the “1.5 - 1.99” rank is due to no IRB approved students answering this.
