#!/bin/bash
status=$(qdbus-qt4 org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus)
if [ $status == "Stopped" ]
then
	out="■"
else
	out=$(qdbus-qt4 org.mpris.clementine /Player org.freedesktop.MediaPlayer.GetMetadata | grep title: | sed 's/.*title: //')
	if [ $status == "Playing" ]
	then
		out="▶ $out"
	else
		out="  $out"
	fi
fi
echo $out
