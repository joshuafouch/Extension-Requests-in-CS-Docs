######## RAW VALUES: RESEARCH QUESTION 6 ########
# Prints all x/y values and n counts displayed in the graph
# (Density plot: reports summary stats and bin-level density estimates)


RQ2_Data <- SurveyData %>%
  filter(!is.na(Final_Score) & Strict_Deadline_Effect != "") %>%
  mutate(Final_Score = as.numeric(as.character(Final_Score))) %>%
  filter(Strict_Deadline_Effect != "This policy would make the course significantly better") %>%
  mutate(
    Opinion = case_when(
      Strict_Deadline_Effect == "This policy would make the course significantly worse"          ~ "Strictness = Worse Quality",
      Strict_Deadline_Effect == "This policy would not impact the quality of the course overall" ~ "Strictness = No Impact"
    )
  )

t_test_result <- t.test(Final_Score ~ Opinion, data = RQ2_Data)

# Group-level summary stats
group_summary <- RQ2_Data %>%
  group_by(Opinion) %>%
  summarise(
    n        = n(),
    Mean     = round(mean(Final_Score, na.rm = TRUE), 2),
    Median   = round(median(Final_Score, na.rm = TRUE), 2),
    SD       = round(sd(Final_Score, na.rm = TRUE), 2),
    Min      = min(Final_Score, na.rm = TRUE),
    Max      = max(Final_Score, na.rm = TRUE),
    .groups  = "drop"
  )

# Density values at each observed Final_Score per group
density_values <- RQ2_Data %>%
  group_by(Opinion) %>%
  summarise(
    density_data = list({
      d <- density(Final_Score, na.rm = TRUE)
      data.frame(x = round(d$x, 2), density = round(d$y, 6))
    }),
    .groups = "drop"
  ) %>%
  tidyr::unnest(density_data)

cat("=== RQ06: Does Disliking Strict Deadlines Predict Lower Grades? ===\n")
cat("X-axis = Final Course Grade (%) | Y-axis = Density of Students\n")
cat("Graph is zoomed to x: 60-110\n\n")
cat("--- Group Summary Statistics ---\n")
print(as.data.frame(group_summary))
cat("\nt-test p-value:", round(t_test_result$p.value, 3), "\n")
cat("\n--- Full Density Curve Values (x = grade, density = height of curve) ---\n")
print(as.data.frame(density_values))
