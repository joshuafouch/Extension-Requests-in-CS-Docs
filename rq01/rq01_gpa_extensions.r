######## RESEARCH QUESTION 1 ######## 
# Students with lower starting GPAs are more likely to request extensions than students with higher starting GPAs.

# Source setup
source("00_setup.r")

# 1. Load Data
SurveyData <- read.csv("Aggregate_Survey+Grade_Data - SurveyData AnonimizedReconciled(1).csv", stringsAsFactors = FALSE)

# Fix non-numeric extension column
SurveyData$num_exts <- as.numeric(as.character(SurveyData$num_exts))

# Fix inconsistent GPA labels
SurveyData$Est_GPA[SurveyData$Est_GPA == "3.98"] <- "3.5 - 4.0"
SurveyData$Est_GPA[SurveyData$Est_GPA == "3.96"] <- "3.5 - 4.0"

# Define Order
gpa_levels <- c("1.5 - 1.99", "2.0 - 2.49", "2.5 - 2.99", "3.0 - 3.49", "3.5 - 4.0", "4.0+")
SurveyData$Est_GPA_Factor <- factor(SurveyData$Est_GPA, levels = gpa_levels)
SurveyData$GPA_Rank <- as.numeric(SurveyData$Est_GPA_Factor)

# 3. Statistical Test (Spearman Correlation)
print(cor.test(SurveyData$GPA_Rank, SurveyData$num_exts, method = "spearman"))

# 4. Visualization
ggplot(subset(SurveyData, !is.na(Est_GPA_Factor)), aes(x = Est_GPA_Factor, y = num_exts)) + 
  
  stat_summary(fun = mean, geom = "bar", fill = "darkgreen", color = "black", width = 0.7) + 
  
  stat_summary(fun.data = function(x){
    return(data.frame(y = mean(x), label = paste0("n=", length(x))))
  }, geom = "text", fontface = "bold", color = "white", vjust = 1.5, size = 5) + 
  
  labs(title = "Average Extensions Requested \n by Estimated GPA", 
       x = "Estimated GPA", 
       y = "Average Number of Extensions") + 
  
  theme_minimal() + 
  theme(axis.title.x = element_text(vjust = -0.4),
        axis.title.y = element_text(vjust = 0.3),
        plot.title = element_text(hjust = 0.5, face = "bold")) + 
  
  coord_cartesian(ylim = c(0, 2.5)) +
  scale_x_discrete(drop = FALSE)
