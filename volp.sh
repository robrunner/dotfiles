#!/bin/bash
echo $(amixer get Master -M | grep -oE "[[:digit:]]*%" | head -n1)
