# Ldap_queries

## ldap - enum - powershell

### List all groups

List all groups with Ldap_queries.

Dump every group object's name. Quick first pass when triaging an unfamiliar domain.

```sh title:"LDAP Queries List All Groups"
Get-ADObject -LDAPFilter '(objectClass=group)' | select name
```
<!-- cheat -->

### Disabled users (bitfield)

Find disabled users (bitfield) with Ldap_queries.

Find disabled users via the LDAP_MATCHING_RULE_BIT_AND on userAccountControl. The `=2` bit is ACCOUNTDISABLE.

```sh title:"LDAP Queries Find Disabled Users (bitfield)"
Get-ADObject -LDAPFilter '(&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=2))' -Properties * | select samaccountname,useraccountcontrol
```
<!-- cheat -->

### Disabled users (cmdlet)

Find disabled users (cmdlet) with Ldap_queries.

Same disabled-user list using the cmdlet's `Enabled` property instead of the LDAP filter.

```sh title:"LDAP Queries Find Disabled Users (cmdlet)"
Get-ADUser -Filter 'Enabled -eq $false'
```
<!-- cheat -->

### Count of users in domain

Enumerate count of users in domain with Ldap_queries.

Total user object count. Sanity check before sprays so you know how loud the operation will be.

```sh title:"LDAP Queries Enumerate Count of Users in Domain"
(Get-ADUser -Filter *).Count
```
<!-- cheat -->

### Count of computers in domain

Enumerate count of computers in domain with Ldap_queries.

Total computer object count. Includes DCs and stale machine accounts.

```sh title:"LDAP Queries Enumerate Count of Computers in Domain"
(Get-ADComputer -Filter *).Count
```
<!-- cheat -->

### Count of groups in domain

Enumerate count of groups in domain with Ldap_queries.

Total group object count.

```sh title:"LDAP Queries Enumerate Count of Groups in Domain"
(Get-ADGroup -Filter *).Count
```
<!-- cheat -->

### Privileged groups (adminCount=1)

Enumerate privileged groups (adminCount=1) with Ldap_queries.

Groups with `adminCount=1` are protected by AdminSDHolder, i.e. high-value privileged groups.

```sh title:"LDAP Queries Enumerate Privileged Groups (adminCount=1)"
Get-ADGroup -Filter "adminCount -eq 1" | select Name
```
<!-- cheat -->

### Privileged + ASREPRoastable

Enumerate privileged + ASREPRoastable with Ldap_queries.

Users that are both privileged (adminCount=1) and ASREPRoastable (DoesNotRequirePreAuth). Top-tier finding when present.

```sh title:"LDAP Queries Enumerate Privileged + ASREPRoastable"
Get-ADUser -Filter {adminCount -eq '1' -and DoesNotRequirePreAuth -eq 'True'}
```
<!-- cheat -->

### Privileged with SPN set

Set privileged with SPN set with Ldap_queries.

Privileged users carrying an SPN. Common when service accounts were dropped into Domain Admins; trivial Kerberoast win.

```sh title:"LDAP Queries Set Privileged with SPN Set"
Get-ADUser -Filter "adminCount -eq '1'" -Properties * | where servicePrincipalName -ne $null | select SamAccountName,MemberOf,ServicePrincipalName | fl
```
<!-- cheat -->

### ASREPRoastable users

Enumerate ASREPRoastable users with Ldap_queries.

All accounts with `DoesNotRequirePreAuth` set. Their AS-REP can be requested without creds and cracked offline.

```sh title:"LDAP Queries Enumerate ASREPRoastable Users"
Get-ADUser -Filter * -Properties DoesNotRequirePreAuth | Where-Object { $_.DoesNotRequirePreAuth -eq $true } | select Name,SamAccountName,DoesNotRequirePreAuth | fl
```
<!-- cheat -->

### SID of host

Enumerate SID of host with Ldap_queries.

Resolve a computer object's SID. Needed for ESC ticketer flows and SID-history attacks.

```sh title:"LDAP Queries Enumerate SID of Host"
(Get-ADComputer -Identity "$host").SID
```
<!-- cheat
var host
-->

### SPN holders in Protected Users

List SPN holders in protected users with Ldap_queries.

Find SPN-holding users who are also in Protected Users. They can't be Kerberoasted (RC4 disabled), so flag them out of the target list early.

```sh title:"LDAP Queries List SPN Holders in Protected Users"
$protectedGroup = Get-ADGroup -Identity "Protected Users"
$protectedMembers = Get-ADGroupMember -Identity $protectedGroup -Recursive
$protectedMembers | Where-Object {
    ($_ | Get-ADUser -Properties ServicePrincipalName).ServicePrincipalName -ne $null
} | Select-Object SamAccountName,ServicePrincipalName
```
<!-- cheat -->

### Disabled users (filter)

Enumerate disabled users (filter) with Ldap_queries.

Disabled users via raw LDAP filter, returning name only.

```sh title:"LDAP Queries Enumerate Disabled Users (filter)"
Get-ADUser -LDAPFilter '(userAccountControl:1.2.840.113556.1.4.803:=2)' | select name
```
<!-- cheat -->

### Recursive group membership

Enumerate recursive group membership with Ldap_queries.

LDAP_MATCHING_RULE_IN_CHAIN (1941) recursively walks group nesting and returns every group a user is in transitively.

```sh title:"LDAP Queries Enumerate Recursive Group Membership"
Get-ADGroup -LDAPFilter "(member:1.2.840.113556.1.4.1941:=$((Get-ADUser -Identity '$user').DistinguishedName))" | Select-Object Name
```
<!-- cheat
var user
-->

### Users with description set

Set users with description set with Ldap_queries.

Lazy admins occasionally stash passwords in the description field. Worth grepping the output for likely creds.

```sh title:"LDAP Queries Set Users with Description Set"
Get-ADUser -Properties * -LDAPFilter '(&(objectCategory=user)(description=*))' | select samaccountname,description
```
<!-- cheat -->

### Trusted-for-delegation users

Enumerate trusted for delegation users with Ldap_queries.

Users with `TRUSTED_FOR_DELEGATION` (UAC bit 524288). Compromise often equals domain compromise.

```sh title:"LDAP Queries Enumerate Trusted for Delegation Users"
Get-ADUser -Properties * -LDAPFilter '(userAccountControl:1.2.840.113556.1.4.803:=524288)' | select Name,memberof, servicePrincipalName,TrustedForDelegation | fl
```
<!-- cheat -->

### Trusted-for-delegation computers

Enumerate trusted for delegation computers with Ldap_queries.

Same flag on computer objects. Coerce the computer to auth to your relay and you can impersonate any user that has touched it.

```sh title:"LDAP Queries Enumerate Trusted for Delegation Computers"
Get-ADComputer -Properties * -LDAPFilter '(userAccountControl:1.2.840.113556.1.4.803:=524288)' | select DistinguishedName,servicePrincipalName,TrustedForDelegation | fl
```
<!-- cheat -->

### Privileged blank-password users

Dump privileged blank password users with Ldap_queries.

Privileged users with PASSWD_NOTREQD set. If they also have an empty password, instant takeover.

```sh title:"LDAP Queries Dump Privileged Blank Password Users"
Get-AdUser -LDAPFilter '(&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=32))(adminCount=1)' -Properties * | select name,memberof | fl
```
<!-- cheat -->

### Members of Security Operations

Enumerate members of security operations with Ldap_queries.

Direct membership of the Security Operations group. Replace with whichever ops/admin group your client uses.

```sh title:"LDAP Queries Enumerate Members of Security Operations"
Get-ADGroupMember -Identity "Security Operations"
```
<!-- cheat -->

### MemberOf for one user

Dump MemberOf for one user with Ldap_queries.

Quick `memberOf` dump for a single account.

```sh title:"LDAP Queries Dump MemberOf for One User"
Get-ADUser -Identity $user -Properties * | select memberof | ft -Wrap
```
<!-- cheat
var user
-->

### Recursive groups (Filter form)

Enumerate recursive groups (Filter form) with Ldap_queries.

Same recursive group walk using `-Filter -RecursiveMatch` instead of the OID.

```sh title:"LDAP Queries Enumerate Recursive Groups (Filter Form)"
Get-ADGroup -Filter "member -RecursiveMatch '$((Get-ADUser -Identity '$user').DistinguishedName)'" | Select-Object Name
```
<!-- cheat
var user
-->

### Count users in OU subtree

Enumerate count users in OU subtree with Ldap_queries.

Total users below an OU including nested OUs.

```sh title:"LDAP Queries Enumerate Count Users in OU Subtree"
$ou = "OU=O,DC=domain,DC=com"
(Get-ADUser -SearchBase $ou -SearchScope Subtree -Filter *).Count
```
<!-- cheat -->

### Users at OU base

Enumerate users at OU base with Ldap_queries.

Only the users at the OU itself, no recursion.

```sh title:"LDAP Queries Enumerate Users At OU Base"
$ou = "OU=O,DC=domain,DC=com"
Get-ADUser -SearchBase $ou -SearchScope Base -Filter *
```
<!-- cheat -->

### Objects at OU base

Enumerate objects at OU base with Ldap_queries.

Any object at the OU base, regardless of class.

```sh title:"LDAP Queries Enumerate Objects At OU Base"
$ou = "OU=O,DC=domain,DC=com"
Get-ADObject -SearchBase $ou -SearchScope Base -Filter *
```
<!-- cheat -->

### Users one level below OU

Enumerate users one level below OU with Ldap_queries.

Users in the OU plus its immediate children, but not deeper.

```sh title:"LDAP Queries Enumerate Users One Level Below OU"
$ou = "OU=O,DC=domain,DC=com"
Get-ADUser -SearchBase $ou -SearchScope OneLevel -Filter *
```
<!-- cheat -->

### Users one level below (numeric)

Enumerate users one level below (numeric) with Ldap_queries.

Same as above but with the numeric SearchScope value.

```sh title:"LDAP Queries Enumerate Users One Level Below (numeric)"
$ou = "OU=O,DC=domain,DC=com"
Get-ADUser -SearchBase $ou -SearchScope 1 -Filter *
```
<!-- cheat -->

### Count users in OU (numeric)

Enumerate count users in OU (numeric) with Ldap_queries.

Recursive subtree count using numeric scope (2 = Subtree).

```sh title:"LDAP Queries Enumerate Count Users in OU (numeric)"
$ou = "OU=O,DC=domain,DC=com"
(Get-ADUser -SearchBase $ou -SearchScope 2 -Filter *).Count
```
<!-- cheat -->

### Direct memberOf list

List direct memberOf list with Ldap_queries.

Distinguished names of groups the user is a direct member of.

```sh title:"LDAP Queries List Direct MemberOf List"
(Get-ADUser -Identity '$user' -Properties MemberOf).MemberOf
```
<!-- cheat
var user
-->

### TrustedForDelegation users (cmdlet)

Enumerate TrustedForDelegation users (cmdlet) with Ldap_queries.

Same TRUSTED_FOR_DELEGATION list using cmdlet syntax.

```sh title:"LDAP Queries Enumerate TrustedForDelegation Users (cmdlet)"
Get-ADUser -Filter {TrustedForDelegation -eq $true}
```
<!-- cheat -->

### Count users in HR OU

Enumerate count users in HR OU with Ldap_queries.

Concrete example of the OU subtree count, scoped to HR.

```sh title:"LDAP Queries Enumerate Count Users in HR OU"
$ou = "OU=HR,DC=domain,DC=com"
(Get-ADUser -SearchBase $ou -SearchScope Subtree -Filter *).Count
```
<!-- cheat -->

### Users with adminCount > 0

Read users with adminCount > 0 with Ldap_queries.

Users with any nonzero adminCount. Catches users currently or formerly in privileged groups (AdminSDHolder leaves the bit set).

```sh title:"LDAP Queries Read Users with AdminCount > 0"
Get-ADUser -Filter {adminCount -gt 0} -Properties admincount,useraccountcontrol | select Name,useraccountcontrol
```
<!-- cheat -->

### Users in HR OU

Enumerate users in HR OU with Ldap_queries.

All users under the HR OU.

```sh title:"LDAP Queries Enumerate Users in HR OU"
$ou = "OU=HR,DC=domain,DC=com"
Get-ADUser -Filter * -SearchBase $ou
```
<!-- cheat -->

### UAC = 262656

Enumerate UAC = 262656 with Ldap_queries.

UAC literal 262656 = NORMAL_ACCOUNT (512) + SMARTCARD_REQUIRED (262144). Smartcard users are interesting for PKINIT abuse.

```sh title:"LDAP Queries Enumerate UAC = 262656"
Get-ADUser -LDAPFilter "(userAccountControl=262656)" | Select-Object SamAccountName
```
<!-- cheat -->

### PASSWD_NOTREQD users

Dump PASSWD NOTREQD users with Ldap_queries.

UAC bit 32 = PASSWD_NOTREQD. Account may have an empty or trivially short password.

```sh title:"LDAP Queries Dump PASSWD NOTREQD Users"
Get-ADUser -LDAPFilter "(userAccountControl:1.2.840.113556.1.4.803:=32)" | Select-Object SamAccountName
```
<!-- cheat -->

### Recursive group membership (groups)

Enumerate recursive group membership (groups) with Ldap_queries.

Same OID 1941 trick but starting from a group, returns every nested group inside it.

```sh title:"LDAP Queries Enumerate Recursive Group Membership (groups)"
Get-ADGroup -LDAPFilter "(member:1.2.840.113556.1.4.1941:=$((Get-ADGroup -Identity '$group').DistinguishedName))" | Select-Object Name
```
<!-- cheat
var group
-->

### Recursive group members

Enumerate recursive group members with Ldap_queries.

Recursive members of a group (users + nested groups expanded).

```sh title:"LDAP Queries Enumerate Recursive Group Members"
Get-ADGroupMember -Identity '$group' -Recursive | Select-Object Name,SamAccountName,ObjectClass
```
<!-- cheat
var group
-->

### Count users in OU (variable)

Enumerate count users in OU (variable) with Ldap_queries.

Subtree count using a pre-set `$ou` variable.

```sh title:"LDAP Queries Enumerate Count Users in OU (variable)"
(Get-ADUser -SearchBase $ou -SearchScope Subtree -Filter *).Count
```
<!-- cheat
var ou
-->

### Count adminCount=1 groups

Enumerate count adminCount=1 groups with Ldap_queries.

Total count of AdminSDHolder-protected groups.

```sh title:"LDAP Queries Enumerate Count AdminCount=1 Groups"
(Get-ADGroup -LDAPFilter "(adminCount=1)").Count
```
<!-- cheat -->

### ASREPRoast minus Protected Users

Enumerate ASREPRoast minus protected users with Ldap_queries.

ASREPRoast candidates excluding Protected Users members (whose RC4 is disabled and can't be cracked).

```sh title:"LDAP Queries Enumerate ASREPRoast Minus Protected Users"
Get-ADUser -Filter * -Properties DoesNotRequirePreAuth | Where-Object { $_.DoesNotRequirePreAuth -eq $true -and $_.SamAccountName -notin $protected } | Select-Object SamAccountName
```
<!-- cheat
var protected
-->

### All SPN holders

List all SPN holders with Ldap_queries.

Every user that has any SPN. Full Kerberoast target list.

```sh title:"LDAP Queries List All SPN Holders"
Get-ADUser -Filter {ServicePrincipalName -like "*"} -Properties ServicePrincipalName | Select-Object SamAccountName,ServicePrincipalName
```
<!-- cheat -->

### Group names from memberOf

Enumerate group names from memberOf with Ldap_queries.

Resolve memberOf DNs back to group names for one user. Useful for spotting non-default privilege.

```sh title:"LDAP Queries Enumerate Group Names from MemberOf"
Get-ADUser -Identity '$user' -Properties MemberOf | ForEach-Object { $_.MemberOf } | Get-ADGroup | Select-Object Name
```
<!-- cheat
var user
-->

## ldap - enum - powershell - computers

### All computers

Enumerate all computers with Ldap_queries.

Every computer object in the domain.

```sh title:"LDAP Queries Enumerate All Computers"
Get-ADObject -LDAPFilter '(objectCategory=computer)'
```
<!-- cheat -->

### Domain Controllers

Enumerate domain controllers with Ldap_queries.

DCs identified via the SERVER_TRUST_ACCOUNT UAC bit (8192).

```sh title:"LDAP Queries Enumerate Domain Controllers"
Get-ADObject -LDAPFilter '(&(objectCategory=Computer)(userAccountControl:1.2.840.113556.1.4.803:=8192))'
```
<!-- cheat -->

### Global catalog servers

Read global catalog servers with Ldap_queries.

GCs flagged in the configuration partition (NTDSDSA options bit 1).

```sh title:"LDAP Queries Read Global Catalog Servers"
Get-ADObject -LDAPFilter '(&(objectCategory=nTDSDSA)(options:1.2.840.113556.1.4.803:=1))'
```
<!-- cheat -->

### Exclude Domain Controllers

Enumerate exclude domain controllers with Ldap_queries.

Anything except DCs (filter on primaryGroupID 516 = Domain Controllers).

```sh title:"LDAP Queries Enumerate Exclude Domain Controllers"
Get-ADObject -LDAPFilter '(!(primaryGroupID=516))'
```
<!-- cheat -->

### Exclude OpsMgr servers

Enumerate exclude OpsMgr servers with Ldap_queries.

Filter out SCOM/OpsMgr management servers and gateways.

```sh title:"LDAP Queries Enumerate Exclude OpsMgr Servers"
Get-ADObject -LDAPFilter '(!(servicePrincipalName=MSOMHSvc/*))'
```
<!-- cheat -->

### Odd-numbered hostnames

Enumerate odd numbered hostnames with Ldap_queries.

Servers whose NetBIOS name ends in an odd digit. Useful when the org uses an odd/even numbering convention.

```sh title:"LDAP Queries Enumerate Odd Numbered Hostnames"
Get-ADObject -LDAPFilter '(|(name=*1)(name=*3)(name=*5)(name=*7)(name=*9))'
```
<!-- cheat -->

### Disabled computers

Enumerate disabled computers with Ldap_queries.

Computer accounts with the ACCOUNTDISABLE UAC bit set.

```sh title:"LDAP Queries Enumerate Disabled Computers"
Get-ADObject -LDAPFilter '(&(objectClass=computer)(userAccountControl:1.2.840.113556.1.4.803:=2))'
```
<!-- cheat -->

### Win Server 2003 non-DCs

Enumerate win server 2003 non DCs with Ldap_queries.

End-of-life servers, almost always missing patches and full of legacy auth.

```sh title:"LDAP Queries Enumerate Win Server 2003 Non DCs"
Get-ADObject -LDAPFilter '(&(&(&(samAccountType=805306369)(!(primaryGroupId=516)))(objectCategory=computer)(operatingSystem=Windows Server 2003*)))'
```
<!-- cheat -->

### Win Server 2003 DCs

Enumerate win server 2003 DCs with Ldap_queries.

EOL DCs are a giant red flag and a near-guaranteed compromise path.

```sh title:"LDAP Queries Enumerate Win Server 2003 DCs"
Get-ADObject -LDAPFilter '(&(&(&(samAccountType=805306369)(primaryGroupID=516)(objectCategory=computer)(operatingSystem=Windows Server 2003*))))'
```
<!-- cheat -->

### Win Server 2008 servers

Enumerate win server 2008 servers with Ldap_queries.

Server 2008 / R2 are also out of support.

```sh title:"LDAP Queries Enumerate Win Server 2008 Servers"
Get-ADObject -LDAPFilter '(&(&(&(&(samAccountType=805306369)(!(primaryGroupId=516)))(objectCategory=computer)(operatingSystem=Windows Server 2008*))))'
```
<!-- cheat -->

### Windows 2000 SP4

Enumerate windows 2000 SP4 with Ldap_queries.

Windows 2000 SP4 endpoints. Trivial to compromise if any are still online.

```sh title:"LDAP Queries Enumerate Windows 2000 SP4"
Get-ADObject -LDAPFilter '(&(&(&(objectCategory=Computer)(operatingSystem=Windows 2000 Professional)(operatingSystemServicePack=Service Pack 4))))'
```
<!-- cheat -->

### Windows XP SP2

Enumerate windows XP SP2 with Ldap_queries.

Windows XP SP2 endpoints. Free MS17-010 candidates.

```sh title:"LDAP Queries Enumerate Windows XP SP2"
Get-ADObject -LDAPFilter '(&(&(&(&(&(&(&(objectCategory=Computer)(operatingSystem=Windows XP Professional)(operatingSystemServicePack=Service Pack 2))))))))'
```
<!-- cheat -->

### Windows XP SP3

Enumerate windows XP SP3 with Ldap_queries.

Windows XP SP3 endpoints. Same story as SP2.

```sh title:"LDAP Queries Enumerate Windows XP SP3"
Get-ADObject -LDAPFilter '(&(&(&(&(&(&(&(objectCategory=Computer)(operatingSystem=Windows XP Professional)(operatingSystemServicePack=Service Pack 3))))))))'
```
<!-- cheat -->

### Vista SP1

Enumerate vista SP1 with Ldap_queries.

Vista SP1 endpoints. Rare in 2026 but still appear in OT/lab subnets.

```sh title:"LDAP Queries Enumerate Vista SP1"
Get-ADObject -LDAPFilter '(&(&(&(&(sAMAccountType=805306369)(objectCategory=computer)(operatingSystem=Windows Vista*)(operatingSystemServicePack=Service Pack 1)))))'
```
<!-- cheat -->

## ldap - enum - powershell - users

### All user accounts

Enumerate all user accounts with Ldap_queries.

Standard user-account class via samAccountType filter.

```sh title:"LDAP Queries Enumerate All User Accounts"
Get-ADObject -LDAPFilter '(sAMAccountType=805306368)'
```
<!-- cheat -->

### All contacts

Enumerate all contacts with Ldap_queries.

Mail contacts (no AD logon).

```sh title:"LDAP Queries Enumerate All Contacts"
Get-ADObject -LDAPFilter '(objectClass=contact)'
```
<!-- cheat -->

### Users and contacts

Enumerate users and contacts with Ldap_queries.

`objectClass=user` returns both real users and Exchange contacts.

```sh title:"LDAP Queries Enumerate Users and Contacts"
Get-ADObject -LDAPFilter '(objectClass=user)'
```
<!-- cheat -->

### Recently active users

Enumerate recently active users with Ldap_queries.

Users that logged in after the given timestamp. Filters out stale accounts so spraying focuses on live ones.

```sh title:"LDAP Queries Enumerate Recently Active Users"
Get-ADObject -LDAPFilter '(&(&(objectCategory=person)(objectClass=user))(lastLogonTimestamp<=128752108510000000))'
```
<!-- cheat -->

### DONT_EXPIRE_PASSWORD users

Dump DONT EXPIRE PASSWORD users with Ldap_queries.

UAC bit 65536. Passwords set once, never rotated; great spray candidates.

```sh title:"LDAP Queries Dump DONT EXPIRE PASSWORD Users"
Get-ADObject -LDAPFilter '(&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=65536))'
```
<!-- cheat -->

### Disabled users (object form)

Enumerate disabled users (object form) with Ldap_queries.

Same disabled-user filter from the Get-ADObject angle.

```sh title:"LDAP Queries Enumerate Disabled Users (object Form)"
Get-ADObject -LDAPFilter '(&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=2))'
```
<!-- cheat -->

### Expired user accounts

Enumerate expired user accounts with Ldap_queries.

Accounts whose accountExpires is set and not the never-expires sentinel value.

```sh title:"LDAP Queries Enumerate Expired User Accounts"
Get-ADObject -LDAPFilter '(&(objectCategory=Person)(objectClass=User)(!accountExpires=0)(!accountExpires=9223372036854775807)) '
```
<!-- cheat -->

### PASSWD_NOTREQD users (object form)

Enumerate PASSWD NOTREQD users (object form) with Ldap_queries.

Get-ADObject form of the PASSWD_NOTREQD search.

```sh title:"LDAP Queries Enumerate PASSWD NOTREQD Users (object Form)"
Get-ADObject -LDAPFilter '(&(objectCategory=Person)(objectClass=User)(userAccountControl:1.2.840.113556.1.4.803:=32))'
```
<!-- cheat -->

### Nested group memberships

Enumerate nested group memberships with Ldap_queries.

Walk every group (including nested) the named user belongs to via OID 1941.

```sh title:"LDAP Queries Enumerate Nested Group Memberships"
Get-ADObject -LDAPFilter '(member:1.2.840.113556.1.4.1941:=(CN=UserName,CN=Users,DC=YOURDOMAIN,DC=NET))'
```
<!-- cheat -->

### Reports without manager

Enumerate reports without manager with Ldap_queries.

Users that have direct reports but no manager set. Often points to abandoned org-tree leaves and stale privileged accounts.

```sh title:"LDAP Queries Enumerate Reports Without Manager"
Get-ADObject -LDAPFilter '(&(objectCategory=person)(objectClass=user)(directReports=*)(!(manager=*)))'
```
<!-- cheat -->

## ldap - enum - powershell - exchange

### Hidden recipients

List hidden recipients with Ldap_queries.

Recipients hidden from address lists. Sometimes admin/service mailboxes.

```sh title:"LDAP Queries List Hidden Recipients"
Get-ADObject -LDAPFilter '(msExchHideFromAddressLists=TRUE)'
```
<!-- cheat -->

### Hidden recipients (no public folders)

Enumerate hidden recipients (no public folders) with Ldap_queries.

Hidden recipients minus public folder objects (cleaner list).

```sh title:"LDAP Queries Enumerate Hidden Recipients (no Public Folders)"
Get-ADObject -LDAPFilter '(&(msExchHideFromAddressLists=TRUE)(!objectClass=publicFolder))'
```
<!-- cheat -->

### Fax recipients

Enumerate fax recipients with Ldap_queries.

Mail recipients with a FAX proxy address.

```sh title:"LDAP Queries Enumerate Fax Recipients"
Get-ADObject -LDAPFilter '(proxyAddresses=FAX:*)'
```
<!-- cheat -->

### Mailboxes on KUNGUR

Enumerate mailboxes on KUNGUR with Ldap_queries.

Mailboxes hosted on the named Exchange server. Adapt the legacy DN to your org.

```sh title:"LDAP Queries Enumerate Mailboxes on KUNGUR"
Get-ADObject -LDAPFilter '(msExchangeHomeserverName=/o=MAILOrg/ou=First Administrative Group/cn=Configuration/cn=Servers/cn=KUNGUR)'
```
<!-- cheat -->

### Reports-to chain

Enumerate reports to chain with Ldap_queries.

Recursive `manager` walk under a named manager. Maps the org subtree, useful for phishing recon.

```sh title:"LDAP Queries Enumerate Reports to Chain"
Get-ADObject -LDAPFilter '(manager:1.2.840.113556.1.4.1941:=CN=Jim,OU=Managed,OU=Accounts,DC=willeke,DC=com)'
```
<!-- cheat -->

## ldap - enum - powershell - groups

### All groups

Enumerate all groups with Ldap_queries.

Every group object.

```sh title:"LDAP Queries Enumerate All Groups"
Get-ADObject -LDAPFilter '(objectClass=group)'
```
<!-- cheat -->

### Direct members of group

Enumerate direct members of group with Ldap_queries.

Direct (non-recursive) members of a single security group by DN.

```sh title:"LDAP Queries Enumerate Direct Members of Group"
Get-ADObject -LDAPFilter '(memberOf=CN=Admin,OU=Security,DC=DOM,DC=NT)'
```
<!-- cheat -->

### Recursive members of group

Enumerate recursive members of group with Ldap_queries.

All members of a security group including those gained via nested groups (OID 1941).

```sh title:"LDAP Queries Enumerate Recursive Members of Group"
Get-ADObject -LDAPFilter '(memberOf:1.2.840.113556.1.4.1941:=CN=GroupOne,OU=Security Groups,OU=Groups,DC=YOURDOMAIN,DC=NET)'
```
<!-- cheat -->

### Recursive user members

Enumerate recursive user members with Ldap_queries.

Same recursive walk but filtered to user objects only.

```sh title:"LDAP Queries Enumerate Recursive User Members"
Get-ADObject -LDAPFilter '(&(objectClass=user)(memberof:1.2.840.113556.1.4.1941:=CN=GroupOne,OU=Security Groups,OU=Groups,DC=YOURDOMAIN,DC=NET))'
```
<!-- cheat -->

### All security groups

Enumerate all security groups with Ldap_queries.

Every security group regardless of scope (groupType high bit).

```sh title:"LDAP Queries Enumerate All Security Groups"
Get-ADObject -LDAPFilter '(groupType:1.2.840.113556.1.4.803:=2147483648)'
```
<!-- cheat -->

### Empty groups

Enumerate empty groups with Ldap_queries.

Groups with no members. Cleanup candidates and occasionally writable.

```sh title:"LDAP Queries Enumerate Empty Groups"
Get-ADObject -LDAPFilter '(&(objectClass=group)(!member=*))'
```
<!-- cheat -->

### Security global groups

Enumerate security global groups with Ldap_queries.

Security groups with Global scope.

```sh title:"LDAP Queries Enumerate Security Global Groups"
Get-ADObject -LDAPFilter '(&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2147483650))'
```
<!-- cheat -->

### Security domain local groups

Enumerate security domain local groups with Ldap_queries.

Security groups with Domain Local scope.

```sh title:"LDAP Queries Enumerate Security Domain Local Groups"
Get-ADObject -LDAPFilter '(&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2147483652))'
```
<!-- cheat -->

### Security universal groups

Enumerate security universal groups with Ldap_queries.

Security groups with Universal scope (forest-wide membership).

```sh title:"LDAP Queries Enumerate Security Universal Groups"
Get-ADObject -LDAPFilter '(&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2147483656))'
```
<!-- cheat -->

## ldap - enum - powershell - distribution groups

### All distribution groups

Enumerate all distribution groups with Ldap_queries.

Every group whose security bit is unset (i.e. distribution only, no ACL impact).

```sh title:"LDAP Queries Enumerate All Distribution Groups"
Get-ADObject -LDAPFilter '(&(objectCategory=group)(!(groupType:1.2.840.113556.1.4.803:=2147483648)))'
```
<!-- cheat -->

### Distribution global

Enumerate distribution global with Ldap_queries.

Distribution groups with Global scope.

```sh title:"LDAP Queries Enumerate Distribution Global"
Get-ADObject -LDAPFilter '(&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2)(!(groupType:1.2.840.113556.1.4.803:=2147483648))) '
```
<!-- cheat -->

### Distribution domain local

Enumerate distribution domain local with Ldap_queries.

Distribution groups with Domain Local scope.

```sh title:"LDAP Queries Enumerate Distribution Domain Local"
Get-ADObject -LDAPFilter '(&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=4)(!(groupType:1.2.840.113556.1.4.803:=2147483648))) '
```
<!-- cheat -->

### Distribution universal

Enumerate distribution universal with Ldap_queries.

Distribution groups with Universal scope.

```sh title:"LDAP Queries Enumerate Distribution Universal"
Get-ADObject -LDAPFilter '(&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=8)(!(groupType:1.2.840.113556.1.4.803:=2147483648))) '
```
<!-- cheat -->

### Recently changed groups

Enumerate recently changed groups with Ldap_queries.

Groups modified after the given timestamp. Useful for spotting fresh privilege changes.

```sh title:"LDAP Queries Enumerate Recently Changed Groups"
Get-ADObject -LDAPFilter '(&(objectClass=group)(whenChanged>=20081231000000.0Z))'
```
<!-- cheat -->

<!-- cheat
export ldap_query
var ldap_query = printf '%s\n' "All groups # (&(objectCategory=group)(objectClass=group))" "Disabled users (UAC 2) # (&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=2))" "Users adminCount=1 # (&(objectCategory=person)(objectClass=user)(adminCount=1))" "Users adminCount=1 with SPN # (&(objectCategory=person)(objectClass=user)(adminCount=1)(servicePrincipalName=*))" "Users DoesNotRequirePreAuth=True # (&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=4194304))" "Users blank passwords # (&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=32)(adminCount=1))" "Users description set # (&(objectCategory=person)(objectClass=user)(description=*))" "Trusted for delegation users # (&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=524288))" "Trusted for delegation computers # (&(objectCategory=computer)(userAccountControl:1.2.840.113556.1.4.803:=524288))" "Users PASSWD_NOTREQD (0x20) # (&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=32))" "UserAccountControl=262656 # (&(objectCategory=person)(objectClass=user)(userAccountControl=262656))" "Groups adminCount=1 # (&(objectCategory=group)(adminCount=1))" "Computers (all) # (objectCategory=computer)" "Domain Controllers # (&(objectCategory=computer)(userAccountControl:1.2.840.113556.1.4.803:=8192))" "Global catalog servers # (&(objectCategory=nTDSDSA)(options:1.2.840.113556.1.4.803:=1))" "Exclude Domain Controllers # (&(objectCategory=computer)(!(primaryGroupID=516)))" "Exclude OpsMgr servers # (&(objectCategory=computer)(!(servicePrincipalName=MSOMHSvc/*)))" "Odd-numbered server names # (&(objectCategory=computer)(|(name=*1)(name=*3)(name=*5)(name=*7)(name=*9)))" "Disabled computers (UAC 2) # (&(objectCategory=computer)(userAccountControl:1.2.840.113556.1.4.803:=2))" "Win2K SP4 computers # (&(objectCategory=computer)(operatingSystem=Windows 2000 Professional)(operatingSystemServicePack=Service Pack 4))" "WinXP SP2 computers # (&(objectCategory=computer)(operatingSystem=Windows XP Professional)(operatingSystemServicePack=Service Pack 2))" "WinXP SP3 computers # (&(objectCategory=computer)(operatingSystem=Windows XP Professional)(operatingSystemServicePack=Service Pack 3))" "Vista SP1 computers # (&(objectCategory=computer)(operatingSystem=Windows Vista*)(operatingSystemServicePack=Service Pack 1))" "All users # (&(objectCategory=person)(objectClass=user))" "All contacts # (&(objectCategory=person)(objectClass=contact))" "All users and contacts # (|(&(objectCategory=person)(objectClass=user))(&(objectCategory=person)(objectClass=contact)))" "Users with DONT_EXPIRE_PASSWORD # (&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=65536))" "Expired user accounts # (&(objectCategory=person)(objectClass=user)(!accountExpires=0)(!accountExpires=9223372036854775807))" "Users PASSWD_NOTREQD (32) # (&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=32))" "User anomaly: DirectReports but no Manager # (&(objectCategory=person)(objectClass=user)(directReports=*)(!(manager=*)))" "Exchange hidden recipients # (msExchHideFromAddressLists=TRUE)" "Exchange hidden recipients (no public folders) # (&(msExchHideFromAddressLists=TRUE)(!objectClass=publicFolder))" "Exchange fax recipients # (proxyAddresses=FAX:*)" "Exchange mailboxes on server KUNGUR # (msExchangeHomeserverName=/o=MAILOrg/ou=First Administrative Group/cn=Configuration/cn=Servers/cn=KUNGUR)" "Report-to chain under CN=Jim # (manager:1.2.840.113556.1.4.1941:=CN=Jim,OU=Managed,OU=Accounts,DC=willeke,DC=com)" "All security groups (all scopes) # (groupType:1.2.840.113556.1.4.803:=2147483648)" "Empty groups # (&(objectClass=group)(!member=*))" "Security Global Groups # (&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2147483650))" "Security Domain Local Groups # (&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2147483652))" "Security Universal Groups # (&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2147483656))" "Distribution groups (all) # (&(objectCategory=group)(!(groupType:1.2.840.113556.1.4.803:=2147483648)))" "Distribution Global Groups # (&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2)(!(groupType:1.2.840.113556.1.4.803:=2147483648)))" "Distribution Domain Local Groups # (&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=4)(!(groupType:1.2.840.113556.1.4.803:=2147483648)))" "Distribution Universal Groups # (&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=8)(!(groupType:1.2.840.113556.1.4.803:=2147483648)))" "Groups changed since 2008 # (&(objectClass=group)(whenChanged>=20081231000000.0Z))" --- --delimiter ' # '  --column 1 --select-column 2
-->
