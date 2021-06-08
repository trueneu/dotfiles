#!/usr/bin/env bash

WM_CLASS=$1
PROGRAM=$2

if [ "x$WM_CLASS" == "x" -o "x$PROGRAM" == "x" ] ; then
    echo "Not enough arguments supplied"
    exit 1
fi

WINDOW_STAT=`wmctrl -l -x | fgrep "$WM_CLASS"`

if [ "x$WINDOW_STAT" == "x" ] ; then
    $PROGRAM
else
    WINDOW_ID=`echo $WINDOW_STAT | awk '{print $1}'`
    wmctrl -i -a $WINDOW_ID
fi
