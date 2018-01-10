# termux-scripts

For more info, pics, tips: https://brouken.com/2018/01/install-nzbget-sabnzbd-termux-android/

## Install SABnzbd

```
apt-get update && apt-get --assume-yes install wget && wget https://raw.githubusercontent.com/moneytoo/termux-scripts/master/sabnzbd/sabnzbd.sh -O - | bash
```

## Install NZBGet

```
apt-get update && apt-get --assume-yes install wget && wget https://raw.githubusercontent.com/moneytoo/termux-scripts/master/nzbget/nzbget.sh -O - | bash
```

PR sent for this package to be included in the Termux repository https://github.com/termux/termux-packages/pull/2017
