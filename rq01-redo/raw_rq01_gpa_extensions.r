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
    .groups = "drop"
  )

cat("=== RQ01: Average Extensions Requested by Estimated GPA ===\n")
cat("X-axis = GPA Group | Y-axis = Mean Extensions | n = count of students\n\n")
print(as.data.frame(RQ01_raw_values))

rq1_cor_test <- cor.test(Cleaned_RQ01_Data$GPA_Rank, Cleaned_RQ01_Data$num_exts_Requested, method = "spearman")
print(rq1_cor_test)
