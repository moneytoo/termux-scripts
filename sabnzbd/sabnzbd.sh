#!/data/data/com.termux/files/usr/bin/bash

apt-get update && apt-get --assume-yes install wget python2 unrar par2 p7zip clang python2-dev libffi-dev openssl-dev termux-tools
pip2 install Cheetah sabyenc cryptography

VERSION="2.3.2"
wget https://github.com/sabnzbd/sabnzbd/releases/download/${VERSION}/SABnzbd-${VERSION}-src.tar.gz -O ~/SABnzbd-${VERSION}-src.tar.gz

OPT=`dirname $PREFIX`/opt
mkdir -p $OPT
tar -zxvf ~/SABnzbd-${VERSION}-src.tar.gz -C $OPT


#### Control script ####

cat << 'EOF' > $PREFIX/bin/sabnzbd
#!/data/data/com.termux/files/usr/bin/bash

OPT=`dirname $PREFIX`/opt/
DIR=$OPT/SABnzbd-2.3.2
PID=$DIR/SABnzbd.pid
SABNZBD=$DIR/SABnzbd.py

start() {
  python2 $SABNZBD --daemon --pidfile $PID --browser 1
}

stop() {
  kill `cat $PID`
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
chmod 700 $PREFIX/bin/sabnzbd


#### Config - set download directory ####

read -p "Make sure Termux session is running in foreground. Press enter to continue."
termux-setup-storage

cat << 'EOF' > ${OPT}/SABnzbd-${VERSION}/sabnzbd.ini
[misc]
download_dir = /data/data/com.termux/files/home/storage/downloads/incomplete
complete_dir = /data/data/com.termux/files/home/storage/downloads
auto_browser = 1
EOF


#### Patch - allow browser auto start in daemon mode ####

cat << 'EOF' > ~/sabnzbd-browser.patch
--- sabnzbd/panic.py
+++ sabnzbd/panic.py
@@ -27,6 +27,7 @@
     import webbrowser
 except ImportError:
     webbrowser = None
+import subprocess
 
 import sabnzbd
 import sabnzbd.cfg as cfg
@@ -193,7 +194,7 @@
 
 def launch_a_browser(url, force=False):
     """ Launch a browser pointing to the URL """
-    if not force and not cfg.autobrowser() or sabnzbd.DAEMON:
+    if not force and not cfg.autobrowser():
         return
 
     if '::1' in url and '[::1]' not in url:
@@ -211,7 +212,7 @@
         if url and not url.startswith('http'):
             url = 'file:///%s' % url
         if webbrowser:
-            webbrowser.open(url, 2, 1)
+            subprocess.call(["termux-open-url", url])
         else:
             logging.info('Not showing panic message in webbrowser, no support found')
     except:
--- SABnzbd.py
+++ SABnzbd.py
@@ -840,7 +840,7 @@
         elif opt in ('-d', '--daemon'):
             if not sabnzbd.WIN32:
                 fork = True
-            autobrowser = False
+            autobrowser = None
             sabnzbd.DAEMON = True
             sabnzbd.RESTART_ARGS.append(opt)
         elif opt in ('-f', '--config-file'):
EOF

cd ${OPT}/SABnzbd-${VERSION} && patch -p0 < ~/sabnzbd-browser.patch


#### Tasker ####

mkdir -p ~/.termux/tasker/
ln -s $PREFIX/bin/sabnzbd ~/.termux/tasker/sabnzbd.sh
