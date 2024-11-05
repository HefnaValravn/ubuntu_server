
For this exercise, I will firstly install apache with `apt install apache2`.


Then, once installed, I can enable it and start it with `systemctl enable apache2` and `systemctl start apache2`.


I will then edit and configure the default webpage by editing the `/etc/apache2/sites-available/000-default.conf` file, and making sure that I DO NOT add a `ServerAlias *` line as that would capture all traffic from other webpages as well.

- I create a basic webpage under the root directory I specified previously (for example, `/var/www/html/default/`) and make sure the text "Welcome" is displayed in it.

- I make sure to handle undefined hosts with the appropriate Error Logs and other methods in the .conf file

- I then restart apache to apply changes with `systemctl restart apache2`.



Once this is done, I create virtual hosts for www1 and www2, by making a configuration file for each under the same directory as the default page.

- I make sure that the www1 page displays www1, whereas the www2 page displays whatever string it is given but in uppercase through `strtoupper`.

I then enable both virtual hosts with `a2ensite www1.conf` and `a2ensite www2.conf`. Then I reload apache2.


Next, I password protect the /private subdirectory of www1 by making a .htaccess file under `/www1/private/` and configuring it to use a .htpassword file under /etc/apache2 that I then create
with `htpasswd -c /etc/apache2/.htpasswd check`.

I ensure that Apache allows .htaccess overrides by changing the configuration in the www1.conf file to include `AllowOverride AuthConfig`. I then reload apache.

Most importantly, I add A type DNS records for all subzones (www1 and www2) in the `/var/lib/bind/nicolas-benedettigonzalez.sasm.uclllabs.be.db` file.


When testing the www2. subzone, I realized I was missing a package, which I could install with `apt install libapache2-mod-php`. This mod for apache allows me to use php.

That is the first part of the assignment.


# SCRIPTING PART

For the scripting part of this assignment, I first create a script `http_add_vhost` that creates the DocumentRoot directory for the vhost, configures vhost specific logging, and creates a default html page with the name of the vhost in it.
It also refuses to create a vhost for a non-existing domain. This script is also found under `/etc/scripts`.

I then create a cleanup script, `http_cleanup`, that removes any vhosts that are older than 4 hours from my machine.
It also removes the A record from the parent zone file (nicolas-benedettigonzalez.sasm.uclllabs.be).
