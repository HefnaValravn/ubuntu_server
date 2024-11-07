
For this exercise, I first install MySQL with `apt install mysql-server`. I can optionally secure it with `mysql_secure_installation`, but it's not necessary.


Once this is done, I can log in to the MySQL shell with the `sudo mysql -u root -p` command.

I then create a database called "check" and create a table within it called "log", with columns "id" 
(auto increment, for identification), "date" and "text". To ensure that, when check enters new rows in the table,
the string isn't longer than 50 characters, I set the "text" column to `VARCHAR(50)`.

I then create a "check" user that can log in only from yoda.uclllabs.be with the given password:
 
- `CREATE USER 'check'@'yoda.uclllabs.be' IDENTIFIED BY 'rDEetGxq82DCE';`

Just in case, I also create a user "check" that can connect to the database from localhost, so the php page works.


I then give him insert and select permissions with `GRANT` so he can enter the database and edit it. To apply this, I 
run `FLUSH PRIVILEGES;`.

To allow connections to the database from anywhere (although check is still the only user who can actually log in,
and only from either localhost or yoda.uclllabs.be!), I change the bind-address line in the "/etc/mysql/mysql.conf.d/mysql.cnf" file
from localhost to 0.0.0.0. This ensures that I can access the database from anywhere, while still maintaining the fact
that if you're not user check and you're not connecting from either localhost or yoda.uclllabs.be, you still won't have
access to the database.

I then insert dummy data in the "log" table until the database is between 80 and 100 rows long.

I create a webpage for the needed address (in my case, `nicolas-benedettigonzalez.sasm.uclllabs.be`) so I can access the mysql_check.php page.
I make sure to create a config file under /etc/apache2/sites-available called "normal.conf" with the right configuration for said address, and then place the mysql_check.php
page under the "/var/www/html/normal" directory.

Finally, I make a page `mysql_check.php` page in the default directory for my server that displays the last row
in the database (see "/var/www/html/normal/mysql_check.php"). To get php to work with mysql, I also install the `php-mysqli` package with apt.
