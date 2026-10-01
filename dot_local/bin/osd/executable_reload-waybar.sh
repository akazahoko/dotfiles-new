#!/usr/bin/env zsh

source "${0:A:h}/helper.sh"

function reload_waybar() {
    pkill waybar
    waybar > /dev/null 2>&1 &
    disown
    TITLE=Waybar
}

reload_waybar
sleep 0.1
notify_std "reload" "" $TITLE "RELOADED!" 