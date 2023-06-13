Obtained files from the eenDB located at 
https://rrndb.umms.med.umich.edu/static/download/

These are the files from version 5.8, released in 2022

Downloading and extracting the files with wget and unzip

wget -P data/raw/ -nc https://rrndb.umms.med.umich.edu/static/download/rrnDB-5.8.tsv.zip
unzip -n -d data/raw/ rrnDB-5.8.tsv.zip

wget -P data/raw/ -nc https://rrndb.umms.med.umich.edu/static/download/rrnDB-5.8_pantaxa_stats_RDP.tsv.zip 
unzip -n -d data/raw/ rrnDB-5.8_pantaxa_stats_RDP.tsv.zip

wget -P data/raw/ -nc https://rrndb.umms.med.umich.edu/static/download/rrnDB-5.8_pantaxa_stats_NCBI.tsv.zip 
unzip -n -d data/raw/ rrnDB-5.8_pantaxa_stats_NCBI.tsv.zip

wget -P data/raw/ -nc https://rrndb.umms.med.umich.edu/static/download/rrnDB-5.8_16S_rRNA.fasta.zip
unzip -n -d data/raw/ rrnDB-5.8_16S_rRNA.fasta.zip


