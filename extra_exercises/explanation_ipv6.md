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


For the next part, I need to actually access the assignment page so I can get the extra instructions. To do this,
I create a ssh tunnel on my local machine that forwards incoming traffic on 127.0.0.1 to my server:

- `ssh -vvv -D 127.0.0.1:1080 -C -N root@193.191.176.194`
(the -vvv part doesn't actually matter, as it just enables logging)
(should for whatever reason the command above not work, you can also use `ssh -vvv -p 22345 -D 127.0.0.1:1080 -C -N root@193.191.176.194`)

Then I can go to my browser settings and configure a socks proxy where the address is 127.0.0.1, port 1080,
and I use socksv5. This makes it so that all traffic coming into my device gets redirected through this ssh
tunnel into my server, which has the right IPv6 address to view the page.

Once that's done, I'll be able to see the assignment page, which tells me to configure an extra port to
be available to connect to on IPv6 (in my case, port 12093).

To make sure this port is available on IPv6, I add the `Listen [::]:12093` line to my apache configuration,
and then check that my server is listening on that port for IPv6 by using `ss` or `netstat` once again.


Finally, if I want to preserve my configuration given that we're using proxmox, I should create the
following files so the files they're referring to don't get changed:

- `touch /etc/.pve-ignore.hosts`
- `touch /etc/network/.pve-ignore.interfaces`
- `touch /etc/systemd/network/.pve-ignore.eth0.network`
