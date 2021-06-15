#!/bin/sh

TIME="$1"
MSG="$2"

notify-send -t 0 "In $TIME minutes!<br>$MSG"
