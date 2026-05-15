---
technique: Linux Local Credential Dumping
category: credentials
targets: Linux Local Secrets
protocols: Local
remote_capable: false
tags: linux credentials shadow passwd gpg keyring memory
---

# Linux Local Credential Dumping

Linux local dumping collects password hashes, keyrings, browser data, GPG material, and process memory that may contain plaintext secrets.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Root access | `/etc/shadow`, process memory, and other users' secrets usually require root |
| User context | Current-user browser and GPG material may be readable without root |

## Linux

### passwd file

#sh #passwd

Read local account metadata.

```sh title:"Read passwd file"
cat /etc/passwd
```
<!-- cheat -->

### shadow file

#sh #shadow

Read local password hashes.

```sh title:"Read shadow file"
cat /etc/shadow
```
<!-- cheat -->

### Unshadow hashes

#sh #john

Combine passwd and shadow files for cracking.

```sh title:"Create unshadow hash file"
unshadow /etc/passwd /etc/shadow > "$hash_file"
```
<!-- cheat
var hash_file
-->

### GPG secret keys

#sh #gpg

List GPG secret keys for the current user.

```sh title:"List GPG secret keys"
gpg --list-secret-keys --keyid-format LONG
```
<!-- cheat -->

### GNOME keyrings

#sh #keyring

List GNOME Keyring files.

```sh title:"List GNOME keyring files"
ls -la ~/.local/share/keyrings
```
<!-- cheat -->

### Firefox profiles

#sh #browser

List Firefox profiles for the current user.

```sh title:"List Firefox profiles"
ls -la ~/.mozilla/firefox
```
<!-- cheat -->

### Chromium data

#sh #browser

List Chromium local data.

```sh title:"List Chromium data"
ls -la ~/.config/chromium
```
<!-- cheat -->

### Process memory strings

#sh #memory

Search a process memory file for common secret words.

```sh title:"Search process memory for secrets"
grep -a -i -e password -e passwd -e secret "/proc/$pid/mem" 2>/dev/null
```
<!-- cheat
var pid
-->

## Detection

Alert on reads of `/etc/shadow`, browser credential stores, keyring files, and process memory by nonstandard tools.
