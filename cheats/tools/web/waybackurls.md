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

Run domain URLs with waybackurls.

#sh #waybackurls #web

Collect archived URLs for a domain.

```sh title:"Waybackurls Run Domain URLs"
waybackurls "$domain"
```
<!-- cheat
var domain
-->

### Subdomain URLs

#sh #waybackurls #web

Run subdomain URLs with waybackurls.

#sh #waybackurls #web

Collect archived URLs for a subdomain.

```sh title:"Waybackurls Run Subdomain URLs"
waybackurls "$subdomain"
```
<!-- cheat
var subdomain
-->
