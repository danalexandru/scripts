#!/bin/bash

if ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` > /dev/null; then
    # DEVICE_NAME="$(iw dev | grep ssid | awk '{print $2}')"
    DEVICE_NAME="$(nmcli -t -f active,ssid dev wifi | grep -E '^yes' | cut -d\' -f2)"
    DEVICE_NAME="${DEVICE_NAME#yes:}"
    echo "直 $DEVICE_NAME"
else
    echo "睊 No Connection"
fi

# DEVICE_NAME="$(iw dev | grep ssid | awk '{print $2}')"
#
# DEVICE_NAME="${$(nmcli -t -f active,ssid dev wifi | grep -E '^yes' | cut -d\' -f2)#yes:}"
#
# DEVICE_NAME="$(nmcli -t -f active,ssid dev wifi | grep -E '^yes' | cut -d\' -f2)"
# DEVICE_NAME="${DEVICE_NAME#yes:}"
