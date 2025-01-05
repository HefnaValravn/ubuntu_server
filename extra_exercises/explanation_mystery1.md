For this exercise... well, I first have to find out what the exercise is about.
To do this, I use tshark to sniff out packages coming from yoda and then query the mystery1 exercise to make the
packages come through. (`tshark -nli eth0 -f "not tcp port 22345" -s0 -w -`)
Once this is done, I can inspect the captured packages with `tshark -r` and filter using yoda's ipv6 or ipv4.

When I do this, I can observe that yoda is trying to access my server through TCP on port 21, which means it's trying
to access an FTP server.

Therefore, I install vsftpd and configure it so yoda can access it and perform operations on it:
- I configure "vsftpd.conf" under /etc so that local users can log in, and so that users accessing the FTP server can
use write operations. I also specify the `local_root`, which is where yoda will then go to do its operations in.
I create a file called "vsftpd.userlist" under /etc and then configure `userlist_enable=YES` and `userlist_file` to
the location of the file, so that any users in that file can access the FTP server. (Important: `userlist_deny` should
be set to NO to allow, and not deny, whatever users are in the userlist file to access the server)

I enable passive mode as it simplifies access for users, and define a list of ports on which users can log in
passively.

I then make sure that ports 21, and 50000 through 51000 are available for the FTP server to work properly by using
iptables.

Next, I create a user "mystery1_2014", the name of which I derived from the login attempts found in the
"/var/log/vsftpd.log" log file.

To figure out which password this user needs, I simply sniffed out with tshark the login attempt from yoda, the same
way I did to find out I had to set up a FTP server in the first place.

Then, to allow users to log in to my FTP server with these credentials that yoda has provided me with, I modified the
"vsftpd" file under "/etc/pam.d" to fulfill the following:
- the authentication method used should be `pam_unix.so`, which means users can use the actual server user
"mystery1_2014" to log in to the server.

I first tried to configure pam using a .db file, but I wasn't able to actually populate it with a username and a 
hashed password, so I resorted to creating a system user instead and using pam_unix.so.

Finally, I restarted vsftpd and tested that I could log in both with `ftp localhost` and from my own machine by using
my server's IP address. I also checked that my pam configuration was correct by using the `pamtester` utility.

I checked the log after querying the assignment, and found out yoda was trying to interact with a .jpg file located
in the root directory specified in the "vsftpd.conf" file. This file didn't exist, so I created it and gave it proper
permissions.
