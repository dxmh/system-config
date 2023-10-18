#!/bin/sh

# Switch to the next layout
yabai -m space --layout "$CLICKED"

# Force update sketchybar status
sketchybar --trigger yabai_layout_change
