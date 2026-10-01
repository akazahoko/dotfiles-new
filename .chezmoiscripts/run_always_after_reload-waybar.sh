#!/usr/bin/env sh

pkill waybar
sleep 0.1
waybar > /dev/null 2>&1 &