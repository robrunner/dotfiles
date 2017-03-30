#!/bin/bash
var=$(pidof x11vnc)
if [ $var > 0 ]
then
	echo 'VNC running'
else
	echo 'VNC not running'
fi
