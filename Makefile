# Rule
# target: prerequisite1 prerequesite2 prerequisite3
# (tab)recipe
# "$<" --- automatic varaible for the first prerequisite
# "$@" --- automatic variable for the target

data/references/silva_seed/silva.seed_v138_1.align : code/get_silva_seed.sh
	$<	 

data/raw/rrnDB-5.8_16S_rRNA.fasta : code/get_rrndb_files.sh
	$< $@

data/raw/rrnDB-5.8_16S_rRNA.align : code/align_sequences.sh\
							data/references/silva_seed/silva.seed_v138_1.align\
							data/raw/rrnDB-5.8_16S_rRNA.fasta	
	$<

data/raw/rrnDB-5.8.tsv : code/get_rrndb_files.sh				 															
	$< $@

data/raw/rrnDB-5.8_pantaxa_stats_NCBI.tsv : code/get_rrndb_files.sh
	$< $@

data/raw/rrnDB-5.8_pantaxa_stats_RDP.tsv : code/get_rrndb_files.sh
	$< $@

