#!/bin/bash

for f in *.*; do
	mv "$f" "$1 - $f";
done
