#!/bin/sh

BLUETOOTH_HEADPHONES_MACADDR="38:18:4C:D1:7F:7E"
CONNECTED=$(bluetoothctl -- info $BLUETOOTH_HEADPHONES_MACADDR | grep Connected)

CONNECTED="$(echo $CONNECTED | tr -d '\t')"

if  [ -z "$CONNECTED" ] || [ "$CONNECTED" = "Connected: no" ]; then
    echo ""
else
    echo ""
fi

