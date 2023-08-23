#!/bin/sh

unreadCount=$(osascript -e 'tell application "Mail" to return the unread count of inbox')
  
if [ "$unreadCount" -gt 0 ]; then 
  icon=on
  label=on
fi 

sketchybar --set mail icon.drawing="${icon:=off}" label.drawing="${label:=off}" label=$unreadCount
