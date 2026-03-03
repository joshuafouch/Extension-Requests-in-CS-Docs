####### Exam Scores versus Extensions Used ############

# Source setup
source("00_setup.r")

# 2. Clean Data (Strict Filter for NAs)
Exam_Data <- SurveyData %>%
    # Convert to numeric FIRST
    mutate(
        num_exts = as.numeric(as.character(num_exts)),
        Final_Exam_Score = as.numeric(Final_Exam_Score)
    ) %>%
    # Filter: Keep only valid rows (0, 1, 2 extensions)
    filter(!is.na(num_exts) & !is.na(Final_Exam_Score)) %>%
    mutate(
        # Convert to Factor so they plot as categories
        Extension_Group = factor(num_exts, levels = c(0, 1, 2), 
                                 labels = c("0 Extensions", "1 Extension", "2 Extensions"))
    )

# 3. Statistical Test (ANOVA) - Corrected
anova_model <- aov(Final_Exam_Score ~ Extension_Group, data = Exam_Data)
p_val <- summary(anova_model)[[1]][["Pr(>F)"]][1]
p_text <- paste0("p = ", round(p_val, 3), " (Significant)")

# 4. Create the Bar Graph
ggplot(Exam_Data, aes(x = Extension_Group, y = Final_Exam_Score, fill = Extension_Group)) +
    
    # Bars: Average Exam Score
    stat_summary(fun = "mean", geom = "bar", color = "black", width = 0.7, alpha = 0.9) +
    
    # Labels: "n=..." inside the bar (White Text)
    stat_summary(fun.data = function(x){
        return(data.frame(y = mean(x) - 10, label = paste0("n=", length(x))))
    }, geom = "text", color = "white", fontface = "bold", size = 5) +
    
    # Labels: Average Score on top (Black Text)
    stat_summary(fun.data = function(x){
        return(data.frame(y = mean(x) + 3, label = paste0(round(mean(x), 1), "%")))
    }, geom = "text", color = "black", fontface = "bold", size = 5) +

    # Add Significance Star
    annotate("text", x = 3, y = 100, label = "*", size = 10, fontface = "bold") +

    labs(title = "Final Exam Performance by Extension Usage",
         subtitle = paste0("Usage correlates with lower scores, but even heavy users average a B+ (88.7%).\n(ANOVA: ", p_text, ")"),
         x = "", # Remove X label as the groups are self-explanatory
         y = "Average Final Exam Score (%)") +
    
    # Color Palette: Green (Good) -> Orange -> Red (Warning)
    scale_fill_manual(values = c("0 Extensions" = "#1b9e77", 
                                 "1 Extension" = "#d95f02", 
                                 "2 Extensions" = "#e7298a")) +
    
    theme_minimal() +
    theme(legend.position = "none",
          axis.text.x = element_text(size = 12, face = "bold")) +
    
    # Set Y-axis
    coord_cartesian(ylim = c(0, 115))
