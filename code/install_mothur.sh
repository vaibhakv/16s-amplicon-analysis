#!/bin/bash

# author: vaibhakv
# inputs: none
# outputs: mothur software
# This is version 1.48.0 for ubuntu distro. 
# You can download the specific version for your distro from the link provided in the README file

wget -nc -P code/ https://github.com/mothur/mothur/releases/download/v1.46.1/Mothur.Ubuntu_20.zip
unzip -n -d code/ code/Mothur.Ubuntu_20.zip

if [[ $? -eq 0 ]]
then
	touch "code/mothur/mothur" 
else 
	echo "FAIL: were not able to successfully install mothur"
fi
