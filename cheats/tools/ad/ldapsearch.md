# Ldapsearch

## ldapsearch

### Anonymous password policy

Dump anonymous password policy with Ldapsearch.

```sh title:"Ldapsearch Dump Anonymous Password Policy"
ldapsearch -H $target -x -b "$base_dn" -s sub "*" | grep -m 1 -B 10 pwdHistoryLength
```
<!-- cheat
var target
var base_dn
-->

### Anonymous user list

List anonymous user list with Ldapsearch.

```sh title:"Ldapsearch List Anonymous User List"
ldapsearch -H $target -x -b "$base_dn" -s sub "(&(objectclass=user))"  | grep sAMAccountName: | cut -f2 -d" "
```
<!-- cheat
var target
var base_dn
-->

### Base query

Find base query with Ldapsearch.

```sh title:"Ldapsearch Find Base Query"
ldapsearch -x -H "ldap://$rhost_name" -s base
```
<!-- cheat
var rhost_name
-->

### Search base DN

Search base DN with Ldapsearch.

```sh title:"Ldapsearch Search Base DN"
ldapsearch -x -H "ldap://$rhost_name" -b "$base_dn"
```
<!-- cheat
var rhost_name
var base_dn
-->

### Nmap LDAP enum

Find nmap LDAP enum with Ldapsearch.

```sh title:"Ldapsearch Find Nmap LDAP Enum"
nmap -n -sV --script "ldap* and not brute" -p 389 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### SPNs with Kerberos

Find SPNs with kerberos with Ldapsearch.

```sh title:"Ldapsearch Find SPNs with Kerberos"
ldapsearch -Y GSSAPI -H "ldap://$rhost_name" -D "$user" -W -b "$base_dn" "servicePrincipalName=*" servicePrincipalName
```
<!-- cheat
var rhost_name
var user
var base_dn
-->

### Authenticated users

Read authenticated users with Ldapsearch.

```sh title:"Ldapsearch Read Authenticated Users"
ldapsearch -x -H "ldap://$rhost_name" -D "$domain\\$user" -w "$pass" -b "$base_dn" '(&(objectCategory=person)(objectClass=user))'
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var base_dn
-->

### AdminCount users

Find AdminCount users with Ldapsearch.

```sh title:"Ldapsearch Find AdminCount Users"
ldapsearch -x -H "ldap://$rhost_name" -D "$domain\\$user" -w "$pass" -b "$base_dn" '(&(objectCategory=user)(adminCount=1))'
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var base_dn
-->

### Password descriptions

Dump password descriptions with Ldapsearch.

```sh title:"Ldapsearch Dump Password Descriptions"
ldapsearch -x -H "ldap://$rhost_name" -D "$domain\\$user" -w "$pass" -b "$base_dn" '(&(objectCategory=user)(|(description=*pass*)(description=*password*)(description=*identifiant*)(description=*pwd*)))'
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var base_dn
-->

### LAPS password attribute

Read LAPS password attribute with Ldapsearch.

```sh title:"Ldapsearch Read LAPS Password Attribute"
ldapsearch -x -H "ldap://$rhost_name" -D "$domain\\$user" -w "$pass" -b "$base_dn" '(ms-Mcs-AdmPwdExpirationtime=*)' ms-Mcs-AdmPwd
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var base_dn
-->

### ldapdomaindump

Dump ldapdomaindump with Ldapsearch.

```sh title:"Ldapsearch Dump Ldapdomaindump"
ldapdomaindump --no-json --no-grep --authtype SIMPLE -o ldap_dump -r "$rhost_ip" -u "$domain\\$user" -p "$pass"
```
<!-- cheat
var rhost_ip
var domain
var user
var pass
-->

### Password policies

Dump password policies with Ldapsearch.

```sh title:"Ldapsearch Dump Password Policies"
ldapsearch-ad.py --server "$rhost_name" -d "$domain" -u "$user" -p "$pass" --type pass-pols
```
<!-- cheat
var rhost_name
var domain
var user
var pass
-->

### Group FGPP

Find group FGPP with Ldapsearch.

```sh title:"Ldapsearch Find Group FGPP"
ldapsearch-ad.py --server "$rhost_name" -d "$domain" -u "$user" -p "$pass" -t search -s "(samaccountname=$group)" cn msDS-PSOApplied
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var group
-->

### User FGPP

Find user FGPP with Ldapsearch.

```sh title:"Ldapsearch Find User FGPP"
ldapsearch-ad.py --server "$rhost_name" -d "$domain" -u "$user" -p "$pass" --type show-user -s "(samaccountname=$target_user)"
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var target_user
-->
