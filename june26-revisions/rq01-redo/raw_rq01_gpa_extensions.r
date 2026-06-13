######## RAW VALUES: RESEARCH QUESTION 1 ########
# Prints all x/y values and n counts displayed in the graph

# Define the levels once at the top
gpa_levels <- c("1.5 - 1.99", "2.0 - 2.49", "2.5 - 2.99", "3.0 - 3.49", "3.5 - 4.0", "4.0+")

# Create the cleaned dataset WITHOUT altering the original SURVEYDATA_BIJECTION
Cleaned_RQ01_Data <- SURVEYDATA_BIJECTION %>%

  # 1. Filter out students without a valid GPA
  filter(Est_GPA != "Didn't have a GPA" & !is.na(Est_GPA)) %>%

  # 2. Apply all data fixes safely within this new dataframe
  mutate(
    # Fix the edge-case GPAs
    Est_GPA = ifelse(Est_GPA %in% c("3.98", "3.96"), "3.5 - 4.0", Est_GPA),

    # Convert extensions to numeric
    num_exts_Requested = as.numeric(as.character(num_exts_Requested)),

    # Create the ordered factor
    Est_GPA_Factor = factor(Est_GPA, levels = gpa_levels),

    # MISSING LINE ADDED HERE:
    GPA_Rank = as.numeric(Est_GPA_Factor)
  )

# Calculate Raw values: mean extensions and n count per GPA group
RQ01_raw_values <- Cleaned_RQ01_Data %>%
  filter(!is.na(Est_GPA_Factor) & !is.na(num_exts_Requested)) %>%
  group_by(GPA_Group = Est_GPA_Factor) %>%
  summarise(
    n = n(),
    Mean_Extensions = round(mean(num_exts_Requested, na.rm = TRUE), 4),
    SE = sd(num_exts_Requested, na.rm = TRUE) / sqrt(n()),
    .groups = "drop"
  )

cat("=== RQ01: Average Extensions Requested by Estimated GPA ===\n")
cat("X-axis = GPA Group | Y-axis = Mean Extensions | n = count of students\n\n")
print(as.data.frame(RQ01_raw_values))

rq1_cor_test <- cor.test(Cleaned_RQ01_Data$GPA_Rank, Cleaned_RQ01_Data$num_exts_Requested, method = "spearman")
print(rq1_cor_test)



# for the IEEE standard bar graph: (AI produced)
IEEE_plot_rq01 <- ggplot(RQ01_raw_values, aes(x = GPA_Group, y = Mean_Extensions)) +

  # 1. Bar Chart: Grayscale fill with black borders
  geom_bar(stat = "identity", fill = "gray70", color = "black", width = 0.6) +

# ---> NEW LAYER: Add Error Bars HERE (Draws underneath the text) <---
  geom_errorbar(aes(ymin = Mean_Extensions - SE, ymax = Mean_Extensions + SE),
                width = 0.2, color = "black", linewidth = 0.6) +

  # 2. Add stacked labels: Exact Y-value on top, (n=X) right below it
  geom_text(aes(y = Mean_Extensions + SE, label = paste0(round(Mean_Extensions, 2), "\n(n=", n, ")")),
              vjust = -0.3,
              size = 2.75,
              lineheight = 0.9,
              family = "serif",   # Matches the label font to the rest of the graph
              fontface = "bold",
              color = "black") +

  # 3. Axis Labels
  labs(
    x = "Self-Reported GPA Range",
    y = "Average Extensions Requested"
  ) +

  # 4. IEEE Strict Formatting Theme (Now with "Bible Font")
  theme_classic() +
  theme(
    text = element_text(family = "serif", size = 10, color = "black"), # Changed to serif
    axis.text.x = element_text(angle = 45, hjust = 1, color = "black"),
    axis.text.y = element_text(color = "black"),
    plot.title = element_blank(),
    plot.subtitle = element_blank(),
    legend.position = "none"
  ) +

  # Expand the top of the Y-axis by 20%
  scale_y_continuous(expand = expansion(mult = c(0, 0.2)))

# Print to check it
print(IEEE_plot_rq01)

# 5. Export to exact IEEE specifications
ggsave("~/Downloads/IEEE_Figure_RQ01.png", plot = IEEE_plot_rq01,
       width = 3.5, height = 3.0, units = "in", dpi = 300)







# output
  GPA_Group  n Mean_Extensions        SE
1 2.0 - 2.49  5          1.6000 0.4000000
2 2.5 - 2.99 12          1.5000 0.1946247
3 3.0 - 3.49 24          1.7500 0.1085143
4  3.5 - 4.0 42          1.1905 0.1285951
5       4.0+  8          0.5000 0.1889822

# SE is Standard Error, the sample size and the standard deviation (how wildly different the students answered) both play a role in the error.
