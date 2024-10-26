#!/bin/bash

PROFILE_DIR="/perm/certificates"
CERT_PATH="$PROFILE_DIR/sptv_serviceacct_2023.p12"


if [[ $# -eq 0 ]] ; then
    /usr/bin/X :0 -nocursor -nolisten tcp vt1
else

    mkdir -p "$PROFILE_DIR"

    if [ ! -f "$PROFILE_DIR/cert9.db" ] ; then
        certutil -d sql:"$PROFILE_DIR" -N --empty-password
    fi

    pk12util -d sql:"$PROFILE_DIR" -i "$CERT_PATH"
    
    # maximize the main window
    echo 'nohup bash -c "sleep 10; while true; do xdotool getwindowfocus windowsize $(xdotool getdisplaygeometry); sleep 60; done" &' > /usr/local/bin/entrypoint-command.sh
    echo 'nohup bash -c "sleep 10; while true; do scrot -F /screenshots/screen.png -o -z >> /screenshots/scrot.log 2>&1; sleep 60; done" &' >> /usr/local/bin/entrypoint-command.sh
    echo $DISPLAY

    echo "$@" >> /usr/bin/entrypoint-command.sh
    chmod +x /usr/bin/entrypoint-command.sh
    /usr/bin/xinit /usr/bin/entrypoint-command.sh -- :0 -nolisten tcp vt1
fi
