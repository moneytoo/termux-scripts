#!/data/data/com.termux/files/usr/bin/bash

apt-get --assume-yes install wget libxml2 p7zip unrar
PKG=nzbget_19.1_`dpkg --print-architecture`.deb
wget https://raw.githubusercontent.com/moneytoo/termux-scripts/master/nzbget/$PKG -O ~/$PKG
dpkg -i ~/$PKG


#### Tasker ####

mkdir -p ~/.termux/tasker

cat << 'EOF' > ~/.termux/tasker/nzbget.sh
#!/data/data/com.termux/files/usr/bin/sh

start() {
  nzbget -D
}

stop() {
  nzbget -Q
}

case "$1" in
  start)
    start
    termux-open-url http://localhost:6789/
    ;;
  stop)
    stop
    ;;
  retart)
    stop
    start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
esac
EOF

chmod 700 ~/.termux/tasker/nzbget.sh
