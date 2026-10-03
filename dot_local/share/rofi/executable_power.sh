#!/usr/bin/env zsh

SUSPEND="睡眠"
SHUTDOWN="關機"
REBOOT="重新啟動"
EXIT="退出"
IDLE="咖啡因"
SUNSET="夜間模式"

if [[ -n "$1" ]]; then
    case "$1" in
        $SUSPEND)systemctl suspend;;
        $SHUTDOWN)systemctl poweroff;;
        $REBOOT)systemctl reboot;;
        $EXIT)systemctl logout;;
        
        $IDLE)
            if [[ -z "systemd-inhibit --list --no-pager | grep -i DONTFUKCINGSLEEP" ]];then
                systemd-inhibit --what=idle:sleep --mode=block --who="DONTFUCKINGSLEEP" sleep infinity &> /dev/null &
            else
                pkill -f "DONTFUCKINGSLEEP" &> /dev/null &
            fi;;
       
        $SUNSET)
            if pgrep -x "wlsunset" >/dev/null; then
                pkill wlsunset &> /dev/null &
            else
                wlsunset -t 4000 &> /dev/null &
            fi;;
    esac
    exit 0
fi

echo -e $SUSPEND
echo -e $SHUTDOWN
echo -e $REBOOT
echo -e $EXIT
echo -e $IDLE
echo -e $SUNSET
