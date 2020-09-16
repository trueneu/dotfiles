#!/usr/bin/env bash

if [ "x$1" == "xload" ] ; then
    pacmd load-module module-jack-source channels=2; pacmd load-module module-jack-sink channels=2;
elif [ "x$1" == "xunload" ] ; then
    pacmd unload-module module-jack-source; pacmd unload-module module-jack-sink;
fi
