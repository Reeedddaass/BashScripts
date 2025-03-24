#!/bin/bash

map=$(setxkbmap -query | grep -oP "(?<=layout:     ).*")
choice=$(echo -e "us\nlt" | dmenu -p "current keyboard: $map")

[ $choice = "us" ] && setxkbmap -layout us
[ $choice = "lt" ] && setxkbmap -layout lt
