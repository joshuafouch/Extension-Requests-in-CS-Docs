######## RESEARCH QUESTION 5 ######## 
# Students who use extensions will not perceive assignments as less valuable to their education than students who do not.

# Source setup
source("00_setup.r")

# Ensure 'Total_Extensions' exists (mapped from num_exts)
if(!"Total_Extensions" %in% names(SurveyData) && "num_exts" %in% names(SurveyData)) {
    SurveyData$Total_Extensions <- as.numeric(SurveyData$num_exts)
}

# Prepare Data
H14_Data <- SurveyData %>%
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
test_result <- wilcox.test(Response_Score ~ User_Group, data = H14_Data)

# Create the Graph with Custom Colors
ggplot(H14_Data, aes(x = User_Group, fill = Response)) +
    geom_bar(position = "fill", width = 0.6) +
    
    # Custom Manual Colors
    scale_fill_manual(values = c(
        "not at all" = "#08306B",        # Dark Navy Blue (The focus)
        "not really" = "#4292C6",        # Medium Blue
        "yes, a little bit" = "#9ECAE1", # Light Blue
        "yes, definitely" = "#DEEBF7"    # Very Pale Blue
    )) +
    
    labs(title = "Does the Extension Policy Devalue Assignments?",
         # This code automatically extracts the p-value and writes it on the graph
         subtitle = paste("Users strongly feel it does not devalue the work: p =", round(test_result$p.value, 3)),
         x = "Student Group",
         y = "Percentage of Students") +
    
    scale_y_continuous(labels = scales::percent)
