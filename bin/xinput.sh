#!/usr/bin/env bash

xinput | grep -P '(Ultimate Gadget Laboratories Ultimate Hacking Keyboard|Razer Razer DeathAdder Elite)' | fgrep pointer | grep -Po '(?<=id=)\d+' | while read p_id ; do
    xinput --set-prop $p_id "libinput Natural Scrolling Enabled" 1
done

setxkbmap -layout 'us,us,ru' -variant 'dvp, ,dvp'

xset dpms 0 0 0
