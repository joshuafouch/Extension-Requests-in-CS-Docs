######## RAW VALUES: RESEARCH QUESTION 9 ########
# Prints all x/y values and n counts for BOTH graphs in this script


# ── GRAPH 1: Average Extensions Used by GPA ──────────────────────────────────
GPA_Data <- SURVEYDATA %>%
  filter(Est_GPA != "" & !is.na(num_exts)) %>%
  mutate(
    num_exts = as.numeric(num_exts),
    Est_GPA  = factor(Est_GPA, levels = c("2.0 - 2.49", "2.5 - 2.99", "3.0 - 3.49", "3.5 - 4.0"))
  ) %>%
  filter(!is.na(Est_GPA))

cor_test <- cor.test(as.numeric(GPA_Data$Est_GPA), GPA_Data$num_exts, method = "spearman")

raw_graph1 <- GPA_Data %>%
  group_by(GPA_Group = Est_GPA) %>%
  summarise(
    n               = n(),
    Mean_Extensions = round(mean(num_exts, na.rm = TRUE), 4),
    .groups = "drop"
  )

cat("=== RQ09 Graph 1: Does the Policy Help Close the Achievement Gap? ===\n")
cat("X-axis = GPA Range (Ascending) | Y-axis = Average Extensions Used\n\n")
print(as.data.frame(raw_graph1))
cat("\nSpearman correlation p-value:", round(cor_test$p.value, 3),
    " | r =", round(cor_test$estimate, 3), "\n")

# ── GRAPH 2: Final Course Grade (%) by GPA ───────────────────────────────────
RQ3_Grades <- SURVEYDATA %>%
  filter(Est_GPA != "" & !is.na(Final_Score)) %>%
  mutate(
    Final_Score = as.numeric(as.character(Final_Score)),
    Est_GPA     = factor(Est_GPA, levels = c("2.0 - 2.49", "2.5 - 2.99", "3.0 - 3.49", "3.5 - 4.0"))
  ) %>%
  filter(!is.na(Est_GPA))

raw_graph2 <- RQ3_Grades %>%
  group_by(GPA_Group = Est_GPA) %>%
  summarise(
    n          = n(),
    Mean_Score = round(mean(Final_Score, na.rm = TRUE), 1),
    Median     = round(median(Final_Score, na.rm = TRUE), 1),
    Q1         = round(quantile(Final_Score, 0.25, na.rm = TRUE), 1),
    Q3         = round(quantile(Final_Score, 0.75, na.rm = TRUE), 1),
    Min        = min(Final_Score, na.rm = TRUE),
    Max        = max(Final_Score, na.rm = TRUE),
    .groups    = "drop"
  )

cat("\n=== RQ09 Graph 2: Does the Policy Ensure Success for At-Risk Students? ===\n")
cat("X-axis = GPA Range | Y-axis = Final Course Grade (%)\n")
cat("Boxplot with jitter. Mean score labels shown above each box.\n")
cat("Red dashed line at y = 70 (failure threshold)\n\n")
print(as.data.frame(raw_graph2))

cat("\nAll individual Final_Score values per GPA group:\n")
print(as.data.frame(
  RQ3_Grades %>% select(GPA_Group = Est_GPA, Final_Score) %>% arrange(GPA_Group, Final_Score)
))
