---
technique: Linux Local Enumeration
category: recon
targets: Linux Workstation, Linux Server
protocols: Local
remote_capable: false
tags: linux recon local-enumeration users processes services sudo
---

# Linux Local Enumeration

Local enumeration establishes kernel, distribution, identity, sudo rights, processes, services, file permissions, and useful tooling before selecting a privilege escalation or credential access path.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Shell access | Commands run from any local or remote shell |
| User context | Most recon commands work as a low-privileged user |

## Linux

### Kernel version

#sh #system

Print the kernel version and architecture.

```sh title:"Print kernel version"
uname -a
```
<!-- cheat -->

### OS release

#sh #system

Print the distribution name and version.

```sh title:"Print OS release"
cat /etc/os-release
```
<!-- cheat -->

### Current identity

#sh #users

Print current user, UID, GID, and group memberships.

```sh title:"Print current identity"
id
```
<!-- cheat -->

### Sudo rights

#sh #sudo

List commands the current user may run through sudo.

```sh title:"List sudo rights"
sudo -l
```
<!-- cheat -->

### Local users

#sh #users

List local user accounts.

```sh title:"List local users"
cat /etc/passwd
```
<!-- cheat -->

### Logged-on users

#sh #sessions

Show active user sessions.

```sh title:"Show active user sessions"
who
```
<!-- cheat -->

### Processes

#sh #processes

List running processes with full command lines.

```sh title:"List running processes"
ps auxww
```
<!-- cheat -->

### Systemd services

#sh #services

List systemd service units and states.

```sh title:"List systemd services"
systemctl list-units --type=service
```
<!-- cheat -->

### SUID files

#sh #suid

Find root-owned SUID binaries.

```sh title:"Find root-owned SUID files"
find / -perm -4000 -user root -type f 2>/dev/null
```
<!-- cheat -->

### Linux capabilities

#sh #capabilities

List files with Linux capabilities.

```sh title:"List files with capabilities"
getcap -r / 2>/dev/null
```
<!-- cheat -->

### Writable directories

#sh #files

Find world-writable directories outside procfs.

```sh title:"Find world-writable directories"
find / -writable -type d ! -path "/proc/*" 2>/dev/null
```
<!-- cheat -->

### Cron files

#sh #cron

List common system cron locations.

```sh title:"List system cron locations"
ls -la /etc/crontab /etc/cron.d /etc/cron.daily /etc/cron.hourly /etc/cron.weekly /etc/cron.monthly 2>/dev/null
```
<!-- cheat -->

### Operator tools

#sh #tools

Check whether common operator tools are installed.

```sh title:"Check common operator tools"
which curl wget nc netcat nmap python python3 perl ruby gcc socat openssl 2>/dev/null
```
<!-- cheat -->

## Detection

Recon bursts often show broad filesystem walks, sudo policy reads, process listing, and service inventory from an unusual account.
