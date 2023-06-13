#!/bin/bash

# author: vaibhakv
# inputs: none
# outputs: mothur software
#
# This is version 1.48.0 for ubuntu distro. 
# You can download the specific version for your distro from the link provided in the README file

wget -nc -P code/mothur/ https://github.com/mothur/mothur/releases/download/v1.48.0/Mothur.Ubuntu_20.zip
unzip -n -d code/mothur/ code/mothur/Mothur.Ubuntu_20.zip