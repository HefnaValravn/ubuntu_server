To prevent ARP spoofing, the first thing I do is find my server's default gateway:

- `ip route | grep default` for the ip address

- `arp -n | grep 193.191.176.254` once I know my ip address for the mac address


Once this is done, I can add a static ARP entry for my default gateway, which prevents attackers from pretending to be my default gateway and thus averting a man-in-the-middle attack:

- `sudo arp -s 193.191.176.254 ca:fe:c0:ff:ee:00 -i eth0`

This command works every time you execute it, but to make it persistent, you need to add it 
to the `/etc/network/if-up.d/` folder in the form of a script. (Also making sure to make the script executable
with `sudo chmod +x (script name)`)
Putting the script in this folder also ensures that the script is executed when the network is restarted,
the RJ45 plug is reseated, or other scenarios.

That's the first part of the assignment. 

Secondly, the check user should be able to execute two specific commands, and no others.
To achieve this, we can use the `sudo visudo` command to open the sudoers file.

Once in the sudoers file, we can add the following two lines:


- `check ALL=(ALL) NOPASSWD: /usr/sbin/ip link set dev eth0 up`
- `check ALL=(ALL) NOPASSWD: /usr/sbin/ip link set dev eth0 down`

These ensure that the user check can execute these two commands as sudo without being prompted for a password,
and ONLY these two specific commands.

