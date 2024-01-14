#!/usr/bin/env bash

function volume_up() {
	pactl set-sink-volume "$1" +2%
}
function volume_down() {
	pactl set-sink-volume "$1" -2%
}
function volume_mute() {
	pactl set-sink-mute "$1" toggle
}

CURRENT_SINK=$(pactl list short sinks | grep RUNNING | awk '{print $1}')

if [ -z "$CURRENT_SINK" ]; then
	exit 1
fi

case "$1" in
--up) volume_up "$CURRENT_SINK" ;;
--down) volume_down "$CURRENT_SINK" ;;
--mute) volume_mute "$CURRENT_SINK" ;;
esac