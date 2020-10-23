#!/usr/bin/env bash

OPERATION=$1

PRECISION_MODE_WIDTH_FILE=/tmp/wacom-precision-mode-width

PRECISION_WIDTH=600

if [ -f $PRECISION_MODE_WIDTH_FILE ] ; then
    PRECISION_WIDTH=`cat $PRECISION_MODE_WIDTH_FILE`
else
    echo -n $PRECISION_WIDTH > $PRECISION_MODE_WIDTH_FILE
fi


if [ -z "$OPERATION" -o "$OPERATION" == "on" ] ; then 

    PRECISION_HEIGHT=`echo "$PRECISION_WIDTH * 95 / 152" | bc`

    X=`xdotool getmouselocation | grep -Po '(?<=x:)\d+'`
    Y=`xdotool getmouselocation | grep -Po '(?<=y:)\d+'`

    xsetwacom set "Wacom Intuos BT S Pen stylus" maptooutput ${PRECISION_WIDTH}x${PRECISION_HEIGHT}+${X}+${Y}

    PRECISION_MODE_STATE_FILE=/tmp/wacom-precision-mode
    touch $PRECISION_MODE_STATE_FILE

    
elif [ "$OPERATION" == "plus" ] ; then
    
    PRECISION_WIDTH=`printf %.0f $(echo "$PRECISION_WIDTH * 0.9" | bc)`
    if [ $PRECISION_WIDTH -lt 100 ] ; then
	PRECISION_WIDTH=100
    fi
    echo -n $PRECISION_WIDTH > $PRECISION_MODE_WIDTH_FILE
    exec $0 on
    
elif [ "$OPERATION" == "minus" ] ; then

    PRECISION_WIDTH=`printf %.0f $(echo "$PRECISION_WIDTH * 1.11111" | bc)`
    echo -n $PRECISION_WIDTH > $PRECISION_MODE_WIDTH_FILE
    exec $0 on

fi

    
