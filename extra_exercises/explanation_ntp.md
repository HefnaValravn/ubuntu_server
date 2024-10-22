
For this exercise, I first need to install NTP with `apt install ntp`.

- Optionally, you can also set the timezone with `timedatectl set-timezone (timezone)`


Then, I can modify the file under `/etc/ntpsec/ntp.conf` and add the following lines:


- `server be.pool.ntp.org` to synchronize my timezone with the given server

- `discard minimum 1` in case my server is rate-limiting connections

- `restrict default ignore` to restrict all time queries by default

- `restrict yoda.uclllabs.be nomodify notrap` to allow yoda queries

- `restrict 127.0.0.1` to allow localhost

- `restrict ::1` for IPv6 localhost


And finally `systemctl restart ntp` to restart the ntp service
