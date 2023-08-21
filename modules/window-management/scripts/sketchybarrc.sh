#!/bin/bash

# Setup and defaults
sketchybar --bar height=45 position=top color=0x15000000
sketchybar --default label.font="SF Compact Display:Medium:14.0" label.color=0xcc000000 label.padding_left=10
sketchybar --default icon.font="SF Compact Display:Medium:14.0" icon.color=0xcc000000

# Mission Control Space indicators
for i in 1 2 3 4 5 6 7 8 9; do sketchybar \
  --add space space.$i left \
  --set space.$i associated_space=$i \
    background.color=0x44ffffff \
    background.corner_radius=5 \
    background.drawing=off \
    background.height=30 \
    icon.drawing=on \
    icon.padding_left=8 \
    icon.padding_right=8 \
    icon="${spaceicons[$i]:=􀏃}" \
    label.drawing=on \
    label.padding_left=0 \
    label.padding_right=10 \
    label="$i" \
    script=space.sh \
    click_script="SID=$i space-click.sh"
done

# Add some custom events to trigger updates
sketchybar \
  --add event yabai_layout_change \
  --add event yabai_focus_change \
  --add event yabai_title_change \
  --add event yabai_window_resized

# Yabai layout information
sketchybar \
  --add item yabai_layout left \
  --set yabai_layout \
    click_script=yabai-layout-click.sh \
    icon.padding_left=20 \
    icon.padding_right=2 \
    icon=􀏝  \
    label.drawing=off \
    label.padding_left=5 \
    script=yabai-layout.sh \
    update_freq=3 \
  --subscribe yabai_layout \
    space_change \
    display_change \
    yabai_layout_change \
    yabai_window_resized \
    yabai_focus_change

# Name of active application:
sketchybar \
  --add item yabai_app_name left \
  --set yabai_app_name \
    label.font.style=bold \
    label.padding_left=8 \
    script=yabai-app-name.sh \
  --subscribe yabai_app_name \
    yabai_focus_change

# Name of active window title:
sketchybar \
  --add item yabai_window_title left \
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
    click_script="open -a Calendar" \
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
    click_script="open -a Slack" \
    icon.color=0xe6ffffff \
    icon.drawing=off \
    icon.padding_left=5 \
    icon.padding_right=5 \
    icon=􁋬 \
    label.drawing=off \
    script=slack.sh \
    update_freq=10

# Mail indicator
sketchybar \
  --add item mail right \
  --set mail \
    background.color=0xff1d9ff7 \
    background.corner_radius=5 \
    background.height=30 \
    click_script="open -a Mail" \
    icon.color=0xe6ffffff \
    icon.drawing=off \
    icon.padding_left=5 \
    icon.padding_right=5 \
    icon=􀍛 \
    label.drawing=off \
    script=mail.sh \
    update_freq=10 \

# Finally, update the bar to render the above
sketchybar --update
