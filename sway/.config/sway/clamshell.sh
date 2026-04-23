#!/bin/sh
# Sync laptop output with lid state. Called from sway's `exec_always` so that
# on a config reload we re-apply the current lid state (sway otherwise resets
# all outputs to enabled, which breaks clamshell mode).

LAPTOP_OUTPUT="eDP-1"
LID_STATE_FILE="/proc/acpi/button/lid/LID/state"

read -r LS < "$LID_STATE_FILE"

case "$LS" in
    *open)   swaymsg output "$LAPTOP_OUTPUT" enable ;;
    *closed) swaymsg output "$LAPTOP_OUTPUT" disable ;;
    *)       echo "Could not get lid state: $LS" >&2 ; exit 1 ;;
esac
