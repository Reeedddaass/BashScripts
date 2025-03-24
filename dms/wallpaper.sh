#!/bin/bash

choice=$(echo -e "display WP\nset WP" | dmenu)

cd ~/Pictures/wp/
if [ "$choice" = "display WP" ]; then
    feh $(ls ~/Pictures/wp/ | dmenu -p "display:") && ~/Scripts/dms/wallpaper.sh
elif [ "$choice" = "set WP" ]; then
    feh --bg-scale $(ls ~/Pictures/wp/ | dmenu -p "set:")
fi
