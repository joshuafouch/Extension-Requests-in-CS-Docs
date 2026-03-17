######## RAW VALUES: RESEARCH QUESTION 8 ########
# Prints all x/y values and n counts displayed in the graph


Year_Data <- SURVEYDATA_BIJECTION %>%
  filter(!is.na(num_exts_Requested) & Year %in% c("Freshman", "Sophomore", "Junior", "Senior")) %>%
  mutate(
    exts_req = as.numeric(num_exts_Requested),
    Year = factor(Year, levels = c("Freshman", "Sophomore", "Junior", "Senior"))
  )

year_data_aov_model <- aov(num_exts_Requested ~ Year, data = Year_Data)
year_data_p_val     <- summary(year_data_aov_model)[[1]][["Pr(>F)"]][1]

# change num_exts_Requested to a numeric
Year_Data$num_exts_Requested <- as.numeric(as.character(Year_Data$num_exts_Requested))

# Raw values: mean extensions and n count per year level
year_data_raw_values <- Year_Data %>%
  group_by(Year) %>%
  summarise(
    n               = n(),
    Mean_Extensions = round(mean(num_exts_Requested, na.rm = TRUE), 4),
    .groups = "drop"
  )

cat("=== RQ08: Extension Usage by Year ===\n")
cat("X-axis = Year Level | Y-axis = Average Extensions Used\n")
cat("n labels shown above each bar\n\n")
print(as.data.frame(year_data_raw_values))
cat("\nANOVA p-value:", round(year_data_p_val, 3), "\n")
