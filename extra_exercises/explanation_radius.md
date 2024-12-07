
For this exercise, I first installed freeradius with `apt install freeradius`.

Once that was done, I went and made sure the socket-control module under "/etc/freeradius/3.0/sites-available" is enabled by making a
symbolic link to the "sites-enabled" folder. I also make sure to reference the right user and group and setting the mode to read write
in its configuration file.

Then, I created a user "check" and assigned him the password "Ch3ck" by editing the "users" file and adding the following line:

- `check Cleartext-Password := "Ch3ck"`

Then, I open the "default" file under "/etc/freeradius/3.0/sites-available/" and add a condition block where if the username is "check",
then the control module is modified like so: `Tmp-String-0 := "%{debug:10}"`. This sets the level of logging to the maximum (1-10), but
only for user check.

Finally, I make sure that a few conditions are met in the radiusd.conf file, specifically in the log part:

- auth is switched to yes, so authentication attempts are logged

- both `auth_badpass` and `auth_goodpass` are set to yes, to log both good password attempts and bad ones.

I then restart freeradius and check that I can authenticate as user check with the command `radtest check Ch3ck localhost 0 testing123`.
