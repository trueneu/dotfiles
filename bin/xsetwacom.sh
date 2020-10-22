#!/usr/bin/env bash

xsetwacom set "Wacom Intuos BT S Pad pad" Button 1 "key +rctrl +rsuper +rshift +ralt F1 -rctrl -rsuper -rshift -ralt"
xsetwacom set "Wacom Intuos BT S Pad pad" Button 2 "key +rctrl +rsuper +rshift +ralt F2 -rctrl -rsuper -rshift -ralt"
xsetwacom set "Wacom Intuos BT S Pad pad" Button 3 "key +rctrl +rsuper +rshift +ralt F3 -rctrl -rsuper -rshift -ralt"
xsetwacom set "Wacom Intuos BT S Pad pad" Button 8 "key ctrl /"

xsetwacom set "Wacom Intuos BT S Pen stylus" maptooutput HEAD-0
xsetwacom set "Wacom Intuos BT S Pen stylus" Button 2 "pan"
xsetwacom set "Wacom Intuos BT S Pen stylus" PanScrollThreshold 200
