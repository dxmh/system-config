#!/bin/bash

# Setup and defaults
sketchybar --bar height=46 position=top color=0x33000000 blur_radius=20
sketchybar --default label.font="SF Pro Display:Regular:16.0" label.color=0xffffffff label.padding_left=10
sketchybar --default icon.font="SF Pro Display:Regular:16.0" icon.color=0xffffffff

# Mission Control Space indicators
for i in 1 2 3 4 5 6 7 8 9; do sketchybar \
  --add space space.$i left \
  --set space.$i associated_space=$i \
    background.color=0x44ffffff \
    background.corner_radius=5 \
    background.drawing=off \
    background.height=30 \
    icon.drawing=on \
    icon.font.size=18 \
    icon.padding_left=6 \
    icon.padding_right=9 \
    icon.y_offset=1 \
    icon="${spaceicons[$i]:=􀏃}" \
    label.drawing=off \
    label.padding_left=-1 \
    label.padding_right=10 \
    label="$i" \
    script=space.sh \
    click_script="SID=$i space-click.sh"
done

# Group for space indicators
sketchybar \
  --add bracket space_indicators "/space\..*/" \
  --set space_indicators \
    background.color=0x22ffffff \
    background.corner_radius=5 \
    background.height=30 \
    background.drawing=on

# Add some custom events to trigger updates
sketchybar \
  --add event yabai_layout_change \
  --add event yabai_focus_change \
  --add event yabai_title_change \
  --add event yabai_window_resized

# Spacer
sketchybar \
  --add item spacer left \
  # --set spacer background.padding_left=5

# Yabai layout selectors
declare -A layout_icons=( ["stack"]="􀯰 " ["float"]="􀇴 " ["bsp"]="􀏝 " )
for layout in "${!layout_icons[@]}"; do sketchybar \
  --add item "yabai_layout_$layout" left \
  --set "yabai_layout_$layout" \
    background.color=0x44ffffff \
    background.corner_radius=5 \
    background.drawing=off \
    background.height=30 \
    icon="${layout_icons[$layout]}" \
    icon.font.size=18 \
    icon.padding_left=6 \
    icon.padding_right=9 \
    icon.y_offset=1 \
    label="$layout" \
    label.drawing=off \
    label.padding_left=-1 \
    label.padding_right=10 \
    script=yabai-layout.sh \
    update_freq=3 \
    click_script="CLICKED=$layout yabai-layout-click.sh" \
  --subscribe yabai_layout
done

# Group for layout selectors
sketchybar \
  --add bracket yabai_layout_selectors "/yabai_layout_.*/" \
  --set yabai_layout_selectors \
    background.color=0x22ffffff \
    background.corner_radius=5 \
    background.height=30 \
    background.drawing=on

# Name of active application:
sketchybar \
  --add item yabai_app_name center \
  --set yabai_app_name \
    label.font.style=bold \
    label.padding_left=8 \
    script=yabai-app-name.sh \
  --subscribe yabai_app_name \
    yabai_focus_change

# Name of active window title:
sketchybar \
  --add item yabai_window_title center \
  --set yabai_window_title \
    label.padding_left=5 \
    script=yabai-window-title.sh \
  --subscribe yabai_window_title \
    yabai_focus_change \
    yabai_title_change

# Calendar events
sketchybar \
  --add item calendar right \
  --set calendar \
    background.color=0xfff4584f \
    background.corner_radius=5 \
    background.drawing=off \
    background.height=30 \
    background.padding_left=10 \
    click_script="calendarUIDs=${calendarUIDs} calendar-click.sh" \
    icon.padding_left=10 \
    icon=􀉉 \
    label.padding_right=10 \
    script="calendarUIDs=${calendarUIDs} calendar.sh" \
    update_freq=60 \
  --subscribe calendar \
    system_woke

# Slack indicator
sketchybar \
  --add item slack right \
  --set slack \
    background.color=0xff4a154b \
    background.corner_radius=5 \
    background.height=30 \
    background.padding_left=8 \
    click_script="open -a Slack" \
    icon.color=0xe6ffffff \
    icon.drawing=off \
    icon.padding_left=8 \
    icon.padding_right=8 \
    icon=􁋬 \
    label.drawing=off \
    label.padding_left=0 \
    label.padding_right=8 \
    script=slack.sh \
    update_freq=10

# Mail indicator
sketchybar \
  --add item mail right \
  --set mail \
    background.color=0xff1d9ff7 \
    background.corner_radius=5 \
    background.height=30 \
    background.padding_left=8 \
    click_script="open -a Mail" \
    icon.color=0xe6ffffff \
    icon.drawing=off \
    icon.padding_left=8 \
    icon.padding_right=8 \
    icon=􀍛 \
    label.drawing=off \
    label.padding_left=0 \
    label.padding_right=8 \
    script=mail.sh \
    update_freq=10 \

# Finally, update the bar to render the above
sketchybar --update
