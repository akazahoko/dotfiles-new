#!/usr/bin/env zsh

ANY_KEY_TO_CONTINUE='read -k 1 -q "?Press any key to continue"'

if [[ -n "$1" ]]; then
    case "$1" in
    "pacman") coproc { "$TERMINAL" -e zsh -c "
        pacman -Ssq | fzf --reverse -m \
        --preview 'pacman -Si {}' \
        --bind 'enter:execute(sudo pacman -S --needed {+} && $ANY_KEY_TO_CONTINUE)+accept' \
        --bind 'alt-h:preview(echo -e \"Tab:\tSelect package\nEnter:\tInstall selected package(s)\")'
        " >/dev/null 2>&1 }
    ;;
    "aur") coproc { "$TERMINAL" -e zsh -c "
        yay -Slaq | fzf --reverse -m \
        --preview 'yay -Si {}' \
        --bind 'enter:execute(yay -S --needed {+} && $ANY_KEY_TO_CONTINUE)+accept' \
        --bind 'ctrl-o:execute(xdg-open https://aur.archlinux.org/packages/{})'
        " >/dev/null 2>&1 }
    ;;
    "listpkg") coproc { "$TERMINAL" -e zsh -c "
        pacman -Qqen | fzf --reverse -m
        " >/dev/null 2>&1 }
    ;;
    "listaur") coproc { "$TERMINAL" -e zsh -c "
        pacman -Qqem | fzf --reverse -m
        " >/dev/null 2>&1 }
    ;;
    "deletepkg") coproc { "$TERMINAL" -e zsh -c "
        pacman -Qqe | fzf --reverse -m \
        --preview 'pacman -Qi {}'   \
        --bind 'delete:execute(clear; sudo pacman -Rns {+}; $ANY_KEY_TO_CONTINUE)+reload(pacman -Qqe)' \
        " >/dev/null 2>&1 }
    ;;
    "cleanorphans") coproc { "$TERMINAL" -e zsh -c '
        ORPHANS=($(pacman -Qtdq))
        if [[ ${#ORPHANS[@]} -gt 0 ]]; then
            sudo pacman -Rns "${ORPHANS[@]}"
        else
            echo "CLEAN!"
        fi
        read -k 1 -q "?Press any key to continue"
        ' >/dev/null 2>&1 }
    ;;
    "updatepkg") coproc { "$TERMINAL" -e zsh -c '
        sudo pacman -Syu
        read -k 1 -q "?Press any key to continue"
        ' >/dev/null 2>&1 }
    ;;
    "updateaur") coproc { "$TERMINAL" -e zsh -c '
        yay -Syua
        read -k 1 -q "?Press any key to continue"
        ' >/dev/null 2>&1 }
    ;;
    esac
    exit 0
fi

echo -e "pacman"
echo -e "aur"
echo -e "listpkg"
echo -e "listaur"
echo -e "deletepkg"
echo -e "cleanorphans"
echo -e "updatepkg"
echo -e "updateaur"
