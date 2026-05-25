# dnsrecon

## subdomains

### Standard enum

Run standard dnsrecon enumeration.

```sh title:"Run dnsrecon standard enum"
dnsrecon -d "$domain"
```
<!-- cheat
import domain_ip
-->

### Zone transfer

Attempt zone transfers with dnsrecon.

```sh title:"Attempt zone transfer with dnsrecon"
dnsrecon -d "$domain" -t axfr
```
<!-- cheat
import domain_ip
-->

### Reverse range

Reverse lookup an explicit IP range.

```sh title:"Reverse lookup IP range with dnsrecon"
dnsrecon -r "$start_ip-$end_ip" -n "$rhost_ip"
```
<!-- cheat
var start_ip
var end_ip
import domain_ip
-->

### Reverse CIDR

Reverse lookup a CIDR range.

```sh title:"Reverse lookup CIDR with dnsrecon"
dnsrecon -r "$cidr" -n "$rhost_ip"
```
<!-- cheat
var cidr
import domain_ip
-->
