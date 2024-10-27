
For this exercise, I first need to install NTP with `apt install ntp`.

- Optionally, you can also set the timezone with `timedatectl set-timezone (timezone)`


Then, I can modify the file under `/etc/ntpsec/ntp.conf` and add the following lines:


- `pool be.pool.ntp.org` to synchronize my timezone with the given server, along with
consecutive lines to add the server's other ipv4 addresses (starting with 45, 109, 162, and 213)

- `discard minimum 1` in case my server is rate-limiting connections

- `restrict default ignore` to restrict all time queries by default

- `restrict be.pool.ntp.org nomodify` to allow the time server to query. I had to use the domain name for this
address instead of the ip address because, it being a pool, the ip address I get when using `nslookup` is different
every time.

- `restrict 193.191.177.12 nomodify notrap` and `restrict 2001:6a8:2880:a021::12 nomodify notrap` to allow yoda
queries

- `restrict 141.135.68.98 nomodify notrap` and `restrict 2a02:1811:2c1f:3b00:ba38:61ff:feea:b298 nomodify notrap`
to allow queries from one other server of my choice

- `restrict 127.0.0.1` to allow localhost

- `restrict ::1` for IPv6 localhost


And finally `systemctl restart ntp` to restart the ntp service, as well as `systemctl restart ntpsec` just in case.
