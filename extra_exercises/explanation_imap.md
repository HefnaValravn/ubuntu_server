
For this exercise, I will first install the necessary packages (`dovecot-imapd`) with apt. This
was preemptively installed in the SMTP lab.


Then, I'll make sure to have the following requisites in the "/etc/dovecot/conf.d/10-ssl.conf" and 
"/etc/dovecot/dovecot.conf files:

- The protocols line should include imap
- SSL should be required
- I should specify my ssl certificate and key files


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

(I can also temporarily enable password mismatching logging by adding the line `auth_verbose = yes` to the 
"10-logging.conf" file.
