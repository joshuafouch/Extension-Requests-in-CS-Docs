######## RAW VALUES: EXTRA 02 — Exam Scores vs Extensions Used ########
# Prints all x/y values and n counts displayed in the graph


Exam_Data <- SURVEYDATA_BIJECTION %>%
  mutate(
    num_exts_Requested         = as.numeric(as.character(num_exts_Requested)),
    Final_Exam_Score = as.numeric(Final_Exam_Score)
  ) %>%
  filter(!is.na(num_exts_Requested) & !is.na(Final_Exam_Score)) %>%
  mutate(
    Extension_Group = factor(num_exts_Requested, levels = c(0, 1, 2),
                             labels = c("0 Extensions", "1 Extension", "2 Extensions"))
  )

anova_model <- aov(Final_Exam_Score ~ Extension_Group, data = Exam_Data)
p_val       <- summary(anova_model)[[1]][["Pr(>F)"]][1]

# Raw values: mean exam score and n count per extension group
extra02_raw_values <- Exam_Data %>%
  group_by(Extension_Group) %>%
  summarise(
    n                    = n(),
    Mean_Exam_Score      = round(mean(Final_Exam_Score, na.rm = TRUE), 1),
    .groups = "drop"
  )

cat("=== EXTRA 02: Final Exam Performance by Extension Usage ===\n")
cat("X-axis = Extension Group | Y-axis = Average Final Exam Score (%)\n")
cat("n labels shown inside bars; mean % shown above bars\n\n")
print(as.data.frame(extra02_raw_values))
cat("\nANOVA p-value:", round(p_val, 3), "\n")


#### for the visual
library(ggplot2)

# 1. Build the dataframe using your exact new summary values
extra02_summary <- data.frame(
  Extension_Group = factor(c("0 Extensions", "1 Extension", "2 Extensions"), 
                           levels = c("0 Extensions", "1 Extension", "2 Extensions")),
  n = c(22, 25, 50),
  Mean_Exam_Score = c(102.1, 90.5, 85.2)
)

# 2. Create the IEEE-compliant Bar Chart
IEEE_plot_extra02 <- ggplot(extra02_summary, aes(x = Extension_Group, y = Mean_Exam_Score)) +
  
  # Bar Chart: Grayscale fill with black borders for high print contrast
  geom_bar(stat = "identity", fill = "gray70", color = "black", width = 0.6) +
  
  # Stacked text labels: Exact Mean on top, (n=X) right below it
  geom_text(aes(label = paste0(Mean_Exam_Score, "\n(n=", n, ")")), 
            vjust = -0.2,       
            size = 3,        
            lineheight = 0.9,   
            family = "serif",   # IEEE "Bible Font"
            fontface = "bold",
            color = "black") +
  
  # Axis Labels
  labs(
    x = "Number of Extensions Used",
    y = "Average Final Exam Score"
  ) +
  
  # Strict IEEE Formatting Theme
  theme_classic() +
  theme(
    text = element_text(family = "serif", size = 10, color = "black"), 
    axis.text.x = element_text(color = "black", face = "bold", size = 9),
    axis.text.y = element_text(color = "black"),
    
    # Remove titles (IEEE requires them in the document caption instead)
    plot.title = element_blank(),    
    plot.subtitle = element_blank(),
    legend.position = "none",
    
    # Force a solid white background
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  ) +
  
  # Expand the Y-axis so the tallest label (102.1) doesn't hit the top boundary
  coord_cartesian(ylim = c(0, 115))

# Print the plot to the RStudio Viewer to check it
print(IEEE_plot_extra02)

# 3. Export to exact IEEE specifications (Single Column = 3.5 inches, 300 DPI)
ggsave("IEEE_Figure_Extra02.png", plot = IEEE_plot_extra02, 
       width = 3.5, height = 3.0, units = "in", dpi = 300, bg = "white")
