######## RAW VALUES: RESEARCH QUESTION 2 ########
# Prints all x/y values and n counts displayed in the graph


SurveyData$num_exts <- as.numeric(as.character(SurveyData$num_exts))

SurveyData$Course_Code <- str_split(SurveyData$Class, ":", simplify = TRUE)[, 1]

Class_Data <- SurveyData %>%
  filter(!is.na(num_exts) & !is.na(Course_Code))

# Raw values: mean extensions and n count per course
raw_values <- Class_Data %>%
  group_by(Course = Course_Code) %>%
  summarise(
    n               = n(),
    Mean_Extensions = round(mean(num_exts, na.rm = TRUE), 4),
    .groups = "drop"
  ) %>%
  arrange(Course)

cat("=== RQ02: Average Extension Requests by Course ===\n")
cat("X-axis = Course Code | Y-axis = Mean Extensions | n = count of students\n\n")
print(as.data.frame(raw_values))
