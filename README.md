# termux-scripts

For more info, pics, tips: https://brouken.com/2018/01/install-nzbget-sabnzbd-termux-android/

## Install SABnzbd

```
apt-get update && apt-get --assume-yes install wget && wget https://raw.githubusercontent.com/moneytoo/termux-scripts/master/sabnzbd.sh -O - | bash
```

## Install NZBGet

```
pkg install nzbget
```

Run following for tasker integration (NZBGet startup script for use with Tasker):

```
apt-get update && apt-get --assume-yes install wget && wget https://raw.githubusercontent.com/moneytoo/termux-scripts/master/nzbget-tasker.sh -O - | bash
```
