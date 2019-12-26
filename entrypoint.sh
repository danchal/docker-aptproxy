#!/bin/sh

mkdir -p /data/cache
mkdir -p /data/log

echo "### Start DBUS service ###"
/etc/init.d/dbus start

echo "### Start AVAHI daemon ###"
/etc/init.d/avahi-daemon start

echo "### Start APT-CACHER-NG service ###"
exec /usr/sbin/apt-cacher-ng -c /etc/apt-cacher-ng ForeGround=1 CacheDir=/data/cache LogDir=/data/log ${APTPROXY_OPTIONS}

cat <<EOF
===========================================================
The dockerized APT-CACHER-NG instance is now ready for use!
===========================================================
EOF
