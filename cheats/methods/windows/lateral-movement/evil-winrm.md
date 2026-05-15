---
technique: Evil-WinRM
category: lateral-movement
targets: Windows WinRM
protocols: WinRM, HTTP, HTTPS
remote_capable: true
tags: windows winrm evil-winrm pth kerberos certificate-auth file-transfer
---

# Evil-WinRM

Evil-WinRM provides an interactive PowerShell session over WinRM from Linux or macOS. It supports password auth, NT hash auth, Kerberos, certificate auth, script loading, file upload, and file download.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| WinRM exposed | TCP 5985 or 5986 must be reachable |
| Account rights | User must be local admin or a member of Remote Management Users with sufficient rights |
| Name resolution | Kerberos mode requires correct DNS and realm configuration |

## Windows

No Windows operator command is included here. This note covers Linux-side Evil-WinRM usage.

## Linux

### Password authentication

#evil-winrm #password

Connect with username and password.

```sh title:"Connect to WinRM with password"
evil-winrm -i "$rhost_ip" -u "$user" -p "$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
-->

### Domain password authentication

#evil-winrm #password #domain

Connect with a domain-qualified username.

```sh title:"Connect to WinRM with domain user"
evil-winrm -i "$rhost_ip" -u "$domain\\$user" -p "$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
-->

### SSL authentication

#evil-winrm #https

Connect over WinRM HTTPS.

```sh title:"Connect to WinRM over HTTPS"
evil-winrm -i "$rhost_ip" -u "$user" -p "$pass" -S
```
<!-- cheat
import domain_ip
import users
import passwords
-->

### Custom port

#evil-winrm #port

Connect to a custom WinRM port.

```sh title:"Connect to custom WinRM port"
evil-winrm -i "$rhost_ip" -u "$user" -p "$pass" -P "$rport"
```
<!-- cheat
import domain_ip
import users
import passwords
var rport
-->

### Pass the hash

#evil-winrm #pth

Authenticate to WinRM with an NT hash.

```sh title:"Connect to WinRM with NT hash"
evil-winrm -i "$rhost_ip" -u "$user" -H "$nt_hash"
```
<!-- cheat
import domain_ip
import users
var nt_hash
-->

### Kerberos password authentication

#evil-winrm #kerberos

Connect with Kerberos using password authentication.

```sh title:"Connect to WinRM with Kerberos password auth"
evil-winrm -i "$rhost_fqdn" -u "$user" -p "$pass" -r "$realm"
```
<!-- cheat
import users
import passwords
var rhost_fqdn
var realm
-->

### Kerberos ccache authentication

#evil-winrm #kerberos #ccache

Connect with an existing Kerberos ticket cache.

```sh title:"Connect to WinRM with Kerberos ccache"
evil-winrm -i "$rhost_fqdn" -u "$user" -r "$realm"
```
<!-- cheat
import users
var rhost_fqdn
var realm
-->

### Certificate authentication

#evil-winrm #certificate

Authenticate to WinRM HTTPS with a certificate and private key.

```sh title:"Connect to WinRM with certificate authentication"
evil-winrm -i "$rhost_ip" -c "$cert_file" -k "$key_file" -S
```
<!-- cheat
import domain_ip
var cert_file
var key_file
-->

### Scripts directory

#evil-winrm #scripts

Start Evil-WinRM with a scripts directory for in-memory script loading.

```sh title:"Start Evil-WinRM with scripts directory"
evil-winrm -i "$rhost_ip" -u "$user" -p "$pass" -s "$scripts_dir"
```
<!-- cheat
import domain_ip
import users
import passwords
var scripts_dir
-->

### Executables directory

#evil-winrm #execute-assembly

Start Evil-WinRM with an executables directory for .NET assembly loading.

```sh title:"Start Evil-WinRM with executables directory"
evil-winrm -i "$rhost_ip" -u "$user" -p "$pass" -e "$executables_dir"
```
<!-- cheat
import domain_ip
import users
import passwords
var executables_dir
-->
