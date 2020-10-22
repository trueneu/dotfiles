#!/usr/bin/env bash

PRECISION_WIDTH=600
PRECISION_HEIGHT=`echo "$PRECISION_WIDTH * 95 / 152" | bc`

X=`xdotool getmouselocation | grep -Po '(?<=x:)\d+'`
Y=`xdotool getmouselocation | grep -Po '(?<=y:)\d+'`

xsetwacom set "Wacom Intuos BT S Pen stylus" maptooutput ${PRECISION_WIDTH}x${PRECISION_HEIGHT}+${X}+${Y}

PRECISION_MODE_STATE_FILE=/tmp/wacom-precision-mode
touch $PRECISION_MODE_STATE_FILE

