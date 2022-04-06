#!/bin/sh


SOUND_VOLUME="$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master))"
SOUND_VOLUME="${SOUND_VOLUME%%%}"

SOUND_ICON=""
if [ "$SOUND_VOLUME" -gt 75 -a "$SOUND_VOLUME" -le 100 ]; then
    SOUND_ICON=""
elif [ "$SOUND_VOLUME" -gt 50 -a "$SOUND_VOLUME" -le 75 ]; then
    SOUND_ICON="墳"
elif [ "$SOUND_VOLUME" -gt 25 -a "$SOUND_VOLUME" -le 50 ]; then
    SOUND_ICON="奔"
else
    SOUND_ICON="奄"
fi

echo "$SOUND_ICON $SOUND_VOLUME%"


