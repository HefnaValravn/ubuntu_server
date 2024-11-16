
For this exercise, I first need to install the appropriate packages with apt: `postfix`, `dovecot-core`, `dovecot-imapd`
and `dovecot-lmtpd`.

Once this is done, I can proceed to configuring postfix by editing the file under `/etc/postfix/` and adding the
right configuration, like specifying the hostname, domain, relay settings, and other SMTP related settings to properly
configure my SMTP server.


Then, I edit the `virtual_mailbox` file under the same directory to create the "user1", "user2" and "check" users for
my mail server. I then generate the database with `postmap /etc/postfix/virtual_mailbox`.

I create a folder for each virtual user under /var/vmail/{username}, one folder for each user. I give the folder tree
the right permissions with `chown` and assigning the vmail folder to GID 5000.


Then, I set up Dovecot for LMTP and the virtual users I've created.
First, I edit the dovecot.conf file under "/etc/dovecot", and specify things like the protocols used (imap and lmtp), the mail uid and gid,
and the passdb and userdb drivers and args. For passdb, I make sure to specify the /etc/dovecot/users file. For userdb,
I make sure to specify a static driver, but for passdb, I use passwd-file (using the /etc/dovecot/users file).
I then modify the password configuration file to use the right hashing algorithm (like SHA512-CRYPT) and then make
a "users" file where I specify each user in the SMTP server with their respective password, which I previously
generate with `doveadm pw -s SHA512-CRYPT`. I have to modify a few settings in the conf.d folder under dovecot to specify
the encryption algorithm and user verification.

I then make sure there exists an MX (and therefore also an A) record in my DNS zone for my server.

Finally, I restart bind9, postfix, dovecot, and enable both postfix and dovecot so they run automatically.
