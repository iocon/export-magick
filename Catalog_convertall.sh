#!/bin/bash
# jpg,tif,psd,psb
# We resize to 3.24MP (1800x1800 square) which is 'catalog res'
# the default quality is 92, we are forcing that since it uses an estimate of the input when converting jpeg to jpeg

shopt -s nullglob nocaseglob extglob
for f in *.@(psb|tif|psd|jpg); do
	convert "$f[0]" -resize '3240000@>' -profile sRGB.ICM -depth 24 -quality 92 "out/${f%.*}.jpg"
#	echo $f
done