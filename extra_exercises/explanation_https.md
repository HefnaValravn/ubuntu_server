

# PREREQUISITES

For this exercise, I first need to install certbot via apt, as well as the `python3-certbot-apache` plugin so I can
use certbot with Apache.


Then, I will install acme by using `curl https://get.acme.sh | sh` and `source ~/.bashrc`. I will also set the
default CA to be Let's Encrypt Production.

I will then configure dns_nsupdate with the right variables, like the nsupdate server, zone and key. I will add
these variables to my .bashrc file and source it.


Next, after generating a tsig keypair and configuring it properly in the "named.conf.local" file under "/etc/bind", I will add a dummy 
TXT record for each zone I need (my main zone, secure. and supersecure.) in my main zone file and then generate the certificates for 
my domains: my normal address, my secure address, and my supersecure address by using acme.sh. This command will give me a "challenge", 
or a value for the TXT record that is in my zone file.
Once I add it and rerun the command, this will generate the certificates under /root/.acme.sh.
I will then install said certificates by specifying the certificates that I just generated. All of this is done through the acme.sh command.




# VHOST CONFIG

As a next step, I need to configure the vhosts for my secure and supersecure addresses. I make sure to enable
automatic redirection to https, and to specify the header configuration on the supersecure vhost. I also specify the fullchain
and key files that I generated earlier with acme in the .conf file under /etc/apache2/sites-available. I reload apache just
in case.

I then enable the pages with `a2enmod ssl headers rewrite` and `a2ensite` before reloading apache.



# CRONTAB

I will then create a cronjob that renews my certificates automatically once a month, by also using the acme.sh
command.



# CAA RECORDS

To ensure unauthorized CAs can't issue certificates for my domains, I will also configure a CAA record by adding
a CAA record to my parent zone, which my subzones can then automatically use. I can do this through my DNS zone
file.
