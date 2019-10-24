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

df <- df[c(1,2,3)]

# Run Markov Model
M <- markov_model(Data = df,
                  var_path = 'Path',
                  var_conv = 'Conversion',
                  var_value = 'Conversion_value',      
                  sep = '>',
                  order = 1,
                  out_more = TRUE)

write.csv(M$result, file = "Markov - Output.csv", row.names = FALSE)

# Output transition matrix as well
write.csv(M$transition_matrix, file = "Markov - Output - Transition Matrix.csv", row.names = FALSE)


# Description
#    Estimate a k-order Markov model from customer journey data.
# Usage
#    markov_model(Data, var_path, var_conv, var_value=NULL, var_null=NULL,
#    order=1, nsim=NULL, max_step=NULL, out_more=FALSE, sep=">",
#    seed=NULL)
# Arguments
#    Data data.frame containing paths and conversions.
#    var_path column name containing paths.
#    var_conv column name containing total conversions.
#    var_value column name containing total conversion value.
#    var_null column name containing total paths that do not lead to conversions.
#    order Markov Model order.
#    nsim total simulations from transition matrix.
#    max_step maximum number of steps for a single simulated path.
#    out_more if TRUE returns the transition probabilities between channels and removal effects.
#    sep separator between the channels.
#    seed random seed. Giving to this parameter the same value over different runs guarantee that results will
#    not vary.