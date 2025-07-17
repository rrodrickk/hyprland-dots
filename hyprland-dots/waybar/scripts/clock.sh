#!/usr/bin/env bash
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
SELECTED=$(find "$WALLPAPER_DIR" -type f | wofi --dmenu --prompt "Select Wallpaper")

if [[ -n "$SELECTED" ]]; then
    hyprctl hyprpaper reload ,"$SELECTED"
fi
