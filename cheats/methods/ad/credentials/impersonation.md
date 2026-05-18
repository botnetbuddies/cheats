---
technique: CredentialImpersonation
category: credential-access
targets: Domain Users, Services
protocols: LDAP, SMB, Kerberos, NTLM
remote_capable: true
tags: impersonation runas powershell credentials ldap ad
---

# CredentialImpersonation

Credential impersonation uses plaintext passwords or credential objects to run commands and remote operations as another domain identity. Use hash and ticket material with pass-the-hash, pass-the-key, or pass-the-ticket notes instead.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Plaintext password | `runas` and PowerShell credential objects need a password |
| Interactive prompt | Native `runas` does not accept the password as a command argument |
| Remote check | Local `whoami` only shows the local token, not remote LDAP authentication context |

## Windows

### runas netonly

#cmd #native #netonly

Start a process whose supplied credentials apply to remote network access only.

```cmd title:"Start netonly process with domain credentials"
runas /netonly /user:$domain\$user "powershell.exe"
```
<!-- cheat
import domain_ip
import users
-->

### PowerShell prompted credential

#powershell #credential

Create a PowerShell credential object through an interactive prompt.

```powershell title:"Create prompted PowerShell credential object"
$credential = Get-Credential
```
<!-- cheat -->

### PowerShell secure password

#powershell #credential

Create a secure string from a plaintext password for a credential object.

```powershell title:"Create secure string password"
$secure_password = ConvertTo-SecureString "$pass" -AsPlainText -Force
```
<!-- cheat
import passwords
-->

### PowerShell credential object

#powershell #credential

Create a PowerShell credential object for a domain user.

```powershell title:"Create PowerShell credential object"
$credential = New-Object System.Management.Automation.PSCredential("$domain\$user", $secure_password)
```
<!-- cheat
import domain_ip
import users
var secure_password := $secure_password
-->

### PowerShell start process

#powershell #credential

Start a process with a PowerShell credential object.

```powershell title:"Start process with alternate credentials"
Start-Process "$process" -Credential $credential
```
<!-- cheat
var process
var credential := $credential
-->

### PowerView credentialed Set-DomainObject

#powershell #powerview #ldap

Run a PowerView LDAP write using an explicit credential object.

```powershell title:"Run PowerView Set-DomainObject with credentials"
Set-DomainObject -Credential $credential -Domain "$domain" -Server "$dc_fqdn" -Identity "$target_user" -Set @{serviceprincipalname="$spn"}
```
<!-- cheat
import domain_ip
var dc_fqdn
var target_user
var spn
var credential := $credential
-->

### SharpLdapWhoami default

#powershell #ldap #verify

Check the current LDAP authentication context.

```powershell title:"Check LDAP identity with SharpLdapWhoami"
.\SharpLdapWhoami.exe
```
<!-- cheat -->

### SharpLdapWhoami Kerberos

#powershell #ldap #kerberos #verify

Check Kerberos LDAP authentication context and group details.

```powershell title:"Check Kerberos LDAP identity with SharpLdapWhoami"
.\SharpLdapWhoami.exe /method:kerberos /all
```
<!-- cheat -->
