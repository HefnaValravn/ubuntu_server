#!/bin/bash



# Wait until eth0 is up
while ! ip link show eth0 | grep -q "state UP"; do
    sleep 1
done

sudo arp -s 193.191.176.254 ca:fe:c0:ff:ee:00 -i eth0
