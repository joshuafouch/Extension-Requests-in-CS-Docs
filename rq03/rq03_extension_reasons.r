######## RESEARCH QUESTION 3 ######## 
# The most common reason students request extensions will be workload conflicts (e.g., multiple assignments due simultaneously).


# Find the Averages
ReasonData <- SURVEYDATA %>% filter(!is.na(Reason_Used)) %>% separate_rows(Reason_Used, sep = ";") %>% mutate(Reason_Used = trimws(Reason_Used)) %>% filter(Reason_Used != "") 
ReasonCounts <- ReasonData %>% count(Reason_Used, sort = TRUE, name = "Count") 

# Plot with Text Wrapping 
ggplot(ReasonCounts[1:5, ], aes(x = reorder(Reason_Used, Count), y = Count)) + 
  geom_bar(stat = "identity", fill = "darkgray") + 
  geom_text(aes(label = Count), hjust = -0.2, fontface = "bold") + 
  coord_flip() + 
  scale_x_discrete(labels = function(x) str_wrap(x, width = 30)) + 
  labs(title = "Top 5 Reasons for Requesting Extensions", x = "Reason", y = "Number of Students") + theme_minimal() + 
  expand_limits(y = max(ReasonCounts$Count) + 10)
