#!/bin/bash
sleep 5
/usr/bin/nxagent -R -norootlessexit -options ~/.nx/config/nxagent.conf :400 &
sleep 5
env DISPLAY=:400 setxkbmap -option grp:win_space_toggle us,il

exit 0
