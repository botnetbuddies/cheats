# Enum4linux

## enum

### All

Enumerate all with Enum4linux.

```sh title:"Enum4linux Enumerate All"
enum4linux -a "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Verbose

Enumerate verbose with Enum4linux.

```sh title:"Enum4linux Enumerate Verbose"
enum4linux -v "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Null access

Dump null access with Enum4linux.

```sh title:"Enum4linux Dump Null Access"
enum4linux -u "" -p "" "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Guest access

Enumerate guest access with Enum4linux.

```sh title:"Enum4linux Enumerate Guest Access"
enum4linux -u "guest" -p "" "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Password

Dump password with Enum4linux.

```sh title:"Enum4linux Dump Password"
enum4linux -u "$user" -p "$pass" "$rhost_ip"
```
<!-- cheat
var user
var pass
var rhost_ip
-->

### Users

List users with Enum4linux.

```sh title:"Enum4linux List Users"
enum4linux -U "$rhost_ip" | grep 'user:'
```
<!-- cheat
var rhost_ip
-->
