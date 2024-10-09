I'm not sure that the commit message I set for most of my commits so far were descriptive enough, so just in case, here are the explanations for the exercises done so far:


- LOCALE: I just modified the /etc/default/locale file to suit my needs.

- SUDO: I added the user "check" to the sudoers group with the "sudo usermod -aG sudo check" command. Then I opened the sudoers file (using sudo visudo) and added a few commands to allow the check user to execute a few commands as sudo without password verification. ("check ALL(ALL) NOPASSWD: /usr/lib/nagios/plugins/check_apt", "check ALL=(ALL) NOPASSWD: /usr/sbin/arp")


- APT: I set up unattended-upgrades so that any new upgrades are automatically installed without me having to do it manually.
