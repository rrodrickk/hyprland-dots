#!/bin/bash
WALLPAPER=$(find ~/Pictures/Wallpapers -type f | wofi --dmenu --prompt "Select Wallpaper")

if [ -n "$WALLPAPER" ]; then
    # Show preview (non-tiling floating window)
    hyprctl keyword windowrule "float,title:^swayimg$"
    hyprctl keyword windowrule "size 50% 60%,title:^swayimg$"
    hyprctl keyword windowrule "center,title:^swayimg$"
    swayimg "$WALLPAPER" &
    
    # Get PID of preview window
    PREVIEW_PID=$!
    
    # Wait for preview to appear
    sleep 0.5
    
    # Confirm dialog
    if zenity --question --text="Use this wallpaper?" --title="Wallpaper Preview"; then
        hyprctl hyprpaper reload ,"$WALLPAPER"
    fi
    
    # Close preview
    kill $PREVIEW_PID
fi