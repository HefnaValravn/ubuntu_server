
For this exercise, I first install MySQL with `apt install mysql-server`. I can optionally secure it with `mysql_secure_installation`, but it's not necessary.


Once this is done, I can log in to the MySQL shell with the `sudo mysql -u root -p` command.

I then create a database called "check" and create a table within it called "log", with columns "id" 
(auto increment, for identification), "date" and "text". To ensure that, when check enters new rows in the table,
the string isn't longer than 50 characters, I set the "text" column to `VARCHAR(50)`.

I then create a "check" user that can log in only from yoda.uclllabs.be with the given password:
 
- `CREATE USER 'check'@'yoda.uclllabs.be' IDENTIFIED BY 'rDEetGxq82DCE';`


I then give him insert and select permissions with `GRANT` so he can enter the database and edit it. To apply this, I 
run `FLUSH PRIVILEGES;`.


I then insert dummy data in the "log" table until the database is between 80 and 100 rows long.



Finally, I make a page `mysql_check.php` page in the default directory for my server that displays the last row
in the database.
