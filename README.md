# LXDesktop
Scratchpad for running LXD containers as desktop straight from display manager

# Notes
A good deal of this project was inspired by information found on the blog https://blog.simos.info/

He makes clear that his work is released with no licensing restrictions. Therefore anything derived from his work is free to be used, modified, shared, etc. according to his restrictions.

See here for my main inspiration: https://blog.simos.info/running-x11-software-in-lxd-containers/

# Setup

Make sure LXD is properly installed and configured. If your system uses firewalld, check the LXD documentation to ensure networking works smoothly. I initially got this working under Ubuntu 20.04, but I've since switched to OpenSUSE Leap 15.2 with LightDM as the display manager. The current configuration will be tested there. I haven't gotten around to it yet.

To get started, set up an LXD container with a desktop environment, e.g.:


`lxc launch images:opensuse/15.2 leap-container`

`lxc exec leap-container -- sudo --user opensuse --login`

`sudo zypper install patterns-xfce-xfce`


**I make no claims as to the security, stability, or worthiness of this software. If your house catches on fire and you end up homeless as a result of running my code, I accept no responsibility, but I wish you the best.**

# Goals

* Quickly set up a desktop in an LXD container and have it boot to a desktop
* Provide an environment for testing different OSes from a stable base OS
* Enable testing of software across different environments in an as near to native way as possible

# Usage

1. Place the lxdesktop-session.sh script in a location accessible to the user's account who will log in with it. For example, /home/$USER/bin/lxdesktop-session.sh
2. Create an xsession file using sample.desktop as a template.
3. Place that file in a directory that your display manager will see
4. Logout and login choosing the new xsession

# Troubleshooting

* Make sure your user is part of the lxd group
* Try disabling pulseaudio in the lxdesktop-session.sh file. If this helps, then pulseaudio is not starting with login. I haven't looked into this. DuckDuckGo(oogle) is your friend.
* Maybe I made a mistake. Check my work :)
