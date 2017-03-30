#!/bin/bash

ping -c 1 -W 1 192.168.1.6 > /dev/null

kodiplaying=false
cmusplaying=false

if [[ $? != 0 ]]
then
	:
else
	playerid=$(curl --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
		--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Player.GetActivePlayers", "params": {} }' \
		'http://192.168.1.6/jsonrpc' \
		| sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep result)

	kodiid="${playerid:$((${#playerid}-1)):1}"
	if [[ $kodiid != 0 ]]
	then
		:
	else
		speed=$(curl --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
			--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Player.GetProperties", "params": { "playerid": 0, "properties": ["speed"] } }' \
			'http://192.168.1.6/jsonrpc' \
			| sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep speed)
		speed="${speed:$((${#speed}-1)):1}"
		kodiplaying=true
		if [[ $speed == 1 ]]
		then
			:
		else
			:
		fi
		artist=$(curl --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
			--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Player.GetItem", "params": { "playerid": 0, "properties": ["artist", "album", "title" ] } }' \
			'http://192.168.1.6/jsonrpc' \
			| sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep artist | sed 's/.*\["\([^]]*\)\"].*/\1/g')
		album=$(curl --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
			--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Player.GetItem", "params": { "playerid": 0, "properties": ["artist", "album", "title" ] } }' \
			'http://192.168.1.6/jsonrpc' \
			| sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep album | sed 's/.*\"\([^]]*\)\".*/\1/g')
		title=$(curl --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
			--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Player.GetItem", "params": { "playerid": 0, "properties": ["artist", "album", "title" ] } }' \
			'http://192.168.1.6/jsonrpc' \
			| sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep title | sed 's/.*\"\([^]]*\)\".*/\1/g')
		kodiout=$title
#		last=$(curl --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
#			--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Playlist.GetProperties", "params": { "playlistid": 0, "properties": ["size"] } }' \
#			'http://192.168.1.6/jsonrpc' \
#			| sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep size | sed 's/.*"result":"size"://')
#		echo $last
	fi
fi

pid=$(pidof cmus)
if [[ $pid > 0 ]]
then
	status=$(cmus-remote -Q | grep status | cut -d' ' -f2-)
	if [ $status == "stopped" ]
	then
		:
	else
		cmusplaying=true
		if [ $status == "playing" ]
		then
			:
		else
			:
		fi
		artist=$(cmus-remote -Q | grep albumartist | cut -d' ' -f3-)
		album=$(cmus-remote -Q | grep 'album ' | cut -d' ' -f3-)
		title=$(cmus-remote -Q | grep 'title ' | cut -d' ' -f3-)
		cur=$(cmus-remote -Q | grep 'tracknumber ' | cut -d' ' -f3-)
		cmusout=$title
		vol=$(cmus-remote -Q | grep 'vol_left ' | cut -d' ' -f3-)
	fi
else
	:
fi

if $kodiplaying
then
	echo $kodiout
elif $cmusplaying
then
	echo $cmusout
fi
