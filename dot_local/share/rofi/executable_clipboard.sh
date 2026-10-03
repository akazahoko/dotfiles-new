#!/usr/bin/env zsh

if [[ -n "$1" ]]; then
    cliphist decode "$1" | wl-copy 
    exit 0
fi

cliphist list
