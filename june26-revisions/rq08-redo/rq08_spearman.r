library(dplyr)
library(ggplot2)


Year_Data <- SURVEYDATA_BIJECTION %>%
  filter(!is.na(num_exts_Requested) & Year %in% c("Freshman", "Sophomore", "Junior", "Senior")) %>%
  mutate(
    # Convert extensions to numeric
    num_exts_Requested = as.numeric(as.character(num_exts_Requested)),

    # Lock the years into standard categorical order for the graph
    Year = factor(Year, levels = c("Freshman", "Sophomore", "Junior", "Senior")),

    # Convert the categories into a single numeric scale (1, 2, 3, 4) for Spearman
    Year_Rank = as.numeric(Year)
  )

# Run the Spearman Correlation test
year_spearman_test <- cor.test(Year_Data$Year_Rank, Year_Data$num_exts_Requested, method = "spearman")

# Raw values: mean extensions and n count per year level
year_data_raw_values <- Year_Data %>%
  group_by(Year) %>%
  summarise(
    n               = n(),
    Mean_Extensions = round(mean(num_exts_Requested, na.rm = TRUE), 4),

    # Calculate Standard Error (added a quick safeguard in case n=1)
    SE              = ifelse(n > 1, sd(num_exts_Requested, na.rm = TRUE) / sqrt(n), 0),

    .groups = "drop"
  )

# Print the statistical outputs to the console
cat("=== RQ08: Extension Usage by Year ===\n")
cat("X-axis = Year Level | Y-axis = Average Extensions Used\n\n")
print(as.data.frame(year_data_raw_values))

cat("\n=== Spearman Correlation Results ===\n")
print(year_spearman_test)


# Create the IEEE-compliant plot for RQ08
IEEE_plot_rq08 <- ggplot(year_data_raw_values, aes(x = Year, y = Mean_Extensions)) +

  # 1. Bar Chart: Grayscale fill with black borders
  geom_bar(stat = "identity", fill = "gray70", color = "black", width = 0.6) +

  # 2. Error Bars
  geom_errorbar(aes(ymin = Mean_Extensions - SE, ymax = Mean_Extensions + SE),
                width = 0.2, color = "black", linewidth = 0.6) +

  # 3. Stacked labels: Shifted ABOVE the error bars
  geom_text(aes(y = Mean_Extensions + SE, label = paste0(round(Mean_Extensions, 2), "\n(n=", n, ")")),
            vjust = -0.3,
            size = 2.75,
            lineheight = 0.9,
            family = "serif",
            fontface = "bold",
            color = "black") +

  # 4. Axis Labels
  labs(
    x = "Class Standing",
    y = "Average Extensions Requested"
  ) +

  # 5. Strict IEEE Formatting Theme
  theme_classic() +
  theme(
    text = element_text(family = "serif", size = 10, color = "black"),
    axis.text.x = element_text(angle = 45, hjust = 1, color = "black"),
    axis.text.y = element_text(color = "black"),
    plot.title = element_blank(),
    plot.subtitle = element_blank(),
    legend.position = "none",

    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  ) +

  # Expand the top of the Y-axis so the labels don't get chopped off
  scale_y_continuous(expand = expansion(mult = c(0, 0.25)))

# Print the plot
print(IEEE_plot_rq08)

# Export to IEEE specs
 ggsave("~/Downloads/IEEE_Figure_RQ08.png", plot = IEEE_plot_rq08,
        width = 800, height = 688, units = "px", dpi = 300, bg = "white")
