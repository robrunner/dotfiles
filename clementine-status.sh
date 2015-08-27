#!/bin/bash
if [ $(qdbus org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus) == "Stopped" ]
then
    out="■"
else
    out=$(qdbus org.mpris.clementine /Player org.freedesktop.MediaPlayer.GetMetadata | grep title: | sed 's/.*: //')
        if [ $(qdbus org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus) == "Playing" ]
        then
            out="▶ $out"
        else
            out="  $out"
        fi
fi
echo $out
