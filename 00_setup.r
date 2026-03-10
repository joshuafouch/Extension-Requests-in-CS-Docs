################ SETUP SCRIPT ################
# This script contains all the libraries and data import code
# Source this file at the beginning of each analysis script with: source("00_setup.r")

########### R ANALYSIS ##############

# BASIC LIBRARIES NEEDED
# must be run upon opening RStudio
library(tidyr); library(ggplot2);library(multcomp);library(pastecs);library(reshape); library(reshape2); library(nlme); library(car); library(pwr); library(dplyr); library(devtools); library(rms);library(psych); library(ggpubr); library(stringr);library(Hmisc)

# IMPORTING DATA IN R
# NOTE: make sure header = false
SURVEYDATA <- read.table(
   "clipboard",
   sep = "\t",
   header = FALSE,
   fill = TRUE,
   quote = "",
   comment.char = ""
)

# for linux
# dependency: xclip
SURVEYDATA <- read.table(
   pipe("xclip -selection clipboard -o", "r"), 
   sep = "\t",
   header = FALSE,
   fill = TRUE,
   quote = "",
   comment.char = ""
)

# CREATE THE HEADER:
header_row <- as.character(SURVEYDATA[1, ])

colnames(SURVEYDATA) <- header_row

SURVEYDATA <- SURVEYDATA[-1, ]

colnames(SURVEYDATA) <- make.names(colnames(SURVEYDATA), unique = TRUE)
