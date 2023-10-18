#!/bin/sh

current_layout=$(yabai -m query --spaces --space | jq -r .type) 

for layout in bsp stack float; do

  if [ "$layout" = "$current_layout" ]; then
    background="on"
  else
    background="off"
  fi

  sketchybar --set yabai_layout_$layout background.drawing="${background:=off}"

done
