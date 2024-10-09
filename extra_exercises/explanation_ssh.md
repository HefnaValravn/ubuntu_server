To change which port the server is listening to, I uncommented the line on the sshd_config file under etc/ssh and changed the port from 22 to 22345.

I disabled reverse DNS lookup by also uncommenting the noDNS line in the same file and setting it to "no".

While I was there, I also uncommented the SSH related lines, namely "AuthorizedKeysFile" (to provide an ssh key file for ssh login) and also the "allow password login" line in case ssh were to fail at some point.

To get SSH to work, I also disabled ssh.socket, which was the faster of the two options.

Once that was done, I created a user check:
useradd -m check

And added his public key in the authorized_keys file under /root/.ssh so he could log in with the provided public key.
While I was there, I also added a newly generated ssh key from my laptop, so I could connect as root without being asked for a password. (valravn@valravn)
I did so by using the ssh-copy-id from my machine; I entered my server password when prompted, and that finally allows me to log in as root without the need for a password.

I then reloaded the daemon and the ssh and sshd services.
