#!/bin/bash

LOW_BATTERY_THRESHOLD=10
CRITICAL_BATTERY_THRESHOLD=5

while true; do
    BATTERY_PATH=$(ls /sys/class/power_supply/ | grep -i BAT | head -1)
    BATTERY_STATUS=$(cat /sys/class/power_supply/$BATTERY_PATH/status)
    BATTERY_CAPACITY=$(cat /sys/class/power_supply/$BATTERY_PATH/capacity)

    if [[ "$BATTERY_STATUS" == "Discharging" ]]; then
        if [[ $BATTERY_CAPACITY -le $CRITICAL_BATTERY_THRESHOLD ]]; then
            notify-send -u critical -c battery "CRITICAL BATTERY" "Battery at ${BATTERY_CAPACITY}% - System will suspend soon!" -i battery-empty
            sleep 30  # Prevent spamming
        elif [[ $BATTERY_CAPACITY -le $LOW_BATTERY_THRESHOLD ]]; then
            notify-send -u high -c battery "LOW BATTERY" "Battery at ${BATTERY_CAPACITY}% - Please connect charger!" -i battery-low
            sleep 60  # Check again after 1 minute
        fi
    fi
    sleep 10  # Main loop sleep
done
