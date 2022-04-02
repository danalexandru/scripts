#!/bin/sh

# Current layout
LAYOUT=$(xkblayout-state print "%n")

if [ "$LAYOUT" = "English" ]; then
    echo "en"
elif [ "$LAYOUT" = "Romanian" ]; then
    echo "ro"
else 
    echo "??"
fi
