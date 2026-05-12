# Smbclient

## connect

### Password

Connect to an SMB share with username and password.

```sh title:"Connect to SMB share with password"
smbclient "\\\\$rhost_ip\\$share" -U "$user%$pass"
```
<!-- cheat
var rhost_ip
var share
var user
var pass
-->

### No password

Connect to an SMB share with a username and no password.

```sh title:"Connect to SMB share with username and no password"
smbclient "\\\\$rhost_ip\\$share" -U "$user%"
```
<!-- cheat
var rhost_ip
var share
var user
-->

### Null session

Connect to an SMB share with a null session.

```sh title:"Connect to SMB share with null session"
smbclient "\\\\$rhost_ip\\$share" -U "%"
```
<!-- cheat
var rhost_ip
var share
-->

## recon

### SMB signing

Check SMB signing with nmap.

```sh title:"Check SMB signing with nmap"
nmap -Pn -sS -T4 --open --script smb-security-mode -p 445 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

## mount

### Mount C$

Mount the administrative `C$` share over CIFS.

```sh title:"Mount administrative C$ share over CIFS"
sudo mount -t cifs "//$rhost_ip/C\$" "$mount_point" -o "username=$user,password=$pass,domain=$domain"
```
<!-- cheat
var rhost_ip
var mount_point
var user
var pass
var domain
-->
