#!/bin/sh

# Get the title of the currently focused window
title=$(yabai -m query --windows --window | jq -r .title)

sketchybar --set yabai_window_title label="${title}"
