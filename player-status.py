#!/usr/bin/env python3
import os
import subprocess

ping = subprocess.run(["ping", "-c", "1", "-W", "1", "kodi"]).returncode

if ping == 0:
    kodi = 1;
else:
    kodi = 0;

status = subprocess.run(["curl", "-s", "--user", "kodi:Ni3P5%Wp", "--header", "Content-Type: application/json", "--data-binary", "{ \"id\": 1, \"jsonrpc\": \"2.0\", \"method\": \"Player.GetActivePlayers\", \"params\": {} }", "kodi:8080/jsonrpc"], stdout = subprocess.PIPE).stdout;

print(status);
