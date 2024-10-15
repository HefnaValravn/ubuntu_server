# APT
- For apt, I first installed unattended-upgrades through `apt install unattended-upgrades`.
- I then manually configured the /etc/apt/apt.conf.d/50unattended-upgrades file to allow all origins:
	- normal packages (distro id + distro codename)
	- security updates (`-security`)
	- extended security maintenance for Ubuntu apps (`{distro_id}:ESMApps:${distro_codename}-apps-security`)
	- extended security maintenance for infrastructure packages (`${distro_id}ESM:${distro_codename}-infra-security`)
	- updates (`-updates`)
	- packages under consideration for future releases (`-proposed`)
	- newest packages reconfigured for older versions of ubuntu (`-backports`)


- Then, in the 20-auto-upgrades file under the same directory, I set a few parameters:
	- update package lists to 1
	- unattended upgrade to 1
	- download upgradeable packages to 1
	- autoclean interval to 7 (clean unused or unneeded packages after 7 days)
