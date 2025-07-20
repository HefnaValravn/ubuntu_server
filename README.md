# Ubuntu Server Deployment and Configuration

This repository documents the setup, deployment, and configuration of a fully featured Ubuntu server, built as part of a hands-on, multi-part assignment and learning experience. It includes everything from basic system configuration to deploying and troubleshooting advanced services like Docker containers, web hosting, email, DNS, and more.

## Table of Contents

- [Overview](#overview)
- [Features & Services](#features--services)
  - [1. Web Hosting (HTTP/HTTPS)](#1-web-hosting-httphttps)
  - [2. DNS Server](#2-dns-server)
  - [3. Mail Server (SMTP/IMAP)](#3-mail-server-smtpimap)
  - [4. Database Server](#4-database-server)
  - [5. Docker Deployments](#5-docker-deployments)
  - [6. Ansible Automation](#6-ansible-automation)
  - [7. FTP Server (Mystery 1)](#7-ftp-server-mystery-1)
  - [8. Forensics & Network Analysis (Mysteries)](#8-forensics--network-analysis-mysteries)
  - [9. RADIUS Authentication](#9-radius-authentication)
  - [10. IPv6 Networking & Certification](#10-ipv6-networking--certification)
  - [11. Backup Automation](#11-backup-automation)
  - [12. NTP Server Configuration](#12-ntp-server-configuration)
  - [13. ARP Configuration & Scripts](#13-arp-configuration--scripts)
  - [14. Miscellaneous Enhancements](#14-miscellaneous-enhancements)
- [Structure](#structure)
- [Notes](#notes)

---

## Overview

This server was set up from a bare Ubuntu installation, with functionality gradually added through scripting, automation tools, manual configuration, and problem-solving based on real-world use cases. It demonstrates expertise in systems administration, networking, security, automation, and troubleshooting.

---

## Features & Services

### 1. Web Hosting (HTTP/HTTPS)

- Configured Apache2 with multiple virtual hosts (`www`, `www1`, `www2`)
- Added password protection to restricted directories
- Enabled SSL/TLS using Let's Encrypt (certbot)
- Created scripts to add/remove virtual hosts dynamically
- Configured headers, redirects, and rewrites for secure communication
- Enabled IPv6 support for all hosted services

### 2. DNS Server

- Deployed BIND9 for authoritative DNS hosting
- Created scripts to add zones and records (A, MX, CNAME)
- Dynamically updated SOA serials
- Used `systemctl` and `rndc` for reliable DNS reloading
- Supported reverse DNS and zone file cleanup automation
- Enabled DNS over IPv6
- Ensured `check` user could securely interact with DNS tools

### 3. Mail Server (SMTP/IMAP)

- Installed and configured Postfix and Dovecot
- Added support for virtual mailboxes
- Integrated stunnel for secure IMAP
- Extracted credentials using Wireshark and SSL termination
- Whitelisted addresses and configured mail logs
- Fixed permissions and resolved delivery/auth issues

### 4. Database Server

- Installed and configured MySQL
- Set `bind-address` for remote connections
- Created a PHP interface to display DB content
- Implemented row control logic (max/min bounds)
- Enabled DB interaction over HTTP

### 5. Docker Deployments

- Developed a custom `Dockerfile` for Nginx
- Used `docker-compose` to manage containers
- Hosted web content on port 8080
- Pushed Nginx image to DockerHub (public repo: `docker_sasm`)
- Placed all files under `/etc/docker-exercise`

### 6. Ansible Automation

- Wrote Ansible playbooks for:
  - HTTP/HTTPS configuration
  - Virtual host setup
  - Inventory and environment management

### 7. FTP Server (Mystery 1)

- Deployed and configured `vsftpd`
- Used virtual users and PAM authentication
- Setup control socket on port 21
- Debugged server response with `tshark`

### 8. Forensics & Network Analysis (Mysteries)

- Mystery 1: Recovered server files, analyzed traffic, deployed FTP
- Mystery 2: Extracted and analyzed .gz -> Linux image -> 7z -> text file
  - Set up custom vhost and DNS for code display on `mystery2`

### 9. RADIUS Authentication

- Installed and configured FreeRADIUS
- Customized logging for specific users
- Enabled control socket and conditional logging in `radiusd.conf`

### 10. IPv6 Networking & Certification

- Completed Hurricane Electric (HE) IPv6 certification
- Configured IPv6 DNS zones and Apache support
- Verified all services (HTTP, SMTP, DNS, IMAP) on IPv6
- Used local tunneling to forward browser traffic
- Added Postfix IPv6 whitelist entries

### 11. Backup Automation

- Used `rsync` for local/offline backups
- Created backup explanation and scripts
- Scheduled jobs and added backup paths to `.gitignore`

### 12. NTP Server Configuration

- Installed and configured `ntpsec`
- Opened firewall ports using `iptables`
- Whitelisted servers and clients
- Documented changes under `/etc/extra_exercises`

### 13. ARP Configuration & Scripts

- Deployed static ARP entries on interface up
- Added dispatcher scripts to handle ARP inconsistencies
- Created systemd service to ensure link reset handling

### 14. Miscellaneous Enhancements

- Added secure SSH setup with `sshguard`, whitelist, and hardening
- Installed and configured Neovim, aliases, environment variables
- Used `sudoers` for restricted command access (e.g., check user)
- Automated package upgrades with `unattended-upgrades`
- Cleaned up with `.gitignore`, improved explanations and structure
