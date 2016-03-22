#!/bin/bash

sudo apt-get update
sudo apt-get upgrade
sudo rpi-update

# http://www.nick-horne.com/tag/raspberry-pi-camera-module-streaming/
git clone git://source.ffmpeg.org/ffmpeg.git
cd ffmpeg
./configure
make
make install
apt-get install crtmpserver
# Edit the following file:
# /etc/crtmpserver/applications/flvplayback.lua
# Add/change the following setings:
# validateHandshake=false,
# keyframeSeek=false,
# seekGranularity=0.1
# clientSideBuffer=30
service crtmpserver restart