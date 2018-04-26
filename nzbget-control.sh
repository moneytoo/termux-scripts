#!/data/data/com.termux/files/usr/bin/bash

cat << 'EOF' >> ~/.bashrc
alias nzbget-start='nzbget -D && termux-open-url http://localhost:6789/'
alias nzbget-stop='nzbget -Q'
EOF
