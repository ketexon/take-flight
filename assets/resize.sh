#!/bin/bash

for f in **/*.png; do
  if [[ "$f" == *"_sm.png" ]]; then
    continue
  fi
  magick convert "$f" -resize 30%  "${f%.*}_sm.png"
done
