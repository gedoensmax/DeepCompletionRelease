#!/bin/bash

i=0
for f in $(ls -d $1/**/*.depth.png)
do
  echo $f
  basename=${f%".depth.png"}
  ((i++))
  ./gaps/bin/x86_64/depth2depth "$basename.depth.png" "$basename.depth_predict_mp.png" -xres 640 -yres 480 -fx 585 -fy 585 -cx 320 -cy 240 -inertia_weight 1000 -smoothness_weight 0.001 -input_normals "$basename.normal_predict_mp.h5" &
  ./gaps/bin/x86_64/depth2depth "$basename.depth.png" "$basename.depth_predict_sc.png" -xres 640 -yres 480 -fx 585 -fy 585 -cx 320 -cy 240 -inertia_weight 1000 -smoothness_weight 0.001 -input_normals "$basename.normal_predict_sc.h5" &
  if (( $i > 8 ))
  then
    wait
    i=0
  fi
done

wait