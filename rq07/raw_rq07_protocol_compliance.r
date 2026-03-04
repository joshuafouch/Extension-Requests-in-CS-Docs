######## RAW VALUES: RESEARCH QUESTION 7 ########
# Prints all x/y values and n counts displayed in the graph (histogram)


Compliance_Data <- SurveyData %>%
  filter(!is.na(ext_1_reqd_correctly)) %>%
  mutate(
    Timing = ifelse(ext_1_reqd_correctly >= 0, "Correct (In Advance)", "Incorrect (After Deadline)")
  )

# Histogram bin counts (binwidth = 1, matching the graph)
bin_counts <- Compliance_Data %>%
  mutate(bin = floor(ext_1_reqd_correctly)) %>%
  count(Timing, bin, name = "Count") %>%
  rename(Days_Before_Deadline = bin) %>%
  arrange(Timing, Days_Before_Deadline)

# Overall group summary
group_summary <- Compliance_Data %>%
  group_by(Timing) %>%
  summarise(
    n      = n(),
    Mean   = round(mean(ext_1_reqd_correctly, na.rm = TRUE), 2),
    Median = round(median(ext_1_reqd_correctly, na.rm = TRUE), 2),
    Min    = min(ext_1_reqd_correctly, na.rm = TRUE),
    Max    = max(ext_1_reqd_correctly, na.rm = TRUE),
    .groups = "drop"
  )

cat("=== RQ07: When Do Students Request Extensions? ===\n")
cat("X-axis = Days Before Deadline (negative = late request)\n")
cat("Y-axis = Number of Requests per bin (binwidth = 1 day)\n")
cat("Vertical dashed line at x = 0\n\n")
cat("--- Group Summary ---\n")
print(as.data.frame(group_summary))
cat("\nTotal requests plotted:", nrow(Compliance_Data), "\n")
cat("\n--- Histogram Bin Counts (each row = one bar) ---\n")
print(as.data.frame(bin_counts))
