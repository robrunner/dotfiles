#!/bin/bash
pid=$(pidof clementine)
if [ $pid > 0 ]
then
	status=$(qdbus-qt4 org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus)
	if [ $status == "Stopped" ]
	then
		out="■"
	else
		outa=$(qdbus-qt4 org.mpris.clementine /Player org.freedesktop.MediaPlayer.GetMetadata | grep artist: | sed 's/.*artist: //')
		outb=$(qdbus-qt4 org.mpris.clementine /Player org.freedesktop.MediaPlayer.GetMetadata | grep album: | sed 's/.*album: //')
		outc=$(qdbus-qt4 org.mpris.clementine /Player org.freedesktop.MediaPlayer.GetMetadata | grep title: | sed 's/.*title: //')
		outd=$(qdbus-qt4 org.mpris.clementine /TrackList org.freedesktop.MediaPlayer.GetCurrentTrack)
		outd=$((outd+1))
		oute=$(qdbus-qt4 org.mpris.clementine /TrackList org.freedesktop.MediaPlayer.GetLength)
		out=$outc" - "$outa": "$outb
		if [ $status == "Playing" ]
		then
			out="▶ $out"
		else
			out="  $out"
		fi
	fi
	outvol=$outd"/"$oute" - Volume: "$(qdbus-qt4 org.mpris.clementine /Player org.freedesktop.MediaPlayer.VolumeGet)"%"
	echo $outvol
	echo $out
else
	echo 'Clementine not running'
fi
