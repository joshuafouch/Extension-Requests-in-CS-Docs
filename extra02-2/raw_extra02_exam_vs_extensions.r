library(dplyr)
library(tidyr)
library(ggplot2)

######## 1. DATA PREP & DUAL ANOVAS ########

# Clean data: grab both Exam Score and Course Grade
Exam_Data <- SURVEYDATA_BIJECTION %>%
  mutate(
    num_exts_Requested = as.numeric(as.character(num_exts_Requested)),
    Final_Exam_Score   = as.numeric(Final_Exam_Score),
    Course_Grade       = as.numeric(Course_Grade) # Depending on your raw data, this might be named Final_Score
  ) %>%
  # Filter out NA rows to ensure a clean 1-to-1 comparison pool
  filter(!is.na(num_exts_Requested) & !is.na(Final_Exam_Score) & !is.na(Course_Grade)) %>%
  mutate(
    Extension_Group = factor(num_exts_Requested, levels = c(0, 1, 2),
                             labels = c("0 Extensions", "1 Extension", "2 Extensions"))
  ) %>%
  filter(!is.na(Extension_Group))

# ANOVA 1: Exam Score
anova_exam <- aov(Final_Exam_Score ~ Extension_Group, data = Exam_Data)
pval_exam  <- summary(anova_exam)[[1]][["Pr(>F)"]][1]

# ANOVA 2: Final Course Grade
anova_course <- aov(Course_Grade ~ Extension_Group, data = Exam_Data)
pval_course  <- summary(anova_course)[[1]][["Pr(>F)"]][1]

######## 2. SUMMARY TABLE & RESHAPING ########

# Calculate the raw means for both categories
extra02_raw_values <- Exam_Data %>%
  group_by(Extension_Group) %>%
  summarise(
    n = n(),
    Mean_Exam_Score   = round(mean(Final_Exam_Score, na.rm = TRUE), 1),
    Mean_Course_Grade = round(mean(Course_Grade, na.rm = TRUE), 1),
    .groups = "drop"
  )

# Print the Raw Output and p-values
cat("=== EXTRA 02: Performance by Extension Usage ===\n")
print(as.data.frame(extra02_raw_values))
cat("\nANOVA (Exam Score) p-value:", round(pval_exam, 3), "\n")
cat("ANOVA (Course Grade) p-value:", round(pval_course, 3), "\n\n")

# Reshape data for the grouped bar chart using pivot_longer
extra02_plot_data <- extra02_raw_values %>%
  pivot_longer(
    cols = c(Mean_Exam_Score, Mean_Course_Grade),
    names_to = "Score_Type",
    values_to = "Mean_Score"
  ) %>%
  mutate(
    # Format the labels cleanly for the chart legend
    Score_Type = factor(Score_Type, 
                        levels = c("Mean_Exam_Score", "Mean_Course_Grade"),
                        labels = c("Final Exam Score", "Final Course Grade"))
  )

######## 3. IEEE-COMPLIANT GROUPED BAR CHART ########

IEEE_plot_extra02 <- ggplot(extra02_plot_data, aes(x = Extension_Group, y = Mean_Score, fill = Score_Type)) +
  
  # Grouped Bars
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), color = "black", width = 0.7) +
  
  # Stacked text labels: Exact Mean on top, (n=X) right below it
  geom_text(aes(label = paste0(Mean_Score, "\n(n=", n, ")")), 
            position = position_dodge(width = 0.8),
            vjust = -0.2,       
            size = 2.5,          
            lineheight = 0.9,   
            family = "serif",   
            fontface = "bold",
            color = "black") +
  
  # IEEE Black & White Contrast Palette
  scale_fill_manual(
    values = c("Final Exam Score" = "gray80", 
               "Final Course Grade" = "gray40"),
    name = "Metric:"
  ) +
  
  labs(
    x = "Number of Extensions Used",
    y = "Average Score (%)"
  ) +
  
  theme_classic() +
  theme(
    text = element_text(family = "serif", size = 10, color = "black"), 
    axis.text.x = element_text(color = "black", face = "bold", size = 10),
    axis.text.y = element_text(color = "black"),
    
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 9),
    legend.text = element_text(size = 8),
    legend.margin = margin(t = 0, r = 0, b = 0, l = 0),
    
    plot.title = element_blank(),    
    plot.subtitle = element_blank(),
    
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  ) +
  
  # Expand the Y-axis so the labels have plenty of room
  coord_cartesian(ylim = c(0, 120))

# Print the plot
print(IEEE_plot_extra02)

# Export to exact IEEE specifications
ggsave("IEEE_Figure_Extra02.png", plot = IEEE_plot_extra02, 
       width = 3.5, height = 3.2, units = "in", dpi = 300, bg = "white")
