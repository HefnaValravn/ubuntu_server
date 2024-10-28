# SERVER PART

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


I also access the file under `/etc/bind/named.conf.options` and modify it to allow queries from anyone and to
listen to all IP addresses, just in case.


Then I restart AppArmor just in case.

Finally, I check that my server configuration is okay with the `named-checkconf` and `named-checkzone nicolas-benedettigonzalez.sasm.uclllabs.be /var/lib/bind/nicolas-benedettigonzalez.sasm.uclllabs.be.db` commands.
I can also check that my configuration is proper with the dig command using the `@localhost` parameter for the
different zones of my server:

- dig @localhost (ns zone)

- dig @localhost (www zone)

- dig @localhost (test zone)


# SCRIPTING PART

For the scripting part of the DNS assignment, we first make sure the prerequisites are met:

- Proper permissions for the scripts folder (`chown root:root /etc/scripts` and `chmod 700 /etc/scripts`)

- Making sure the check user can run the scripts as sudo without being prompted for a password by editing the
sudoers file and adding the following line: `check ALL=(ALL) NOPASSWD: /etc/scripts/dns_add_zone, /etc/scripts/dns_add_record`

- Including the yoda zones config file in the `/etc/bind/named.conf.local` file and adding the appropriate files
to gitignore to avoid repo pollution:
	- `include "/etc/bind/named.conf.yoda-zones";`
	- In .gitignore: `/etc/bind/named.conf.yoda-zones` and `/var/lib/bind/yoda_zone_*`

Once this is done, we can get started with the scripts.

