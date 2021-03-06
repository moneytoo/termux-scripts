#!/data/data/com.termux/files/usr/bin/bash

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
