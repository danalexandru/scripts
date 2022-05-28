#!/bin/sh

# Thank you Luke 🙂
CLOCK_12H_FORMAT="$(date '+%I')"
case "$CLOCK_12H_FORMAT" in
	"00") TIME_ICON="🕛" ;;
	"01") TIME_ICON="🕐" ;;
	"02") TIME_ICON="🕑" ;;
	"03") TIME_ICON="🕒" ;;
	"04") TIME_ICON="🕓" ;;
	"05") TIME_ICON="🕔" ;;
	"06") TIME_ICON="🕕" ;;
	"07") TIME_ICON="🕖" ;;
	"08") TIME_ICON="🕗" ;;
	"09") TIME_ICON="🕘" ;;
	"10") TIME_ICON="🕙" ;;
	"11") TIME_ICON="🕚" ;;
	"12") TIME_ICON="🕛" ;;
esac

DATE_ICON=""
DATE="$(date '+%a %d %b %Y')"

TIME="$(date '+%H:%M:%S')"

SEPARATOR="|"
echo "$DATE_ICON $DATE $SEPARATOR $TIME_ICON $TIME"

