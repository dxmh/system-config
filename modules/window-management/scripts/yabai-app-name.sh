#!/bin/sh

# Get the name of the currently focused app
app=$(yabai -m query --windows --window | jq -r .app)

sketchybar --set yabai_app_name label="${app}"
