######## RESEARCH QUESTION 1 ######## 
# Students with lower starting GPAs are more likely to request extensions than students with higher starting GPAs.

# Fix non-numeric extension column
SURVEYDATA$num_exts <- as.numeric(as.character(SURVEYDATA$num_exts))

# Fix inconsistent GPA labels
SURVEYDATA$Est_GPA[SURVEYDATA$Est_GPA == "3.98"] <- "3.5 - 4.0"
SURVEYDATA$Est_GPA[SURVEYDATA$Est_GPA == "3.96"] <- "3.5 - 4.0"

# Define Order
gpa_levels <- c("1.5 - 1.99", "2.0 - 2.49", "2.5 - 2.99", "3.0 - 3.49", "3.5 - 4.0", "4.0+")
SURVEYDATA$Est_GPA_Factor <- factor(SURVEYDATA$Est_GPA, levels = gpa_levels)
SURVEYDATA$GPA_Rank <- as.numeric(SURVEYDATA$Est_GPA_Factor)

# 1. Statistical Test (Spearman Correlation)
print(cor.test(SURVEYDATA$GPA_Rank, SURVEYDATA$num_exts, method = "spearman"))

# 2. Visualization
ggplot(subset(SURVEYDATA, !is.na(Est_GPA_Factor)), aes(x = Est_GPA_Factor, y = num_exts)) + 
  
  stat_summary(fun = mean, geom = "bar", fill = "darkgray", color = "black", width = 0.7) + 
  
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
