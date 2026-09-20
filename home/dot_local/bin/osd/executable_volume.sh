#!/usr/bin/env zsh

source "${0:A:h}/helper.sh"

# VOLUME CONTROL (PIPEWIRE WPCTL)

function sink_notify() {
    local VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')
    local STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')
    local PROGRESS=$VOLUME

    if [[ "$STATUS" == "[MUTED]" ]]; then
        VOLUME="已靜音"
        ICON=$ICON_DIR/osd/nf-fa-volume_mute.png
    elif (("$VOLUME" >= 65)); then
        ICON=$ICON_DIR/osd/nf-fa-volume_high.png
    elif (("$VOLUME" >= 35)); then
        ICON=$ICON_DIR/osd/nf-fa-volume_middle.png
    elif (("$VOLUME" > 0)); then
        ICON=$ICON_DIR/osd/nf-fa-volume_low.png
    elif (("$VOLUME" == 0)); then
        ICON=$ICON_DIR/osd/nf-fa-volume_zero.png
    fi

    notify_slider "osd-volume-sink" "$ICON" "輸出音量" "$VOLUME" "$PROGRESS"
}

function src_notify() {
    local VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2 * 100}')
    local STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $3}')
    local PROGRESS=$VOLUME

    if [[ "$STATUS" == "[MUTED]" ]]; then
        VOLUME="已靜音"
        ICON=$ICON_DIR/osd/nf-md-microphone_off.png
    else
        ICON=$ICON_DIR/osd/nf-md-microphone.png
    fi

    notify_slider "osd-volume-src" "$ICON" "輸入音量" "$VOLUME" "$PROGRESS"
}

function sink_up() {
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ "0.05"+
    sink_notify
}

function sink_down() {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "0.05"-
    sink_notify
}

function sink_mute() {
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    sink_notify
}

function src_up() {
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ "0.05"+
    src_notify
}

function src_down() {
    wpctl set-volume @DEFAULT_AUDIO_SOURCE@ "0.05"-
    src_notify
}

function src_mute() {
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    src_notify
}

# PLAYERCTL

function media_notify() {
    local STATUS=$(playerctl status)
    local PLAYER=$(playerctl metadata --format "{{playerName}}")
    local TITLE=$(playerctl -p $PLAYER metadata title)
    local ARTIST=$(playerctl -p $PLAYER metadata artist)
    local LENGTH=$(playerctl -p $PLAYER metadata length)
    local ART=$(playerctl -p $PLAYER metadata mpris:artUrl)

    notify_std "playerctl" "$ART" $TITLE "$ARTIST\n$PLAYER - $STATUS"
}

function media_playpause() {
    local STATUS=$(playerctl status)
    case "$STATUS" in
    Playing) playerctl pause ;;
    Paused) playerctl play ;;
    esac
    media_notify
}

function media_next() {
    local PLAYER=$(playerctl metadata --format "{{playerName}}")
    playerctl -p $PLAYER next
    media_notify
}

function media_prev() {
    local PLAYER=$(playerctl metadata --format "{{playerName}}")
    playerctl -p $PLAYER previous
    media_notify
}

$1
