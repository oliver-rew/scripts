#!/bin/bash
sudo iptables --table nat --append POSTROUTING --out-interface wlan0 -j MASQUERADE
sudo iptables --append FORWARD --in-interface eth1 -j ACCEPT
sudo su -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'
