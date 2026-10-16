#!/usr/bin/env zsh

SCRIPT="${0:A:h}/$NAME/funcs.sh"
CONTINUE='read -k 1 -q "?Press any key to continue"'
CHAFA='chafa -f sixels -s "${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}"'
BAT='bat --color=always'
ICON_DIR="$HOME/.local/bin/osd/icons"

print_prompt() {
    for i in {1..${#PROMPTS}}; do
        printf '%d:%b\n' "$i" "${PROMPTS[i]}"
    done
}

prompt_user() {
    OPTION=$(print_prompt | show_dmenu)

    if [[ -z $OPTION ]]; then
        exit 0
    fi
}

spawn_terminal() {
    foot -a menu -T $TITLE $SCRIPT $OPTION
}

spawn_direct() {
    $SCRIPT $OPTION
}

notify_std() {
    notify-send -e \
        -a osd \
        -u low \
        -h string:x-canonical-private-synchronous:osd-"$1" \
        -i "$2" \
        -t 1000 \
        "$3" \
        "$4"
}

notify_slider() {
    notify-send -e \
        -a osd \
        -u low \
        -h string:x-canonical-private-synchronous:osd-"$1" \
        -i "$2" \
        -t 1000 \
        "$3" \
        "$4" \
        -h int:value:"$5"
}
