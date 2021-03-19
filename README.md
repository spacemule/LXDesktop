# LXDesktop
Scratchpad for running LXD containers as desktop straight from display manager

# Notes
A good deal of this project was inspired by information found on the blog https://blog.simos.info/

He makes clear that his work is released with no licensing restrictions. Therefore anything derived from his work is free to be used, modified, shared, etc. according to his (lack of?) restrictions.

See here for my main inspiration: https://blog.simos.info/running-x11-software-in-lxd-containers/

I included a folder called "Inspiration." It's a collection of terrible little scripts I wrote for testing using nested X servers. Please don't use them as is, but take a look to see what you can do with similar ideas. They are not meant for full DEs; they are meant for launching applications within a container and displaying them on a nested X server. The clip ones can be mapped to keyboard shortcuts to share clipboards between servers. The others are for launching different types of nested X servers and were designed to run at session start. Once again, these were just scratch files and by no means ready for prime time.

# Setup

Make sure LXD is properly installed and configured. If your system uses firewalld, check the LXD documentation to ensure networking works smoothly. I initially got this working under Ubuntu 20.04, but I've since switched to OpenSUSE Leap 15.2 with LightDM as the display manager. The current configuration will be tested there. I haven't gotten around to it yet.

I like to add `security.idmap.isolated = "true"` to my default lxd profile. It makes me feel safer, but with this level of access to real hardware, who knows!

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

1. Place the lxdesktop-session.sh script in a location accessible to the user's account who will log in with it. For example, /opt/lxdesktop/bin/lxdesktop-session.sh
2. Create an xsession file using sample.desktop as a template.
3. Place that file in a directory that your display manager will see. Looks like the default is usually /usr/share/xsessions. Arch Wiki says it's fine to play around there, but I don't like messing with the /usr directory. Make a snapshot, or, if you know another option to get this seen by the display manager, let me know!
4. Logout and login choosing the new xsession

# Planned features

* Make a script to manage/automate adding and removing sessions
* Track available/enabled sessions
* Automate setup of common container configs

# Troubleshooting

* Make sure your user is part of the lxd group
* Try disabling pulseaudio in the lxdesktop-session.sh file. If this helps, then pulseaudio is not starting with login. I haven't looked into this. DuckDuckGo(oogle) is your friend.
* Maybe I made a mistake. Check my work :)
