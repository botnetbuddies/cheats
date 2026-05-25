# Smbclient

## connect

### Password

Dump password with Smbclient.

```sh title:"Smbclient Dump Password"
smbclient "\\\\$rhost_ip\\$share" -U "$user%$pass"
```
<!-- cheat
var rhost_ip
var share
var user
var pass
-->

### No password

Dump no password with Smbclient.

```sh title:"Smbclient Dump No Password"
smbclient "\\\\$rhost_ip\\$share" -U "$user%"
```
<!-- cheat
var rhost_ip
var share
var user
-->

### Null session

Run null session with Smbclient.

```sh title:"Smbclient Run Null Session"
smbclient "\\\\$rhost_ip\\$share" -U "%"
```
<!-- cheat
var rhost_ip
var share
-->

## recon

### SMB signing

Check SMB signing with Smbclient.

```sh title:"Smbclient Check SMB Signing"
nmap -Pn -sS -T4 --open --script smb-security-mode -p 445 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

## mount

### Mount C$

Mount c$ with Smbclient.

```sh title:"Smbclient Mount C$"
sudo mount -t cifs "//$rhost_ip/C\$" "$mount_point" -o "username=$user,password=$pass,domain=$domain"
```
<!-- cheat
var rhost_ip
var mount_point
var user
var pass
var domain
-->
