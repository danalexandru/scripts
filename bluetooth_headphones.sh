#!/bin/sh

BLUETOOTH_HEADPHONES_MACADDR="38:18:4C:D1:7F:7E"
CONNECTED=$(bluetoothctl -- info $BLUETOOTH_HEADPHONES_MACADDR | grep Connected)

CONNECTED="$(echo $CONNECTED | tr -d '\t')"

if [ "$CONNECTED" = "Connected: no" ]; then
    pactl loadmodule module-bluetooth-discover
    bluetoothctl -- connect $BLUETOOTH_HEADPHONES_MACADDR
else
    bluetoothctl -- disconnect $BLUETOOTH_HEADPHONES_MACADDR
fi
