######## RAW VALUES: RESEARCH QUESTION 9 ########
# Prints all x/y values and n counts displayed in the graph


Year_Data <- SurveyData %>%
  filter(!is.na(num_exts) & Year %in% c("Freshman", "Sophomore", "Junior", "Senior")) %>%
  mutate(
    num_exts = as.numeric(num_exts),
    Year = factor(Year, levels = c("Freshman", "Sophomore", "Junior", "Senior"))
  )

aov_model <- aov(num_exts ~ Year, data = Year_Data)
p_val     <- summary(aov_model)[[1]][["Pr(>F)"]][1]

# Raw values: mean extensions and n count per year level
raw_values <- Year_Data %>%
  group_by(Year) %>%
  summarise(
    n               = n(),
    Mean_Extensions = round(mean(num_exts, na.rm = TRUE), 4),
    .groups = "drop"
  )

cat("=== RQ09: Extension Usage by Year ===\n")
cat("X-axis = Year Level | Y-axis = Average Extensions Used\n")
cat("n labels shown above each bar\n\n")
print(as.data.frame(raw_values))
cat("\nANOVA p-value:", round(p_val, 3), "\n")
