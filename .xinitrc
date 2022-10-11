#!/bin/sh

# Programs to run
udiskie &
flameshot& 
numlockx &

# Other
#~/.config/scripts/multimonitor_layout.sh
#~/.config/scripts/multimonitor_layout2.sh
~/.config/scripts/multimonitor_layout3.sh

xrdb -load ~/.Xresources
nitrogen --restore

# dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

xset s off
xset -dpms
xset s noblank

# Turn CapsLock off
setxkbmap -option ctrl:nocaps &

# Turn CapsLock back on
# setxkbmap -option (to turn back on)

exec dwm

