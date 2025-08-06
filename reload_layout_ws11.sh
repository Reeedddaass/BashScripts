#!/bin/bash

i3-msg "exec killall btop"
i3-msg "exec killall cava"
i3-msg "exec killall tty-clock"

i3-msg "workspace 11; append_layout ~/.config/i3/layouts/ws11.json"
nohup kitty sh -c 'printf "\033]0;btop\007"; exec btop' >/dev/null 2>&1 &
nohup kitty sh -c 'printf "\033]0;cava\007"; exec cava' >/dev/null 2>&1 &
nohup kitty sh -c 'printf "\033]0;tty-clock\007"; exec tty-clock -s -c -C 1' >/dev/null 2>&1 &
