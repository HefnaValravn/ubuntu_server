
To configure the backup, I did multiple things:


First, I created a script "backup.sh" (/etc/scripts/backup.sh) that creates a copy of any file it receives under /var/backups/inotify:

- Making the directory with "mkdir -p /var/backups/inotify"

- Recreating the files in the new directory while preserving permissions and file structure with "cp -p --parents $1 /var/backups/inotify"

- Adding the date and time the backup was made by renaming the file with "mv"



Secondly, I made a script "incron_config.sh" (/etc/scripts/incron_config.sh) that creates the configuration for incron to work properly and passes all files that are changed (IN_CLOSE_WRITE) to the backup.sh script:
find /etc -type d ! -regex '.*/\.git.*' ! -name 'incron.d' -print0 | while IFS= read -r -d '' dir; do
	echo "$dir IN_CLOSE_WRITE,recursive=false /etc/scripts/backup.sh \$@/\$#" >> /etc/incron.d/etc.conf
done

This script also ignores any .git and incron.d files found in the directory, and restarts the incron service every time it's executed.


I then added this script to my crontab so it would run every 15 minutes (*/15).


Finally, I made a script "cleanup_yoda.sh" (/etc/scripts/cleanup_yoda.sh) which cleans up the /etc/yoda directory for checking the completion of this assignment:

- Find any files under /etc/yoda with one max subdirectory of depth: "find /etc/yoda/* -maxdepth 1"

- Only find files older than 240 minutes: "-mmin +240"

- Remove any found files: "-exec rm -rf {} \;"


And I also added this script to my crontab to be executed every hour (0 * * * *).


Additionally, I made a backup script on my local machine that, using SSH login to not require a password, backs up all my files in /etc to my local machine after 5 minutes every time I boot my laptop:

- Using the rsync command to delete any files in the selected directory that don't match the remote directory's files and create a new backup: 
rsync -avz --delete -e "ssh -p 22345 root@193.191.176.194" /home/valravn/server_backup

- Logging the backup to a file on my machine so I can monitor it better:

echo "Backup completed on $(date)" >> /home/valravn/server_backup_logs/backup.log


And finally added this script to the crontab on my own machine so it runs whenever I boot:

@reboot /etc/server_backup.sh
