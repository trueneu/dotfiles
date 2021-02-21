#!/usr/bin/env bash

NEXT_STATE_FILE=/tmp/wacom-next-monitor
CURRENT_STATE_FILE=/tmp/wacom-current-monitor
PRECISION_MODE_STATE_FILE=/tmp/wacom-precision-mode

if [ -f $PRECISION_MODE_STATE_FILE ] ; then
    if [ -f $CURRENT_STATE_FILE ] ; then
	NEXT_MONITOR=`cat $CURRENT_STATE_FILE`
    else
	NEXT_MONITOR=HEAD-0
    fi
    rm $PRECISION_MODE_STATE_FILE
else
    if [ -f $NEXT_STATE_FILE ] ; then
	NEXT_MONITOR=`cat $NEXT_STATE_FILE`
    else
	NEXT_MONITOR=HEAD-1
    fi
fi

xsetwacom set "Wacom Intuos Pro M Pen stylus" maptooutput $NEXT_MONITOR
xsetwacom set "Wacom Intuos Pro M Pen eraser" maptooutput $NEXT_MONITOR
echo -n $NEXT_MONITOR > $CURRENT_STATE_FILE

if [ "$NEXT_MONITOR" == "HEAD-0" ] ; then
    echo -n "HEAD-1" > $NEXT_STATE_FILE
elif [ "$NEXT_MONITOR" == "HEAD-1" ] ; then
    echo -n "HEAD-2" > $NEXT_STATE_FILE
else
    echo -n "HEAD-0" > $NEXT_STATE_FILE
fi
