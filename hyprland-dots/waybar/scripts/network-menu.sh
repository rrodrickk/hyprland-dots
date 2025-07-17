#!/bin/bash
case $1 in
    "wifi") nm-connection-editor;;
    "bluetooth") blueman-manager;;
    *) rofi -show network -modi "network:~/.config/waybar/scripts/network-menu.sh";;
esac