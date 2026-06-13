library(dplyr)
library(ggplot2)

# ==========================================
# 1. CLEAN AND PREPARE DATA
# ==========================================
Extra03_Summary_Data <- SURVEYDATA_BIJECTION %>%
  # FILTER: Remove students who don't have a Final Exam Score or GPA
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
  filter(GPA_Range != "Other" & num_exts_Requested %in% c("0", "1", "2"))


# ==========================================
# 2. CREATE THE SUMMARY TABLE (WITH SE FIX)
# ==========================================
TTable_Output <- Extra03_Summary_Data %>%
  group_by(GPA_Range, num_exts_Requested) %>%
  summarise(
    Avg_Exam_Score = round(mean(Final_Exam_Score, na.rm = TRUE), 6),
    Avg_Final_Grade = round(mean(Final_Score, na.rm = TRUE), 6),
    Student_Count = n(),

    # THE FIX: If n=1, set the error to 0. Otherwise, calculate it normally!
    SE_Grade = ifelse(Student_Count == 1, 0, sd(Final_Score, na.rm = TRUE) / sqrt(Student_Count)),

    Raw_SE = sd(Final_Score, na.rm = TRUE) / sqrt(Student_Count),

    SE_Text_Shift = ifelse(Student_Count <= 2, 0, Raw_SE),

    .groups = 'drop'
  )

# Format the Extension labels so they look clean in the legend
TTable_Output$num_exts_Requested <- factor(TTable_Output$num_exts_Requested,
                                          levels = c("0", "1", "2"),
                                          labels = c("0 Ext.", "1 Ext.", "2 Ext."))


# ==========================================
# 3. GENERATE THE GRAPH
# ==========================================
IEEE_plot_leveler <- ggplot(TTable_Output, aes(x = GPA_Range, y = Avg_Final_Grade, fill = num_exts_Requested)) +

  # 1. Grouped bars (position_dodge puts them side-by-side)
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), color = "black", width = 0.7) +

# UPDATED: Use 'SE_Bar' for the ymin/ymax. R will skip drawing whiskers where this is NA.
  geom_errorbar(aes(ymin = Avg_Final_Grade - SE_Bar, ymax = Avg_Final_Grade + SE_Bar),
                position = position_dodge(width = 0.8),
                width = 0.25, color = "black", linewidth = 0.6) +

# UPDATED: Use 'SE_Text_Shift' for the Y coordinate.
#
  geom_text(aes(y = Avg_Final_Grade + SE_Text_Shift, label = paste0(round(Avg_Final_Grade, 1), "\n(n=", Student_Count, ")")),
            position = position_dodge(width = 0.8),
            vjust = -0.3,
            size = 2.5,
            lineheight = 0.9,
            family = "serif",
            fontface = "bold",
            color = "black") +

  scale_fill_manual(
    values = c("0 Ext." = "gray90",
                "1 Ext." = "gray60",
                "2 Ext." = "gray30"),
    name = "Extensions Used:"
  ) +

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
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA),
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 9),
    legend.text = element_text(size = 8),
    legend.margin = margin(t = 0, r = 0, b = 0, l = 0),
    plot.title = element_blank(),
    plot.subtitle = element_blank()
  ) +

  # Set the Y-axis limits so the labels have room at the top (Increased slightly for error bars)
  coord_cartesian(ylim = c(50, 120))

print(IEEE_plot_leveler)

# Export to IEEE specs
 ggsave("~/Downloads/IEEE_Figure_extra03.png", plot = IEEE_plot_leveler,
        width = 800, height = 688, units = "px", dpi = 300, bg = "white")
