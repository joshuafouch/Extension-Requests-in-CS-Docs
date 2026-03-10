######## RAW VALUES: EXTRA 03 — Exam Scores Controlled for GPA ########
# Prints all x/y values and n counts displayed in the graph


cat("=== EXTRA 03: Final Exam Performance by GPA Range & Extension Usage ===\n")
cat("X-axis = GPA Range | Y-axis = Average Final Exam Score (%)\n")
cat("Grouped bars by Extensions Used (0, 1, 2)\n")
cat("Score % labels above each bar; n= labels inside each bar\n\n")
cat("--- All bar values ---\n")
cat("Columns: GPA_Range | Extensions Used | Avg_Exam_Score | Student_Count (n)\n\n")

raw_values <- Plot_Data %>%
  select(GPA_Range, Extensions_Used = num_exts, Avg_Exam_Score, n = Student_Count) %>%
  arrange(GPA_Range, Extensions_Used)

print(as.data.frame(raw_values))

cat("\n--- Y-axis range shown in graph: 60 to 130 ---\n")
