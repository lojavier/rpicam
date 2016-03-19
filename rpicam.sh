#!/bin/bash

startTime=`date +%s`
formatTime=`date +"%Y%m%d_%H%M"`
temp=$((startTime / 60))
temp2=$((startTime % 60))
temp3=$((startTime % 3600))
temp4=$((startTime % 216000))

echo $formatTime
echo $startTime
echo $temp
echo $temp2
echo $temp3
echo $temp4

while [ 1 -eq 1 ]
do
	timeSec=`date +%s`
	checkTime=$((timeSec % 3600))
	if [ $checkTime -eq 0 ]; then
		formatTime=`date +"%Y%m%d_%H%M"`
		fileName="$formatTime.h264"
		echo "It's of the hour"

		timeDay==`date +"%Y%m%d"`
		exit 0

		# raspivid -n -w 1280 -h 720 -o - | ffmpeg
		# sudo apt-get install -y gpac
		# MP4Box -fps 30 -add myvid.h264 myvid.mp4
		sleep 3540
	else
		sleep 0.9
		fileName="$formatTime.h264"
		echo $fileName
	fi
done