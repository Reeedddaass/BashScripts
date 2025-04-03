#!/bin/bash

declare -A config_paths=(
    [i3]="$HOME/.config/i3/config"
    [polybar]="$HOME/.config/polybar/config.ini"
    [picom]="$HOME/.config/picom.conf"
    [kitty]="$HOME/.config/kitty/kitty.conf"
    [neofetch]="$HOME/.config/neofetch/config.conf"
)

choice=$(printf "%s\n" "${!config_paths[@]}" | dmenu -p "config:")

[ -z "$choice" ] && exit 1

kitty -e vim "${config_paths[$choice]}"