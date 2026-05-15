---
technique: SysV Init Persistence
category: persistence
targets: Linux SysVinit, Linux Upstart
protocols: Local
remote_capable: false
tags: linux persistence init initd service rc
---

# SysV Init Persistence

SysV init persistence installs or modifies startup scripts that run during service start or boot on systems that still honor `/etc/init.d` and rc directories.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Root access | Required to write service scripts and rc links |
| Init compatibility | Target must run or support SysVinit compatibility |
| Prepared script | Keep payload logic in a staged script or tool note |

## Linux

### List init scripts

#sh #init #recon

List SysV init scripts.

```sh title:"List init scripts"
ls -la /etc/init.d
```
<!-- cheat -->

### List rc links

#sh #init #recon

List runlevel startup links.

```sh title:"List rc startup links"
ls -la /etc/rc*.d
```
<!-- cheat -->

### Check service script

#sh #init #filesystem

Check permissions on an init script.

```sh title:"Check init script permissions"
ls -la "$init_script"
```
<!-- cheat
var init_script
-->

### Step 1: Install init script

#sh #init #persistence

Copy a prepared init script into `/etc/init.d`.

```sh title:"Install init script"
cp "$script_path" "/etc/init.d/$service_name"
```
<!-- cheat
var script_path
var service_name
-->

### Step 2: Make init script executable

#sh #init #persistence

Make the installed init script executable.

```sh title:"Make init script executable"
chmod 755 "/etc/init.d/$service_name"
```
<!-- cheat
var service_name
-->

### Step 3: Register init script

#sh #init #persistence

Register the init script for default runlevels on Debian-family systems.

```sh title:"Register init script"
update-rc.d "$service_name" defaults
```
<!-- cheat
var service_name
-->

### Step 4: Start init service

#sh #init #persistence

Start the installed init service.

```sh title:"Start init service"
service "$service_name" start
```
<!-- cheat
var service_name
-->

## Detection

Monitor writes under `/etc/init.d`, new rc links, and legacy service starts on systemd hosts.
