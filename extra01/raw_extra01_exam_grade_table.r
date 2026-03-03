######## RAW VALUES: EXTRA 01 — Exam Grade Table ########
# Prints the full summary table produced by this script


library(dplyr)

SurveyData <- read.csv("surveydata.csv", stringsAsFactors = FALSE)

Summary_Data <- SurveyData %>%
  filter(!is.na(Final_Exam_Score) & !is.na(num_exts) & !is.na(Est_GPA)) %>%
  mutate(
    num_exts        = as.character(num_exts),
    Final_Exam_Score = as.numeric(Final_Exam_Score),
    Final_Score      = as.numeric(Final_Score),
    GPA_Range = case_when(
      Est_GPA %in% c("4.0+", "3.5 - 4.0", "3.98", "3.96") ~ "A Range (3.5 - 4.0)",
      Est_GPA == "3.0 - 3.49"                               ~ "B Range (3.0 - 3.49)",
      Est_GPA %in% c("2.5 - 2.99", "2.0 - 2.49", "1.5 - 1.99") ~ "C/D Range (< 3.0)",
      TRUE ~ "Other"
    ),
    GPA_Range = factor(GPA_Range, levels = c("A Range (3.5 - 4.0)", "B Range (3.0 - 3.49)", "C/D Range (< 3.0)"))
  ) %>%
  filter(GPA_Range != "Other")

Table_Output <- Summary_Data %>%
  group_by(GPA_Range, num_exts) %>%
  summarise(
    Avg_Exam_Score  = round(mean(Final_Exam_Score), 2),
    Avg_Final_Grade = round(mean(Final_Score), 2),
    Student_Count   = n(),
    .groups = "drop"
  )

cat("=== EXTRA 01: Exam Scores, Final Grades, Extensions by GPA Range ===\n")
cat("Rows: GPA Range x Extensions Used\n")
cat("Avg_Exam_Score = mean final exam score | Avg_Final_Grade = mean final course grade\n")
cat("Student_Count = n per cell\n\n")
print(as.data.frame(Table_Output))

# Marginal totals
cat("\n--- Marginal n by GPA Range ---\n")
print(as.data.frame(Table_Output %>% group_by(GPA_Range) %>%
  summarise(Total_n = sum(Student_Count), .groups = "drop")))

cat("\n--- Marginal n by Extensions Used ---\n")
print(as.data.frame(Table_Output %>% group_by(num_exts) %>%
  summarise(Total_n = sum(Student_Count), .groups = "drop")))
