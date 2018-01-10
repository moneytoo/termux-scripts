#!/data/data/com.termux/files/usr/bin/bash

mkdir -p ~/.termux/tasker/

cat << 'EOF' > ~/.termux/tasker/sshd.sh
#!/data/data/com.termux/files/usr/bin/sh

start() {
  sshd
}

stop() {
  killall sshd
}

case "$1" in
  start)
    start
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

chmod 700 ~/.termux/tasker/sshd.sh
