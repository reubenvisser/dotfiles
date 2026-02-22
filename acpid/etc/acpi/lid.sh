#!/bin/bash
# Toggle laptop display on lid open/close

export DISPLAY=:0
export XAUTHORITY=/home/rvisser/.Xauthority

case "$1" in
    button/lid)
        case "$3" in
            close) xrandr --output eDP-1 --off ;;
            open)  xrandr --output eDP-1 --auto ;;
        esac
        ;;
esac
