#!/bin/bash

ping -c 1 -W 1 192.168.1.101 > /dev/null

kodiplaying=false
cmusplaying=false

if [[ $? != 0 ]]
then
	echo "KODI not running"
else
	playerid=$(curl -s --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
		--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Player.GetActivePlayers", "params": {} }' \
		'http://192.168.1.101:8080/jsonrpc' \
		| sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep result)

	kodiid="${playerid:$((${#playerid}-1)):1}"
	if [[ $kodiid != 0 ]]
	then
		echo "KODI connected"
	else
		speed=$(curl -s --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
			--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Player.GetProperties", "params": { "playerid": 0, "properties": ["speed"] } }' \
			'http://192.168.1.101:8080/jsonrpc' \
			| sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep speed)
		speed="${speed:$((${#speed}-1)):1}"
		kodiplaying=true
		if [[ $speed == 1 ]]
		then
			echo "> KODI running"
		else
			echo "| KODI running"
		fi
		artist=$(curl -s --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
			--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Player.GetItem", "params": { "playerid": 0, "properties": ["artist", "album", "title" ] } }' \
			'http://192.168.1.101:8080/jsonrpc' \
			| sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep artist | sed 's/.*\["\([^]]*\)\"].*/\1/g')
		album=$(curl -s --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
			--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Player.GetItem", "params": { "playerid": 0, "properties": ["artist", "album", "title" ] } }' \
			'http://192.168.1.101:8080/jsonrpc' \
			| sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep album | sed 's/.*\"\([^]]*\)\".*/\1/g')
		title=$(curl -s --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
			--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Player.GetItem", "params": { "playerid": 0, "properties": ["artist", "album", "title" ] } }' \
			'http://192.168.1.101:8080/jsonrpc' \
			| sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep title | sed 's/.*\"\([^]]*\)\".*/\1/g')
		kodiout=$title" - "$artist": "$album
#		last=$(curl -s --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
#			--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Playlist.GetProperties", "params": { "playlistid": 0, "properties": ["size"] } }' \
#			'http://192.168.1.101:8080/jsonrpc' \
#			| sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep size | sed 's/.*"result":"size"://')
#		echo $last
		fileid=$(curl -s --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
			--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Player.GetItem", "params": { "playerid": 0 } }' \
			'http://192.168.1.101:8080/jsonrpc' | sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep result | awk -v k="text" '{n=split($0,a,":"); for (i=1; i<=n; i++) print a[i]}' | tail -n1)
		filename=$(curl -s --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
			--data-binary "{ \"id\": 1, \"jsonrpc\": \"2.0\", \"method\": \"AudioLibrary.GetSongDetails\", \"params\": { \"songid\": ${fileid}, \"properties\": [\"file\"] } }" \
			'http://192.168.1.101:8080/jsonrpc' | sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep file | sed 's/.*\"\([^]]*\)\".*/\1/g')
		filename="${filename%/*}/folder.jpg"
		filename=$(echo -n $filename | perl -pe 's/([^a-zA-Z0-9_.!~*()'\''-])/sprintf("%%%02X", ord($1))/ge' | perl -pe 's/([^a-zA-Z0-9_.!~*()'\''-])/sprintf("%%%02X", ord($1))/ge')
		filename="192.168.1.101:8080/image/image://"$filename
		old_filename=$(cat /home/robert/dotfiles/oldfilename)
		if [ "$filename" != "$old_filename" ]
		then
			curl -s --user kodi:Ni3P5%Wp "$filename" > /home/robert/dotfiles/kodi.jpg
			echo "$filename" > /home/robert/dotfiles/oldfilename
		fi
	fi
fi

pid=$(pidof cmus)
if [[ $pid > 0 ]]
then
	status=$(cmus-remote -Q | grep status | cut -d' ' -f2-)
	if [ $status == "stopped" ]
	then
		echo "cmus connected"
	else
		cmusplaying=true
		if [ $status == "playing" ]
		then
			echo "> cmus running"
		else
			echo "| cmus running"
		fi
		artist=$(cmus-remote -Q | grep albumartist | cut -d' ' -f3-)
		album=$(cmus-remote -Q | grep 'album ' | cut -d' ' -f3-)
		title=$(cmus-remote -Q | grep 'title ' | cut -d' ' -f3-)
		cur=$(cmus-remote -Q | grep 'tracknumber ' | cut -d' ' -f3-)
		cmusout=$cur". "$title" - "$artist": "$album
		vol=$(cmus-remote -Q | grep 'vol_left ' | cut -d' ' -f3-)
		folder=$(cmus-remote -Q | grep 'file' | cut -d' ' -f2-)
		folder=$(dirname "${folder}")"/folder.jpg"
		ln -sf "$folder" '/home/robert/dotfiles/folder.jpg'
	fi
else
	echo "cmus not running"
fi

if $kodiplaying
then
	echo $kodiout
	ln -sf '/home/robert/dotfiles/kodi.jpg' '/home/robert/dotfiles/folder.jpg'
elif $cmusplaying
then
	echo $cmusout
	echo "Volume: "$vol"%"
else
	ln -sf '/home/robert/dotfiles/blank.png' '/home/robert/dotfiles/folder.jpg'
fi
