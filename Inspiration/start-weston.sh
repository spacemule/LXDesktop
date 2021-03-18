#!/bin/bash
sleep 2
kstart5 --desktop 3 --fullscreen --skiptaskbar -- weston --width 1920 --height 1080 
sleep 2
#kstart5 -- Xwayland :500
kstart5 -- Xwayland :500 -ac
sleep 2
env DISPLAY=:500 xhost +SI:localuser:ubuntu
sudo -u ubuntu --login env DISPLAY=:500 dbus-run-session startplasma-x11
#DISPLAY=:500 openbox
