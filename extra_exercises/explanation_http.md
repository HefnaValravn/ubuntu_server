
For this exercise, I will firstly install apache with `apt install apache2`.


Then, once installed, I can enable it and start it with `systemctl enable apache2` and `systemctl start apache2`.


I will then edit and configure the default webpage by editing the `/etc/apache2/sites-available/000-default.conf` file.

- I create a basic webpage under the root directory I specified previously (for example, `/var/www/html/default/`) and make sure the text "Welcome" is displayed in it.

- I make sure to handle undefined hosts with the appropriate Error Logs and other methods in the .conf file

- I then restart apache to apply changes with `systemctl restart apache2`.



Once this is done, I create virtual hosts for www1 and www2, by making a configuration file for each under the same directory as the default page.

- I make sure that the www1 page displays www1, whereas the www2 page displays whatever string it is given but in uppercase through `strtoupper`.

I then enable both virtual hosts with `a2ensite www1.conf` and `a2ensite www2.conf`. Then I reload apache2.


Next, I password protect the /private subdirectory of www1 by making a .htaccess file under `/www1/private/` and configuring it to use a .htpassword file under /etc/apache2 that I then create
with `htpasswd -c /etc/apache2/.htpasswd check`.

I ensure that Apache allows .htaccess overrides by changing the configuration in the www1.conf file to include `AllowOverride AuthConfig`. I then reload apache.


That is the first part of the assignment.
