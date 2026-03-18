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
