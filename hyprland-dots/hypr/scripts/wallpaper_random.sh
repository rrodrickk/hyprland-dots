#!/bin/bash
wallpaper=$(find ~/Pictures/Wallpapers -type f | shuf -n 1)
hyprctl hyprpaper reload ,"$wallpaper"
