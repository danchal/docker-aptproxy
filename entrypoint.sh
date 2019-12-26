#!/bin/sh

# Copy all configuration files if not already existing
if [ ! -f /config/acng.conf ]; then
    echo "WARNING: /config/acng.conf does not exist, creating all missing configuration files"
    cp -n -r /etc/apt-cacher-ng/* /config/;
fi

echo "### Start DBUS service ###"
/etc/init.d/dbus start

echo "### Start AVAHI daemon ###"
/etc/init.d/avahi-daemon start

echo "### Start APT-CACHER-NG service ###"
exec /usr/sbin/apt-cacher-ng -c /config ForeGround=1 CacheDir=/cache

cat <<EOF
===========================================================
The dockerized APT-CACHER-NG instance is now ready for use!
===========================================================
EOF
