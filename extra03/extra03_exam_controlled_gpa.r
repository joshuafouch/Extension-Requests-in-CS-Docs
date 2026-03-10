########## Extensions v Exam Scores Controlled for GPA ###################

# Clean Data for Plotting
Plot_Data <- SURVEYDATA %>%
    # Filter out the "NA" rows
    filter(num_exts != "" & !is.na(Avg_Exam_Score)) %>%
    mutate(
        # Ensure Extension is a Factor
        num_exts = factor(num_exts, levels = c("0", "1", "2")),
        # Ensure GPA is ordered correctly
        GPA_Range = factor(GPA_Range, levels = c("A Range (3.5 - 4.0)", "B Range (3.0 - 3.49)", "C/D Range (< 3.0)"))
    )

ggplot(Plot_Data, aes(x = GPA_Range, y = Avg_Exam_Score, fill = num_exts)) +
    
    # A. The Bars
    geom_bar(stat = "identity", position = position_dodge(width = 0.8), width = 0.7, color = "black", alpha = 0.9) +
    
    # B. Score Labels (Top of Bar)
    geom_text(aes(label = paste0(round(Avg_Exam_Score, 1), "%")), 
              position = position_dodge(width = 0.8), vjust = -0.5, size = 4.5, fontface = "bold") +
    
    # C. N-Count Labels (Inside Bar)
    # Keeping text white, so we use dark grays for the bars
    geom_text(aes(label = paste0("n=", Student_Count)), 
              position = position_dodge(width = 0.8), vjust = 1.5, size = 4, color = "white", fontface = "bold") +
    
    # D. Black and White Colors
    # 0=Black, 1=Dark Gray, 2=Medium Gray (Dark enough for white text)
    scale_fill_manual(values = c("0" = "black", "1" = "gray30", "2" = "gray55"), 
                      name = "Extensions Used") +
    
    labs(title = "Final Exam Performance by GPA & Extension Usage",
         subtitle = "Controlled Analysis: 'A' students perform similarly regardless of extension use.",
         x = "Student GPA Range",
         y = "Average Final Exam Score (%)") +
    
    theme_minimal() +
    theme(
        plot.title = element_text(face = "bold", size = 14),
        axis.text.x = element_text(face = "bold", size = 11),
        legend.position = "top"
    ) +
    
    # Set Y-axis to 130 to fit the 117% label
    coord_cartesian(ylim = c(60, 130))
