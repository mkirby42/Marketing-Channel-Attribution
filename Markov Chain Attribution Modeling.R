#! /usr/bin/Rscript

# Read in libraries
if (!require(ChannelAttribution)){
install.packages("ChannelAttribution")
library(ChannelAtrribution)
}

# Set working directory
setwd <- setwd('/Users/mattkirby/repos/Marketing-Channel-Attribution')

# Read in csv
df <- read.csv('Paths.csv')

df <- df[c(1,2)]

#Run Markov Model
M <- markov_model(df, 'Path', var_value = 'Conversion', var_conv = 'Conversion', sep = '>', order = 1, out_more = TRUE)

write.csv(M$result, file = "Markov - Output.csv", row_names = FALSE)

# Output transition matrix as well
write.csv(M$transition_matrix, file = "Markov - Output - Transition Matrix.csv", row_names = FALSE)