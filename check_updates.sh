#!/bin/sh

PACKAGE_ICON=""
NO_OF_PACKAGES=$(checkupdates | wc -l)

if [ $NO_OF_PACKAGES -eq 0 ]; then
    echo "$PACKAGE_ICON  N/A"
else 
    echo "$PACKAGE_ICON  $NO_OF_PACKAGES"
fi


