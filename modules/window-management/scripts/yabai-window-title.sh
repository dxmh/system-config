#!/bin/sh

# Get the title of the currently focused window
title=$(yabai -m query --windows --window | jq -r .title)

stack_index=$(yabai -m query --windows --window | jq -r '.["stack-index"]')

if [ "$stack_index" -gt 0 ]; then
  stack_total=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
  stack_status="􀯰 Window stack ${stack_index}/${stack_total}"
fi

sketchybar --set yabai_window_title label="${title}   ${stack_status}"
