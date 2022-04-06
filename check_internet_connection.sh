#!/bin/sh

if ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` > /dev/null; then
    DEVICE_NAME="$(iw dev | grep ssid | awk '{print $2}')"
    echo "直 $DEVICE_NAME"
else
    echo "睊 No Connection"
fi

