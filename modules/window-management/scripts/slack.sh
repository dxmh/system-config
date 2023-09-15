#!/bin/sh

dockBadge=$(lsappinfo info -only StatusLabel -app Slack | sed -rn 's/"StatusLabel"=\{ "label"="(.*)" \}/\1/p')

if [ -n "$dockBadge" ]; then
  icon=on
  label=on
  [ "$dockBadge" = "•" ] && label=off # Don't show a pointless label
fi

sketchybar --set slack \
  icon.drawing="${icon:=off}" \
  label.drawing="${label:=off}" \
  label="$dockBadge"
