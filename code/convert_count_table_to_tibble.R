#!/usr/bin/Rscript --vanilla

# input: mothur-formatted count file
# output: tidy data frame with asv, genome, count as columns
# put inputs in order of input output

library(tidyverse)
library(data.table)

args <- commandArgs(trailingOnly = TRUE)

input_file <- args[1]
output_file <- args[2]

 fread(input_file) %>% 
   rename(asv=Representative_Sequence) %>% 
   select(-total) %>% 
   melt(id.vars="asv", variable.name = "genome", value.name = "count") %>% 
   filter(count != 0) %>% 
   write_tsv(output_file)


  
