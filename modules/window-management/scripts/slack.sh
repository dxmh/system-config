#!/bin/sh

# Show Slack icon in the bar if Slack has a badge in the Dock:
lsappinfo info -only StatusLabel -app Slack \
  | sed s/\"//g | grep -Po "label=\S" && icon=on

sketchybar --set slack icon.drawing="${icon:=off}"
