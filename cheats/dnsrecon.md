# dnsrecon

## subdomains

### Standard enum

Run standard dnsrecon enumeration.

```sh title:"Run dnsrecon standard enum"
dnsrecon -d "$domain"
```
<!-- cheat
var domain
-->

### Zone transfer

Attempt zone transfers with dnsrecon.

```sh title:"Attempt zone transfer with dnsrecon"
dnsrecon -d "$domain" -t axfr
```
<!-- cheat
var domain
-->

### Reverse range

Reverse lookup an explicit IP range.

```sh title:"Reverse lookup IP range with dnsrecon"
dnsrecon -r "$start_ip-$end_ip" -n "$dns_server"
```
<!-- cheat
var start_ip
var end_ip
var dns_server
-->

### Reverse CIDR

Reverse lookup a CIDR range.

```sh title:"Reverse lookup CIDR with dnsrecon"
dnsrecon -r "$cidr" -n "$dns_server"
```
<!-- cheat
var cidr
var dns_server
-->