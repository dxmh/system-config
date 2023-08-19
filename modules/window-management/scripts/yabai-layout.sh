#!/bin/sh

case $(yabai -m query --spaces --space | jq -r .type) in
  bsp)
    if [ "$(yabai -m query --windows --window | jq -r '.["has-fullscreen-zoom"]')" = "true" ]; then 
      label=on
      label_text=Zoomed
      icon=􀬸 
    else
      icon=􀏝 
      label=off
    fi
  ;;
  stack)
    icon=􀯰 
    label=on
    stack_index=$(yabai -m query --windows --window | jq '.["stack-index"]')
    stack_total=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
    label_text="${stack_index}/${stack_total}"
    ;;
  float)
    icon=􀇴 
    label=off
  ;;
esac

sketchybar --set yabai_layout icon="$icon" label="$label_text" label.drawing="$label"
