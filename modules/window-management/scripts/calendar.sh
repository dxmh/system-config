#!/bin/bash

# Set some defaults
background=off
color=0xffffffff
font=regular

# Get the next event in the format "12:34 My Event"
nextEvent=$(
  icalBuddy \
    --bullet "" \
    --excludeAllDayEvents \
    --excludeEndDates \
    --includeCals "${calendarUIDs}" \
    --includeEventProps "datetime,title" \
    --includeOnlyEventsFromNowOn \
    --limitItems 1 \
    --noCalendarNames \
    --noPropNames \
    --propertyOrder "datetime,title" \
    --propertySeparators "| |" \
    --timeFormat "%H:%M" \
    eventsToday
)

inHours() {
  # Output the time in hours, using half-up rounding
  echo "$(( ( $1 + 60 / 2 ) / 60 ))"
}

if [ ! "$nextEvent" ]; then
  result="No upcoming events"
else

  startTime=$(cut -f1 -d' ' <<< "$nextEvent")
  eventTitle="${nextEvent/$startTime /}"

  epochStartTime=$(date +%s -d "$startTime")
  epochNow=$(date +%s)
  relativeStartTimeInMinutes=$(( ( epochStartTime - epochNow ) / 60 ))

  # Output the time in hours
  if [ $relativeStartTimeInMinutes -ge 60 ]; then
    result="$eventTitle in $(inHours $relativeStartTimeInMinutes)h"

  # Output the time in the past tense
  elif [ $relativeStartTimeInMinutes -lt 0 ]; then 

    # Remove the minus sign
    relativeStartTimeInMinutes=${relativeStartTimeInMinutes/-/}

    if [ $relativeStartTimeInMinutes -gt 60 ]; then
      result="$eventTitle started $(inHours $relativeStartTimeInMinutes)h ago"
    else
      result="$eventTitle started $relativeStartTimeInMinutes minutes ago"
    fi

  # Catch this edge case...
  elif [ $relativeStartTimeInMinutes -eq 0 ]; then 
    result="$eventTitle starts now"

  # Output the results in minutes
  else
    result="$eventTitle in $relativeStartTimeInMinutes minutes"

  fi

  # Emphasise nearing events
  if [ $relativeStartTimeInMinutes -le 10 ] && [ $relativeStartTimeInMinutes -gt -2 ]; then
    background=on
    color=0xe6ffffff
    font=semibold
  fi

fi

sketchybar --set calendar \
  background.drawing=$background \
  label="$result" \
  label.color=$color \
  label.font.style=$font \
  icon.color=$color
