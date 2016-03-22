#!/bin/bash

#mkdir -p /tmp/stream
#raspistill --nopreview -vf -hf -w 1280 -h 720 -q 100 -o /tmp/stream/pic.jpg -tl 10 -t 9999999 -th 0:0:0 &
#LD_LIBRARY_PATH=/usr/local/lib mjpg_streamer -i "input_file.so -f /tmp/stream -n pic.jpg" -o "output_http.so -w /usr/local/www"

# raspivid -n -w 1280 -h 720 -vf -hf -o - -t 0 -awb auto -ex auto | tee /media/usbseagate/Videos/testVideo.h264 | cvlc -vvv stream:///dev/stdin --sout '#rtp{sdp=rtsp://:8554/}' :demux=h264
# raspivid -n -w 1280 -h 720 -vf -hf -o - -t 0 -awb auto -ex auto | cvlc -vvv stream:///media/usbseagate/Videos/testVideo1.h264 --sout '#rtp{sdp=rtsp://:8554/}' :demux=h264

# sudo raspivid -n -w 1280 -h 720 -vf -hf -o - -t 0 -awb auto -ex auto | tee /media/usbseagate/Videos/ testVideo.h264 | ffmpeg -i - -vcodec copy -an -f flv -metadata streamName=myStream tcp://0.0.0.0:6666

sudo raspivid -n -w 1280 -h 720 -vf -hf -o - -t 0 -awb auto -ex auto | ffmpeg -i - -vcodec copy -an -f flv -metadata streamName=myStream tcp://0.0.0.0:6666 &

sudo raspivid -n -w 1280 -h 720 -vf -hf -o - -t 0 -awb auto -ex auto | ffmpeg -i - -vcodec copy -an -f flv -metadata streamName=myStream tcp://0.0.0.0:6666 &

# sudo raspivid -n -w 1280 -h 720 -vf -hf -o - -t 0 -awb auto -ex auto | ffmpeg -i - -vf drawtext="fontfile=/usr/share/fonts/truetype/ttf-dejavu/DejaVuSerif.ttf: text='Text to write is this one, overlaid':fontsize=20:fontcolor=white:x=100:y=100" -an -f flv -metadata streamName=myStream tcp://0.0.0.0:6666 &

# https://sites.google.com/a/asu.edu/wireless-video-sensor/video/how-to-setup-full-ffmpeg-tools-in-ubuntu-11-10/useful-ffmpeg-commands
# ffmpeg -f video4linux2 -input_format mjpeg -s 1280x720 -i /dev/video0 \
# -vf drawtext="fontfile=/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf: \
# text='%{localtime\:%T}': fontcolor=white@0.8: x=7: y=700" -vcodec libx264 \
# -preset veryfast -f mp4 -pix_fmt yuv420p -y output.mp4