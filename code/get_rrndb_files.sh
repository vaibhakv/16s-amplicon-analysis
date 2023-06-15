#!/bin/bash

# author: vaibhakv
# inputs: stdin file names
# outputs: rrndb files

target=$1

filename=`echo $target | sed "s/.*\///"`
path=`echo $target | sed -E "s/(.*\/).*/\1/"`


wget -nc -P "$path" https://rrndb.umms.med.umich.edu/static/download/"$filename".zip
unzip -n -d "$path" "$target".zip

if [[ $? -eq 0 ]]
then
	touch "$target" 
else 
	echo "FAIL: were not able to successfully extract $filename"
fi


