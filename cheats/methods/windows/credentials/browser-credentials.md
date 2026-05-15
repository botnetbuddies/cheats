---
technique: Browser Credential Stores
category: credentials
targets: Windows User Profiles
protocols: Local
remote_capable: false
tags: windows credentials browser chrome edge firefox dpapi
---

# Browser Credential Stores

Browser credential stores hold saved passwords, cookies, tokens, and session databases protected by user context and DPAPI.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| User profile access | Browser data is stored under each user's profile |
| DPAPI context | Decryption usually requires the user context or DPAPI material |
| Browser profile | Target browser must have stored credentials or cookies |

## Windows

### Chrome user data

#cmd #browser #chrome

List Chrome user data for the current user.

```cmd title:"List Chrome user data"
dir "%LOCALAPPDATA%\Google\Chrome\User Data"
```
<!-- cheat -->

### Edge user data

#cmd #browser #edge

List Edge user data for the current user.

```cmd title:"List Edge user data"
dir "%LOCALAPPDATA%\Microsoft\Edge\User Data"
```
<!-- cheat -->

### Firefox profiles

#cmd #browser #firefox

List Firefox profiles for the current user.

```cmd title:"List Firefox profiles"
dir "%APPDATA%\Mozilla\Firefox\Profiles"
```
<!-- cheat -->

### Chrome login database

#cmd #browser #chrome

List Chrome login databases.

```cmd title:"List Chrome login databases"
dir "%LOCALAPPDATA%\Google\Chrome\User Data\*\Login Data"
```
<!-- cheat -->

### Chrome cookies

#cmd #browser #chrome

List Chrome cookie databases.

```cmd title:"List Chrome cookie databases"
dir "%LOCALAPPDATA%\Google\Chrome\User Data\*\Network\Cookies"
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers Windows browser credential stores.
