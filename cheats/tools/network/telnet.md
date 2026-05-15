# Telnet

## recon

### Nmap safe scripts

Run safe Telnet NSE scripts.

```sh title:"Run safe Telnet NSE scripts"
nmap -n -sV -Pn --script "*telnet* and safe" -p 23 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

## connect

### Connect

Connect to a Telnet service.

```sh title:"Connect to Telnet"
telnet "$rhost_ip" "$rport"
```
<!-- cheat
var rhost_ip
var rport := 23
-->
