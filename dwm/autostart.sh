#!/bin/sh

echo "Set alt shift as a way of switching between keyboard layouts"

setxkbmap -layout us,ro -option grp:alt_shift_toggle

/home/aldan/.config/suckless/dwmblocks/dwmblocks
echo "Finished running autostart"

