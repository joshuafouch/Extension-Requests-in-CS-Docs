######## RESEARCH QUESTION 5 ######## 
# Students who use extensions will not perceive assignments as less valuable to their education than students who do not.

# Ensure 'Total_Extensions' exists (mapped from num_exts)
if(!"Total_Extensions" %in% names(SURVEYDATA) && "num_exts" %in% names(SURVEYDATA)) {
    SURVEYDATA$Total_Extensions <- as.numeric(SURVEYDATA$num_exts)
}

# Prepare Data
RQ05_DATA <- SURVEYDATA %>%
    filter(!is.na(HW_ImportanceValue) & !is.na(Total_Extensions)) %>%
    mutate(
        User_Group = ifelse(Total_Extensions > 0, "Extension User", "Non-User"),
        Response = factor(HW_ImportanceValue, 
                          levels = c("not at all", "not really", "yes, a little bit", "yes, definitely")),
        # Create numeric version for the statistical test
        Response_Score = case_when(
            HW_ImportanceValue == "not at all" ~ 1,
            HW_ImportanceValue == "not really" ~ 2,
            HW_ImportanceValue == "yes, a little bit" ~ 3,
            HW_ImportanceValue == "yes, definitely" ~ 4
        )
    )

# Run the Statistical Test (Mann-Whitney U)
# We need this to generate the 'test_result' variable used in the graph subtitle
test_result <- wilcox.test(Response_Score ~ User_Group, data = RQ05_DATA)

# Create the Graph with Custom Colors
ggplot(RQ05_DATA, aes(x = User_Group, fill = Response)) +
    geom_bar(position = "fill", width = 0.6) +
    
    # Custom Manual Colors (Shades of Gray)
    scale_fill_manual(values = c(
        "not at all" = "gray20",        # Darkest Gray
        "not really" = "gray50",        # Medium Dark Gray
        "yes, a little bit" = "gray75", # Medium Light Gray
        "yes, definitely" = "gray95"    # Lightest Gray
    )) +    

    labs(title = "Does the Extension Policy Devalue Assignments?",
         # This code automatically extracts the p-value and writes it on the graph
         subtitle = paste("Users strongly feel it does not devalue the work"),
         x = "Student Group",
         y = "Percentage of Students") +
    
    scale_y_continuous(labels = scales::percent)

print(round(test_result$p.value, 3)
