#!/bin/bash
#
## Find all directories in /etc, excluding .git and incron.d directories
#
find /etc -type d ! -regex '.*/\.git.*' ! -name 'incron.d' -print0 | while IFS= read -r -d '' dir; do
	# Create an incron rule for each directory found
	echo "$dir IN_CLOSE_WRITE,recursive=false /etc/scripts/backup.sh \$@/\$#" >> /etc/incron.d/etc.conf
done

#Restart the incron service to apply changes
systemctl restart incron
        
