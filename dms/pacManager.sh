#!/bin/bash

choice1=$(echo -e "Update\nInstall\nRemove\nSearch" | dmenu -i)
choice2=$(echo -e "pacman\nyay" | dmenu -i)

if [ "$choice1" = "Search" ] && [ "$choice2" = "pacman" ]; then
	sudo pacman -Ss $(pacman -Sl | awk '{print $2}' | dmenu -i)
fi

if [ "$choice1" = "Search" ] && [ "$choice2" = "yay" ]; then
       	yay -Ss $(yay -Ss "" | grep -E '^(aur|core|extra|community)' | awk '{print $1}' | awk -F/ '{print $2}' | sort -u | dmenu -i)
fi


if [ "$choice1" = "Install" ] && [ "$choice2" = "pacman" ]; then
       	sudo pacman -S $(pacman -Sl | awk '{print $2}' | dmenu -i)
fi

if [ "$choice1" = "Install" ] && [ "$choice2" = "yay" ]; then
	yay -S $(yay -Ss "" | grep -E '^(aur|core|extra|community)' | awk '{print $1}' | awk -F/ '{print $2}' | sort -u | dmenu -i)
fi


if [ "$choice1" = "Remove" ] && [ "$choice2" = "pacman" ]; then
       	sudo pacman -Rns $(pacman -Q | awk '{print $1}' | dmenu -i)
fi

if [ "$choice1" = "Remove" ] && [ "$choice2" = "yay" ]; then
       	yay -Rns $(yay -Q | awk '{print $1}' | dmenu -i)
fi


if [ "$choice1" = "Update" ] && [ "$choice2" = "pacman" ]; then
       	sudo pacman -Syu
fi

if [ "$choice1" = "Update" ] && [ "$choice2" = "yay" ]; then
       	yay -Syu
fi
