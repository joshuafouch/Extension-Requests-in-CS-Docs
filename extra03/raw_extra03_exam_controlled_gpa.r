######## RAW VALUES: EXTRA 03 — Exam Scores Controlled for GPA ########
# Prints all x/y values and n counts displayed in the graph


# NOTE: 'object' must exist in your environment before running this script.
# It is the Table_Output data frame produced by extra01_exam_grade_table.r
# Run extra01_exam_grade_table.r first, then rename the result:
#   object <- Table_Output

Plot_Data <- object %>%
  filter(num_exts != "" & !is.na(Avg_Exam_Score)) %>%
  mutate(
    num_exts  = factor(num_exts, levels = c("0", "1", "2")),
    GPA_Range = factor(GPA_Range, levels = c("A Range (3.5 - 4.0)", "B Range (3.0 - 3.49)", "C/D Range (< 3.0)"))
  )

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
