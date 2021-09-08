#!/bin/sh

until [ -e /sys/class/net/utun ] && [ $(cat /sys/class/net/utun/carrier) = 1 ]; do sleep 1; done

NETFILTER_MARK=129
IPROUTE2_TABLE_ID=129

ip route replace default dev utun table "$IPROUTE2_TABLE_ID"
ip rule add fwmark "$NETFILTER_MARK" lookup "$IPROUTE2_TABLE_ID" priority 1

nft -f - << EOF
define LOCAL_SUBNET = {127.0.0.0/8, 224.0.0.0/4, 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12, 169.254.0.0/16, 240.0.0.0/4}
table clash
flush table clash
table clash {
    chain local {
        type route hook output priority 0; policy accept;
        ip protocol != { udp } accept
        ip daddr \$LOCAL_SUBNET accept
        
        ct state new ct mark set $NETFILTER_MARK
        ct mark $NETFILTER_MARK mark set $NETFILTER_MARK
    }
    chain forward {
        type filter hook prerouting priority 0; policy accept;
        ip protocol != { udp } accept
        ip daddr \$LOCAL_SUBNET accept
        iif utun accept
        
        mark set $NETFILTER_MARK
    }
}
EOF