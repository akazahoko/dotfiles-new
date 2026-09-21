#!/usr/bin/env bash

if [ -n "$1" ];then
    wl-copy "$ROFI_INFO"
    exit 0
fi

NF_FILE="$HOME/.cache/nerdglyphs.json"

if [ ! -f $NF_FILE ];then 
    curl -s https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/glyphnames.json -o $FILE
fi

jq -r 'to_entries[] | select(.key != "METADATA") | "\(.value.char)\t\(.key)\u0000info\u001f\(.value.char)"' "$NF_FILE"
