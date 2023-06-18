#!/bin/bash

# input: count table you generated from `mothur's` `count.seqs` command 
# output: count table without the headers which you can directly input into the R script 
# eg.. if inpt is `data/v4/rrnDB.count_table` then output will be `data/v4/rrnDB.count_table2``]

target=$1

tail +3 $target > "$target"2