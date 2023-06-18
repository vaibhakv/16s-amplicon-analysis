#!/bin/bash
#
# author: vaibhakv
# dependency: data/raw/rrnDB-5.6_16S_rRNA.align
# input: the target name, which is really the output
#           data/<region>/rrnDB.align

target=$1
region=`echo $target | sed -E "s/.*\/(.*)\/.*/\1/"`
path=`echo $target | sed -E "s/(.*\/.*)\/.*/\1/"`

# echo "target: $target"
# echo "region: $region"
# echo "path: $path"

if [[ "$region" = "v19" ]]
then
	start=1044
	end=43116
	echo "region = $region"
elif [[ "$region" = "v4" ]]
then 
	start=13862
	end=23444
	echo "region = $region"	
elif [[ "$region" = "v34" ]]
then 
	start=6428
	end=23444
	echo "region = $region"	
elif [[ "$region" = "v45" ]]
then 
	start=13862
	end=27659
	echo "region = $region"	
else 
	echo "We don't have co-ordinates for this region" 
	exit 1
fi

mkdir -p $path 

code/mothur/mothur "#pcr.seqs(fasta=data/raw/rrnDB-5.6_16S_rRNA.align, start=$start, end=$end, outputdir=$path); filter.seqs(vertical=TRUE)"

#to check if mothur executed successfully
if [[ $? -eq 0 ]]
then	
	sed "/^[^>]/ s/\./-/g" $path/rrnDB-5.6_16S_rRNA.pcr.filter.fasta > $path/rrnDB-5.6_16S_rRNA.pcr.filter.test.fasta

	touch $path/rrnDB-5.6_16S_rRNA.bad.accnos $path/rrnDB.bad.accnos
	touch $path/rrnDB-5.6_16S_rRNA.scrap.pcr.align
else
	echo "FAIL: mothur ran into a problem"
	exit 1
fi

#clean up the file names
mv $path/rrnDB-5.6_16S_rRNA.pcr.filter.test.fasta $target
mv $path/rrnDB-5.6_16S_rRNA.bad.accnos $path/rrnDB.bad.accnos

#garbage collection
rm $path/rrnDB-5.filter
rm $path/rrnDB-5.6_16S_rRNA.pcr.align   
rm $path/rrnDB-5.6_16S_rRNA.scrap.pcr.align
rm $path/rrnDB-5.6_16S_rRNA.pcr.filter.fasta

