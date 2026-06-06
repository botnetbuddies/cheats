---
tool: Katana
category: tools
targets: Web Applications
protocols: HTTP, HTTPS
remote_capable: true
tags: web crawler katana tools
---

# Katana

Katana crawls web applications and extracts discovered URLs, routes, JavaScript endpoints, forms, XHRs, and page resources. Keep crawls scoped and paced; headless, authenticated, form-fill, and high-concurrency crawls can create traffic or trigger state-changing behavior if used carelessly.

Validated against Katana `v1.6.1`.

<!-- cheat
export katana
var output_file = printf '%s\n' katana.jsonl katana-urls.txt "katana-$(date +%Y%m%d-%H%M%S).jsonl" --- --header 'Katana output file'
var output_dir = printf '%s\n' katana-responses katana-output "katana-output-$(date +%Y%m%d-%H%M%S)" --- --header 'Katana output directory'
var katana_scope_templates = printf '%s\n' '-depth 2 -fs fqdn -rate-limit 25 -concurrency 5 # safe same-host crawl' '-depth 3 -fs rdn -rate-limit 50 -concurrency 10 # registered-domain crawl' '-depth 3 -cs "$scope_regex" -cos "$out_scope_regex" # explicit regex scope' --- --header 'Katana scope profile'
var katana_output_templates = printf '%s\n' '-jsonl -output katana.jsonl # compact JSONL' '-store-response -store-response-dir katana-responses -output katana-with-responses.txt # store requests/responses' '-silent -output katana-urls.txt # plain URL output' --- --header 'Katana output profile'
-->

## Linux

### Crawl one URL with safe defaults

#sh #katana #web

Start with one URL, shallow depth, explicit same-host scope, and a conservative rate limit. `-fs fqdn` keeps crawling tied to the input host instead of expanding across the registered domain.

```sh title:"Crawl one URL with safe defaults"
katana -u "$url" \
  -depth 2 -fs fqdn \
  -rate-limit 25 -concurrency 5 -timeout 10 \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Crawl a URL list conservatively

#sh #katana #web

Use a URL list when each line is an allowed starting point. Keep `-parallelism` modest so many inputs do not multiply total request volume unexpectedly.

```sh title:"Crawl a URL list conservatively"
katana -list "$url_list" \
  -depth 2 -fs fqdn \
  -parallelism 5 -concurrency 5 -rate-limit 50 \
  -output "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### Crawl within the registered domain

#sh #katana #web

For an explicitly authorized apex/domain crawl, use registered-domain scope. This is broader than `fqdn` and may crawl sibling hosts under the same registered domain.

```sh title:"Crawl within the registered domain"
katana -u "$url" \
  -depth 3 -fs rdn \
  -rate-limit 50 -concurrency 10 \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Crawl only an explicit host scope

#sh #katana #web

For a precise engagement scope, provide an in-scope regex. Escape dots and anchor host patterns so unrelated domains do not match by substring.

```sh title:"Crawl only an explicit host scope"
katana -u "$url" \
  -crawl-scope "$scope_regex" \
  -crawl-out-scope "$out_scope_regex" \
  -depth 3 -rate-limit 25 \
  -output "$output_file"
```
<!-- cheat
var url
var scope_regex
var out_scope_regex
var output_file
-->

### Write compact JSONL crawl output

#sh #katana #web

Use JSONL when you need form details, XHR metadata, raw evidence, or stable fields for later review. `-omit-body` keeps output smaller and reduces sensitive response capture.

```sh title:"Write compact JSONL crawl output"
katana -u "$url" \
  -depth 2 -fs fqdn \
  -jsonl -omit-body \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### List Katana JSONL output fields

#sh #katana #web

List the JSONL fields supported by the installed Katana version before scripting against field names.

```sh title:"List Katana JSONL output fields"
katana -list-output-fields
```
<!-- cheat
-->

### Store crawl requests and responses

#sh #katana #web

Store full HTTP requests and responses only for a small, reviewed scope. This can capture secrets, tokens, personal data, and large response bodies.

```sh title:"Store crawl requests and responses"
katana -u "$url" \
  -depth 2 -fs fqdn \
  -store-response -store-response-dir "$output_dir" \
  -output "$output_file"
```
<!-- cheat
var url
var output_dir
var output_file
-->

### Parse JavaScript-linked endpoints

#sh #katana #web

Enable JavaScript endpoint parsing with `-js-crawl`. This extracts and follows endpoints referenced from JavaScript files without needing a browser.

```sh title:"Parse JavaScript-linked endpoints"
katana -u "$url" \
  -depth 3 -fs fqdn \
  -js-crawl \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Use deeper JavaScript parsing

#sh #katana #web

Use `-jsluice` for deeper JavaScript parsing when the target is JS-heavy. It is memory intensive, so keep scope and depth controlled.

```sh title:"Use deeper JavaScript parsing"
katana -u "$url" \
  -depth 3 -fs fqdn \
  -js-crawl -jsluice \
  -rate-limit 25 \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Crawl known files and sitemap routes

#sh #katana #web

Include known files such as `robots.txt` and sitemap XML when you want Katana-native route discovery from common metadata files. Katana requires at least depth 3 for known-file crawling to be effective.

```sh title:"Crawl known files and sitemap routes"
katana -u "$url" \
  -depth 3 -fs fqdn \
  -known-files robotstxt,sitemapxml \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Keep selected route and file extensions

#sh #katana #web

Keep only discovered outputs with specific extensions. Include `none` when extensionless routes are useful.

```sh title:"Keep selected route and file extensions"
katana -u "$url" \
  -depth 3 -fs fqdn \
  -js-crawl \
  -extension-match js,json,php,aspx,html,none \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Filter common static asset extensions

#sh #katana #web

Filter noisy static assets when the goal is route and endpoint discovery rather than asset inventory.

```sh title:"Filter common static asset extensions"
katana -u "$url" \
  -depth 3 -fs fqdn \
  -js-crawl \
  -extension-filter png,jpg,jpeg,gif,svg,woff,woff2,css,ico \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Crawl dynamically rendered pages headlessly

#sh #katana #web

Use headless mode when routes appear only after browser rendering. It is heavier and noisier than the standard crawler, so keep depth and rate conservative.

```sh title:"Crawl dynamically rendered pages headlessly"
katana -u "$url" \
  -headless -system-chrome \
  -depth 2 -fs fqdn \
  -rate-limit 10 -concurrency 3 \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Run hybrid standard and headless crawl

#sh #katana #web

Hybrid mode combines standard and headless crawling for broader coverage. Use it after a non-headless pass shows missing browser-rendered routes.

```sh title:"Run hybrid standard and headless crawl"
katana -u "$url" \
  -hybrid -system-chrome \
  -depth 2 -fs fqdn \
  -rate-limit 10 -concurrency 3 \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Extract XHR URLs from headless crawl

#sh #katana #web

Extract XHR URLs and methods during headless crawling. JSONL output is useful because it preserves method metadata.

```sh title:"Extract XHR URLs from headless crawl"
katana -u "$url" \
  -headless -system-chrome -xhr-extraction \
  -depth 2 -fs fqdn \
  -jsonl -omit-body \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Wait for dynamic page stability

#sh #katana #web

Tune page loading when single-page apps miss late-rendered links. Start with small waits; long waits multiply crawl time quickly.

```sh title:"Wait for dynamic page stability"
katana -u "$url" \
  -headless -system-chrome \
  -page-load-strategy domcontentloaded -dom-wait-time 8 \
  -depth 2 -fs fqdn \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Extract forms without filling them

#sh #katana #web

Extract forms without submitting them. This is safer than automatic form filling and is usually the right first pass on authenticated or stateful applications.

```sh title:"Extract forms without filling them"
katana -u "$url" \
  -depth 2 -fs fqdn \
  -form-extraction \
  -jsonl -omit-body \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Authorized automatic form fill with exclusions

#sh #katana #web

Avoid `-automatic-form-fill` by default. Use it only when the rules of engagement allow form interaction and the crawl is constrained away from logout, delete, purchase, invite, password, and profile-update paths.

```sh title:"Authorized automatic form fill with exclusions"
katana -u "$url" \
  -depth 2 -fs fqdn \
  -automatic-form-fill \
  -crawl-out-scope 'logout|signout|delete|remove|destroy|purchase|invite|password|profile' \
  -rate-limit 10 -concurrency 2 \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Crawl with a session cookie

#sh #katana #web

Pass cookies as headers. Prefer environment variables or a local shell history-disabled workflow; do not commit cookies, bearer tokens, or session headers to files in the repository.

```sh title:"Crawl with a session cookie"
katana -u "$url" \
  -headers "Cookie: $cookie_header" \
  -depth 2 -fs fqdn \
  -rate-limit 10 -concurrency 3 \
  -output "$output_file"
```
<!-- cheat
var url
var cookie_header
var output_file
-->

### Crawl with custom auth headers

#sh #katana #web

Use repeated `-headers` flags for required auth, CSRF, tenant, or API headers.

```sh title:"Crawl with custom auth headers"
katana -u "$url" \
  -headers "Cookie: $cookie_header" \
  -headers "X-CSRF-Token: $csrf_token" \
  -headers "X-Requested-With: XMLHttpRequest" \
  -depth 2 -fs fqdn \
  -output "$output_file"
```
<!-- cheat
var url
var cookie_header
var csrf_token
var output_file
-->

### Crawl with a bearer token

#sh #katana #web

For bearer or API-token-backed applications, pass the token as an authorization header and keep output compact to avoid capturing sensitive response bodies.

```sh title:"Crawl with a bearer token"
katana -u "$url" \
  -headers "Authorization: Bearer $bearer_token" \
  -headers "Accept: application/json" \
  -depth 2 -fs fqdn \
  -jsonl -omit-body \
  -output "$output_file"
```
<!-- cheat
var url
var bearer_token
var output_file
-->

### Crawl with headers from a file

#sh #katana #web

Read headers from a local file when many headers are required. Keep that file outside version control and delete it after the engagement if it contains secrets.

```sh title:"Crawl with headers from a file"
katana -u "$url" \
  -headers "$header_file" \
  -depth 2 -fs fqdn \
  -output "$output_file"
```
<!-- cheat
var url
var header_file
var output_file
-->

### Headless authenticated crawl with cookie

#sh #katana #web

Use headless mode for pages where auth-dependent routes only appear after browser-side rendering.

```sh title:"Headless authenticated crawl with cookie"
katana -u "$url" \
  -headless -system-chrome \
  -headers "Cookie: $cookie_header" \
  -depth 2 -fs fqdn \
  -rate-limit 10 -concurrency 2 \
  -output "$output_file"
```
<!-- cheat
var url
var cookie_header
var output_file
-->

### Headless crawl with a Chrome session profile

#sh #katana #web

Reuse a Chrome data directory for browser/session-oriented crawling when you have already established a valid session in that profile. Keep the data directory local and protected because it may contain session material.

```sh title:"Headless crawl with a Chrome session profile"
katana -u "$url" \
  -headless -system-chrome \
  -chrome-data-dir "$chrome_data_dir" -no-incognito \
  -depth 2 -fs fqdn \
  -output "$output_file"
```
<!-- cheat
var url
var chrome_data_dir
var output_file
-->

### Use an existing Chrome debug session

#sh #katana #web

Attach to an already launched Chrome debugging instance when you need Katana to use an existing browser context.

```sh title:"Use an existing Chrome debug session"
katana -u "$url" \
  -headless \
  -chrome-ws-url "$chrome_ws_url" \
  -depth 2 -fs fqdn \
  -output "$output_file"
```
<!-- cheat
var url
var chrome_ws_url
var output_file
-->

### Headless auto-login with a test account

#sh #katana #web

Automatic login is supported for simple username/password flows in headless mode, but it is experimental and easy to misuse. Prefer a short-lived test account with minimal privileges.

```sh title:"Headless auto-login with a test account"
katana -u "$url" \
  -headless -system-chrome \
  -auto-login "$username:$password" \
  -depth 2 -fs fqdn \
  -crawl-out-scope 'logout|signout|delete|remove|destroy|password' \
  -output "$output_file"
```
<!-- cheat
var url
var username
var password
var output_file
-->

### Debug login redirects with verbose output

#sh #katana #web

If every result is a login page, first confirm the cookie/header set works with a single shallow crawl and verbose output.

```sh title:"Debug login redirects with verbose output"
katana -u "$url" \
  -headers "Cookie: $cookie_header" \
  -depth 1 -fs fqdn \
  -disable-redirects \
  -verbose
```
<!-- cheat
var url
var cookie_header
-->

### Troubleshoot missing authenticated XHR routes

#sh #katana #web

If CSRF or AJAX-only routes are missing, include the same headers the browser sends and enable XHR extraction in headless mode.

```sh title:"Troubleshoot missing authenticated XHR routes"
katana -u "$url" \
  -headless -system-chrome -xhr-extraction \
  -headers "Cookie: $cookie_header" \
  -headers "X-CSRF-Token: $csrf_token" \
  -headers "X-Requested-With: XMLHttpRequest" \
  -depth 2 -fs fqdn \
  -jsonl -omit-body \
  -output "$output_file"
```
<!-- cheat
var url
var cookie_header
var csrf_token
var output_file
-->

### Show external discoveries without following them

#sh #katana #web

If authenticated paths are unexpectedly absent, check whether scope or depth is too restrictive. Temporarily display out-of-scope discoveries rather than disabling scope.

```sh title:"Show external discoveries without following them"
katana -u "$url" \
  -headers "Cookie: $cookie_header" \
  -depth 3 -fs fqdn \
  -display-out-scope \
  -output "$output_file"
```
<!-- cheat
var url
var cookie_header
var output_file
-->

### Limit crawl duration for short-lived sessions

#sh #katana #web

If a session expires quickly, reduce crawl time and request volume. `-crawl-duration` accepts values such as `30s`, `5m`, or `1h`.

```sh title:"Limit crawl duration for short-lived sessions"
katana -u "$url" \
  -headers "Cookie: $cookie_header" \
  -depth 2 -fs fqdn \
  -crawl-duration 5m \
  -rate-limit 10 -concurrency 2 \
  -output "$output_file"
```
<!-- cheat
var url
var cookie_header
var output_file
-->

### Debug cookie domain and path assumptions

#sh #katana #web

If cookies work in a browser but not Katana, verify that the copied cookie is for the same domain/path, is not expired, and includes all required session cookies. Use exact FQDN scope while debugging so redirects and sibling hosts are obvious.

```sh title:"Debug cookie domain and path assumptions"
katana -u "$url" \
  -headers "Cookie: $cookie_header" \
  -depth 1 -fs fqdn \
  -debug -error-log "$output_file"
```
<!-- cheat
var url
var cookie_header
var output_file
-->

### Keep crawl on the exact input host

#sh #katana #web

Use exact-host scope for the lowest-surprise crawl.

```sh title:"Keep crawl on the exact input host"
katana -u "$url" -depth 2 -fs fqdn -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Exclude state-changing paths

#sh #katana #web

Use out-of-scope filters for known state-changing or session-ending paths. This does not replace manual review, but it reduces obvious risk.

```sh title:"Exclude state-changing paths"
katana -u "$url" \
  -depth 2 -fs fqdn \
  -crawl-out-scope 'logout|signout|delete|remove|destroy|disable|purchase|checkout|invite|password|2fa|mfa' \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Reduce duplicate and similar crawl noise

#sh #katana #web

Ignore duplicate query-parameter variants and similar numeric paths when a site generates many near-identical URLs.

```sh title:"Reduce duplicate and similar crawl noise"
katana -u "$url" \
  -depth 3 -fs fqdn \
  -ignore-query-params -filter-similar \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Cap pages crawled per domain

#sh #katana #web

Set a per-domain page cap for large applications so one host cannot consume the whole crawl budget.

```sh title:"Cap pages crawled per domain"
katana -u "$url" \
  -depth 4 -fs fqdn \
  -max-domain-pages 250 \
  -rate-limit 25 \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Use per-host request pacing

#sh #katana #web

Add per-host pacing when crawling multiple inputs that may resolve to the same application or edge.

```sh title:"Use per-host request pacing"
katana -list "$url_list" \
  -depth 2 -fs fqdn \
  -host-rate-limit 5 -rate-limit 50 \
  -parallelism 5 -concurrency 5 \
  -output "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### Authorized broader same-host crawl

#sh #katana #web

> Warning: use aggressive crawling only on explicitly authorized targets. Keep scope restrictions enabled. Higher depth, headless crawling, JavaScript parsing, known-file crawling, form filling, and higher concurrency can trigger defenses, mutate state, or collect sensitive data.

Increase coverage without disabling scope. This is a broader crawl, not a license to follow unrelated hosts.

```sh title:"Authorized broader same-host crawl"
katana -u "$url" \
  -depth 5 -fs fqdn \
  -js-crawl -known-files all \
  -rate-limit 100 -concurrency 20 \
  -max-domain-pages 1000 \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Authorized high-coverage headless crawl

#sh #katana #web

Use aggressive headless coverage only when dynamic routes matter and the target can tolerate browser traffic.

```sh title:"Authorized high-coverage headless crawl"
katana -u "$url" \
  -hybrid -system-chrome -xhr-extraction \
  -depth 4 -fs fqdn \
  -js-crawl \
  -rate-limit 25 -concurrency 5 \
  -max-domain-pages 500 \
  -jsonl -omit-body \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Authorized aggressive form-aware crawl

#sh #katana #web

Only enable automatic form fill in aggressive mode when form interaction is explicitly authorized and dangerous routes are excluded.

```sh title:"Authorized aggressive form-aware crawl"
katana -u "$url" \
  -hybrid -system-chrome \
  -depth 3 -fs fqdn \
  -form-extraction -automatic-form-fill \
  -crawl-out-scope 'logout|signout|delete|remove|destroy|disable|purchase|checkout|invite|password|2fa|mfa' \
  -rate-limit 10 -concurrency 2 \
  -jsonl -omit-body \
  -output "$output_file"
```
<!-- cheat
var url
var output_file
-->
