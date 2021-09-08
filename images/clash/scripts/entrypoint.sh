#!/bin/sh

# Create tun devixe
mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 600 /dev/net/tun

# Generate config
if [ -f /etc/config/config.conf ]; then
  cp /etc/config/config.yaml /root/.config/clash/config.yaml
fi
if [ -f /vault/secrets/proxies ]; then
  cat /vault/secrets/proxies >> /root/.config/clash/config.yaml
fi

# setup_tun.sh will wait until utun available and setup route table
/root/scripts/setup_tun.sh &

exec /opt/bin/clash
