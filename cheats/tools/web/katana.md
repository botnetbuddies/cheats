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

Run crawl URL with Katana.

#sh #katana #web

Crawl a target URL.

```sh title:"Katana Run Crawl URL"
katana -u "$url"
```
<!-- cheat
var url
-->

### Crawl list

#sh #katana #web

List crawl list with Katana.

#sh #katana #web

Crawl URLs from a file.

```sh title:"Katana List Crawl List"
katana -list "$urls_file"
```
<!-- cheat
var urls_file
-->

### Headless crawl

#sh #katana #web

Run headless crawl with Katana.

#sh #katana #web

Crawl with headless browser support.

```sh title:"Katana Run Headless Crawl"
katana -u "$url" -headless
```
<!-- cheat
var url
-->
