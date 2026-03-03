######## RESEARCH QUESTION 9 ######## 
# Is there a correlation between grade level and the amount of extensions used?

# Source setup
source("00_setup.r")

# Load and Order Data
Year_Data <- SurveyData %>%
    filter(!is.na(num_exts) & Year %in% c("Freshman", "Sophomore", "Junior", "Senior")) %>%
    mutate(
        num_exts = as.numeric(num_exts),
        # Force the correct chronological order
        Year = factor(Year, levels = c("Freshman", "Sophomore", "Junior", "Senior"))
    )

# Run ANOVA (Is the difference significant?)
aov_model <- aov(num_exts ~ Year, data = Year_Data)
p_val <- summary(aov_model)[[1]][["Pr(>F)"]][1]

# Create the Plot
ggplot(Year_Data, aes(x = Year, y = num_exts, fill = Year)) +
    # Show the Mean as a bar
    stat_summary(fun = "mean", geom = "bar", color = "black", alpha = 0.8) +
    
    # Add N Counts (Placed above the bar for readability on light colors)
    stat_summary(fun.data = function(x){
        return(data.frame(y = mean(x), label = paste0("n=", length(x))))
    }, geom = "text", fontface = "bold", color = "black", vjust = -0.5, size = 4) +
    
    labs(title = "Extension Usage by Year",
         subtitle = paste("Trend: Usage increases with seniority. p =", round(p_val, 3)),
         y = "Average Extensions Used",
         x = "") +
    
    scale_fill_brewer(palette = "Blues") +
    theme_minimal() +
    theme(legend.position = "none") +
    
    # Adjust Y-axis to make room for the text labels on top
    coord_cartesian(ylim = c(0, 2.0))
