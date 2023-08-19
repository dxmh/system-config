#!/bin/sh

# Slack's window title contains indicators that suggest unread messages:
yabai -m query --windows | jq -r '.[] | select(.app == "Slack") | .title' \
  | grep -e \* -e ! -e new && icon=on
  
sketchybar --set slack icon.drawing="${icon:=off}"
