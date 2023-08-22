#!/bin/sh

# Display a graphical prompt to change the label of the current space
# https://sapegin.me/blog/show-gui-dialog-from-shell/

current_space_id=$(yabai -m query --spaces --space | jq -r .index)
current_space_label=$(sketchybar --query space.$current_space_id | jq -r .label.value)
new_space_label=$(osascript <<EOT
    tell app "System Events"
      text returned of ( display dialog "Enter the new label for the current space:"  with title "Rename space" default answer "$current_space_label"  buttons {"OK"}  default button 1 )
    end tell
EOT)

if [ -n "$new_space_label" ]; then
  sketchybar --set space.$current_space_id \
    label="$new_space_label" \
    label.drawing=on
else
  sketchybar --set space.$current_space_id \
    label="$current_space_label" \
    label.drawing=off
fi
