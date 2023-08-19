#!/bin/sh

# Define the next layout
case $(yabai -m query --spaces --space | jq -r .type) in
  bsp) next=stack ;;
  stack) next=float ;;
  float) next=bsp ;;
esac

# Switch to the next layout
yabai -m space --layout "${next:=bsp}"

# Force update sketchybar status
sketchybar --trigger yabai_layout_change
