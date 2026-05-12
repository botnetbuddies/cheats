# Smbmap

## enum

### Password

Enumerate SMB shares with username and password.

```sh title:"Enumerate SMB shares with password"
smbmap -H "$rhost_ip" -u "$user" -p "$pass" -d "$domain"
```
<!-- cheat
var rhost_ip
var user
var pass
var domain
-->

### Null access

Enumerate SMB shares with null access.

```sh title:"Enumerate SMB shares with null access"
smbmap -u "" -p "" -P 445 -H "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Guest access

Enumerate SMB shares as guest.

```sh title:"Enumerate SMB shares as guest"
smbmap -u "guest" -p "" -P 445 -H "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Share roots

List the root of all readable shares.

```sh title:"List root of readable SMB shares"
smbmap -H "$rhost_ip" -u "$user" -p "$pass" -d "$domain" -r
```
<!-- cheat
var rhost_ip
var user
var pass
var domain
-->

### Recursive path

Recursively list a path on readable shares.

```sh title:"Recursively list SMB path"
smbmap -H "$rhost_ip" -u "$user" -p "$pass" -d "$domain" -R "$path" --depth "$depth"
```
<!-- cheat
var rhost_ip
var user
var pass
var domain
var path
var depth := 1
-->
