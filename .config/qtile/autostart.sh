#!/bin/bash
function run {
  if ! pgrep -x $(basename $1 | head -c 15) 1>/dev/null;
  then
    $@&
  fi
}

run kanshi &
run nm-applet &
run blueman-applet &
run udiskie -t --appindicator &
run pasystray &
run /bin/lxqt-policykit-agent &
run emacs --daemon &
run flameshot &
swaybg -i ~/Pictures/wallpapers/0277.jpg -m fill &
