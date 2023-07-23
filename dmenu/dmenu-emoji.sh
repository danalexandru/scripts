#!/bin/sh

# dmenu theming
lines="-l 20"

font="-fn HackNerdFont-10"
if [ $# -eq 0 ]; then
    options="$font -nb #2C323E -nf #9899a0 -sb #BF616A -sf #2C323E"
elif [ $# -gt 1 ]; then
    printf "WARNING: The number of arguments needs to be either 1 or 0. You have given $# arguments: \n$@\n"
    options="$font -nb #2C323E -nf #9899a0 -sb #BF616A -sf #2C323E"
else
    case $1 in
        --default)
            options="$font -nb #222222 -nf #bbbbbb -sb #005577 -sf #eeeeee"
            ;;
        --doom-one)
            options="$font -nb #14191F -nf #8C92AC -sb #1F2833 -sf #F3F3F6"
            ;;
        --gruvbox)
            options="$font -nb #282828 -nf #ebdbb2 -sb #1d2021 -sf #ffaf00"
            ;;
        --vscode)
            options="$font -nb #2a2e32 -nf #eff0f1 -sb #3daee9 -sf #eff0f1"
            ;;
        *)
            printf "Unknown Argument $1; Expected one of the following:\n\t--default\n\t--doom-one\n\t--gruvbox\n"
    esac
fi

emoji_list_path="${HOME}/.config/scripts/dmenu/emoji_list"
grep -v "#" $emoji_list_path | dmenu -p "pick emoji:" \
    $lines $options | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard;

if [ -n "$(xclip -o -selection clipboard)" ]; then
notify-send "Emoji copied" "$(xclip -o -selection clipboard) successfully copied!" --icon=dialog-information;
fi
