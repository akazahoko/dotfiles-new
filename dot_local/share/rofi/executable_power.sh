#!/usr/bin/env bash

if [ -n "$1" ]; then
    case "$1" in
        suspend)systemctl suspend;;
        shutdown)systemctl poweroff;;
        reboot)systemctl reboot;;
        logout)systemctl logout;;
        sunset)
            if pgrep -x "wlsunset" >/dev/null; then
                pkill -f wlsunset
            else
                wlsunset -t 4000 &> /dev/null &
            fi;;
    esac
    exit 0
fi

echo -e "suspend"
echo -e "shutdown"
echo -e "reboot"
echo -e "logout"
echo -e "sunset"

