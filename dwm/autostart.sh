#!/bin/sh

echo "Set alt shift as a way of switching between keyboard layouts"

setxkbmap -layout us,ro -option grp:alt_shift_toggle

${HOME}/.config/scripts/toggle-transparency.sh &
${HOME}/.config/suckless/dwmblocks/dwmblocks &

echo "Finished running autostart"

