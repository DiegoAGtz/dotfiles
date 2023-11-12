#!/bin/sh

# Brightness
brightnessctl -r &
blueman-applet &

# Polkit
# lxqt-policykit-agent &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Compositor
picom &

# Systray
cbatticon -i notification &
volumeicon &
nm-applet &
udiskie -t &
megasync &

# Wallpaper
feh --bg-scale -z ~/Pictures/wallpapers/ &

# emacs daemon
emacs --daemon &
