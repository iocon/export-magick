#!/bin/bash
# jpg,tif,psd,psb
# added huffman directive to not use optimized encoding. Files are ~10% bigger this way...
# I could do it without the limit and if the file output is 0 bytes, do it again with the limit. 3rd pass with 'memory 8' is also possible
# -limit memory 32
# the default quality is 92, we are forcing that since it uses an estimate of the input when converting jpeg to jpeg

[ -d out ] || mkdir out

shopt -s nullglob nocaseglob extglob
for f in *.@(psb|tif|psd|jpg); do
	convert "$f[0]" -profile sRGB.ICM -depth 24 -quality 92 "out/${f%.*}.jpg"
	if ! [ -s "out/${f%.*}.jpg" ]; then
		echo making non-optimized $f
		convert "$f[0]" -profile sRGB.ICM -limit memory 32 -depth 24 -quality 92 "out/${f%.*}.jpg"
	fi
#	echo $f
done