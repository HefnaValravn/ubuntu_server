
Wow, I didn't think I'd get this exercise so quickly.

Basically, there is a directory on yoda (https://yoda.uclllabs.be/mystery2) where there are a few .gif files,
one for each student.
If you try to open your own, it fails, so what I tried to do instead is to curl the address and save it to
a file. Doing so, I discovered that it was a .gz file, so I extracted it with `gzip -d`.

The resulting file looked like it was a Linux ext2 filesystem data file, containing recuperable files inside.
To recover said files, I used `photorec`, which allows me to enter the os image and recover any files contained
within.

Once this was done, I found that there was a new directory, "recup_dir1", which contained a 7z file called
f0000920.
I extracted the file with `7z x (file)` to find the content was a text file containing instructions on setting
up a vhost, and configuring it to display a certain string on it.

Therefore, I created a configuration file under "/etc/apache2/sites-available", created the directory specified
in this file under "/var/www/html/", added an index page with the code specified in the extracted file,
then added an A record for "mystery2" to my main zone file.

Finally, I updated the serial, restarted bind9, enabled the site with `a2ensite` and restarted apache2.
I then tested that I could access the mystery2 vhost with curl and that I would get the right string when
accessing the page.
