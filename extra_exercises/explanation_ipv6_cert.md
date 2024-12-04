
For this exercise, I first need to create an account on the Hurricane Electric page. The username is my server's
name (nicolas-benedettigonzalez) minus the hyphen and followed by the current academic year (24). I choose a
secure password which I save in a file in the /root directory called "ipv6_sage". Once this is done, I can go on
to configure my server with the right IPv6 address in the right range with the right zone:

- First, since I don't have an IPv6 address in the required, range, I create one:
	- `ip -6 addr add 2001:6a8:2880:a7c2::1/64 dev eth0` (since c2 is 194 in hex and 194 is the last part of
my IPv4 address)

- Then I add it to my "eth0.network" file and to the "hosts" file under /etc to make it persistent. (I can also
add the HE username to the same line as the IPv6 address in this file for completeness)
	- For the eth0.network file, I have to change some things around. Firstly, I need to add the new address,
without specifying a gateway, and then create a custom route linked with a certain table (in my case, 200).
Then, I create a routing policy rule which specifies that incoming traffic from the new IPv6 address should use
the lookup table 200, which specifies that incoming traffic should be routed to the eth0 device, which uses the
already existing IPv6 address by default. 

Once this is done, I can go on to create the reverse DNS zone under "/var/lib/bind", which points to my main
ns zone (`ns.nicolas-benedettigonzalez.sasm.uclllabs.be.`) and contains a PTR record that maps the new IPv6
address to my server:
	- `1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0    IN      PTR     nicolas-benedettigonzalez.sasm.uclllabs.be.`

I save this file, then create a configuration file for it under "/etc/bind" that points to it. I should define
it as type master, as it is not a slave to my main zone.

Once this is done, I also need to add an NS record on my main zone file to delegate authority to my server for
the reverse DNS zone I just created:
- `c.2.7.a.0.8.8.2.0.0.a.6.0.1.0.0.2.ip6.arpa.  IN  NS  ns1.nicolas-benedettigonzalez.sasm.uclllabs.be.`
I update the serial number of the zone file and restart bind with systemctl.
 
