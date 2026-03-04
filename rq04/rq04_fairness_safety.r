######## RESEARCH QUESTION 4 ######## 
# The availability of automated, no-questions-asked extensions will increase students' overall sense of fairness and psychological safety in the course.

# Prepare Data
RQ4_Data <- SurveyData %>%
    mutate(
        Opinion = case_when(
            is.na(Extension_Impact_onQuality) | Extension_Impact_onQuality == "" ~ "Did Not Answer",
            str_detect(Extension_Impact_onQuality, regex("better", ignore_case = TRUE)) ~ "Made Course Better",
            str_detect(Extension_Impact_onQuality, regex("worse", ignore_case = TRUE)) ~ "Made Course Worse",
            str_detect(Extension_Impact_onQuality, regex("no impact", ignore_case = TRUE)) ~ "No Impact"
        )
    )

# Plot the Graph
ggplot(RQ4_Data, aes(x = Opinion, fill = Opinion, linetype = Opinion)) +
    
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
    scale_fill_manual(values = c("Made Course Better" = "darkgray", 
                                 "No Impact" = "gray", 
                                 "Made Course Worse" = "lightgray",
                                 "Did Not Answer" = "#f2f2f2")) + 
    
    # Custom Line Types: "Did Not Answer" gets a dashed border
    scale_linetype_manual(values = c("Made Course Better" = "solid", 
                                     "No Impact" = "solid", 
                                     "Made Course Worse" = "solid",
                                     "Did Not Answer" = "22")) + 
    
    theme_minimal() +
    theme(legend.position = "none")

# proportions test
# 1. Filter out the people who didn't answer so we only test valid opinions
Valid_Opinions <- RQ4_Data %>%
    filter(Opinion != "Did Not Answer" & !is.na(Opinion))

# 2. Count how many said "Made Course Better" vs Total valid responses
better_count <- sum(Valid_Opinions$Opinion == "Made Course Better")
total_count <- nrow(Valid_Opinions)

# 3. Run the Proportion Test 
# (Testing if the proportion is significantly greater than 50%)
prop.test(x = better_count, n = total_count, p = 0.5, alternative = "greater")
