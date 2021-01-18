#!/usr/bin/env bash

#xrandr --dpi 144

# 7680 + 7680 == 15360
# 2160 * 2 == 4320

xrandr --output DP-0 --auto --primary --mode 3840x2160 --rate 120.00 # --scale 0.6666666x0.66666666
xrandr --output HDMI-0 --auto --right-of DP-0 --mode 2560x1440 --rate 99.95

# xrandr --fbmm 15360x4320 --output DP-0 --primary --mode 3840x2160 --rate 120.00 --pos 0x0 --scale 0.33333x0.33333

# xrandr --fbmm 7680x2160
# xrandr --output DP-0 --primary --mode 3840x2160 --rate 120.00 --pos 0x0
# xrandr --output HDMI-0 --right-of DP-0 --mode 2560x1440 --rate 99.95 --scale 1.5x1.5x --pos 3840x0 --panning 3840x2160+3840+0

# xrandr --fb 19200x10800

# 11520
# 7680

# 6480
# 4320

# total width 6400
# x1.5 9600

# total height 2160
# x1.5 3240

# 3840 * 1.5 = 5760
# 2560 * 1.5 = 3840
# 1440 * 1.5 = 2160

# xrandr --output DP-0 --primary --mode 3840x2160 --rate 120.00 --pos 0x0 --scale 3x3 --panning 11520x6480+0+0
# xrandr --output HDMI-0 --pos 11520x0 --mode 2560x1440 --rate 99.95 --scale 2x2 --panning 7680x4320+11520+6480
# xrandr --fb 9600x3240 --output DP-0 --primary --mode 3840x2160 --rate 120.00 --pos 0x0 --scale 0.6x0.6 --panning 5760x3240+0+0 --output HDMI-0 --right-of DP-0 --mode 2560x1440 --rate 99.95 --pos 5760x0 --scale 0.9x0.9 --panning 3840x2160+5760+0
# xrandr --fb 9600x3240 --output DP-0 --primary --mode 3840x2160 --rate 120.00 --pos 0x0 --scale 0.6x0.6 --output HDMI-0 --right-of DP-0 --mode 2560x1440 --rate 99.95 --pos 5760x0 --scale 0.9x0.9
