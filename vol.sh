#!/bin/bash
vol=$(amixer get Master -M | grep -oE "[[:digit:]]*%" | head -n1)
vol="${vol::-1}"
echo "$vol"
