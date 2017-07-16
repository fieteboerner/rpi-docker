#!/bin/bash

iptables -t nat -A POSTROUTING -s $VPN_NET -o eth0 -j MASQUERADE
while true ; do openvpn /etc/openvpn/openvpn.conf ; done >> /var/log/openvpn.log &
tail -F /var/log/openvpn.log

