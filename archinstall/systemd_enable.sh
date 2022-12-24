#!/bin/sh
#
# Enable all systemd daemons after installing required packages
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable cronie
systemctl enable cronie.service
systemctl enable systemd-timesyncd
