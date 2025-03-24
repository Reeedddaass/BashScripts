#!/bin/bash

set -e

curDir=$(pwd)

choice1=$(echo -e "Compress\nDecompress" | dmenu)
if [ -z "$choice1" ]; then
    exit 1
fi

choice2=$(ls "$curDir" | dmenu -p "Choose a file or directory:")
if [ -z "$choice2" ]; then 
    exit 1
fi

if [ ! -e "$choice2" ]; then
    exit 1
fi


if [ "$choice1" = "Compress" ]; then
    if [ -d "$choice2" ]; then
        zip -r "$choice2.zip" "$choice2"
        if [ $? -eq 0 ]; then
            echo "Successfully compressed directory $choice2 to $choice2.zip."
        else
            echo "Error compressing directory $choice2."
            exit 1
        fi
    elif [ -f "$choice2" ]; then
        zip "$choice2.zip" "$choice2"
        if [ $? -eq 0 ]; then
            echo "Successfully compressed file $choice2 to $choice2.zip."
        else
            echo "Error compressing file $choice2."
            exit 1
        fi
    else
        echo "Error: Invalid selection."
        exit 1
    fi
fi

if [ "$choice1" = "Decompress" ]; then
    if [[ "$choice2" == *.zip ]]; then  # Check if the selected file is a .zip
        unzip "$choice2"
    else
        echo "Error: The selected file is not a .zip archive."
        exit 1
    fi
fi
