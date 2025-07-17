#!/bin/bash
WALLPAPER=$(find "$HOME/Pictures/Wallpapers" -type f | wofi --dmenu -p "Select Wallpaper")

if [[ -n "$WALLPAPER" ]]; then
    # Convert to absolute path
    WALLPAPER=$(realpath "$WALLPAPER")
    
    # Ensure hyprpaper is running
    pgrep hyprpaper || hyprpaper &
    
    # Load and apply with retry
    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "$WALLPAPER"
    sleep 0.2  # Critical pause
    
    # Set for all monitors
    for monitor in $(hyprctl monitors | grep -oP 'Monitor \K[^ ]+'); do
        hyprctl hyprpaper wallpaper "$monitor,$WALLPAPER"
    done
    
    # Update config
    sed -i "s|^preload = .*|preload = $WALLPAPER|" ~/.config/hypr/hyprpaper.conf
    sed -i "s|^wallpaper = .*|wallpaper = ,$WALLPAPER|" ~/.config/hypr/hyprpaper.conf
fi
