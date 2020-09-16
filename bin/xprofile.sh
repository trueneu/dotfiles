#!/usr/bin/env bash

xrandr --output HDMI-0 --auto --primary --mode 2560x1440 --rate 120.00
xrandr --output DVI-D-0 --auto --right-of HDMI-0 --mode 1920x1080 --rate 144.00
