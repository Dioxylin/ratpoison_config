#!/bin/sh
FRAMEDUMP="$HOME/.rpframe_gimp"

if [ -f "$FRAMEDUMP" ]
then
    ratpoison -c "frestore `cat "$FRAMEDUMP"`"
fi

if ! ps -C gimp >/dev/null
then
    exec gimp "$@"
else
    WGIMP=$(ratpoison -c "windows %n %t" \
            | sed -ne 's/^\([0-9]\+\) The GIMP/\1/p')
    WLAYERS=$(ratpoison -c "windows %n %t" \
              | sed -ne 's/^\([0-9]\+\) Layers/\1/p')
    ratpoison -c focus
    ratpoison -c "select $WGIMP"
    ratpoison -c focus
    ratpoison -c "select $WLAYERS"
    ratpoison -c focus
    ratpoison -c other
    ratpoison -c "echo The Gimp is already running."
fi
