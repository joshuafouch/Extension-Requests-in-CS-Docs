######## RESEARCH QUESTION 4 ######## 
# The availability of automated, no-questions-asked extensions will increase students' overall sense of fairness and psychological safety in the course.

# Source setup
source("00_setup.r")

# Prepare Data
H12_Data <- SurveyData %>%
    mutate(
        Opinion = case_when(
            is.na(Extension_Impact_onQuality) | Extension_Impact_onQuality == "" ~ "Did Not Answer",
            str_detect(Extension_Impact_onQuality, regex("better", ignore_case = TRUE)) ~ "Made Course Better",
            str_detect(Extension_Impact_onQuality, regex("worse", ignore_case = TRUE)) ~ "Made Course Worse",
            str_detect(Extension_Impact_onQuality, regex("no impact", ignore_case = TRUE)) ~ "No Impact"
        )
    )

# Plot the Graph
ggplot(H12_Data, aes(x = Opinion, fill = Opinion, linetype = Opinion)) +
    
    # THICK LINES: size = 1.2 makes the border thick
    geom_bar(stat = "count", color = "gray30", size = 1.2, width = 0.7) +
    
    # Add labels with "n=" prefix
    geom_text(stat = "count", aes(label = paste0("n=", ..count.., "\n(", round(..count../sum(..count..)*100, 1), "%)")), 
              vjust = -0.2, size = 4.5, fontface = "bold", color = "gray30") +
    
    labs(title = "Did the Extension Policy Improve the Course?",
         subtitle = "Student Perceptions (Non-Respondents shown in dashed gray)",
         x = "", 
         y = "Number of Students") +
    
    # Custom Colors
    scale_fill_manual(values = c("Made Course Better" = "#66c2a5", 
                                 "No Impact" = "#999999", 
                                 "Made Course Worse" = "#fc8d62",
                                 "Did Not Answer" = "#f2f2f2")) + 
    
    # Custom Line Types: "Did Not Answer" gets a dashed border
    scale_linetype_manual(values = c("Made Course Better" = "solid", 
                                     "No Impact" = "solid", 
                                     "Made Course Worse" = "solid",
                                     "Did Not Answer" = "22")) + 
    
    theme_minimal() +
    theme(legend.position = "none")
