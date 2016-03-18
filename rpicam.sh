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
	tempTime=`date +%s`
	checkTime=$((tempTime % 3600))
	if [ $checkTime -eq 0 ]; then
		echo "It's of the hour"
		exit 0
	else
		sleep 1
	fi
done