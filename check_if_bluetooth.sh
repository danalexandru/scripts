#!/bin/sh

# BLUETOOTH_HEADPHONES_MACADDR="38:18:4C:D1:7F:7E"
BLUETOOTH_HEADPHONES_MACADDR="90:7A:58:EC:C9:54"
CONNECTED=$(bluetoothctl -- info $BLUETOOTH_HEADPHONES_MACADDR | grep Connected)
NAME=$(bluetoothctl -- info $BLUETOOTH_HEADPHONES_MACADDR | grep Name)

CONNECTED="$(echo $CONNECTED | tr -d '\t')"
NAME="$(echo ${NAME/Name: /} | tr -d '\t')"

if  [ -z "$CONNECTED" ] || [ "$CONNECTED" = "Connected: no" ]; then
    echo "󰂲 Disconnected"
else
    echo "󰂱 ${NAME}"
fi

