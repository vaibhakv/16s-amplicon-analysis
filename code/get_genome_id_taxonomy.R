#!/usr/bin/Rscript --vanilla

# input: - data/raw/rrnDB-5.6.tsv
#        - data/references/spp_lookup.tsv
#        - data/raw/rrnDB-5.6_pantaxa_stats_NCBI.tsv
# output: tsv containing genome id along with taxonomic info
#        - data/references/genome_id_taxonomy.tsv


library(tidyverse)

metadata <- read_tsv(file = "data/raw/rrnDB-5.6.tsv") %>% 
  rename(genome_id = `Data source record id`,
         subspecies_id = `NCBI tax id`,
         rdp = `RDP taxonomic lineage`,
         scientific_name = `NCBI scientific name`) %>% 
  select(genome_id, subspecies_id, rdp, scientific_name) 

sp_spp_lookup <- read_tsv("data/references/spp_lookup.tsv", 
         col_names = c("domain", "species_id", "subspecies_id"))

makeup_tax <- tibble(
  taxid = c(1359, 1919, 76857, 76859, 78448, 96241, 115778, 118163, 137722, 155615,
            271881, 299583, 301953, 328813, 412965, 483913, 522306, 639200, 641491,
            693153, 1075399, 1114970, 1170562, 2338073, 2881428, 2886352, 2893572,
            2978683, 3025782),
  species = c("Lactococcus cremoris", "Streptomyces microflavus","Fusobacterium polymorphum",
              "Fusobacterium animalis", "Bifidobacterium pullorum", "Bacillus spizizenii", 
              "Leuconostoc gasicomitatum", "Pleurocapsa sp. PCC 7327", 
              "Azospirillum sp. B510", "Fusobacterium vincentii",
              "Lactiplantibacillus argentoratensis", "Francisella orientalis", 
              "Caldicellulosiruptor acetigenus", "Alistipes onderdonkii", 
              "Candidatus Vesicomyosocius okutanii",
              "Bacillus inaquosorum", "Candidatus Accumulibacter regalis", 
              "Sphaerotilus sulfidivorans", "Pseudodesulfovibrio mercurii", 
              "Vibrio atlanticus", 
              "Blattabacterium sp. (Cryptocercus punctulatus) str. Cpu", 
              "Pseudomonas ogarae",
              "Calothrix sp. PCC 6303", "Serratia inhibens", 
              "Parasynechococcus marenigrum", "Allocoleopsis franciscana", 
              "Dickeya parazeae", "Burkholderia orbicola",
              "Allorhizobium ampelinum"))

tax <- read_tsv("data/raw/rrnDB-5.6_pantaxa_stats_NCBI.tsv") %>% 
  filter(rank == "species") %>% 
  rename(species = name) %>% 
  select(taxid, species) %>%
  bind_rows(., makeup_tax)

inner_join(metadata, sp_spp_lookup, by="subspecies_id") %>% 
  select(-domain, -subspecies_id) %>% 
  anti_join(. , tax, by=c("species_id" = "taxid")) %>% 
  count(species_id) %>% 
  nrow(.) == 0

stopifnot(test)

inner_join(metadata, sp_spp_lookup, by="subspecies_id") %>% 
  select(-domain, -subspecies_id) %>% 
  inner_join(. , tax, by=c("species_id" = "taxid")) %>% 
  select(genome_id, rdp, species, scientific_name) %>% 
  write_tsv("data/references/genome_id_taxonomy.tsv")
  
  
  
  
  
  