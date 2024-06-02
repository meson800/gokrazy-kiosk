#!/bin/bash

if [[ $# -eq 0 ]] ; then
    /usr/bin/X :0 -nocursor -nolisten tcp vt1
else
    mkdir -p tmp/screenshots
    # maximize the main window
    echo 'nohup bash -c "sleep 10; while true; do xdotool getwindowfocus windowsize $(xdotool getdisplaygeometry); sleep 60; done" &' > /usr/bin/entrypoint-command.sh
    echo 'nohup bash -c "sleep 10; while true; do scrot -F tmp/screenshots/screen.png -o -z; sleep 60; done" &' >> /usr/bin/entrypoint-command.sh

    echo "$@" >> /usr/bin/entrypoint-command.sh
    chmod +x /usr/bin/entrypoint-command.sh
    /usr/bin/xinit /usr/bin/entrypoint-command.sh -- :0 -nolisten tcp vt1
fi
