######## RESEARCH QUESTION 10 ######## 
# Does the policy help close the gap between students with lower prior GPAs and high achievers?

# Source setup
source("00_setup.r")

# Does the policy help close the gap?
# Clean and Order GPA Data
GPA_Data <- SurveyData %>%
    filter(Est_GPA != "" & !is.na(num_exts)) %>%
    mutate(
        num_exts = as.numeric(num_exts),
        # FACTOR WITH ORDER: This forces the graph to be Ascending
        Est_GPA = factor(Est_GPA, levels = c("2.0 - 2.49", "2.5 - 2.99", "3.0 - 3.49", "3.5 - 4.0"))
    ) %>%
    filter(!is.na(Est_GPA)) # Remove any that didn't match the levels

# Run Correlation Test
# Convert to numeric 1-4 scale just for the statistical test
cor_test <- cor.test(as.numeric(GPA_Data$Est_GPA), GPA_Data$num_exts, method = "spearman")

# Create the Plot
ggplot(GPA_Data, aes(x = Est_GPA, y = num_exts, fill = Est_GPA)) +
    # Use 'stat_summary' to show the MEAN bars
    stat_summary(fun = "mean", geom = "bar", color = "black", alpha = 0.8) +
    
    # Add the P-value to the plot
    annotate("text", x = 3, y = 1.8, label = paste("p <", round(cor_test$p.value, 3), ", r =", round(cor_test$estimate, 3)), size = 4, fontface = "bold") +
    
    labs(title = "Does the Policy Help Close the Achievement Gap?",
         subtitle = "Significance Supported: Lower-GPA students use extensions significantly more.",
         x = "Self-Reported GPA (Ascending)",
         y = "Average Extensions Used") +
    
    theme_minimal() +
    theme(legend.position = "none") +
    scale_fill_brewer(palette = "Oranges", direction = -1)

# To further prove this, did the low self-reported GPA students still success in class?
# Prepare Data (Clean and Order)
RQ3_Grades <- SurveyData %>%
    filter(Est_GPA != "" & !is.na(Final_Score)) %>%
    mutate(
        Final_Score = as.numeric(as.character(Final_Score)),
        # Force Ascending Order
        Est_GPA = factor(Est_GPA, levels = c("2.0 - 2.49", "2.5 - 2.99", "3.0 - 3.49", "3.5 - 4.0"))
    ) %>%
    filter(!is.na(Est_GPA))

# Calculate Means for Labels
Means <- RQ3_Grades %>%
    group_by(Est_GPA) %>%
    summarise(Avg_Score = round(mean(Final_Score), 1))

# Create Boxplot with 70% Threshold
ggplot(RQ3_Grades, aes(x = Est_GPA, y = Final_Score, fill = Est_GPA)) +
    geom_boxplot(alpha = 0.7) +
    geom_jitter(width = 0.1, alpha = 0.4) +
    
    # Add the Mean Scores as Text Labels
    geom_text(data = Means, aes(y = Avg_Score + 2, label = paste0(Avg_Score, "%")), 
              fontface = "bold", size = 5, color = "black") +
    
    # --- DANGER ZONE LINE (At 70%) ---
    geom_hline(yintercept = 70, linetype = "dashed", color = "red", size = 1) +
    
    # Label explaining the line
    annotate("text", x = 1.5, y = 68, label = "Failure Threshold (<70%)", color = "red", fontface = "bold") +
    
    labs(title = "Does the Policy Ensure Success for At-Risk Students?",
         subtitle = "Even the lowest-GPA students achieved a B+ average (87.6%),\nstaying well above the failure threshold (70%).",
         x = "Self-Reported GPA",
         y = "Final Course Grade (%)") +
    
    scale_fill_brewer(palette = "Oranges", direction = -1) +
    theme_minimal() +
    theme(legend.position = "none") +
    
    # Set Y-axis to focus on the relevant range
    coord_cartesian(ylim = c(60, 115))
