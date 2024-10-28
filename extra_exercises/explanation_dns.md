
First, I need to install bind and all its utilities with `apt install bind9 bind9utils bind9-doc`.

Once that's done, I can configure the primary zone (authoritative zone) of my dns server by editing the file
under `/etc/bind/named.conf.local`.

- Here, I can specify the name of my zone, the type, the .db file, and add the IPs of `ns1.uclllabs.be` and
`ns2.uclllabs.be` to be added as slaves.


Then, I create the .db file under the `/var/lib/bind` directory, where I can define things like the
serial, refresh, retry, expire, and minimum TTL (for ipv6) parameters. Additionally, I can also define the slave
domain names in this file, as well as my own domain name. Finally, in this file I define the ns., www., and
test. zones for my dns server, and what IP they should return.

Afterwards, I ensure the permissions are correct through AppArmor, by editing the file under
`/etc/apparmor.d/usr.sbin.named`:

- `/etc/bind/** r`
- `/var/lib/bind/** rw`
- `/var/lib/bind/ rw`
- `/var/cache/bind/** lrw`
- `/var/cache/bind/ rw`


Then I restart AppArmor just in case.

Finally, I check that my server configuration is okay with the `named-checkconf` and `named-checkzone nicolas-benedettigonzalez.sasm.uclllabs.be /var/lib/bind/nicolas-benedettigonzalez.sasm.uclllabs.be.db` commands.

(END OF FIRST PART)
