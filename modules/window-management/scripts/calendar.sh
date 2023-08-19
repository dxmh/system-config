#!/bin/bash

# Set some defaults
background=off
color=0xcc000000
font=medium

# Get the next event in the format "12:34 My Event"
next_event=$(
  icalBuddy \
    --bullet "" \
    --excludeAllDayEvents \
    --excludeEndDates \
    --includeOnlyEventsFromNowOn \
    --limitItems 1 \
    --noCalendarNames \
    --noPropNames \
    --propertyOrder "datetime,title" \
    --propertySeparators "| |" \
    --timeFormat "%H:%M" \
    eventsToday
)

if [ ! "$next_event" ]; then
  result="No upcoming events"
else

  event_date=$(cut -f1 -d' ' <<< "$next_event")
  event_title="${next_event/$event_date /}"

  event_date_epoch=$(date +%s -d "$event_date")
  now_epoch=$(date +%s)
  mins_until=$(( ( event_date_epoch - now_epoch ) / 60 ))

  # Output the time in hours, using half-up rounding
  if [ $mins_until -ge 60 ]; then
    time_until="in $(( ( mins_until + 60 / 2 ) / 60 ))h"

  # Output the time in the past tense
  elif [ $mins_until -lt 0 ]; then 

    # Remove the minus sign
    mins_until=${mins_until/-/}

    if [ $mins_until -gt 60 ]; then
      # In hours
      time_until="started $(( ( mins_until + 60 / 2 ) / 60 ))h ago"
    else
      # In minutes
      time_until="started $mins_until minutes ago"
    fi

  # Catch this edge case...
  elif [ $mins_until -eq 0 ]; then 
    time_until="starts now"

  # Output the results in minutes
  else
    time_until="in $mins_until minutes"

  fi

  # Emphasise nearing events
  if [ $mins_until -le 10 ] && [ $mins_until -gt -2 ]; then
    background=on
    color=0xe6ffffff
    font=semibold
  fi

  result="${event_title} ${time_until}"

fi

sketchybar --set calendar \
  background.drawing=$background \
  label="$result" \
  label.color=$color \
  label.font.style=$font \
  icon.color=$color

