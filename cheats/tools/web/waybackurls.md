---
tool: waybackurls
category: tools
targets: Web Applications
protocols: HTTP, HTTPS
remote_capable: true
tags: web archive urls tools
---

# waybackurls

waybackurls collects archived URLs for a domain to seed content discovery, parameter discovery, and historical endpoint review.

## Linux

### Domain URLs

#sh #waybackurls #web

Collect archived URLs for a domain.

```sh title:"waybackurls Collect archived URLs"
waybackurls "$domain"
```
<!-- cheat
var domain
-->

### Subdomain URLs

#sh #waybackurls #web

Collect archived URLs for a subdomain.

```sh title:"waybackurls Collect archived subdomain URLs"
waybackurls "$subdomain"
```
<!-- cheat
var subdomain
-->
