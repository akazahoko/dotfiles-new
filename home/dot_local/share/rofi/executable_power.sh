#!/usr/bin/env bash

if [ -n "$1" ]; then
    case "$1" in
        suspend)systemctl suspend;;
        shutdown)systemctl poweroff;;
        reboot)systemctl reboot;;
        logout)systemctl logout;;
    esac
    exit 0
fi

echo "suspend"
echo "shutdown"
echo "reboot"
echo "logout"
