#!/bin/bash
# file: script_download_kaist_db.sh.sh
# auhtor: Soonmin Hwang

# Use as:
#   script_download_kaist_db.sh.sh SET_NUMBER VIDEO_NUMBER
#
# The script creates a folder hierarchy and download corresponding video sequence files.

if [ $# -eq 2 ]
then

	set=$1
	vid=$2
	
	dstPath="videos/Set0${set}/V00${vid}" 

	echo ${dstPath}

	mkdir -p ${dstPath}

	srcPath="http://multispectral.kaist.ac.kr/KAIST-IJRR-DB/${dstPath}"
	wget -P ${dstPath} "${srcPath}/RGB.seq"
	wget -P ${dstPath} "${srcPath}/T8.seq"
else

	echo "Please pass two arguments. (e.g. script_download_kaist_db.sh.sh 0 0)"
fi

