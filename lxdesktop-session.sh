#!/bin/bash

#Because I'm lazy I'm using the following positional arguments in this script. I figure it's not much of an issue since the script is called by a hard-coded Xsession file
# $1 -- name of container
# $2 -- username within container
# $3 -- command to run

#Clean up DISPLAY variable. I'm no bash whiz, so there's probably a more elegant way to do this
CLEAN_DISPLAY=${DISPLAY%%.*}
CLEAN_DISPLAY=${CLEAN_DISPLAY:1} 

#Ensure container can speak to X. Might not be necessary
xhost + SI:localuser:$(whoami)

#Add Xserver to container
lxc config device add $1 X0 proxy connect="unix:@/tmp/.X11-unix/X$CLEAN_DISPLAY" listen="unix:@/tmp/.X11-unix/X0" security.gid=$(id -g) security.uid=$(id -u) bind=container

#Add PulseAudio to container
lxc config device add $1 PASocket proxy connect="unix:/run/user/$(id -u)/pulse/native" listen="unix:/home/.pulse-native" bind=container uid=$(id -u) gid=$(id -g) mode="0666" security.uid=$(id -u) security.gid=$(id -g)

#Add GPU to container for hardware accel. Tested with Intel. May need extra for Nvidia
lxc config device add $1 mygpu gpu

lxc start $1
#Adjust as needed. Very likely a better way to do this. Haven't looked into it yet.
sleep 2

#Only needs to be done once, but left in for safety
lxc exec $1 -- sed -i "s/; enable-shm = yes/enable-shm = no/g" /etc/pulse/client.conf

#Start the desktop. Needs unbuffer to keep display manager from killing X
unbuffer lxc exec $1 -t -- sudo -u $2 --login env PULSE_SERVER=unix:/home/.pulse-native XDG_SESSION_TYPE=x11 DISPLAY=unix:0 $3

#Examples of what this command can look like

#unbuffer lxc exec $1 -t -- sudo -u $2 --login env PULSE_SERVER=unix:/home/.pulse-native XDG_SESSION_TYPE=x11 DISPLAY=unix:0 startxfce4
#unbuffer lxc exec $1 -t -- sudo -u $2 --login env PULSE_SERVER=unix:/home/.pulse-native XDG_SESSION_TYPE=x11 DISPLAY=unix:0 budgie-desktop
#unbuffer lxc exec $1 -t -- sudo -u $2 --login env PULSE_SERVER=unix:/home/.pulse-native XDG_SESSION_TYPE=x11 DISPLAY=unix:0 dbus-run-session gnome-session --session=ubuntu

#Shut down the container and remove its access to host devices/services
lxc stop $1
lxc config device remove $1 X0
lxc config device remove $1 PASocket
lxc config device remove $1 mygpu
#No need to call xhost again since X is shut down at this point

exit 0
