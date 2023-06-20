library(tidyverse)

v34 <- read_tsv("data/v34/rrnDB.count_tibble")

#how many rrn copies are in each genome?
v34 %>% 
  group_by(genome) %>% 
  summarise(n_rrn = sum(count), .groups = "drop") %>% 
  ggplot(aes(x=n_rrn)) + geom_histogram(binwidth = 1)

v34 %>% 
  group_by(genome) %>% 
  summarise(n_rrn = sum(count), .groups = "drop") %>% 
  count(n_rrn) %>% 
  mutate(fraction = n / sum(n))

# what is the number of ASVs per genome?
v34 %>% 
  group_by(genome) %>% 
  summarise(n_asv = n(), n_rrn = sum(count)) %>% 
  group_by(n_rrn) %>% 
  summarise(med_n_asv = median(n_asv),
            lq_n_asv = quantile(n_asv, prob = 0.25),
            uq_n_asv = quantile(n_asv, prob = 0.75)) 


v34 %>% 
  group_by(genome) %>% 
  summarise(n_asv = n(), n_rrn = sum(count)) %>% 
  ggplot(aes(x=n_rrn, y=n_asv)) + geom_smooth(method="lm")

# how many genomes does each ASV appear in?

v34 %>% 
  group_by(asv) %>% 
  summarise(n_genomes = n()) %>% 
  count(n_genomes) %>% 
  mutate(fraction = n/sum(n))
