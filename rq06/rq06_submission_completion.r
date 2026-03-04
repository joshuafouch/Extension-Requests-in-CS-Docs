######## RESEARCH QUESTION 6 ######## 
# Of the students who requested extensions, what percentage were never submitted versus the percentage that were submitted?

# Force columns to be numeric to avoid the "Invalid Type" error
SURVEYDATA <- SURVEYDATA %>%
  mutate(
    num_exts = as.numeric(as.character(num_exts)),
    num_of_no_submissions_with_extensions = as.numeric(as.character(num_of_no_submissions_with_extensions)),
    Final_Score = as.numeric(as.character(Final_Score)),
    ext_1_reqd_correctly = as.numeric(as.character(ext_1_reqd_correctly)),
    num_of_late_submissions_with_extensions = as.numeric(as.character(num_of_late_submissions_with_extensions)),
    num_of_late_submissions_without_extensions = as.numeric(as.character(num_of_late_submissions_without_extensions))
  )


Extension_Users <- SurveyData %>%
  filter(num_exts > 0)

# Calculate Stats
Total_Requests <- sum(Extension_Users$num_exts, na.rm = TRUE)
Total_Ghosts <- sum(Extension_Users$num_of_no_submissions_with_extensions, na.rm = TRUE)

# Calculate Rates
Completion_Rate <- round(100 - (Total_Ghosts / Total_Requests * 100), 1)

# Create Pie Chart
Status_DF <- data.frame(
  Status = c("Work Completed", "Work Ghosted (Not Submitted)"),
  Count = c(Total_Requests - Total_Ghosts, Total_Ghosts)
)

ggplot(Status_DF, aes(x = "", y = Count, fill = Status)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste0(round(Count / sum(Count) * 100, 1), "%")), 
            position = position_stack(vjust = 0.5), color = "white", fontface = "bold", size = 5) +
  labs(title = "Do Extensions Lead to 'Ghosting'?",
       subtitle = paste("Completion Rate:", Completion_Rate, "% - Students almost always do the work."),
       fill = "Outcome") +
  scale_fill_manual(values = c("Work Completed" = "gray20", "Work Ghosted (Not Submitted)" = "darkgray")) +
  theme_void()
