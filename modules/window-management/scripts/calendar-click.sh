#!/bin/sh

popup_status=$(sketchybar --query calendar | jq -r .popup.drawing)
prefix=popup_events

if [ "$popup_status" != "on" ]; then

  # Start with a blank popup:
  sketchybar --remove "/^$prefix/"

  # Emulate some top padding
  # https://github.com/FelixKratz/SketchyBar/issues/330
  sketchybar --add item "${prefix}-padding-top" popup.calendar \
    --set "${prefix}-padding-top" \
      background.color=0x00000000 \
      background.height=15 \
      background.drawing=on \

  # Populate the popup with events from today:
  icalBuddy \
    --bullet "" \
    --excludeAllDayEvents \
    --includeCals "${calendarUIDs}" \
    --includeEventProps "datetime,title" \
    --noCalendarNames \
    --noPropNames \
    --propertyOrder "datetime,title" \
    --propertySeparators "|:\t|" \
    --timeFormat "%H:%M" \
    eventsToday \
  | while read -r line; do
    i=$((i=i+1))
    sketchybar --add item "$prefix$i" popup.calendar
    sketchybar --set "$prefix$i" \
      background.padding_left=10 \
      background.padding_right=20 \
      background.color=0x00000000 \
      background.height=30 \
      background.drawing=on \
      icon.drawing=off \
      label="$line"
  done

  # Emulate some bottom padding
  # https://github.com/FelixKratz/SketchyBar/issues/330
  sketchybar --add item "${prefix}-padding-bottom" popup.calendar \
    --set "${prefix}-padding-bottom" \
      background.color=0x00000000 \
      background.height=15 \
      background.drawing=on

fi

sketchybar --set calendar \
    popup.align=right \
    popup.background.color=0xbf000000 \
    popup.background.border_width=0 \
    popup.background.border_color=0xffffffff \
    popup.background.corner_radius=15 \
    popup.drawing=toggle \
    popup.height=0 \
    popup.horizontal=off \
    popup.blur_radius=15 \
    popup.y_offset=22
