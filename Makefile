# Rule
# target: prerequisite1 prerequesite2 prerequisite3
# (tab)recipe
# "$<" --- automatic varaible for the first prerequisite
# "$@" --- automatic variable for the target

code/mothur/mothur: code/install_mothur.sh
	$<

data/references/silva_seed/silva.seed_v138.align : code/get_silva_seed.sh
	$<	 

data/raw/rrnDB-5.6_16S_rRNA.fasta : code/get_rrndb_files.sh
	$< $@

data/raw/rrnDB-5.6.tsv : code/get_rrndb_files.sh				 															
	$< $@

data/raw/rrnDB-5.6_pantaxa_stats_NCBI.tsv : code/get_rrndb_files.sh
	$< $@

data/raw/rrnDB-5.6_pantaxa_stats_RDP.tsv : code/get_rrndb_files.sh
	$< $@

#align sequences
data/raw/rrnDB-5.6_16S_rRNA.align : code/align_sequences.sh\
							data/references/silva_seed/silva.seed_v138.align\
							data/raw/rrnDB-5.6_16S_rRNA.fasta\
							code/mothur/mothur
	$<

#extract regions
data/%/rrnDB.align data/%/rrnDB-5.6_16S_rRNA.bad.accnos : code/extract_region.sh\

	$< $@

data/v19/rrnDB.unique.align data/v19/rrnDB.count_table : code/count_unique_seqs.sh\
											data/v19/rrnDB.align\
											code/mothur/mothur
	$< $@

data/v4/rrnDB.unique.align data/v4/rrnDB.count_table : code/count_unique_seqs.sh\
											data/v4/rrnDB.align\
											code/mothur/mothur
	$< $@

data/v34/rrnDB.unique.align data/v34/rrnDB.count_table : code/count_unique_seqs.sh\
											data/v34/rrnDB.align\
											code/mothur/mothur
	$< $@

data/v45/rrnDB.unique.align data/v45/rrnDB.count_table : code/count_unique_seqs.sh\
											data/v45/rrnDB.align\
											code/mothur/mothur
	$< $@

data/v45/rrnDB.count_table2: code/remove_headers.sh\
					data/v45/rrnDB.count_table
	$< data/v45/rrnDB.count_table


data/%/rrnDB.count_tibble: code/convert_count_table_to_tibble.R\
				data/%/rrnDB.count_table2