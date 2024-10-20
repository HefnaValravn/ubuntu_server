I'm not sure that the commit message I set for most of my commits so far were descriptive enough, so just in case, here are the explanations for the exercises done so far:

- GIT: For git, I created a repository under /etc and created commits every time I make changes. I back these
changes up to a remote repo (private repo). I also added 5 commits that symbolize my progress for this first
deadline under /root/commits

- LOCALE: I just modified the /etc/default/locale file to suit my needs, then applied the configuration by running `sudo locale-gen` and `sudo update-locale`.

- SUDO: First I installed the required packages (`monitoring-plugins-basic` and `net-tools`). 
I added the user "check" to the sudoers group with the `sudo usermod -aG sudo check` command. This allows the check user to execute sudo commands. 
Then I opened the sudoers file (using `sudo visudo`) and added a few commands to allow the check user to execute a few commands as sudo without password verification. (`check ALL=(ALL) NOPASSWD: /usr/lib/nagios/plugins/check_apt`, `check ALL=(ALL) NOPASSWD: /usr/sbin/arp`)

