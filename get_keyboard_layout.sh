#!/bin/sh

function sway_fn() {
    LAYOUT=$(swaymsg -t get_inputs | jq -r 'first(.[] | select(.type == "keyboard") | .xkb_active_layout_name)')
    if [ "$LAYOUT" = "English (US)" ]; then
        echo "en"
    elif [ "$LAYOUT" = "Romanian" ]; then
        echo "ro"
    else 
        echo "??"
    fi
}

function xorg_fn() {
    # Current layout
    LAYOUT=$(xkblayout-state print "%n")
    
    if [ "$LAYOUT" = "English" ]; then
        echo "en"
    elif [ "$LAYOUT" = "Romanian" ]; then
        echo "ro"
    else 
        echo "??"
    fi
}

case "${1}" in 
 --xorg) xorg_fn;;
 --sway) sway_fn;;
 *) echo "Unknown case ${1}";;
esac
