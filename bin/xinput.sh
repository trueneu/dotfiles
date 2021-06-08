#!/usr/bin/env bash

xinput | grep -P '(Ultimate Gadget Laboratories Ultimate Hacking Keyboard|Razer Razer DeathAdder)' | fgrep pointer | grep -Po '(?<=id=)\d+' | while read p_id ; do
    xinput --set-prop $p_id "libinput Natural Scrolling Enabled" 1
    xinput --set-float-prop $p_id 'Coordinate Transformation Matrix' 0.5 0 0 0 0.5 0 0 0 1
done

xinput | grep -P 'Wacom Intuos Pro M Finger touch' | fgrep pointer | grep -Po '(?<=id=)\d+' | while read p_id ; do
    xinput --set-float-prop $p_id "Device Accel Constant Deceleration" 3.0
done


setxkbmap -layout 'us,us,ru' -variant 'dvp, ,dvp'

xset dpms 0 0 0
