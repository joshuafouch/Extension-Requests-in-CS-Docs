######## RAW VALUES: EXTRA 02 — Exam Scores vs Extensions Used ########
# Prints all x/y values and n counts displayed in the graph


Exam_Data <- SURVEYDATA %>%
  mutate(
    num_exts         = as.numeric(as.character(num_exts)),
    Final_Exam_Score = as.numeric(Final_Exam_Score)
  ) %>%
  filter(!is.na(num_exts) & !is.na(Final_Exam_Score)) %>%
  mutate(
    Extension_Group = factor(num_exts, levels = c(0, 1, 2),
                             labels = c("0 Extensions", "1 Extension", "2 Extensions"))
  )

anova_model <- aov(Final_Exam_Score ~ Extension_Group, data = Exam_Data)
p_val       <- summary(anova_model)[[1]][["Pr(>F)"]][1]

# Raw values: mean exam score and n count per extension group
raw_values <- Exam_Data %>%
  group_by(Extension_Group) %>%
  summarise(
    n                    = n(),
    Mean_Exam_Score      = round(mean(Final_Exam_Score, na.rm = TRUE), 1),
    .groups = "drop"
  )

cat("=== EXTRA 02: Final Exam Performance by Extension Usage ===\n")
cat("X-axis = Extension Group | Y-axis = Average Final Exam Score (%)\n")
cat("n labels shown inside bars; mean % shown above bars\n\n")
print(as.data.frame(raw_values))
cat("\nANOVA p-value:", round(p_val, 3), "\n")
