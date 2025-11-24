# This is our Extensions Research Project!

# to copy data from clipboard (in WINDOWS not in macos)
# this command is no header
`
df <- read.table(
    "clipboard",
    sep = "\t",
    header = FALSE, 
    fill = TRUE,
    quote = "",
    comment.char = ""
)
`

# make the header row the actual header
` 
header_row <- as.character(df[1, ])

colnames(df) <- header_row

df <- df[-1, ]
`

# fix header names
`
colnames(df) <- make.names(colnames(df), unique = TRUE)
`