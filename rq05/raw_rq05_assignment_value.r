######## RAW VALUES: RESEARCH QUESTION 5 ########
# Prints all x/y values and n counts displayed in the graph


if (!"Total_Extensions" %in% names(SurveyData) && "num_exts" %in% names(SurveyData)) {
  SurveyData$Total_Extensions <- as.numeric(SurveyData$num_exts)
}

H14_Data <- SurveyData %>%
  filter(!is.na(HW_ImportanceValue) & !is.na(Total_Extensions)) %>%
  mutate(
    User_Group = ifelse(Total_Extensions > 0, "Extension User", "Non-User"),
    Response = factor(HW_ImportanceValue,
                      levels = c("not at all", "not really", "yes, a little bit", "yes, definitely")),
    Response_Score = case_when(
      HW_ImportanceValue == "not at all"        ~ 1,
      HW_ImportanceValue == "not really"        ~ 2,
      HW_ImportanceValue == "yes, a little bit" ~ 3,
      HW_ImportanceValue == "yes, definitely"   ~ 4
    )
  )

# Raw values: count and proportion per group x response level
raw_values <- H14_Data %>%
  count(User_Group, Response, name = "n") %>%
  group_by(User_Group) %>%
  mutate(
    Group_Total  = sum(n),
    Proportion   = round(n / Group_Total * 100, 1)
  ) %>%
  ungroup()

# Group totals (n shown per bar in the graph)
group_totals <- H14_Data %>%
  count(User_Group, name = "Group_n")

cat("=== RQ05: Does the Extension Policy Devalue Assignments? ===\n")
cat("X-axis = Student Group | Y-axis = Proportion of students (stacked %)\n")
cat("Fill = HW Importance Response Level\n\n")
cat("Group totals (n per bar):\n")
print(as.data.frame(group_totals))
cat("\nDetailed breakdown (each segment of the stacked bar):\n")
print(as.data.frame(raw_values))
