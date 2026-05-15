---
tool: Katana
category: tools
targets: Web Applications
protocols: HTTP, HTTPS
remote_capable: true
tags: web crawler katana tools
---

# Katana

Katana crawls web applications and extracts routes, JavaScript links, forms, and discovered endpoints.

## Linux

### Crawl URL

#sh #katana #web

Crawl a target URL.

```sh title:"Crawl URL with Katana"
katana -u "$url"
```
<!-- cheat
var url
-->

### Crawl list

#sh #katana #web

Crawl URLs from a file.

```sh title:"Crawl URL list with Katana"
katana -list "$urls_file"
```
<!-- cheat
var urls_file
-->

### Headless crawl

#sh #katana #web

Crawl with headless browser support.

```sh title:"Crawl with Katana headless mode"
katana -u "$url" -headless
```
<!-- cheat
var url
-->
