#!/usr/bin/env zsh

DIR=$HOME/Pictures/Wallpapers

if [[ -n $1 ]]; then
    wal -o $XDG_CONFIG_HOME/wal/postrun.sh -i $DIR/$1 &> /dev/null
fi

for img in $DIR/*.{jpg,png}; do
    echo -en "$(basename $img)\0icon\x1f$img\n"
done
