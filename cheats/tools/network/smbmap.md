# Smbmap

## enum

### Password

Dump password with Smbmap.

```sh title:"Smbmap Dump Password"
smbmap -H "$rhost_ip" -u "$user" -p "$pass" -d "$domain"
```
<!-- cheat
var rhost_ip
var user
var pass
var domain
-->

### Null access

Enumerate null access with Smbmap.

```sh title:"Smbmap Enumerate Null Access"
smbmap -u "" -p "" -P 445 -H "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Guest access

Enumerate guest access with Smbmap.

```sh title:"Smbmap Enumerate Guest Access"
smbmap -u "guest" -p "" -P 445 -H "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Share roots

Read share roots with Smbmap.

```sh title:"Smbmap Read Share Roots"
smbmap -H "$rhost_ip" -u "$user" -p "$pass" -d "$domain" -r
```
<!-- cheat
var rhost_ip
var user
var pass
var domain
-->

### Recursive path

List recursive path with Smbmap.

```sh title:"Smbmap List Recursive Path"
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
