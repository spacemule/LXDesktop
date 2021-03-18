# LXDesktop
Scratchpad for running LXD containers as desktop straight from display manager

# Notes
A good deal of this project was inspired by information found on the blog https://blog.simos.info/

He makes clear that his work is released with no licensing restrictions. Therefore anything derived from his work is free to be used, modified, shared, etc. according to his restrictions.

See here for my main inspiration: https://blog.simos.info/running-x11-software-in-lxd-containers/

# Set-up

Make sure LXD is properly installed and configured. If your system uses firewalld, check the LXD documentation to ensure networking works smoothly. I initially got this working under Ubuntu 20.04, but I've since switched to OpenSUSE Leap 15.2. The current configuration is tested there.

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

To follow...
