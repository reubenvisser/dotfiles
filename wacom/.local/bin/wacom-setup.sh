#!/bin/bash
# Wacom Intuos S persistent configuration
# Place in ~/dotfiles/scripts/wacom-setup.sh

CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/wacom/wacom.conf"

if [ ! -f "$CONFIG" ]; then
    echo "Error: Config not found at $CONFIG"
    echo "Create it with your monitor and device names."
    exit 1
fi

source "$CONFIG"

STYLUS="Wacom Intuos S Pen stylus"
PAD="Wacom Intuos S Pad pad"

# Resolve monitor name to geometry string for xsetwacom compatibility
resolve_output() {
    local name="$1"
    local geom
    geom=$(xrandr | grep "^${name} connected" | grep -oP '\d+x\d+\+\d+\+\d+')
    if [ -n "$geom" ]; then
        echo "$geom"
    else
        echo "$name"
    fi
}

init() {
    # Wait for device to be ready
    sleep 1
    xsetwacom set "$STYLUS" MapToOutput "$(resolve_output "${MONITORS[$DEFAULT]}")"
    xsetwacom set "$STYLUS" Threshold 550

    xsetwacom set "$PAD" Button 1 "key super F1"
    xsetwacom set "$PAD" Button 2 "key super F2"
    xsetwacom set "$PAD" Button 3 "key super F3"
    xsetwacom set "$PAD" Button 8 "key super F4"
}

swap_to() {
    xsetwacom set "$STYLUS" MapToOutput "$(resolve_output "${MONITORS[$1]}")"
}


case "$1" in
    init) init ;;
    swap_to) swap_to "$2";;
esac
