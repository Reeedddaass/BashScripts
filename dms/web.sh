#!/bin/bash

declare -A sites=(
	["YouTube"]="https://youtube.com"
	["DuckDuckGo"]="search"
	["Google"]="search"
	["Google Maps"]="https://maps.google.com"
	["Facebook"]="https://facebook.com"
	["Twitter"]="https://x.com"
	["Arch Wiki"]="https://wiki.archlinux.org"	
	["GitHub"]="https://github.com"
)

site_name=$(printf "%s\n" "${!sites[@]}" | dmenu -p "Choose website:")
[ -z "$site_name" ] && exit

choice=$(echo -e "Librewolf\nFirefox" | dmenu -p "Choose Browser:")
[ -z "$choice" ] && exit

case "$site_name" in
    "YouTube")
        action=$(echo -e "Open Website\nSearch" | dmenu -p "YouTube:")
        [ -z "$action" ] && exit
        if [ "$action" = "Search" ]; then
            query=$(echo "" | dmenu -p "Search YouTube:")
            [ -z "$query" ] && exit
            url="https://www.youtube.com/results?search_query=$query"
        else
            url="https://youtube.com"
        fi
        ;;
    "Google Maps")
        action=$(echo -e "Open Website\nSearch" | dmenu -p "Google Maps:")
        [ -z "$action" ] && exit
        if [ "$action" = "Search Location" ]; then
            query=$(echo "" | dmenu -p "Search Google Maps:")
            [ -z "$query" ] && exit
            url="https://www.google.com/maps/search/url=$query"
        else
            url="https://maps.google.com"
        fi
        ;;
    "Google")
        query=$(echo "" | dmenu -p "Search Google:")
        [ -z "$query" ] && exit
        url="https://www.google.com/search?q=$query"
        ;;
    "DuckDuckGo")
        query=$(echo "" | dmenu -p "Search DuckDuckGo:")
        [ -z "$query" ] && exit
        url="https://duckduckgo.com/?q=$query"
        ;;
    *)
        url="${sites[$site_name]}"
        ;;
esac

if [ "$choice" = "Librewolf" ]; then
    librewolf "$url"
elif [ "$choice" = "Firefox" ]; then
    firefox "$url"
fi
