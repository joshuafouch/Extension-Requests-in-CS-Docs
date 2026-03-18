####### Table of Exam Scores, Final Grades, Avg Extensions, etc... #############

# 1. Clean and Prepare Data
Extra01_Summary_Data <- SURVEYDATA_BIJECTION %>%
  # FILTER: Remove students who don't have a Final Exam Score (The "NA" lines)
  filter(!is.na(Final_Exam_Score)  & !is.na(Est_GPA)) %>%
  mutate(
    num_exts_Requested = as.character(num_exts_Requested),
    Final_Exam_Score = as.numeric(Final_Exam_Score),
    Final_Score = as.numeric(Course_Grade),
    
    # Categorize GPA
    GPA_Range = case_when(
      Est_GPA %in% c("4.0+", "3.5 - 4.0", "3.98", "3.96") ~ "A Range (3.5 - 4.0)",
      Est_GPA == "3.0 - 3.49" ~ "B Range (3.0 - 3.49)",
      Est_GPA %in% c("2.5 - 2.99", "2.0 - 2.49", "1.5 - 1.99") ~ "C/D Range (< 3.0)",
      TRUE ~ "Other"
    ),
    GPA_Range = factor(GPA_Range, levels = c("A Range (3.5 - 4.0)", "B Range (3.0 - 3.49)", "C/D Range (< 3.0)"))
  ) %>%
  filter(GPA_Range != "Other")

# 2. Create the Summary Table
Table_Output <- Extra01_Summary_Data %>%
  group_by(GPA_Range, num_exts_Requested) %>%
  summarise(
    Avg_Exam_Score = round(mean(Final_Exam_Score), 6),
    Avg_Final_Grade = round(mean(Final_Score), 6),
    Student_Count = n(),
    .groups = 'drop'
  )

# 3. View the Clean Table
print(Table_Output)
write.csv(Table_Output, "GPA_Extension_Analysis.csv", row.names = FALSE)
