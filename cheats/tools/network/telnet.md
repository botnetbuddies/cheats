# Telnet

## recon

### Nmap safe scripts

Enumerate nmap safe scripts with Telnet.

Run safe Telnet NSE scripts.

```sh title:"Telnet Enumerate Nmap Safe Scripts"
nmap -n -sV -Pn --script "*telnet* and safe" -p 23 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

## connect

### Connect

Run connect with Telnet.

Connect to a Telnet service.

```sh title:"Telnet Run Connect"
telnet "$rhost_ip" "$rport"
```
<!-- cheat
var rhost_ip
var rport := 23
-->
