library(ggplot2)
library(dplyr)

# 1. Load the data 
pie_data <- read.csv("your_spreadsheet.csv", stringsAsFactors = FALSE)
colnames(pie_data) <- c("Category", "n_count", "Percent_String")

# 2. Clean Data and Calculate the Exact Geometry
pie_data <- pie_data %>%
    mutate(
        Percent_Numeric = as.numeric(gsub("%", "", Percent_String)),
        Category = as.character(Category),
        
        # Clean the category names for the Legend
        Category_Clean = case_when(
            Category == "1" ~ "1 Extension",
            Category == "ALL" ~ "ALL Assignments",
            TRUE ~ paste0(Category, " Extensions")
        ),
        Category_Clean = factor(Category_Clean, levels = c("1 Extension", "2 Extensions", "3 Extensions", "4 Extensions", "ALL Assignments")),
        
        # The label to go INSIDE the pie chart, formatted exactly like your image
        Inside_Label = paste0(Category, " (", Percent_Numeric, "%)")
    ) %>%
    
    # Lock in the order so our math perfectly matches the graph
    arrange(Category_Clean) %>%
    
    mutate(
        # Calculate precise start and end points for each slice
        ymax = cumsum(Percent_Numeric),
        ymin = ymax - Percent_Numeric,
        midpoint = (ymax + ymin) / 2,
        
        # Calculate the exact radial angle for the text to point outward
        angle_deg = 90 - (midpoint / sum(Percent_Numeric) * 360),
        
        # Standard flip for left side of the circle
        text_angle = ifelse(angle_deg < -90 | angle_deg > 90, angle_deg + 180, angle_deg),
        
        # THE FIX: Manually force the "1 Extension" slice to flip 180 degrees!
        text_angle = ifelse(Category == "1", text_angle + 180, text_angle)
    )

# 3. Create the Pie Chart
# We use geom_rect instead of geom_bar because it guarantees our angle math lines up perfectly!
IEEE_pie_chart <- ggplot(pie_data) +
    
    # The pie slices (xmin=0, xmax=1 defines the radius of the circle)
    geom_rect(aes(ymin = ymin, ymax = ymax, xmin = 0, xmax = 1, fill = Category_Clean), 
              color = "black", linewidth = 0.5) +
    
    # Turn the rectangles into a circular pie chart
    coord_polar(theta = "y") +
    
    # The radial text inside the slices
    # x = 0.75 pushes the text out towards the outer edge of the pie
    geom_text(aes(x = 0.75, y = midpoint, label = Inside_Label, angle = text_angle), 
              family = "serif", fontface = "bold", size = 3, color = "black") +
    
    # IEEE Grayscale (Lightened slightly so the black text is easily readable on dark slices)
    scale_fill_manual(
        values = c("gray45", "gray60", "gray75", "gray90", "white"), 
        name = "Suggested Policy:"
    ) +
    
    # Strict IEEE Theme with bottom legend
    theme_void() + 
    theme(
        text = element_text(family = "serif", size = 10, color = "black"),
        plot.margin = margin(t = 10, r = 10, b = 10, l = 10),
        
        # Restore the Legend
        legend.position = "bottom",
        legend.title = element_text(face = "bold", size = 9),
        legend.text = element_text(size = 8),
        legend.margin = margin(t = 0, r = 0, b = 0, l = 0),
        
        plot.background = element_rect(fill = "white", color = NA),
        panel.background = element_rect(fill = "white", color = NA)
    ) +
    
    # Wrap the legend neatly so it fits the column
    guides(fill = guide_legend(nrow = 2, byrow = TRUE))

# Print the plot
print(IEEE_pie_chart)

# 4. Export to exact IEEE specifications
ggsave("IEEE_PieChart_ImageStyle.png", plot = IEEE_pie_chart, 
       width = 4.5, height = 4.6, units = "in", dpi = 300, bg = "white")
