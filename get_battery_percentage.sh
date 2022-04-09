#!/bin/sh

BATTERY_PERCENTAGE="$(upower -i $(upower -e | grep 'BAT') | grep -E percentage)"
BATTERY_PERCENTAGE="${BATTERY_PERCENTAGE##* }"
BATTERY_PERCENTAGE="${BATTERY_PERCENTAGE%%%}"
BATTERY_IS_PLUGGED_ICON=""
BATTERY_ICON=""

BATTERY_STATUS="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state: | cut -d ':' -f 2 | xargs)"
if [[ "$BATTERY_STATUS" == "charging" || "$BATTERY_STATUS" == "fully-charged" ]]; then
    BATTERY_IS_PLUGGED_ICON="ﮣ"
elif [ "$BATTERY_STATUS" == "discharging" ]; then
    BATTERY_IS_PLUGGED_ICON="ﮤ"
else
    echo " Unknown status \"$BATTERY_STATUS\"."
    exit 1
fi

if [ "$BATTERY_PERCENTAGE" -gt 90 -a "$BATTERY_PERCENTAGE" -le 100 ]; then
    BATTERY_ICON=""
 elif [ "$BATTERY_PERCENTAGE" -gt 75 -a "$BATTERY_PERCENTAGE" -le 90 ]; then
     BATTERY_ICON=""
 elif [ "$BATTERY_PERCENTAGE" -gt 50 -a "$BATTERY_PERCENTAGE" -le 75 ]; then
     BATTERY_ICON=""
 elif [ "$BATTERY_PERCENTAGE" -gt 25 -a "$BATTERY_PERCENTAGE" -le 50 ]; then
     BATTERY_ICON=""
else
    BATTERY_ICON=""
fi

echo "$BATTERY_IS_PLUGGED_ICON $BATTERY_ICON $BATTERY_PERCENTAGE%"

