# Ldap_queries

## ldap - enum - powershell

### List all groups

Dump every group object's name. Quick first pass when triaging an unfamiliar domain.

```sh title:"List every group object name"
Get-ADObject -LDAPFilter '(objectClass=group)' | select name
```
<!-- cheat -->

### Disabled users (bitfield)

Find disabled users via the LDAP_MATCHING_RULE_BIT_AND on userAccountControl. The `=2` bit is ACCOUNTDISABLE.

```sh title:"Find disabled users via UAC bitfield (ACCOUNTDISABLE=2)"
Get-ADObject -LDAPFilter '(&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=2))' -Properties * | select samaccountname,useraccountcontrol
```
<!-- cheat -->

### Disabled users (cmdlet)

Same disabled-user list using the cmdlet's `Enabled` property instead of the LDAP filter.

```sh title:"Find disabled users via cmdlet Enabled property"
Get-ADUser -Filter 'Enabled -eq $false'
```
<!-- cheat -->

### Count of users in domain

Total user object count. Sanity check before sprays so you know how loud the operation will be.

```sh title:"Total domain user count, sizing for spray operations"
(Get-ADUser -Filter *).Count
```
<!-- cheat -->

### Count of computers in domain

Total computer object count. Includes DCs and stale machine accounts.

```sh title:"Total domain computer count, includes stale accounts"
(Get-ADComputer -Filter *).Count
```
<!-- cheat -->

### Count of groups in domain

Total group object count.

```sh title:"Total domain group count"
(Get-ADGroup -Filter *).Count
```
<!-- cheat -->

### Privileged groups (adminCount=1)

Groups with `adminCount=1` are protected by AdminSDHolder, i.e. high-value privileged groups.

```sh title:"AdminSDHolder-protected groups (high value targets)"
Get-ADGroup -Filter "adminCount -eq 1" | select Name
```
<!-- cheat -->

### Privileged + ASREPRoastable

Users that are both privileged (adminCount=1) and ASREPRoastable (DoesNotRequirePreAuth). Top-tier finding when present.

```sh title:"Privileged users that are also ASREPRoastable"
Get-ADUser -Filter {adminCount -eq '1' -and DoesNotRequirePreAuth -eq 'True'}
```
<!-- cheat -->

### Privileged with SPN set

Privileged users carrying an SPN. Common when service accounts were dropped into Domain Admins; trivial Kerberoast win.

```sh title:"Privileged users carrying SPN, trivial Kerberoast win"
Get-ADUser -Filter "adminCount -eq '1'" -Properties * | where servicePrincipalName -ne $null | select SamAccountName,MemberOf,ServicePrincipalName | fl
```
<!-- cheat -->

### ASREPRoastable users

All accounts with `DoesNotRequirePreAuth` set. Their AS-REP can be requested without creds and cracked offline.

```sh title:"DoesNotRequirePreAuth set, ASREPRoast candidates"
Get-ADUser -Filter * -Properties DoesNotRequirePreAuth | Where-Object { $_.DoesNotRequirePreAuth -eq $true } | select Name,SamAccountName,DoesNotRequirePreAuth | fl
```
<!-- cheat -->

### SID of host

Resolve a computer object's SID. Needed for ESC ticketer flows and SID-history attacks.

```sh title:"Resolve computer SID for ticketer / SID-history flows"
(Get-ADComputer -Identity "$host").SID
```
<!-- cheat
var host
-->

### SPN holders in Protected Users

Find SPN-holding users who are also in Protected Users. They can't be Kerberoasted (RC4 disabled), so flag them out of the target list early.

```sh title:"SPN holders inside Protected Users (skip from roast list)"
$protectedGroup = Get-ADGroup -Identity "Protected Users"
$protectedMembers = Get-ADGroupMember -Identity $protectedGroup -Recursive
$protectedMembers | Where-Object {
    ($_ | Get-ADUser -Properties ServicePrincipalName).ServicePrincipalName -ne $null
} | Select-Object SamAccountName,ServicePrincipalName
```
<!-- cheat -->

### Disabled users (filter)

Disabled users via raw LDAP filter, returning name only.

```sh title:"Disabled users via raw LDAP filter, name only"
Get-ADUser -LDAPFilter '(userAccountControl:1.2.840.113556.1.4.803:=2)' | select name
```
<!-- cheat -->

### Recursive group membership

LDAP_MATCHING_RULE_IN_CHAIN (1941) recursively walks group nesting and returns every group a user is in transitively.

```sh title:"Recursive group memberships via LDAP_MATCHING_RULE_IN_CHAIN"
Get-ADGroup -LDAPFilter "(member:1.2.840.113556.1.4.1941:=$((Get-ADUser -Identity '$user').DistinguishedName))" | Select-Object Name
```
<!-- cheat
var user
-->

### Users with description set

Lazy admins occasionally stash passwords in the description field. Worth grepping the output for likely creds.

```sh title:"Users with description set, sometimes contains creds"
Get-ADUser -Properties * -LDAPFilter '(&(objectCategory=user)(description=*))' | select samaccountname,description
```
<!-- cheat -->

### Trusted-for-delegation users

Users with `TRUSTED_FOR_DELEGATION` (UAC bit 524288). Compromise often equals domain compromise.

```sh title:"TRUSTED_FOR_DELEGATION users (high value targets)"
Get-ADUser -Properties * -LDAPFilter '(userAccountControl:1.2.840.113556.1.4.803:=524288)' | select Name,memberof, servicePrincipalName,TrustedForDelegation | fl
```
<!-- cheat -->

### Trusted-for-delegation computers

Same flag on computer objects. Coerce the computer to auth to your relay and you can impersonate any user that has touched it.

```sh title:"TRUSTED_FOR_DELEGATION computers, coercion + relay path"
Get-ADComputer -Properties * -LDAPFilter '(userAccountControl:1.2.840.113556.1.4.803:=524288)' | select DistinguishedName,servicePrincipalName,TrustedForDelegation | fl
```
<!-- cheat -->

### Privileged blank-password users

Privileged users with PASSWD_NOTREQD set. If they also have an empty password, instant takeover.

```sh title:"Privileged + PASSWD_NOTREQD, instant takeover if empty"
Get-AdUser -LDAPFilter '(&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=32))(adminCount=1)' -Properties * | select name,memberof | fl
```
<!-- cheat -->

### Members of Security Operations

Direct membership of the Security Operations group. Replace with whichever ops/admin group your client uses.

```sh title:"Direct members of Security Operations group"
Get-ADGroupMember -Identity "Security Operations"
```
<!-- cheat -->

### MemberOf for one user

Quick `memberOf` dump for a single account.

```sh title:"Dump memberOf for a single account"
Get-ADUser -Identity $user -Properties * | select memberof | ft -Wrap
```
<!-- cheat
var user
-->

### Recursive groups (Filter form)

Same recursive group walk using `-Filter -RecursiveMatch` instead of the OID.

```sh title:"Recursive group walk via -Filter -RecursiveMatch"
Get-ADGroup -Filter "member -RecursiveMatch '$((Get-ADUser -Identity '$user').DistinguishedName)'" | Select-Object Name
```
<!-- cheat
var user
-->

### Count users in OU subtree

Total users below an OU including nested OUs.

```sh title:"Count users below OU including nested OUs"
$ou = "OU=O,DC=domain,DC=com"
(Get-ADUser -SearchBase $ou -SearchScope Subtree -Filter *).Count
```
<!-- cheat -->

### Users at OU base

Only the users at the OU itself, no recursion.

```sh title:"Users directly at OU, no recursion"
$ou = "OU=O,DC=domain,DC=com"
Get-ADUser -SearchBase $ou -SearchScope Base -Filter *
```
<!-- cheat -->

### Objects at OU base

Any object at the OU base, regardless of class.

```sh title:"Any object directly at OU base, no recursion"
$ou = "OU=O,DC=domain,DC=com"
Get-ADObject -SearchBase $ou -SearchScope Base -Filter *
```
<!-- cheat -->

### Users one level below OU

Users in the OU plus its immediate children, but not deeper.

```sh title:"Users in OU and immediate children, depth 1"
$ou = "OU=O,DC=domain,DC=com"
Get-ADUser -SearchBase $ou -SearchScope OneLevel -Filter *
```
<!-- cheat -->

### Users one level below (numeric)

Same as above but with the numeric SearchScope value.

```sh title:"Same OneLevel scope expressed numerically (1)"
$ou = "OU=O,DC=domain,DC=com"
Get-ADUser -SearchBase $ou -SearchScope 1 -Filter *
```
<!-- cheat -->

### Count users in OU (numeric)

Recursive subtree count using numeric scope (2 = Subtree).

```sh title:"Recursive count via numeric Subtree scope (2)"
$ou = "OU=O,DC=domain,DC=com"
(Get-ADUser -SearchBase $ou -SearchScope 2 -Filter *).Count
```
<!-- cheat -->

### Direct memberOf list

Distinguished names of groups the user is a direct member of.

```sh title:"DNs of groups user is a direct member of"
(Get-ADUser -Identity '$user' -Properties MemberOf).MemberOf
```
<!-- cheat
var user
-->

### TrustedForDelegation users (cmdlet)

Same TRUSTED_FOR_DELEGATION list using cmdlet syntax.

```sh title:"TRUSTED_FOR_DELEGATION users via cmdlet syntax"
Get-ADUser -Filter {TrustedForDelegation -eq $true}
```
<!-- cheat -->

### Count users in HR OU

Concrete example of the OU subtree count, scoped to HR.

```sh title:"Concrete subtree count example for HR OU"
$ou = "OU=HR,DC=domain,DC=com"
(Get-ADUser -SearchBase $ou -SearchScope Subtree -Filter *).Count
```
<!-- cheat -->

### Users with adminCount > 0

Users with any nonzero adminCount. Catches users currently or formerly in privileged groups (AdminSDHolder leaves the bit set).

```sh title:"adminCount > 0, catches former privileged users too"
Get-ADUser -Filter {adminCount -gt 0} -Properties admincount,useraccountcontrol | select Name,useraccountcontrol
```
<!-- cheat -->

### Users in HR OU

All users under the HR OU.

```sh title:"All users under HR OU"
$ou = "OU=HR,DC=domain,DC=com"
Get-ADUser -Filter * -SearchBase $ou
```
<!-- cheat -->

### UAC = 262656

UAC literal 262656 = NORMAL_ACCOUNT (512) + SMARTCARD_REQUIRED (262144). Smartcard users are interesting for PKINIT abuse.

```sh title:"NORMAL_ACCOUNT + SMARTCARD_REQUIRED, PKINIT candidates"
Get-ADUser -LDAPFilter "(userAccountControl=262656)" | Select-Object SamAccountName
```
<!-- cheat -->

### PASSWD_NOTREQD users

UAC bit 32 = PASSWD_NOTREQD. Account may have an empty or trivially short password.

```sh title:"PASSWD_NOTREQD users, may have empty password"
Get-ADUser -LDAPFilter "(userAccountControl:1.2.840.113556.1.4.803:=32)" | Select-Object SamAccountName
```
<!-- cheat -->

### Recursive group membership (groups)

Same OID 1941 trick but starting from a group, returns every nested group inside it.

```sh title:"All nested groups inside a parent group via OID 1941"
Get-ADGroup -LDAPFilter "(member:1.2.840.113556.1.4.1941:=$((Get-ADGroup -Identity '$group').DistinguishedName))" | Select-Object Name
```
<!-- cheat
var group
-->

### Recursive group members

Recursive members of a group (users + nested groups expanded).

```sh title:"Recursive group members, nested groups expanded"
Get-ADGroupMember -Identity '$group' -Recursive | Select-Object Name,SamAccountName,ObjectClass
```
<!-- cheat
var group
-->

### Count users in OU (variable)

Subtree count using a pre-set `$ou` variable.

```sh title:"Subtree user count using preset $ou variable"
(Get-ADUser -SearchBase $ou -SearchScope Subtree -Filter *).Count
```
<!-- cheat
var ou
-->

### Count adminCount=1 groups

Total count of AdminSDHolder-protected groups.

```sh title:"Count of AdminSDHolder-protected groups"
(Get-ADGroup -LDAPFilter "(adminCount=1)").Count
```
<!-- cheat -->

### ASREPRoast minus Protected Users

ASREPRoast candidates excluding Protected Users members (whose RC4 is disabled and can't be cracked).

```sh title:"ASREPRoast candidates, excluding Protected Users"
Get-ADUser -Filter * -Properties DoesNotRequirePreAuth | Where-Object { $_.DoesNotRequirePreAuth -eq $true -and $_.SamAccountName -notin $protected } | Select-Object SamAccountName
```
<!-- cheat
var protected
-->

### All SPN holders

Every user that has any SPN. Full Kerberoast target list.

```sh title:"Every SPN-holding user (full Kerberoast list)"
Get-ADUser -Filter {ServicePrincipalName -like "*"} -Properties ServicePrincipalName | Select-Object SamAccountName,ServicePrincipalName
```
<!-- cheat -->

### Group names from memberOf

Resolve memberOf DNs back to group names for one user. Useful for spotting non-default privilege.

```sh title:"Resolve memberOf DNs to group names for one user"
Get-ADUser -Identity '$user' -Properties MemberOf | ForEach-Object { $_.MemberOf } | Get-ADGroup | Select-Object Name
```
<!-- cheat
var user
-->

## ldap - enum - powershell - computers

### All computers

Every computer object in the domain.

```sh title:"All computer objects in the domain"
Get-ADObject -LDAPFilter '(objectCategory=computer)'
```
<!-- cheat -->

### Domain Controllers

DCs identified via the SERVER_TRUST_ACCOUNT UAC bit (8192).

```sh title:"DCs via SERVER_TRUST_ACCOUNT UAC bit (8192)"
Get-ADObject -LDAPFilter '(&(objectCategory=Computer)(userAccountControl:1.2.840.113556.1.4.803:=8192))'
```
<!-- cheat -->

### Global catalog servers

GCs flagged in the configuration partition (NTDSDSA options bit 1).

```sh title:"GCs flagged in configuration partition (NTDSDSA bit 1)"
Get-ADObject -LDAPFilter '(&(objectCategory=nTDSDSA)(options:1.2.840.113556.1.4.803:=1))'
```
<!-- cheat -->

### Exclude Domain Controllers

Anything except DCs (filter on primaryGroupID 516 = Domain Controllers).

```sh title:"Everything except DCs (primaryGroupID != 516)"
Get-ADObject -LDAPFilter '(!(primaryGroupID=516))'
```
<!-- cheat -->

### Exclude OpsMgr servers

Filter out SCOM/OpsMgr management servers and gateways.

```sh title:"Filter out SCOM/OpsMgr management servers and gateways"
Get-ADObject -LDAPFilter '(!(servicePrincipalName=MSOMHSvc/*))'
```
<!-- cheat -->

### Odd-numbered hostnames

Servers whose NetBIOS name ends in an odd digit. Useful when the org uses an odd/even numbering convention.

```sh title:"Hostnames ending in an odd digit (numbering convention)"
Get-ADObject -LDAPFilter '(|(name=*1)(name=*3)(name=*5)(name=*7)(name=*9))'
```
<!-- cheat -->

### Disabled computers

Computer accounts with the ACCOUNTDISABLE UAC bit set.

```sh title:"Computer accounts disabled via UAC bit 2"
Get-ADObject -LDAPFilter '(&(objectClass=computer)(userAccountControl:1.2.840.113556.1.4.803:=2))'
```
<!-- cheat -->

### Win Server 2003 non-DCs

End-of-life servers, almost always missing patches and full of legacy auth.

```sh title:"EOL Server 2003 non-DCs, likely unpatched targets"
Get-ADObject -LDAPFilter '(&(&(&(samAccountType=805306369)(!(primaryGroupId=516)))(objectCategory=computer)(operatingSystem=Windows Server 2003*)))'
```
<!-- cheat -->

### Win Server 2003 DCs

EOL DCs are a giant red flag and a near-guaranteed compromise path.

```sh title:"EOL Server 2003 DCs, near-guaranteed compromise"
Get-ADObject -LDAPFilter '(&(&(&(samAccountType=805306369)(primaryGroupID=516)(objectCategory=computer)(operatingSystem=Windows Server 2003*))))'
```
<!-- cheat -->

### Win Server 2008 servers

Server 2008 / R2 are also out of support.

```sh title:"Out-of-support Server 2008 / R2 servers"
Get-ADObject -LDAPFilter '(&(&(&(&(samAccountType=805306369)(!(primaryGroupId=516)))(objectCategory=computer)(operatingSystem=Windows Server 2008*))))'
```
<!-- cheat -->

### Windows 2000 SP4

Windows 2000 SP4 endpoints. Trivial to compromise if any are still online.

```sh title:"Windows 2000 SP4 endpoints, trivial compromise"
Get-ADObject -LDAPFilter '(&(&(&(objectCategory=Computer)(operatingSystem=Windows 2000 Professional)(operatingSystemServicePack=Service Pack 4))))'
```
<!-- cheat -->

### Windows XP SP2

Windows XP SP2 endpoints. Free MS17-010 candidates.

```sh title:"Windows XP SP2 endpoints, MS17-010 candidates"
Get-ADObject -LDAPFilter '(&(&(&(&(&(&(&(objectCategory=Computer)(operatingSystem=Windows XP Professional)(operatingSystemServicePack=Service Pack 2))))))))'
```
<!-- cheat -->

### Windows XP SP3

Windows XP SP3 endpoints. Same story as SP2.

```sh title:"Windows XP SP3 endpoints, same legacy attack surface"
Get-ADObject -LDAPFilter '(&(&(&(&(&(&(&(objectCategory=Computer)(operatingSystem=Windows XP Professional)(operatingSystemServicePack=Service Pack 3))))))))'
```
<!-- cheat -->

### Vista SP1

Vista SP1 endpoints. Rare in 2026 but still appear in OT/lab subnets.

```sh title:"Vista SP1 endpoints, occasional in OT/lab networks"
Get-ADObject -LDAPFilter '(&(&(&(&(sAMAccountType=805306369)(objectCategory=computer)(operatingSystem=Windows Vista*)(operatingSystemServicePack=Service Pack 1)))))'
```
<!-- cheat -->

## ldap - enum - powershell - users

### All user accounts

Standard user-account class via samAccountType filter.

```sh title:"All real user accounts via samAccountType filter"
Get-ADObject -LDAPFilter '(sAMAccountType=805306368)'
```
<!-- cheat -->

### All contacts

Mail contacts (no AD logon).

```sh title:"All mail contact objects (no AD logon)"
Get-ADObject -LDAPFilter '(objectClass=contact)'
```
<!-- cheat -->

### Users and contacts

`objectClass=user` returns both real users and Exchange contacts.

```sh title:"Users plus Exchange contacts (objectClass=user)"
Get-ADObject -LDAPFilter '(objectClass=user)'
```
<!-- cheat -->

### Recently active users

Users that logged in after the given timestamp. Filters out stale accounts so spraying focuses on live ones.

```sh title:"Users active after the given lastLogonTimestamp"
Get-ADObject -LDAPFilter '(&(&(objectCategory=person)(objectClass=user))(lastLogonTimestamp<=128752108510000000))'
```
<!-- cheat -->

### DONT_EXPIRE_PASSWORD users

UAC bit 65536. Passwords set once, never rotated; great spray candidates.

```sh title:"Passwords never expire, prime spray candidates"
Get-ADObject -LDAPFilter '(&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=65536))'
```
<!-- cheat -->

### Disabled users (object form)

Same disabled-user filter from the Get-ADObject angle.

```sh title:"Disabled users, Get-ADObject form"
Get-ADObject -LDAPFilter '(&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=2))'
```
<!-- cheat -->

### Expired user accounts

Accounts whose accountExpires is set and not the never-expires sentinel value.

```sh title:"accountExpires set and not the never-expires sentinel"
Get-ADObject -LDAPFilter '(&(objectCategory=Person)(objectClass=User)(!accountExpires=0)(!accountExpires=9223372036854775807)) '
```
<!-- cheat -->

### PASSWD_NOTREQD users (object form)

Get-ADObject form of the PASSWD_NOTREQD search.

```sh title:"PASSWD_NOTREQD users, Get-ADObject form"
Get-ADObject -LDAPFilter '(&(objectCategory=Person)(objectClass=User)(userAccountControl:1.2.840.113556.1.4.803:=32))'
```
<!-- cheat -->

### Nested group memberships

Walk every group (including nested) the named user belongs to via OID 1941.

```sh title:"Walk every nested group for the named user via OID 1941"
Get-ADObject -LDAPFilter '(member:1.2.840.113556.1.4.1941:=(CN=UserName,CN=Users,DC=YOURDOMAIN,DC=NET))'
```
<!-- cheat -->

### Reports without manager

Users that have direct reports but no manager set. Often points to abandoned org-tree leaves and stale privileged accounts.

```sh title:"directReports set but manager null, often stale accounts"
Get-ADObject -LDAPFilter '(&(objectCategory=person)(objectClass=user)(directReports=*)(!(manager=*)))'
```
<!-- cheat -->

## ldap - enum - powershell - exchange

### Hidden recipients

Recipients hidden from address lists. Sometimes admin/service mailboxes.

```sh title:"Mail recipients hidden from address lists"
Get-ADObject -LDAPFilter '(msExchHideFromAddressLists=TRUE)'
```
<!-- cheat -->

### Hidden recipients (no public folders)

Hidden recipients minus public folder objects (cleaner list).

```sh title:"Hidden recipients minus public folder objects"
Get-ADObject -LDAPFilter '(&(msExchHideFromAddressLists=TRUE)(!objectClass=publicFolder))'
```
<!-- cheat -->

### Fax recipients

Mail recipients with a FAX proxy address.

```sh title:"Mail recipients with FAX proxy address"
Get-ADObject -LDAPFilter '(proxyAddresses=FAX:*)'
```
<!-- cheat -->

### Mailboxes on KUNGUR

Mailboxes hosted on the named Exchange server. Adapt the legacy DN to your org.

```sh title:"Mailboxes hosted on the named Exchange server"
Get-ADObject -LDAPFilter '(msExchangeHomeserverName=/o=MAILOrg/ou=First Administrative Group/cn=Configuration/cn=Servers/cn=KUNGUR)'
```
<!-- cheat -->

### Reports-to chain

Recursive `manager` walk under a named manager. Maps the org subtree, useful for phishing recon.

```sh title:"Recursive manager walk under named manager (org subtree)"
Get-ADObject -LDAPFilter '(manager:1.2.840.113556.1.4.1941:=CN=Jim,OU=Managed,OU=Accounts,DC=willeke,DC=com)'
```
<!-- cheat -->

## ldap - enum - powershell - groups

### All groups

Every group object.

```sh title:"Every group object in the directory"
Get-ADObject -LDAPFilter '(objectClass=group)'
```
<!-- cheat -->

### Direct members of group

Direct (non-recursive) members of a single security group by DN.

```sh title:"Direct members of named group, no nesting"
Get-ADObject -LDAPFilter '(memberOf=CN=Admin,OU=Security,DC=DOM,DC=NT)'
```
<!-- cheat -->

### Recursive members of group

All members of a security group including those gained via nested groups (OID 1941).

```sh title:"All members including nested-group inheritance via OID 1941"
Get-ADObject -LDAPFilter '(memberOf:1.2.840.113556.1.4.1941:=CN=GroupOne,OU=Security Groups,OU=Groups,DC=YOURDOMAIN,DC=NET)'
```
<!-- cheat -->

### Recursive user members

Same recursive walk but filtered to user objects only.

```sh title:"Recursive members filtered to user objects only"
Get-ADObject -LDAPFilter '(&(objectClass=user)(memberof:1.2.840.113556.1.4.1941:=CN=GroupOne,OU=Security Groups,OU=Groups,DC=YOURDOMAIN,DC=NET))'
```
<!-- cheat -->

### All security groups

Every security group regardless of scope (groupType high bit).

```sh title:"Every security group regardless of scope"
Get-ADObject -LDAPFilter '(groupType:1.2.840.113556.1.4.803:=2147483648)'
```
<!-- cheat -->

### Empty groups

Groups with no members. Cleanup candidates and occasionally writable.

```sh title:"Groups with no members (cleanup / write candidates)"
Get-ADObject -LDAPFilter '(&(objectClass=group)(!member=*))'
```
<!-- cheat -->

### Security global groups

Security groups with Global scope.

```sh title:"Security groups with Global scope"
Get-ADObject -LDAPFilter '(&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2147483650))'
```
<!-- cheat -->

### Security domain local groups

Security groups with Domain Local scope.

```sh title:"Security groups with Domain Local scope"
Get-ADObject -LDAPFilter '(&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2147483652))'
```
<!-- cheat -->

### Security universal groups

Security groups with Universal scope (forest-wide membership).

```sh title:"Security groups with Universal scope (forest-wide)"
Get-ADObject -LDAPFilter '(&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2147483656))'
```
<!-- cheat -->

## ldap - enum - powershell - distribution groups

### All distribution groups

Every group whose security bit is unset (i.e. distribution only, no ACL impact).

```sh title:"Distribution-only groups (security bit unset)"
Get-ADObject -LDAPFilter '(&(objectCategory=group)(!(groupType:1.2.840.113556.1.4.803:=2147483648)))'
```
<!-- cheat -->

### Distribution global

Distribution groups with Global scope.

```sh title:"Distribution groups with Global scope"
Get-ADObject -LDAPFilter '(&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2)(!(groupType:1.2.840.113556.1.4.803:=2147483648))) '
```
<!-- cheat -->

### Distribution domain local

Distribution groups with Domain Local scope.

```sh title:"Distribution groups with Domain Local scope"
Get-ADObject -LDAPFilter '(&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=4)(!(groupType:1.2.840.113556.1.4.803:=2147483648))) '
```
<!-- cheat -->

### Distribution universal

Distribution groups with Universal scope.

```sh title:"Distribution groups with Universal scope"
Get-ADObject -LDAPFilter '(&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=8)(!(groupType:1.2.840.113556.1.4.803:=2147483648))) '
```
<!-- cheat -->

### Recently changed groups

Groups modified after the given timestamp. Useful for spotting fresh privilege changes.

```sh title:"Groups whenChanged after timestamp, spot fresh privesc"
Get-ADObject -LDAPFilter '(&(objectClass=group)(whenChanged>=20081231000000.0Z))'
```
<!-- cheat -->

<!-- cheat
export ldap_query
var ldap_query = printf '%s\n' "All groups # (&(objectCategory=group)(objectClass=group))" "Disabled users (UAC 2) # (&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=2))" "Users adminCount=1 # (&(objectCategory=person)(objectClass=user)(adminCount=1))" "Users adminCount=1 with SPN # (&(objectCategory=person)(objectClass=user)(adminCount=1)(servicePrincipalName=*))" "Users DoesNotRequirePreAuth=True # (&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=4194304))" "Users blank passwords # (&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=32)(adminCount=1))" "Users description set # (&(objectCategory=person)(objectClass=user)(description=*))" "Trusted for delegation users # (&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=524288))" "Trusted for delegation computers # (&(objectCategory=computer)(userAccountControl:1.2.840.113556.1.4.803:=524288))" "Users PASSWD_NOTREQD (0x20) # (&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=32))" "UserAccountControl=262656 # (&(objectCategory=person)(objectClass=user)(userAccountControl=262656))" "Groups adminCount=1 # (&(objectCategory=group)(adminCount=1))" "Computers (all) # (objectCategory=computer)" "Domain Controllers # (&(objectCategory=computer)(userAccountControl:1.2.840.113556.1.4.803:=8192))" "Global catalog servers # (&(objectCategory=nTDSDSA)(options:1.2.840.113556.1.4.803:=1))" "Exclude Domain Controllers # (&(objectCategory=computer)(!(primaryGroupID=516)))" "Exclude OpsMgr servers # (&(objectCategory=computer)(!(servicePrincipalName=MSOMHSvc/*)))" "Odd-numbered server names # (&(objectCategory=computer)(|(name=*1)(name=*3)(name=*5)(name=*7)(name=*9)))" "Disabled computers (UAC 2) # (&(objectCategory=computer)(userAccountControl:1.2.840.113556.1.4.803:=2))" "Win2K SP4 computers # (&(objectCategory=computer)(operatingSystem=Windows 2000 Professional)(operatingSystemServicePack=Service Pack 4))" "WinXP SP2 computers # (&(objectCategory=computer)(operatingSystem=Windows XP Professional)(operatingSystemServicePack=Service Pack 2))" "WinXP SP3 computers # (&(objectCategory=computer)(operatingSystem=Windows XP Professional)(operatingSystemServicePack=Service Pack 3))" "Vista SP1 computers # (&(objectCategory=computer)(operatingSystem=Windows Vista*)(operatingSystemServicePack=Service Pack 1))" "All users # (&(objectCategory=person)(objectClass=user))" "All contacts # (&(objectCategory=person)(objectClass=contact))" "All users and contacts # (|(&(objectCategory=person)(objectClass=user))(&(objectCategory=person)(objectClass=contact)))" "Users with DONT_EXPIRE_PASSWORD # (&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=65536))" "Expired user accounts # (&(objectCategory=person)(objectClass=user)(!accountExpires=0)(!accountExpires=9223372036854775807))" "Users PASSWD_NOTREQD (32) # (&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=32))" "User anomaly: DirectReports but no Manager # (&(objectCategory=person)(objectClass=user)(directReports=*)(!(manager=*)))" "Exchange hidden recipients # (msExchHideFromAddressLists=TRUE)" "Exchange hidden recipients (no public folders) # (&(msExchHideFromAddressLists=TRUE)(!objectClass=publicFolder))" "Exchange fax recipients # (proxyAddresses=FAX:*)" "Exchange mailboxes on server KUNGUR # (msExchangeHomeserverName=/o=MAILOrg/ou=First Administrative Group/cn=Configuration/cn=Servers/cn=KUNGUR)" "Report-to chain under CN=Jim # (manager:1.2.840.113556.1.4.1941:=CN=Jim,OU=Managed,OU=Accounts,DC=willeke,DC=com)" "All security groups (all scopes) # (groupType:1.2.840.113556.1.4.803:=2147483648)" "Empty groups # (&(objectClass=group)(!member=*))" "Security Global Groups # (&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2147483650))" "Security Domain Local Groups # (&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2147483652))" "Security Universal Groups # (&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2147483656))" "Distribution groups (all) # (&(objectCategory=group)(!(groupType:1.2.840.113556.1.4.803:=2147483648)))" "Distribution Global Groups # (&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=2)(!(groupType:1.2.840.113556.1.4.803:=2147483648)))" "Distribution Domain Local Groups # (&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=4)(!(groupType:1.2.840.113556.1.4.803:=2147483648)))" "Distribution Universal Groups # (&(objectCategory=group)(groupType:1.2.840.113556.1.4.803:=8)(!(groupType:1.2.840.113556.1.4.803:=2147483648)))" "Groups changed since 2008 # (&(objectClass=group)(whenChanged>=20081231000000.0Z))" --- --delimiter ' # '  --column 1 --select-column 2
-->
