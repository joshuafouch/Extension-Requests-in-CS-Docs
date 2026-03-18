######## RAW VALUES: RESEARCH QUESTION 8 ########
# Prints all x/y values and n counts displayed in the graph


Year_Data <- SURVEYDATA_BIJECTION %>%
  filter(!is.na(num_exts_Requested) & Year %in% c("Freshman", "Sophomore", "Junior", "Senior")) %>%
  mutate(
    exts_req = as.numeric(num_exts_Requested),
    Year = factor(Year, levels = c("Freshman", "Sophomore", "Junior", "Senior"))
  )

year_data_aov_model <- aov(num_exts_Requested ~ Year, data = Year_Data)
year_data_p_val     <- summary(year_data_aov_model)[[1]][["Pr(>F)"]][1]

# change num_exts_Requested to a numeric
Year_Data$num_exts_Requested <- as.numeric(as.character(Year_Data$num_exts_Requested))

# Raw values: mean extensions and n count per year level
year_data_raw_values <- Year_Data %>%
  group_by(Year) %>%
  summarise(
    n               = n(),
    Mean_Extensions = round(mean(num_exts_Requested, na.rm = TRUE), 4),
    .groups = "drop"
  )

cat("=== RQ08: Extension Usage by Year ===\n")
cat("X-axis = Year Level | Y-axis = Average Extensions Used\n")
cat("n labels shown above each bar\n\n")
print(as.data.frame(year_data_raw_values))
cat("\nANOVA p-value:", round(year_data_p_val, 3), "\n")


# for the graph
library(ggplot2)

# --- Assuming you have already run your code to create 'year_data_raw_values' ---

# Create the IEEE-compliant plot for RQ08
IEEE_plot_rq08 <- ggplot(year_data_raw_values, aes(x = Year, y = Mean_Extensions)) +
  
  # 1. Bar Chart: Grayscale fill with black borders for high contrast
  geom_bar(stat = "identity", fill = "gray70", color = "black", width = 0.6) +
  
  # 2. Add stacked labels: Exact Y-value (rounded to 2) on top, (n=X) right below it
  geom_text(aes(label = paste0(round(Mean_Extensions, 2), "\n(n=", n, ")")), 
            vjust = -0.2,       
            size = 2.75,        
            lineheight = 0.9,   
            family = "serif",   # "Bible font" for the floating text
            fontface = "bold",
            color = "black") +
  
  # 3. Axis Labels
  labs(
    x = "Class Standing",
    y = "Average Extensions Requested"
  ) +
  
  # 4. IEEE Strict Formatting Theme
  theme_classic() +
  theme(
    text = element_text(family = "serif", size = 10, color = "black"), 
    axis.text.x = element_text(angle = 45, hjust = 1, color = "black"),
    axis.text.y = element_text(color = "black"),
    plot.title = element_blank(),    
    plot.subtitle = element_blank(),
    legend.position = "none",
    
    # Force the plot background to be solid white
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  ) +
  
  # Expand the top of the Y-axis by 20% so the labels don't get chopped off by the margin
  scale_y_continuous(expand = expansion(mult = c(0, 0.2)))

# Print the plot to the RStudio Viewer to check it
print(IEEE_plot_rq08)

# 5. Export to exact IEEE specifications (Single Column = 3.5 inches, 300 DPI, White BG)
ggsave("IEEE_Figure_RQ08.png", plot = IEEE_plot_rq08, 
       width = 3.5, height = 3.0, units = "in", dpi = 300, bg = "white")
