#!/bin/bash

choice1=$(echo -e "Shutdown\nReboot\nSleep\nWindows" | dmenu -p "Uptime: $(uptime -p)")
choice2=$(echo -e "no\nyes" | dmenu -p "$choice1 ???")
[ -z "$choice1" ] || [ -z "$choice2" ] && exit

if [ "$choice1" = "Shutdown" ] && [ "$choice2" = "yes" ]; then systemctl poweroff; fi
if [ "$choice1" = "Reboot" ] && [ "$choice2" = "yes" ]; then systemctl reboot; fi
if [ "$choice1" = "Sleep" ] && [ "$choice2" = "yes" ]; then systemctl suspend; fi
if [ "$choice1" = "Windows" ] && [ "$choice2" = "yes" ]; then sudo ~/Scripts/bootToWindows.sh; fi
