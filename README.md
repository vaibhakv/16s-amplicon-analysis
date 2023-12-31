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
- R version 4.3.1 (2023-06-16)
  - `tidyverse` (v. 2.0.0)
  - `data.table` (v. 1.14.8)
  - `rmarkdown` (v. 2.22)

### My computer

    ## R version 4.3.1 (2023-06-16)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 22.04.2 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
    ## LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.20.so;  LAPACK version 3.10.0
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
    ##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
    ##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
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
    ##  [1] gtable_0.3.1     compiler_4.3.1   tidyselect_1.2.0 scales_1.2.1    
    ##  [5] yaml_2.3.5       fastmap_1.1.0    R6_2.5.1         generics_0.1.3  
    ##  [9] knitr_1.37       munsell_0.5.0    pillar_1.9.0     tzdb_0.4.0      
    ## [13] rlang_1.1.1      utf8_1.2.2       stringi_1.7.6    xfun_0.39       
    ## [17] timechange_0.2.0 cli_3.6.1        withr_2.5.0      magrittr_2.0.3  
    ## [21] digest_0.6.29    grid_4.3.1       rstudioapi_0.14  hms_1.1.3       
    ## [25] lifecycle_1.0.3  vctrs_0.6.2      evaluate_0.15    glue_1.6.2      
    ## [29] fansi_1.0.3      colorspace_2.0-3 tools_4.3.1      pkgconfig_2.0.3 
    ## [33] htmltools_0.5.5

##### Current status of the EDA (I’ll keep changing this as the project progresses)

``` r
library(tidyverse)
library(here)
```

### Need to determine the number of *rrn* operons accross the v34 regions of the genomes

``` r
count_tibble <- read_tsv(here("data/processed/rrnDB.count_tibble"), 
                         col_types = "cccd")
```

We want to count and plot the number of copies per genome We’ll maybe do
this for the **v4** sub-region as an example

``` r
count_tibble %>% 
  filter(region == "v4") %>% 
  group_by(genome) %>% 
  summarise(n_rrn = sum(count), .groups = "drop") %>% 
  ggplot(aes(x=n_rrn)) + geom_histogram(binwidth = 1)
```

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

``` r
count_tibble %>% 
  filter(region == "v4") %>% 
  group_by(genome) %>% 
  summarise(n_rrn = sum(count)) %>% 
  count(n_rrn) %>% 
  mutate(fraction = n / sum(n))
```

    ## # A tibble: 20 × 3
    ##    n_rrn     n  fraction
    ##    <dbl> <int>     <dbl>
    ##  1     1  1589 0.102    
    ##  2     2  1749 0.112    
    ##  3     3  2162 0.139    
    ##  4     4  1827 0.117    
    ##  5     5  1259 0.0808   
    ##  6     6  2127 0.137    
    ##  7     7  2684 0.172    
    ##  8     8   974 0.0625   
    ##  9     9   365 0.0234   
    ## 10    10   325 0.0209   
    ## 11    11   144 0.00924  
    ## 12    12   161 0.0103   
    ## 13    13    71 0.00456  
    ## 14    14   105 0.00674  
    ## 15    15    23 0.00148  
    ## 16    16     5 0.000321 
    ## 17    17     5 0.000321 
    ## 18    18     1 0.0000642
    ## 19    19     1 0.0000642
    ## 20    21     1 0.0000642

We see that most genomes actually have more than one copy of the *rrn*
operon. Are those copies the same sequence / ASV..?

### Determine number of ASVs per genome

Considering most genomes have multiple copies of the *rrn* operon, we
need to know whether they are the same ASV. Otherwise we run the risk of
splitting a single genome into multiple ASVs.

Now we’ll take into account all the sub-regions that we’ve extracted ie
v4, v34, v45

``` r
count_tibble %>% 
  group_by(region, genome) %>% 
  summarise(n_asv = n(), n_rrn = sum(count)) %>% 
  group_by(region, n_rrn) %>% 
  summarise(med_n_asv = median(n_asv),
            mean_n_asv = mean(n_asv),
            lq_n_asv = quantile(n_asv, prob = 0.25),
            uq_n_asv = quantile(n_asv, prob = 0.75)) %>% 
  filter(n_rrn == 7)
```

    ## `summarise()` has grouped output by 'region'. You can override using the
    ## `.groups` argument.
    ## `summarise()` has grouped output by 'region'. You can override using the
    ## `.groups` argument.

    ## # A tibble: 3 × 6
    ## # Groups:   region [3]
    ##   region n_rrn med_n_asv mean_n_asv lq_n_asv uq_n_asv
    ##   <chr>  <dbl>     <dbl>      <dbl>    <dbl>    <dbl>
    ## 1 v34        7         2       2.10        1        3
    ## 2 v4         7         1       1.48        1        2
    ## 3 v45        7         1       1.64        1        2

``` r
count_tibble %>% 
  group_by(region, genome) %>% 
  summarise(n_asv = n(), n_rrn = sum(count)) %>% 
  ggplot(aes(x=n_rrn, y=n_asv, color=region)) + geom_smooth(method="lm")
```

    ## `summarise()` has grouped output by 'region'. You can override using the
    ## `.groups` argument.
    ## `geom_smooth()` using formula = 'y ~ x'

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

We can see that the sub-region **v34** has more number of ASVs per
genome than **v4** and **v45**. **v4** is common between them so it just
says that the **v3** region has more number of unique ASVs than **v5**
region.

### Determine whether an ASV is unique to genomes they’re found in

Instead of looking at the number of ASVs per genome, we want to see the
number of genomes per ASV.

``` r
count_tibble %>% 
  group_by(region, asv) %>% 
  summarise(n_genomes = n()) %>% 
  count(n_genomes) %>% 
  mutate(fraction = n/sum(n)) %>% 
  filter(n_genomes == 1)
```

    ## `summarise()` has grouped output by 'region'. You can override using the
    ## `.groups` argument.

    ## # A tibble: 3 × 4
    ## # Groups:   region [3]
    ##   region n_genomes     n fraction
    ##   <chr>      <int> <int>    <dbl>
    ## 1 v34            1  7246    0.779
    ## 2 v4             1  4592    0.759
    ## 3 v45            1  5717    0.778

We can see that with the these sub-region, how many % of the ASVs were
unique to a genome
