#!/bin/sh

# Brightness
brightnessctl -r &

# Polkit
lxqt-policykit-agent &

# Compositor
picom &

# Systray
cbatticon &
volumeicon &
nm-applet &
udiskie -t &

# Wallpaper
feh --bg-scale -z ~/Pictures/wallpapers/ &

# emacs daemon
emacs --daemon &
