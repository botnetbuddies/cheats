---
technique: Drupal Enumeration
category: cms
targets: Drupal
protocols: HTTP, HTTPS
remote_capable: true
tags: web drupal cms
---

# Drupal Enumeration

Drupal enumeration checks core indicators, exposed changelog files, user endpoints, modules, and known vulnerable routes.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| URL | Requires a target Drupal URL |
| Version | Version-specific paths and modules matter |
| Tooling | Commands use curl and droopescan |

## Linux

### Changelog probe

#sh #curl #drupal

Check for an exposed Drupal changelog.

```sh title:"Check Drupal changelog"
curl -sk "$url/CHANGELOG.txt"
```
<!-- cheat
var url
-->

### User login probe

#sh #curl #drupal

Check Drupal user login route.

```sh title:"Check Drupal user login route"
curl -sk "$url/user/login"
```
<!-- cheat
var url
-->

### droopescan

#sh #droopescan #drupal

Run droopescan against Drupal.

```sh title:"Run droopescan against Drupal"
droopescan scan drupal -u "$url"
```
<!-- cheat
var url
-->
