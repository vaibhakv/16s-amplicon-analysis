#!/bin/bash

# author: vaibhakv
# inputs: stdin file names
# outputs: rrndb files

archive=$1


wget -nc -P data/raw/ https://rrndb.umms.med.umich.edu/static/download/"$archive".zip
unzip -n -d data/raw/ data/raw/"$archive".zip


