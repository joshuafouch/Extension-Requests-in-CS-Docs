######## RAW VALUES: RESEARCH QUESTION 3 ########
# Prints all x/y values and n counts displayed in the graph


ReasonData <- SURVEYDATA %>%
  filter(!is.na(Reason_Used)) %>%
  separate_rows(Reason_Used, sep = ";") %>%
  mutate(Reason_Used = trimws(Reason_Used)) %>%
  filter(Reason_Used != "")

ReasonCounts <- ReasonData %>%
  count(Reason_Used, sort = TRUE, name = "Count")

# Raw values: top 5 reasons (the bars shown in the graph)
raw_values <- ReasonCounts[1:5, ]

cat("=== RQ03: Top 5 Reasons for Requesting Extensions ===\n")
cat("X-axis (flipped) = Reason | Y-axis = Number of Students (Count)\n")
cat("Note: each student may contribute to multiple reasons.\n\n")
cat("All reasons with counts:\n")
print(as.data.frame(ReasonCounts))
cat("\nTop 5 shown in graph:\n")
print(as.data.frame(raw_values))
