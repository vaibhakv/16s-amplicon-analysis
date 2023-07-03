#!/usr/bin/Rscript --vanilla

# input: tidy count files for each region
# output: composity tidy count file to with column to indicate the region

tibble_files <- commandArgs(trailingOnly = TRUE)

library(tidyverse)
# tibble_files <- c("data/v4/rrnDB.count_tibble", "data/v34/rrnDB.count_tibble",
#                   "data/v45/rrnDB.count_tibble")
# 
# names(tibble_files) <- c("v4", "v34", "v45")

names(tibble_files) <- str_replace(string = tibble_files,
                                   pattern = "data/(.*)/rrnDB.count_tibble",
                                   replacement = "\\1")

map_dfr(tibble_files, read_tsv, .id = "region", col_types = "ccd") %>% 
  write_tsv("data/processed/rrnDB.count_tibble")
