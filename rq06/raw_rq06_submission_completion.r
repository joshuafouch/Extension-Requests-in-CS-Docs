######## RAW VALUES: RESEARCH QUESTION 6 ########
# Prints all x/y values and n counts displayed in the graph (pie chart)


SURVEYDATA <- SURVEYDATA %>%
  mutate(
    num_exts = as.numeric(as.character(num_exts)),
    num_of_no_submissions_with_extensions = as.numeric(as.character(num_of_no_submissions_with_extensions)),
    Final_Score = as.numeric(as.character(Final_Score)),
    ext_1_reqd_correctly = as.numeric(as.character(ext_1_reqd_correctly)),
    num_of_late_submissions_with_extensions = as.numeric(as.character(num_of_late_submissions_with_extensions)),
    num_of_late_submissions_without_extensions = as.numeric(as.character(num_of_late_submissions_without_extensions))
  )

Extension_Users <- Data %>%
  filter(num_exts > 0)

Total_Requests  <- sum(Extension_Users$num_exts, na.rm = TRUE)
Total_Ghosts    <- sum(Extension_Users$num_of_no_submissions_with_extensions, na.rm = TRUE)
Total_Completed <- Total_Requests - Total_Ghosts
Completion_Rate <- round(100 - (Total_Ghosts / Total_Requests * 100), 1)
Ghost_Rate      <- round(Total_Ghosts / Total_Requests * 100, 1)

Status_DF <- data.frame(
  Status     = c("Work Completed", "Work Ghosted (Not Submitted)"),
  Count      = c(Total_Completed, Total_Ghosts),
  Percentage = c(round(Total_Completed / Total_Requests * 100, 1),
                 round(Total_Ghosts    / Total_Requests * 100, 1))
)

cat("=== RQ06: Do Extensions Lead to 'Ghosting'? ===\n")
cat("Pie chart slices: Work Completed vs Work Ghosted\n\n")
cat("--- Extension User Summary ---\n")
cat("Number of students who requested extensions:", nrow(Extension_Users), "\n")
cat("Total extension requests (num_exts sum)    :", Total_Requests, "\n")
cat("Total ghosted (no submission)              :", Total_Ghosts, "\n")
cat("Total completed                            :", Total_Completed, "\n")
cat("Completion Rate                            :", Completion_Rate, "%\n")
cat("Ghost Rate                                 :", Ghost_Rate, "%\n\n")
cat("--- Pie Chart Values ---\n")
print(as.data.frame(Status_DF))
