#!/bin/sh

echo "Set alt shift as a way of switching between keyboard layouts"

setxkbmap -layout us,ro -option grp:alt_shift_toggle

${HOME}/.config/scripts/toggle-transparency.sh &
${HOME}/.config/suckless/dwmblocks/dwmblocks &
${HOME}/.screenlayout/layout-ct.sh

udiskie &
flameshot& 
xrdb -load ~/.Xresources

nitrogen --restore
xset s off
xset -dpms
xset s noblank

# Turn CapsLock off
setxkbmap -option ctrl:nocaps &

echo "Finished running autostart"

