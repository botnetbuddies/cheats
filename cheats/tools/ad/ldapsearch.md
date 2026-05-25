# Ldapsearch

## ldapsearch

### Anonymous password policy

Anonymous LDAP bind that pulls the domain password policy (lockout threshold, complexity, history). Works on misconfigured DCs that allow anonymous reads.

```sh title:"Ldapsearch Anonymous bind, fetch password policy attributes"
ldapsearch -H $target -x -b "$base_dn" -s sub "*" | grep -m 1 -B 10 pwdHistoryLength
```
<!-- cheat
var target
var base_dn
-->

### Anonymous user list

Anonymous LDAP bind to enumerate sAMAccountNames. Free userlist if the DC accepts unauthenticated reads.

```sh title:"Ldapsearch Anonymous bind, dump sAMAccountName values for spraying"
ldapsearch -H $target -x -b "$base_dn" -s sub "(&(objectclass=user))"  | grep sAMAccountName: | cut -f2 -d" "
```
<!-- cheat
var target
var base_dn
-->

### Base query

Query the LDAP root DSE.

```sh title:"Ldapsearch Query LDAP root DSE"
ldapsearch -x -H "ldap://$rhost_name" -s base
```
<!-- cheat
var rhost_name
-->

### Search base DN

Run an anonymous LDAP search from a base DN.

```sh title:"Ldapsearch Anonymous LDAP search from base DN"
ldapsearch -x -H "ldap://$rhost_name" -b "$base_dn"
```
<!-- cheat
var rhost_name
var base_dn
-->

### Nmap LDAP enum

Run LDAP nmap scripts except brute force scripts.

```sh title:"Ldapsearch Run LDAP nmap enum scripts"
nmap -n -sV --script "ldap* and not brute" -p 389 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### SPNs with Kerberos

Search for service principal names using GSSAPI.

```sh title:"Ldapsearch Search LDAP SPNs with GSSAPI"
ldapsearch -Y GSSAPI -H "ldap://$rhost_name" -D "$user" -W -b "$base_dn" "servicePrincipalName=*" servicePrincipalName
```
<!-- cheat
var rhost_name
var user
var base_dn
-->

### Authenticated users

List domain users with simple bind credentials.

```sh title:"Ldapsearch List LDAP users with simple bind"
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

List users protected by `adminCount=1`.

```sh title:"Ldapsearch List LDAP users with adminCount=1"
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

Search user descriptions for password-related strings.

```sh title:"Ldapsearch Search LDAP user descriptions for password words"
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

Query LAPS attributes and return `ms-Mcs-AdmPwd` if readable.

```sh title:"Ldapsearch Query readable LAPS password attributes"
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

Dump LDAP domain data with simple bind credentials.

```sh title:"Ldapsearch Dump LDAP domain data with ldapdomaindump"
ldapdomaindump --no-json --no-grep --authtype SIMPLE -o ldap_dump -r "$rhost_ip" -u "$domain\\$user" -p "$pass"
```
<!-- cheat
var rhost_ip
var domain
var user
var pass
-->

### Password policies

List all password policies, including fine-grained password policies.

```sh title:"List LDAP password policies with ldapsearch-ad"
ldapsearch-ad.py --server "$rhost_name" -d "$domain" -u "$user" -p "$pass" --type pass-pols
```
<!-- cheat
var rhost_name
var domain
var user
var pass
-->

### Group FGPP

Show fine-grained password policy applied to a group.

```sh title:"Ldapsearch Show FGPP applied to group"
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

Show fine-grained password policy applied to a user.

```sh title:"Ldapsearch Show FGPP applied to user"
ldapsearch-ad.py --server "$rhost_name" -d "$domain" -u "$user" -p "$pass" --type show-user -s "(samaccountname=$target_user)"
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var target_user
-->
