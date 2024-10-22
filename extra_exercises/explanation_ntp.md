
For this exercise, I first need to install NTP with `apt install ntp`.

- Optionally, you can also set the timezone with `timedatectl set-timezone (timezone)`


Then, I can modify the file under `/etc/ntpsec/ntp.conf` and add the following lines:


- `server be.pool.ntp.org` to synchronize my timezone with the given server, along with
consecutive lines to add the server's other ipv4 addresses (starting with 45, 109, 162, and 213)

- `discard minimum 1` in case my server is rate-limiting connections

- `restrict default kod nomodify notrap nopeer noquery` to restrict all time queries by default

- `restrict 193.191.177.12 nomodify notrap` and `restrict 2001:6a8:2880:a021::12 nomodify notrap` to allow yoda
queries

- `restrict 141.135.68.98 nomodify notrap` and `restrict 2a02:1811:2c1f:3b00:ba38:61ff:feea:b298 nomodify notrap`
to allow queries from one other server of my choice

- `restrict 127.0.0.1` to allow localhost

- `restrict ::1` for IPv6 localhost


And finally `systemctl restart ntp` to restart the ntp service.


At this point in the exercise, ntp still wasn't working, so I tried an alternative approach by using iptables.

I used the following commands while keeping the `/etc/ntpsec/ntp.conf` file intact:


- `iptables -A INPUT -p tcp --dport 22345 -j ACCEPT` to allow ssh

- then, `iptables -P INPUT DROP` to block any incoming queries (the first time I executed this command I
didn't allow ssh beforehand so I had to go allow input from the server console on Proxmox)


- `sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT` to allow established connections

- `sudo iptables -A INPUT -p udp --dport 22345 -s 193.191.177.12 -j ACCEPT` to allow yoda ipv4
- `sudo iptables -A INPUT -p udp --dport 22345 -s 141.135.68.98 -j ACCEPT` to allow one other server of my choice ipv4
- `sudo iptables -A INPUT -p udp --dport 22345 -s 2001:6a8:2880:a021::12 -j ACCEPT` to allow yoda ipv6
- `sudo iptables -A INPUT -p udp --dport 22345 -s 2a02:1811:2c1f:3b00:ba38:61ff:feea:b298 -j ACCEPT` to allow the other server's ipv6


- `sudo iptables -A INPUT -p udp --dport 22345 -s 127.0.0.1 -j ACCEPT` to allow localhost ipv4
- `sudo iptables -A INPUT -p udp --dport 22345 -s ::1 -j ACCEPT` to allow localhost ipv6


Finally, I saved all these changes with `sudo iptables-save | sudo tee /etc/iptables/rules.v4`
