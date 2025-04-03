#!/bin/bash

choice1=$(echo -e "Update\nInstall\nRemove\nSearch\nInfo" | dmenu -i -p "Action:")
[ -z "$choice1" ] && exit

if [[ "$choice1" != "Info" ]]; then
    choice2=$(echo -e "pacman\nyay" | dmenu -i -p "Package manager:")
    [ -z "$choice2" ] && exit
fi

select_package() {
    echo "$1" | dmenu -i -l 20 -p "Select package:"
}

extract_pkgname() {
    echo "$1" | cut -d' ' -f1
}

# INFO
if [ "$choice1" = "Info" ]; then
    info=$(yay -Ps | awk '/^==> Total installed packages:/ {show=1} /^ -> Flagged Out Of Date AUR Packages:/ {show=0} show {print}')
    echo "$info" | dmenu -l 22 -p "System Stats"
    exit
fi

# SEARCH
if [ "$choice1" = "Search" ]; then
    search_term=$(echo "" | dmenu -p "Search for:")
    [ -z "$search_term" ] && exit

    if [ "$choice2" = "pacman" ]; then
        results=$(pacman -Ss "$search_term")
        [ -z "$results" ] && notify-send "No results" "Nothing found for '$search_term'" && exit
        pkg=$(echo "$results" |
            awk -F/ '/^core\/|^extra\/|^community\// {gsub(/  +/, " "); print $2}' |
            awk '{print $1 " - " substr($0, index($0,$2))}' |
            sort -u |
            dmenu -i -l 20 -p "Search result:")
        [ -z "$pkg" ] && exit
        pacman -Ss "$(extract_pkgname "$pkg")"
    elif [ "$choice2" = "yay" ]; then
        results=$(yay -Ss "$search_term")
        [ -z "$results" ] && notify-send "No results" "Nothing found for '$search_term'" && exit
        pkg=$(echo "$results" |
            awk -F/ '/^aur\/|^core\/|^extra\/|^community\// {gsub(/  +/, " "); print $2}' |
            awk '{print $1 " - " substr($0, index($0,$2))}' |
            sort -u |
            dmenu -i -l 20 -p "Search result:")
        [ -z "$pkg" ] && exit
        yay -Ss "$(extract_pkgname "$pkg")"
    fi
fi

# INSTALL 
if [ "$choice1" = "Install" ]; then
    if [ "$choice2" = "pacman" ]; then
        pkg=$(pacman -Sl | awk '{print $2}' | sort -u | dmenu -i -l 20 -p "Install package:")
        [ -z "$pkg" ] && exit
        sudo pacman -S "$pkg"
    elif [ "$choice2" = "yay" ]; then
        search_term=$(echo "" | dmenu -p "Search AUR for:")
        [ -z "$search_term" ] && exit

        results=$(yay -Ss "$search_term")
        [ -z "$results" ] && notify-send "No results" "Nothing found for '$search_term'" && exit

        pkg=$(echo "$results" |
            awk -F/ '/^aur\/|^extra\/|^core\/|^community\// {gsub(/  +/, " "); print $2}' |
            awk '{print $1 " - " substr($0, index($0,$2))}' |
            sort -u |
            dmenu -i -l 20 -p "Install package:")
        [ -z "$pkg" ] && exit
        yay -S "$(extract_pkgname "$pkg")"
    fi
fi

# REMOVE
if [ "$choice1" = "Remove" ]; then
    if [ "$choice2" = "pacman" ]; then
        pkg=$(pacman -Q | awk '{print $1}' | sort | dmenu -i -l 20 -p "Remove package:")
        [ -z "$pkg" ] && exit
        sudo pacman -Rns "$pkg"
    elif [ "$choice2" = "yay" ]; then
        pkg=$(yay -Q | awk '{print $1}' | sort | dmenu -i -l 20 -p "Remove package:")
        [ -z "$pkg" ] && exit
        yay -Rns "$pkg"
    fi
fi

# UPDATE
if [ "$choice1" = "Update" ]; then
    if [ "$choice2" = "pacman" ]; then
        sudo pacman -Syu
    elif [ "$choice2" = "yay" ]; then
        yay -Syu
    fi
fi