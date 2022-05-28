#!/bin/sh

# Get sound for both left and right 
SOUND_VOLUME="$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget PCM))"

# Split variables
SOUND_VOLUME_LEFT="$(echo $SOUND_VOLUME | awk '{print $1}')"
SOUND_VOLUME_RIGHT="$(echo $SOUND_VOLUME | awk '{print $NF}')"

# Remove the % sign
SOUND_VOLUME_LEFT="${SOUND_VOLUME_LEFT%%%}"
SOUND_VOLUME_RIGHT="${SOUND_VOLUME_RIGHT%%%}"

# Recombine variables
SOUND_VOLUME=$(($SOUND_VOLUME_LEFT + $SOUND_VOLUME_RIGHT))
SOUND_VOLUME=$(($SOUND_VOLUME/2))
SOUND_ICON=""

if [ "$SOUND_VOLUME" -gt 75 -a "$SOUND_VOLUME" -le 100 ]; then
    SOUND_ICON=""
elif [ "$SOUND_VOLUME" -gt 50 -a "$SOUND_VOLUME" -le 75 ]; then
    SOUND_ICON="墳"
elif [ "$SOUND_VOLUME" -gt 25 -a "$SOUND_VOLUME" -le 50 ]; then
    SOUND_ICON="奔"
elif [ "$SOUND_VOLUME" -gt 0 -a "$SOUND_VOLUME" -le 25 ]; then
    SOUND_ICON="奄"
else
    SOUND_ICON="婢"
fi

echo "$SOUND_ICON $SOUND_VOLUME%"


