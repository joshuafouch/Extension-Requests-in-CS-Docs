######## RESEARCH QUESTION 7 ######## 
# How many extension requests were submitted correctly and on time according to the protocol?

# Prepare Data
# Positive Value = Days BEFORE deadline (Good)
# Negative Value = Days AFTER deadline (Bad)
Compliance_Data <- SurveyData %>%
  filter(!is.na(ext_1_reqd_correctly)) %>%
  mutate(
    Timing = ifelse(ext_1_reqd_correctly >= 0, "Correct (In Advance)", "Incorrect (After Deadline)")
  )

# Histogram
ggplot(Compliance_Data, aes(x = ext_1_reqd_correctly, fill = Timing)) +
  geom_histogram(binwidth = 1, color = "black", alpha = 0.7) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "black", size = 1) +
  
  labs(title = "When Do Students Request Extensions?",
       subtitle = "Values > 0 indicate requests made in advance (Compliance)",
       x = "Days Before Deadline (Negative = Late Request)",
       y = "Number of Requests") +
  
  scale_fill_manual(values = c("Correct (In Advance)" = "gray30", "Incorrect (After Deadline)" = "lightgray")) +
  theme_minimal()
