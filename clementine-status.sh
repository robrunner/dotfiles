#!/bin/bash
status=$(qdbus org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus)
if [ $status == "Stopped" ]
then
    out="■"
else
    out=$(qdbus org.mpris.clementine /Player org.freedesktop.MediaPlayer.GetMetadata | grep title: | sed 's/.*: //')
        if [ $status == "Playing" ]
        then
            out="▶ $out"
        else
            out="  $out"
        fi
fi
echo $out
