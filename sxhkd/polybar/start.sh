#!/bin/bash

pkill -x polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar wsbar -c ~/.config/polybar/config.ini &
polybar monitorbar -c ~/.config/polybar/config.ini &
polybar timebar -c ~/.config/polybar/config.ini &
polybar controlbar -c ~/.config/polybar/config.ini &
polybar controlbar2 -c ~/.config/polybar/config.ini &
