#!/usr/bin/env bash

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
            options="$font -nb #282828 -nf #a89984 -sb #3c3836 -sf #ebdbb2"
            ;;
        *)
            printf "Unknown Argument $1; Expected one of the following:\n\t--default\n\t--doom-one\n\t--gruvbox\n"
    esac
fi

selected="$(ps -a -u $USER | \
            # dmenu -i -p "Type to search and select process to kill" \
            dmenu -p "Type to search and select process to kill" \
            $lines $options | \
            awk '{print $1" "$4}')"; 

if [[ ! -z $selected ]]; then

    answer="$(echo -e "Yes\nNo" | \
            # dmenu -i -p "$selected will be killed, are you sure?" \
            dmenu -p "$selected will be killed, are you sure?" \
            $lines $options )"

    if [[ $answer == "Yes" ]]; then
        selpid="$(awk '{print $1}' <<< $selected)"; 
        kill -9 $selpid
    fi
fi

exit 0
