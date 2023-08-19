#!/bin/bash

# We can't switch spaces with yabai, so instead we put something
# together based on the solution at https://superuser.com/a/1200775

declare -A keycodes=( [1]=18 [2]=19 [3]=20 [4]=21 [5]=23 [6]=22 [7]=26 [8]=28 [9]=25 )

osascript -e "tell application \"System Events\" to key code ${keycodes[$SID]} using control down"
