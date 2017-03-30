#!/bin/bash

ping -c 1 -W 1 192.168.1.101 > /dev/null
kodicon=$?
kodiid=1

if [[ $kodicon == 0 ]]
then
	playerid=$(curl --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
		--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Player.GetActivePlayers", "params": {} }' \
		'http://192.168.1.101:8080/jsonrpc' \
		| sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep result)

	kodiid="${playerid:$((${#playerid}-1)):1}"
fi

cmusid=$(pidof cmus)

if [[ $kodiid == 0 ]]
then
	if [[ $1 == "pause" ]]
	then
		curl --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
			--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Player.PlayPause", "params": { "playerid": 0 } }' \
			'http://192.168.1.101:8080/jsonrpc'
	elif [[ $1 == "next" ]]
	then
		curl --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
			--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Player.GoTo", "params": { "playerid": 0, "to": "next" } }' \
			'http://192.168.1.101:8080/jsonrpc'
	elif [[ $1 == "prev" ]]
	then
		curl --user kodi:Ni3P5%Wp --header 'Content-Type: application/json' \
			--data-binary '{ "id": 1, "jsonrpc": "2.0", "method": "Player.GoTo", "params": { "playerid": 0, "to": "previous" } }' \
			'http://192.168.1.101:8080/jsonrpc'
	fi
else 
	if [[ $cmusid > 0 ]]
	then
		if [[ $1 == "pause" ]]
		then
			cmus-remote -u
		elif [[ $1 == "next" ]]
		then
			cmus-remote -n
		elif [[ $1 == "prev" ]]
		then
			cmus-remote -p
		fi
	fi
fi
