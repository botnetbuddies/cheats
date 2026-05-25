# Smbclient

## connect

### Password

Dump password with Smbclient.

Connect to an SMB share with username and password.

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

Connect to an SMB share with a username and no password.

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

Connect to an SMB share with a null session.

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

Check SMB signing with nmap.

```sh title:"Smbclient Check SMB Signing"
nmap -Pn -sS -T4 --open --script smb-security-mode -p 445 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

## mount

### Mount C$

Mount c$ with Smbclient.

Mount the administrative `C$` share over CIFS.

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
