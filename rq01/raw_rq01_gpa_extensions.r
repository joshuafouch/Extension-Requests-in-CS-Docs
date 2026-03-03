######## RAW VALUES: RESEARCH QUESTION 1 ########
# Prints all x/y values and n counts displayed in the graph


SurveyData <- read.csv("Aggregate_Survey+Grade_Data - SurveyData AnonimizedReconciled(1).csv", stringsAsFactors = FALSE)

SurveyData$num_exts <- as.numeric(as.character(SurveyData$num_exts))

SurveyData$Est_GPA[SurveyData$Est_GPA == "3.98"] <- "3.5 - 4.0"
SurveyData$Est_GPA[SurveyData$Est_GPA == "3.96"] <- "3.5 - 4.0"

gpa_levels <- c("1.5 - 1.99", "2.0 - 2.49", "2.5 - 2.99", "3.0 - 3.49", "3.5 - 4.0", "4.0+")
SurveyData$Est_GPA_Factor <- factor(SurveyData$Est_GPA, levels = gpa_levels)

# Raw values: mean extensions and n count per GPA group
raw_values <- SurveyData %>%
  filter(!is.na(Est_GPA_Factor) & !is.na(num_exts)) %>%
  group_by(GPA_Group = Est_GPA_Factor) %>%
  summarise(
    n          = n(),
    Mean_Extensions = round(mean(num_exts, na.rm = TRUE), 4),
    .groups = "drop"
  )

cat("=== RQ01: Average Extensions Requested by Estimated GPA ===\n")
cat("X-axis = GPA Group | Y-axis = Mean Extensions | n = count of students\n\n")
print(as.data.frame(raw_values))
