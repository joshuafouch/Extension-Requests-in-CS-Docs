######## RAW VALUES: RESEARCH QUESTION 4 ########
# Prints all x/y values and n counts displayed in the graph


H12_Data <- SurveyData %>%
  mutate(
    Opinion = case_when(
      is.na(Extension_Impact_onQuality) | Extension_Impact_onQuality == "" ~ "Did Not Answer",
      str_detect(Extension_Impact_onQuality, regex("better", ignore_case = TRUE)) ~ "Made Course Better",
      str_detect(Extension_Impact_onQuality, regex("worse",  ignore_case = TRUE)) ~ "Made Course Worse",
      str_detect(Extension_Impact_onQuality, regex("no impact", ignore_case = TRUE)) ~ "No Impact"
    )
  )

# Raw values: count and percentage per opinion category
raw_values <- H12_Data %>%
  count(Opinion, name = "n") %>%
  mutate(Percentage = round(n / sum(n) * 100, 1))

cat("=== RQ04: Did the Extension Policy Improve the Course? ===\n")
cat("X-axis = Opinion Category | Y-axis = Number of Students (n)\n")
cat("Labels on graph: n=XX and percentage\n\n")
print(as.data.frame(raw_values))
cat("\nTotal students:", sum(raw_values$n), "\n")
