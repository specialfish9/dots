#!/usr/bin/env bash

op=$( echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | wofi -i --dmenu -c $HOME/.config/wofi/powermenu_config -s $HOME/.config/wofi/powermenu.css | awk '{print tolower($2)}' )

case $op in 
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                systemctl $op
                ;;
        lock)
                systemctl --user start lock
                ;;
        logout)
                killall Hyprland
                ;;
esac
