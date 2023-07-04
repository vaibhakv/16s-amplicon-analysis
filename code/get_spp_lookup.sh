#!/bin/bash

# author: vaibhakv
# inputs: 
# outputs: 


wget -P data/references/ -nc https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxcat.zip
unzip -n -d data/references/ data/references/taxcat.zip

if [[ $? -eq 0 ]]
 then
 	mv data/references/categories.dmp data/references/spp_lookup.tsv
 else 
 	echo "FAIL: were not able to successfully extract the file 
 fi

