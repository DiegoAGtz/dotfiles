#!/bin/bash
function run {
  if ! pgrep -x $(basename $1 | head -c 15) 1>/dev/null;
  then
    $@&
  fi
}

run autorandr --change &
run nm-applet &
run nitrogen --restore &
run picom &
# run blueberry-tray & # bluetooth
run udiskie -t &
run volumeicon &
run /bin/lxqt-policykit-agent &
run emacs --daemon &
