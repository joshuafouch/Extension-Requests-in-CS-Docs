######## RAW VALUES: RESEARCH QUESTION 5 ########
# Prints all x/y values and n counts displayed in the graph


RQ05_DATA <- SURVEYDATA_BIJECTION %>%
  # Make sure we only look at rows that answered the question and have extension data
  filter(!is.na(HW_ImportanceValue) & !is.na(num_exts_Requested) & !is.na(num_valid_Extensions)) %>%
  
  # Convert columns to numeric safely
  mutate(
    num_exts_Requested = as.numeric(as.character(num_exts_Requested)),
    num_valid_Extensions = as.numeric(as.character(num_valid_Extensions)),
    
    User_Group = case_when(
      num_exts_Requested > 0 & num_valid_Extensions > 0 ~ "Extension User",
      num_exts_Requested == 0 & num_valid_Extensions == 0 ~ "Non-User",
      TRUE ~ "Drop" # Flags the 3 students who requested but were denied
    )
  ) %>%
  
  # Drop the 3 edge cases
  filter(User_Group != "Drop") %>%
  
  # Format the responses in the correct order for your pie chart
  mutate(
    Response = factor(HW_ImportanceValue,
                      levels = c("not at all", "not really", "yes, a little bit", "yes, definitely"))
  )

raw_values <- RQ05_DATA %>%
  count(User_Group, Response, name = "Count") %>%
  group_by(User_Group) %>%
  mutate(
    Group_Total = sum(Count),
    Percentage = round(Count / Group_Total * 100, 1)
  ) %>%
  ungroup()

# 3. Print the Tables to the Console
cat("=== RQ05: Did the Policy Devalue Assignments? (Pie Chart Data) ===\n\n")

# Table 1: Extension Users
cat("--- TABLE 1: EXTENSION USERS (n =", sum(raw_values$Count[raw_values$User_Group == "Extension User"]), ") ---\n")
print(as.data.frame(raw_values %>% filter(User_Group == "Extension User") %>% select(-User_Group)))
cat("\n")

# Table 2: Non-Users
cat("--- TABLE 2: NON-USERS (n =", sum(raw_values$Count[raw_values$User_Group == "Non-User"]), ") ---\n")
print(as.data.frame(raw_values %>% filter(User_Group == "Non-User") %>% select(-User_Group)))




# for the IEEE standard pie charts (AI produced)
library(ggplot2)

# --- Assuming you have already run your code to create 'raw_values' ---

# Create the IEEE-compliant faceted pie charts
IEEE_plot_rq05 <- ggplot(raw_values, aes(x = 1, y = Percentage, fill = Response)) +
  
  # 1. Pie Chart Configuration (Now drawn at x = 1 so we can push text outward)
  geom_bar(stat = "identity", width = 1, color = "black", linewidth = 0.4) +
  
  # clip = "off" ensures that numbers outside the circle don't get chopped off by the plot edges
  coord_polar(theta = "y", start = 0, clip = "off") +
  
  # 2. Split into two side-by-side charts
  facet_wrap(~ User_Group, ncol = 2) + 
  
  # 3. LABELS ON THE CIRCUMFERENCE
  geom_text(aes(x = 1.85, label = ifelse(Percentage > 0, paste0(signif(Percentage, 3), "%"), "")), 
            position = position_stack(vjust = 0.5), 
            family = "serif", fontface = "bold", size = 3, color = "black") +
  
  # 4. IEEE Black & White Palette
  scale_fill_manual(
    values = c("not at all" = "gray50", 
               "not really" = "gray70", 
               "yes, a little bit" = "gray90", 
               "yes, definitely" = "white"),
    name = "Student Response:"
  ) +
  
  # 5. IEEE Strict Formatting Theme
  theme_void() + 
  theme(
    text = element_text(family = "serif", size = 10, color = "black"),
    
    # Expand the invisible margins slightly to give the outside labels room to breathe
    plot.margin = margin(t = 10, r = 10, b = 10, l = 10),
    
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA),
    
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 9),
    legend.text = element_text(size = 8),
    legend.margin = margin(t = 0, r = 0, b = 0, l = 0),
    
    strip.text = element_text(family = "serif", face = "bold", size = 10, margin = margin(b = 10)),
    
    plot.title = element_blank(),
    plot.subtitle = element_blank()
  ) +
  
  # Wrap the legend into 2 rows
  guides(fill = guide_legend(nrow = 2, byrow = TRUE))

# Print the plot to the RStudio Viewer to check it
print(IEEE_plot_rq05)

# 6. Export to exact IEEE specifications
ggsave("IEEE_Figure_RQ05.png", plot = IEEE_plot_rq05, 
       width = 3.5, height = 3.0, units = "in", dpi = 300, bg = "white")## better>>>>?>?????????????/
