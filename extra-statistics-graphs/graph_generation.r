library(ggplot2)
library(dplyr)

# 1. Load the new data 
extra_data <- read.csv("figure.csv", stringsAsFactors = FALSE)

# Rename columns manually to avoid any weird characters
colnames(extra_data) <- c("Response", "n_count", "Percent_String")

# 2. Clean and Prepare the Data
extra_data <- extra_data %>%
  mutate(
    Percent_Numeric = as.numeric(gsub("%", "", Percent_String)),
    
    # Lock in the order of the responses
    Response = factor(Response, levels = c(
      "1 Day", 
      "2 Days", 
      "3 Days", 
      "4 Days", 
      "5 Days", 
      "6 Days", 
      "1 Week", 
      "> 1 Week"
    ))
  )

# 3. Create the IEEE-compliant Bar Chart
IEEE_plot_extra <- ggplot(extra_data, aes(x = Response, y = Percent_Numeric)) +
  
  geom_bar(stat = "identity", fill = "gray70", color = "black", width = 0.7) +
  
  geom_text(aes(label = paste0(Percent_Numeric, "%\n(n=", n_count, ")")), 
            vjust = -0.2,       
            size = 2.5,        
            lineheight = 0.9,   
            family = "serif",   # IEEE "Bible Font"
            fontface = "bold",
            color = "black") +
  
  labs(
    x = "Preferred Extension Length",
    y = "Percentage of Responses (%)"
  ) +
  
  # Strict IEEE Formatting Theme
  theme_classic() +
  theme(
    text = element_text(family = "serif", size = 10, color = "black"), 
    
    # Angle the long X-axis labels at 45 degrees so they fit the 3.5-inch column
    axis.text.x = element_text(color = "black", angle = 45, hjust = 1, size = 9),
    axis.text.y = element_text(color = "black"),
    
    plot.title = element_blank(),    
    plot.subtitle = element_blank(),
    legend.position = "none",
    
    # Force a solid white background
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  ) +
  
  # Expand the Y-axis slightly so the tallest label doesn't hit the top boundary
  coord_cartesian(ylim = c(0, 80))

# Print the plot to the RStudio Viewer to check it
print(IEEE_plot_extra)

# 4. Export to exact IEEE specifications 
ggsave("extrafigure.png", plot = IEEE_plot_extra, 
       width = 3.5, height = 3.5, units = "in", dpi = 300, bg = "white")
