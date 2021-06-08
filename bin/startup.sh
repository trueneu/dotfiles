#!/usr/bin/env bash

xrdb -merge ~/.Xresources
sudo /usr/bin/systemctl restart xkeysnail.service
/usr/bin/systemctl --user restart clipper.service
