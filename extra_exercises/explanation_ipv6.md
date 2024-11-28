For this exericse, I first of all need to find out what the last quartet of my ipv4 address is. In my case, this number
is 194, which in hex is c2. Therefore, I will add my ipv6 address with the last part being c2.
I do this by running the command `sudo ip -6 addr add 2001:6a8:2880:a020::c2/64 dev eth0`. I then configure the default
gateway with the command `sudo ip -6 route add default via 2001:6a8:2880:a020::fe`.

This, however, is only a temporary fix; to make it persistent, I need to edit the
"/etc/systemd/network/eth0.network" file and add my ipv6 address, as well as the "hosts" file under
/etc.

I then restart bind with `systemctl restart bind9`.

Once this is done, I should go make sure that the necessary ports (TCP 25, 53, 80, 443, 993 and 22345) are listening
for IPV6 connections. I can use the `ss` or `netstat` commands in combination with `grep` for this.

Before I add any AAAA records, I first need to check if my system is IPv6 ready. To do this, I can use
`cat /proc/sys/net/ipv6/conf/all/disable_ipv6` to check the status of ipv6. If the output is 0, then it is enabled;
if the output is 1, it is disabled, in which case I can use the following commands to enable it:

- `sysctl -w net.ipv6.conf.all.disable_ipv6=0` (affects all ports globally and sets ipv6 to be enabled)

- `sysctl -w net.ipv6.conf.default.disable_ipv6=0` (affects future interfaces, so that the default is always to have
ipv6 on)

I can also check that I have an IPv6 address assigned by using `ip -6 addr show`, and pinging the gateway with
`ping6 (ipv6 address)`.


Once this is done, I can safely add AAAA records to my zone file under "/var/lib/bind".

- One for my address: `nicolas-benedettigonzalez.sasm.uclllabs.be. IN AAAA (my ipv6 address)`

- One for my ns zone: `ns.nicolas-benedettigonzalez.sasm.uclllabs.be. IN AAAA (my ipv6 address)`


I then restart bind.


Finally, I need to configure a service that will display the last port to listen on for IPv6 when connecting from
my server's IPv6 address. To do this, I first configure a script under /etc/scripts that logs which port was last used
for IPv6 and logs it to a text file under /var/tmp. This script runs indefinitely and listens on which ports IPv6 has
last been used.
I then create a service for this script, so I can make it persistent even across reboots. I reload the daemon, enable
the service I just made, and start it.


Finally, if I want to preserve my configuration given that we're using proxmox, I should create the
following files so the files they're referring to don't get changed:

- `touch /etc/.pve-ignore.hosts`
- `touch /etc/network/.pve-ignore.interfaces`
- `touch /etc/systemd/network/.pve-ignore.eth0.network`
