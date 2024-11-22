
For this exercise, I will first install the necessary packages (`dovecot-imapd`) with apt. This
was preemptively installed in the SMTP lab.


Then, I'll make sure to have the following requisites in the "/etc/dovecot/conf.d/10-ssl.conf" and 
"/etc/dovecot/dovecot.conf files:

- The protocols line should include imap
- SSL should be required
- I should specify my ssl certificate and key files
When specifying the SSL certificate and key, it's very important to put a "<" before the file
location to indicate that the key and certificate are within the file, not the file itself.

I will also edit the "10-mail.conf" file to specify the location of my virtual users' mail.


Next, I will edit the "10-auth.conf" file to ensure that plaintext authentication is disabled, among
other things.

Then, I also make sure I have a user "user1" configured with a password in the users file. This was done
for the SMTP lab.
Also done in the previous lab: I configure the "auth-passwdfile.conf.ext" file under "conf.d" to make sure
it uses the password file "users".

Finally, I make sure the "10-master.conf" file includes the right listener (imaps) and the right port
and SSL configuration.

Then I restart dovecot.


# INVESTIGATION PART

For the next part, I need to find out what user1's password is.
To accomplish this, I first install wireshark + tshark and stunnel4, and configure stunnel with the 
right input port (993) and output port (143). This means that stunnel will take traffic from 993 
and forward it to port 143. 

I then configure dovecot so it doesn't run on port 993 anymore (stunnel
will be using that port instead) and it accepts plaintext connections over port 143 instead; 
this basically means that I put an intermediary between yoda and dovecot (stunnel) so I can
temporarily receive unencrypted traffic to extract the password.

Once this is done, I can run the command `sudo tshark -i lo -f "port 143"`, which will capture
all incoming traffic on port 143. 

From there, whenever yoda tries to access my server, I can see
what password it's trying to access it with; once I find out what that password is, I can
generate a hash of it with `doveadm pw -s SHA256-CRYPT` and put it in the "users" file under
"/etc/dovecot". 

I can also optionally check that the password I just configured works by running
`doveadm auth test user1@nicolas-benedettigonzalez.sasm.uclllabs.be` and entering the password
I extracted from tshark.
