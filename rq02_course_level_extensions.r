######## RESEARCH QUESTION 2 ######## 
# Students in lower-division (freshman/sophomore) courses will request extensions more frequently than those in upper-division (junior) courses.

# Source setup
source("00_setup.r")

# Ensure extensions are numeric
SurveyData$num_exts <- as.numeric(as.character(SurveyData$num_exts))

# Prepare Data
# Split "CSC 144: Object Oriented..." to just "CSC 144"
SurveyData$Course_Code <- str_split(SurveyData$Class, ":", simplify = TRUE)[, 1]

# Filter out rows with missing extensions or course codes
Class_Data <- SurveyData %>% 
    filter(!is.na(num_exts) & !is.na(Course_Code))

# Calculate Counts (n) manually for labels
Labels <- Class_Data %>%
    group_by(Course_Code) %>%
    summarise(
        y_pos = 0.1,  # Place text near bottom
        Count = n()   # Count students per class
    )

# Plot with Labels
ggplot(Class_Data, aes(x = Course_Code, y = num_exts, fill = Course_Code)) +
    stat_summary(fun = mean, geom = "bar", color = "black") +
    stat_summary(fun.data = mean_cl_normal, geom = "errorbar", width = 0.2) +
    
    # Add "n=XX" labels at the bottom of bars
    geom_text(data = Labels, aes(y = y_pos, label = paste0("n=", Count)), 
              color = "white", fontface = "bold", vjust = 0) +
    
    labs(title = "Average Extension Requests by Course",
         x = "Course", 
         y = "Average Number of Extensions") +
    theme_minimal() +
    theme(legend.position = "none", 
          axis.text.x = element_text(angle = 45, hjust = 1)) +
    coord_cartesian(ylim = c(0, 2.5))
