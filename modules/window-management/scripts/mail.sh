#!/bin/sh

unreadCount=$(osascript -e 'tell application "Mail" to return the unread count of inbox')
  
[ "$unreadCount" -gt 0 ] && icon=on

sketchybar --set mail icon.drawing="${icon:=off}"
