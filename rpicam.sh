#!/bin/bash

startTime=`date +%s`
timeDay=`date +"%Y%m%d"`
# mainPath="/media/usbseagate/Videos"
mainPath="/home/pi/Videos"
currentDateTime=""
filePathH264=""
fileNameMP4=""

checkFilePath() {
	if [ ! -d $mainPath/$timeDay ]; then
		mkdir -p $mainPath/$timeDay
	fi
	return 0
}

killVideoStream() {
	pid=`pidof ffmpeg`
	if [ $? -eq 0 ]; then
		kill -9 $pid
	fi
	return 0
}

startVideoStream() {
	previousFilePathH264="$mainPath/$timeDay/$currentDateTime.h264"
	previousDateTime="$currentDateTime"
	currentDateTime=`date +"%Y%m%d_%H%M%S"`
	filePathH264="$mainPath/$timeDay/$currentDateTime.h264"
	raspivid -n -w 1280 -h 720 -vf -hf -fps 30 -o - -t 0 -awb auto -ex auto | tee $filePathH264 | ffmpeg -i - -vcodec copy -an -f flv -metadata streamName=myStream tcp://0.0.0.0:6666 &
	if [ $? -eq 1 ]; then
		echo "ERROR: Could not start raspivid" >> rpicam.log
		exit 1
	fi
	return 0
}

convertVideo() {
	filePathMP4="$mainPath/$previousTimeDay/$previousDateTime.mp4"
	MP4Box -fps 30 -add $previousFilePathH264 $filePathMP4 &
	wait $!
	if [ $? -eq 1 ]; then
		echo "WARNING: Could not convert $previousFilePathH264" >> rpicam.log
	else
		rm $previousFilePathH264 &
		wait $!
		if [ $? -eq 1 ]; then
			echo "WARNING: Could not delete $previousFilePathH264" >> rpicam.log
		fi
	fi
	return 0
}

bootup() {
	checkFilePath
	killVideoStream
	startVideoStream
}

sleepLoop() {
	timeSec=`date +%s`
	checkTime=$((timeSec % 3600))
	x=$((3600 - checkTime - 2))
	sleep $x
}

bootup
sleepLoop

while [ 1 -eq 1 ]
do
	timeSec=`date +%s`
	checkTime=$((timeSec % 3600))
	if [ $checkTime -eq 0 ]; then
		previousTimeDay="$timeDay"
		timeDay=`date +"%Y%m%d"`
		checkFilePath
		killVideoStream
		startVideoStream
		convertVideo
		sleepLoop
	fi
done