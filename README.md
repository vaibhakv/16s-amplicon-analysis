Assessing whether intra and inter-genomic variation hinder the utility
of ASVs
================
Vaibhav Gawde
2023-06-20

## Questions

- Within a genome, how many distinct sequences of the 16s rRNA gene are
  present relative to the number of copies per genome? How far apart are
  these sequences from each other? How does this scale from genome to
  kingdoms?

- Within a taxa (any level), how may ASVs from that taxa are shared with
  sister taxa? How does this change with taxonomic level? Variable
  region?

- Make sure we have taxonomic data for all our genomes

- Read FASTA files into R

- inner_join with tsv file

- group_by / summarize to count number of sequences and copies per
  genome

### Dependencies:

- [mothur
  v1.46.1](https://github.com/mothur/mothur/releases/tag/v1.46.1) -
  `code/install_mothur.sh` installs mothur
- `wget`
- R version 4.3.0 (2023-04-21)
  - `tidyverse` (v. 2.0.0)
  - `data.table` (v. 1.14.8)
  - `rmarkdown` (v. 2.22)

### My computer

    ## R version 4.3.0 (2023-04-21)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 22.04.2 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
    ## LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.20.so;  LAPACK version 3.10.0
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_IN.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_IN.UTF-8        LC_COLLATE=en_IN.UTF-8    
    ##  [5] LC_MONETARY=en_IN.UTF-8    LC_MESSAGES=en_IN.UTF-8   
    ##  [7] LC_PAPER=en_IN.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_IN.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## time zone: Asia/Kolkata
    ## tzcode source: system (glibc)
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ##  [1] rmarkdown_2.22    data.table_1.14.8 lubridate_1.9.2   forcats_1.0.0    
    ##  [5] stringr_1.5.0     dplyr_1.1.2       purrr_1.0.1       readr_2.1.4      
    ##  [9] tidyr_1.3.0       tibble_3.2.1      ggplot2_3.4.2     tidyverse_2.0.0  
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] gtable_0.3.1     compiler_4.3.0   tidyselect_1.2.0 scales_1.2.1    
    ##  [5] yaml_2.3.5       fastmap_1.1.0    R6_2.5.1         generics_0.1.3  
    ##  [9] knitr_1.37       munsell_0.5.0    pillar_1.9.0     tzdb_0.4.0      
    ## [13] rlang_1.1.1      utf8_1.2.2       stringi_1.7.6    xfun_0.39       
    ## [17] timechange_0.2.0 cli_3.6.1        withr_2.5.0      magrittr_2.0.3  
    ## [21] digest_0.6.29    grid_4.3.0       rstudioapi_0.14  hms_1.1.3       
    ## [25] lifecycle_1.0.3  vctrs_0.6.2      evaluate_0.15    glue_1.6.2      
    ## [29] fansi_1.0.3      colorspace_2.0-3 tools_4.3.0      pkgconfig_2.0.3 
    ## [33] htmltools_0.5.5
