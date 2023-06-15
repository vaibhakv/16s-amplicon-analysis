#!/bin/bash

# author: vaibhakv
# inputs: data/raw/rrnDB-5.8_16S_rRNA.fasta
#         data/references/silva_seed/silva.seed_v138_1.align
# outputs: data/raw/rrnDB-5.8_16S_rRNA.align
#
# We need to include flip=T to make sure all sequences are pointed in the same direction

sed "s/ /_/g" data/raw/rrnDB-5.8_16S_rRNA.fasta > data/raw/rrnDB-5.8_16S_rRNA.temp.fasta
code/mothur/mothur '#align.seqs(fasta=data/raw/rrnDB-5.8_16S_rRNA.fasta, reference=data/references/silva_seed/silva.seed_v138_1.align, flip=T)'

if [[ $? -eq 0 ]]
then 
	mv data/raw/rrnDB-5.8_16S_rRNA.temp.fasta data/raw/rrnDB-5.8_16S_rRNA.fasta
	rm data/raw/rrnDB-5.8_16S_rRNA.temp.fasta
else
	echo "FAIL: mothur failed to align sequences"
	exit 1
fi

