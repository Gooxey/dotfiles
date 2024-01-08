#!/bin/bash

sleep="󰐥 Suspend"
reboot=" Reboot"
shutdown="󰤄 Poweroff"

selected_option=$(echo "$sleep
$reboot
$shutdown" | rofi \
	-dmenu \
	-i \
	-p "Powermenu" \
	-theme "~/.config/rofi/theme/powermenu.rasi"
)

case $selected_option in
$shutdown) shutdown now ;;
$reboot) reboot ;;
$sleep) systemctl suspend ;;
esac