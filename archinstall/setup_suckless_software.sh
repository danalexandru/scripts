#/!bin/sh
#
# This script will be used in order to recompile the suckless software installed on the system, in case of a OS reinstall

# Specify the user (this script will be run as root => you need the absolute path to the suckless locations
HOMEDIR="/home/aldan"


echo "Set up dwm"
cd ${HOMEDIR}/.config/suckless/dwm
make clean install


echo "Set up st"
cd ${HOMEDIR}/.config/suckless/st
make clean install


echo "Set up tabbed"
cd ${HOMEDIR}/.config/suckless/tabbed
make clean install


echo "Set up dmenu"
cd ${HOMEDIR}/.config/suckless/dmenu
make clean install


echo "Set up dwmblocks"
cd ${HOMEDIR}/.config/suckless/dwmblocks
make clean install


echo "Set up slock"
cd ${HOMEDIR}/.config/suckless/slock
make clean install

