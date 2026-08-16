# libraries

```R
library(ggplot2);library(multcomp);library(pastecs);library(reshape); library(reshape2); library(nlme); library(car); library(pwr); library(dplyr); library(devtools); library(rms);library(psych); library(ggpubr)

```

# Importing Data

## Header = False

```R
# to copy data from clipboard (in WINDOWS not in macos)
OBJECT_NAME <- read.table(
    "clipboard",
    sep = "\t",
    header = FALSE, 
    fill = TRUE,
    quote = "",
    comment.char = ""
)
```

## Create a Header variable

```R
header_row <- as.character(OBJECT_NAME[1, ])
```

## Make it the Header Row

```R
colnames(OBJECT_NAME) <- header_row
```

## Delete Unneeded Header Row

```R
OBJECT_NAME <- OBJECT_NAME[-1, ]
```

## Fix Header

```R
colnames(OBJECT_NAME) <- make.names(colnames(OBJECT_NAME), unique = TRUE)
```

## Make String Column to Numerical

```R
SurveyData$Total_Extensions <- as.numeric(as.character(SurveyData$Total_Extensions))
```



# H0: Correlation Between Extension Usage and Final Grade

```
```





# H1: Students with lower starting GPAs are more likely to request extensions than students with higher starting GPAs.

```R
# Make the GPAs Numerical
SurveyData$GPA_Rank <- as.numeric(factor(SurveyData$Est_GPA, levels = c("1.5 - 1.99", "2.0 - 2.49", "2.5 - 2.99", "3.0 - 3.49", "3.5 - 4.0", "4.0+")))


# correlation test
cor.test(SurveyData$GPA_Rank, SurveyData$Total_Extensions, method = "spearman")
```

## Result:

```
Spearman's rank correlation rho

data:  SurveyData$GPA_Rank and SurveyData$Total_Extensions
S = 320930, p-value = 5.736e-05
alternative hypothesis: true rho is not equal to 0
sample estimates:
       rho 
-0.3707003 
```

### Gemini Report Based off of Statistic

"A Spearman's rank-order correlation was run to determine the relationship between a student's estimated GPA and the number of extensions they requested. There was a moderate, statistically significant negative correlation between GPA and extension usage ($r_s(122) = -.37, p < .001$), supporting Hypothesis 1. This indicates that students with lower reported GPAs tended to utilize the extension policy more frequently than their higher-performing peers."



