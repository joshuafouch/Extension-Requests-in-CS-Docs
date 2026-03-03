######## RESEARCH QUESTION 6 ######## 
# Do students believe that strict deadlines would improve their learning, or does the policy's flexibility allow for higher quality work?

# Source setup
source("00_setup.r")

# Prepare Data (Filter out the single outlier)
RQ2_Data <- SurveyData %>%
    filter(!is.na(Final_Score) & Strict_Deadline_Effect != "") %>%
    mutate(Final_Score = as.numeric(as.character(Final_Score))) %>%
    filter(Strict_Deadline_Effect != "This policy would make the course significantly better") %>%
    mutate(
        Opinion = case_when(
            Strict_Deadline_Effect == "This policy would make the course significantly worse" ~ "Strictness = Worse Quality",
            Strict_Deadline_Effect == "This policy would not impact the quality of the course overall" ~ "Strictness = No Impact"
        )
    )

# Calculate P-Value
t_test_result <- t.test(Final_Score ~ Opinion, data = RQ2_Data)
p_val_text <- paste0("p = ", round(t_test_result$p.value, 3))

# Create the Density Plot
ggplot(RQ2_Data, aes(x = Final_Score, fill = Opinion)) +
    # Draw distributions
    geom_density(alpha = 0.5) +
    
    labs(title = "Does Disliking Strict Deadlines Predict Lower Grades?",
         # DYNAMIC SUBTITLE: Puts the p-value right here
         subtitle = paste0("No. Students who need flexibility perform just as well as those who don't. (", p_val_text, ")"),
         x = "Final Course Grade (%)",
         y = "Density of Students",
         fill = "Student Opinion") +
    
    scale_fill_manual(values = c("Strictness = Worse Quality" = "#e74c3c", "Strictness = No Impact" = "#3498db")) +
    theme_minimal() +
    
    # Zoom in on passing grades
    coord_cartesian(xlim = c(60, 110))
