# Enum4linux

## enum

### All

Run broad enum4linux enumeration.

```sh title:"Run broad enum4linux enumeration"
enum4linux -a "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Verbose

Run verbose enum4linux enumeration.

```sh title:"Run verbose enum4linux enumeration"
enum4linux -v "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Null access

Run enum4linux with null credentials.

```sh title:"Run enum4linux with null credentials"
enum4linux -u "" -p "" "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Guest access

Run enum4linux as guest.

```sh title:"Run enum4linux as guest"
enum4linux -u "guest" -p "" "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Password

Run enum4linux with username and password.

```sh title:"Run enum4linux with password"
enum4linux -u "$user" -p "$pass" "$rhost_ip"
```
<!-- cheat
var user
var pass
var rhost_ip
-->

### Users

List users with enum4linux.

```sh title:"List users with enum4linux"
enum4linux -U "$rhost_ip" | grep 'user:'
```
<!-- cheat
var rhost_ip
-->
