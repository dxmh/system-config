#!/bin/sh

popup_status=$(sketchybar --query calendar | jq -r .popup.drawing)
prefix=popup_events

if [ "$popup_status" != "on" ]; then

  # Start with a blank popup:
  sketchybar --remove "/^$prefix/"

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
    sketchybar --set "$prefix$i" label="$line"
  done

fi

sketchybar --set calendar \
    popup.align=right \
    popup.background.color=0xbf000000 \
    popup.background.border_width=0 \
    popup.background.corner_radius=0 \
    popup.drawing=toggle \
    popup.height=25 \
    popup.horizontal=off \
    popup.blur_radius=15 \
    popup.y_offset=0
