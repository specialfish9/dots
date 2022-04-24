#!/bin/bash

pkill -x polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar wsbar -c ~/.config/polybar/config.ini &
    MONITOR=$m polybar monitorbar -c ~/.config/polybar/config.ini &
    MONITOR=$m polybar timebar -c ~/.config/polybar/config.ini &
    MONITOR=$m polybar controlbar -c ~/.config/polybar/config.ini &
    MONITOR=$m polybar controlbar2 -c ~/.config/polybar/config.ini &
  done
else
    polybar wsbar -c ~/.config/polybar/config.ini &
    polybar monitorbar -c ~/.config/polybar/config.ini &
    polybar timebar -c ~/.config/polybar/config.ini &
    polybar controlbar -c ~/.config/polybar/config.ini &
    polybar controlbar2 -c ~/.config/polybar/config.ini &
fi
