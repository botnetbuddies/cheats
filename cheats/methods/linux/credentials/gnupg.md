---
technique: GnuPG Credential Hunting
category: credentials
targets: Linux User Accounts
protocols: Local
remote_capable: false
tags: linux credentials gpg gnupg secrets
---

# GnuPG Credential Hunting

GnuPG credential hunting looks for private keys, keyrings, and encrypted files that can expose stored secrets when passphrases or agent access are available.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| User file access | Operator must read the target user's GnuPG directory or encrypted files |
| Key material | Decryption requires a private key, agent access, or passphrase |
| Useful encrypted data | Target must store recoverable secrets in encrypted files |

## Linux

### List secret keys

#sh #gpg #credentials

List secret keys in the current GnuPG home.

```sh title:"List GPG secret keys"
gpg --list-secret-keys
```
<!-- cheat -->

### List target key files

#sh #gpg #filesystem

List files in a target GnuPG home.

```sh title:"List target GnuPG files"
find "$gnupg_home" -type f 2>/dev/null
```
<!-- cheat
var gnupg_home
-->

### List keys from target home

#sh #gpg #credentials

List secret keys from a target GnuPG home.

```sh title:"List keys from target GnuPG home"
gpg --homedir "$gnupg_home" --list-secret-keys
```
<!-- cheat
var gnupg_home
-->

### Decrypt with target home

#sh #gpg #credentials

Decrypt a file using a target GnuPG home.

```sh title:"Decrypt file with target GnuPG home"
gpg --homedir "$gnupg_home" -d "$encrypted_file"
```
<!-- cheat
var gnupg_home
var encrypted_file
-->

### Find encrypted files

#sh #filesystem #credentials

Find common GnuPG encrypted files under a target home directory.

```sh title:"Find GPG encrypted files"
find "$home_dir" -type f -name '*.gpg' 2>/dev/null
```
<!-- cheat
var home_dir
-->

## Detection

Monitor access to user GnuPG homes, secret key export attempts, and decryption commands from unusual shells or accounts.
