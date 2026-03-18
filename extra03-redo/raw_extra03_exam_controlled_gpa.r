######## RAW VALUES: EXTRA 03 — Exam Scores Controlled for GPA ########
# Prints all x/y values and n counts displayed in the graph

# Clean Data for Plotting
extra03_Plot_Data <- SURVEYDATA_BIJECTION %>%
    # Filter out the "NA" rows
    filter(num_exts_Requested != "" & !is.na(Avg_Exam_Score)) %>%
    mutate(
        # Ensure Extension is a Factor
        num_exts_Requested = factor(num_exts_Requested, levels = c("0", "1", "2")),
        # Ensure GPA is ordered correctly
        GPA_Range = factor(GPA_Range, levels = c("A Range (3.5 - 4.0)", "B Range (3.0 - 3.49)", "C/D Range (< 3.0)"))
    )

cat("=== EXTRA 03: Final Exam Performance by GPA Range & Extension Usage ===\n")
cat("X-axis = GPA Range | Y-axis = Average Final Exam Score (%)\n")
cat("Grouped bars by Extensions Used (0, 1, 2)\n")
cat("Score % labels above each bar; n= labels inside each bar\n\n")
cat("--- All bar values ---\n")
cat("Columns: GPA_Range | Extensions Used | Avg_Exam_Score | Student_Count (n)\n\n")

extra_03_raw_values <- Plot_Data %>%
  select(GPA_Range, Extensions_Used = num_exts, Avg_Exam_Score, n = Student_Count) %>%
  arrange(GPA_Range, Extensions_Used)

print(as.data.frame(extra_03_raw_values))

cat("\n--- Y-axis range shown in graph: 60 to 130 ---\n")

# 1. Clean and Prepare Data
Extra03_Summary_Data <- SURVEYDATA_BIJECTION %>%
  # FILTER: Remove students who don't have a Final Exam Score (The "NA" lines)
  filter(!is.na(Final_Exam_Score)  & !is.na(Est_GPA)) %>%
  mutate(
    num_exts_Requested = as.character(num_exts_Requested),
    Final_Exam_Score = as.numeric(Final_Exam_Score),
    Final_Score = as.numeric(Course_Grade),
    
    # Categorize GPA
    GPA_Range = case_when(
      Est_GPA %in% c("4.0+", "3.5 - 4.0", "3.98", "3.96") ~ "A Range",
      Est_GPA == "3.0 - 3.49" ~ "B Range",
      Est_GPA %in% c("2.5 - 2.99", "2.0 - 2.49", "1.5 - 1.99") ~ "C/D Range",
      TRUE ~ "Other"
    ),
    GPA_Range = factor(GPA_Range, levels = c("A Range", "B Range", "C/D Range"))
  ) %>%
  filter(GPA_Range != "Other")

# 2. Create the Summary Table
TTable_Output <- Extra03_Summary_Data %>%
  group_by(GPA_Range, num_exts_Requested) %>%
  summarise(
    Avg_Exam_Score = round(mean(Final_Exam_Score), 6),
    Avg_Final_Grade = round(mean(Final_Score), 6),
    Student_Count = n(),
    .groups = 'drop'
  )

# graph
library(ggplot2)

# --- Assuming you have already run your exact code to create 'Table_Output' ---

# 1. Format the Extension labels so they look clean in the legend and on the graph
TTable_Output$num_exts_Requested <- factor(TTable_Output$num_exts_Requested, 
                                          levels = c("0", "1", "2"), 
                                          labels = c("0 Ext.", "1 Ext.", "2 Ext."))

# 2. Create the IEEE-Compliant Grouped Bar Chart (Final Grades)
IEEE_plot_leveler <- ggplot(TTable_Output, aes(x = GPA_Range, y = Avg_Final_Grade, fill = num_exts_Requested)) +
  
  # Grouped bars (position_dodge puts them side-by-side)
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), color = "black", width = 0.7) +
  
  # Stacked text labels above each specific bar (Score on top, n-count below)
  geom_text(aes(label = paste0(round(Avg_Final_Grade, 1), "\n(n=", Student_Count, ")")), 
            position = position_dodge(width = 0.8), 
            vjust = -0.2, 
            size = 2.5,          
            lineheight = 0.9, 
            family = "serif", 
            fontface = "bold", 
            color = "black") +
  
  # IEEE Black & White Contrast Palette
  scale_fill_manual(
    values = c("0 Ext." = "gray90", 
               "1 Ext." = "gray60", 
               "2 Ext." = "gray30"),
    name = "Extensions Used:"
  ) +

  # Axis Labels
  labs(
    x = "Student Starting GPA Range",
    y = "Average Final Course Grade (%)"
  ) +
  
  # Strict IEEE Theme
  theme_classic() +
  theme(
    text = element_text(family = "serif", size = 10, color = "black"),
    axis.text.x = element_text(color = "black", face = "bold"),
    axis.text.y = element_text(color = "black"),
    
    # Solid white background
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA),
    
    # Legend formatting
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 9),
    legend.text = element_text(size = 8),
    legend.margin = margin(t = 0, r = 0, b = 0, l = 0),
    
    plot.title = element_blank(),
    plot.subtitle = element_blank()
  ) +
  
  # Set the Y-axis limits so the labels have room at the top
  coord_cartesian(ylim = c(50, 115))

# Print the plot to check it
print(IEEE_plot_leveler)

# 3. Export to exact IEEE specifications
ggsave("IEEE_Figure_Leveler_FinalGrades.png", plot = IEEE_plot_leveler, 
       width = 3.5, height = 3.2, units = "in", dpi = 300, bg = "white")
