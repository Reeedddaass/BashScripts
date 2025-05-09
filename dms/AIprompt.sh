#!/bin/bash

model=mistral

mkdir -p ~/AI_chats
filename=~/AI_chats/$(date +"%Y-%m-%d_%H-%M-%S").log
history=""

echo "Conversation started: $(date)" >> "$filename"
echo "Model: $model" >> "$filename"
echo -e "------------------------------------\n\n" >> "$filename"

while true; do
	prompt=$(echo "" | dmenu -p "Prompt:")
	[ -z "$prompt" ] && exit;
	
	history="$history\nUser: $prompt"
	echo -e "\tUser: $prompt\n" >> "$filename"

	response=$(echo -e "$history" | ollama run "$model")
	history="$history\nAI: $response"
	echo -e "\tAI: $response\n" >> "$filename"

	echo -e "$response\n\nPRESS ENTER" | fold -s -w 60 | dmenu -l 10 -p "AI:"

	choice=$(echo -e "Yes\nNo" | dmenu -i -p "Continue?")
	[ -z "$choice" ] || [ "$choice" != "Yes" ] && break;
done
