# dnsrecon

## subdomains

### Standard enum

Enumerate standard enum with dnsrecon.

```sh title:"Dnsrecon Enumerate Standard Enum"
dnsrecon -d "$domain"
```
<!-- cheat
import domain_ip
-->

### Zone transfer

Enumerate zone transfer with dnsrecon.

```sh title:"Dnsrecon Enumerate Zone Transfer"
dnsrecon -d "$domain" -t axfr
```
<!-- cheat
import domain_ip
-->

### Reverse range

Enumerate reverse range with dnsrecon.

```sh title:"Dnsrecon Enumerate Reverse Range"
dnsrecon -r "$start_ip-$end_ip" -n "$rhost_ip"
```
<!-- cheat
var start_ip
var end_ip
import domain_ip
-->

### Reverse CIDR

Enumerate reverse CIDR with dnsrecon.

```sh title:"Dnsrecon Enumerate Reverse CIDR"
dnsrecon -r "$cidr" -n "$rhost_ip"
```
<!-- cheat
var cidr
import domain_ip
-->
