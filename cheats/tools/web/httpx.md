---
tool: httpx
category: tools
targets: Web Applications
protocols: HTTP, HTTPS
remote_capable: true
tags: web httpx recon tools
---

# httpx

`httpx` probes HTTP services at scale and collects live-web metadata such as status codes, titles, technologies, redirects, response sizes, IPs, ASNs, CDN/WAF signals, and JSONL records for later triage.

Use it after you already have a list of candidate hosts or URLs. This page stays focused on `httpx`: turning input into live HTTP/S targets and prioritizing the most interesting web surfaces.

<!-- cheat
export httpx
var output_file = printf '%s\n' httpx.txt httpx.jsonl "httpx-$(date +%Y%m%d-%H%M%S).txt" --- --header 'httpx output file'
var output_dir = printf '%s\n' httpx-responses httpx-screenshots "httpx-output-$(date +%Y%m%d-%H%M%S)" --- --header 'httpx output directory'
var httpx_probe_templates = printf '%s\n' '-silent -status-code -title -tech-detect # conservative triage' '-silent -status-code -title -tech-detect -json -follow-redirects # JSONL metadata' '-silent -status-code -title -tech-detect -server -cdn -asn -ip # infra metadata' --- --header 'httpx probe profile'
var httpx_filter_templates = printf '%s\n' '-mc 200,204,301,302,307,308,401,403 # common interesting statuses' '-fc 404,400,500 # common noisy statuses' '-fd # near-duplicate filtering' --- --header 'httpx filter profile'
-->

## Linux

### Expected input shape

#sh #httpx #web

Assume the input file contains one host or URL per line. Hosts without a scheme are probed with HTTPS first and then HTTP fallback by default.

```sh title:"Expected input shape"
httpx -l "$url_list"
```
<!-- cheat
import url_list
-->

### Probe one target

#sh #httpx #web

Use `-u` for a single target or a small comma-separated target list.

```sh title:"Probe one target"
httpx -u "$url"
```
<!-- cheat
var url
-->

### Conservative live web triage

#sh #httpx #web

Start with a conservative metadata pass. This is the default operator workflow for turning many candidate hosts into a reviewable live-web list.

```sh title:"Conservative live web triage"
httpx -l "$url_list" \
  -status-code -title -tech-detect -web-server \
  -content-length -content-type -location \
  -ip -cdn -response-time \
  -threads 25 -rate-limit 50 -timeout 10 \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

This prints results to the terminal and also saves the same line-oriented output with `-o`. Review the terminal for quick feedback, but keep the saved file as the durable artifact for notes, retesting, and manual review.

### Display both HTTP and HTTPS probe results

#sh #httpx #web

By default, `httpx` prefers HTTPS and falls back to HTTP. Use `-no-fallback` when you explicitly want both schemes displayed where reachable.

```sh title:"Display both HTTP and HTTPS probe results"
httpx -l "$url_list" \
  -status-code -title -web-server -location \
  -no-fallback \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### Respect schemes already present in input

#sh #httpx #web

Use `-no-fallback-scheme` when your input already includes schemes and you want `httpx` to respect them instead of applying fallback behavior.

```sh title:"Respect schemes already present in input"
httpx -l "$url_list" \
  -status-code -title -no-fallback-scheme \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### High-signal metadata pass

#sh #httpx #web

Collect fields that help separate routine live hosts from targets worth manual review.

```sh title:"Collect high-signal HTTP metadata"
httpx -l "$url_list" \
  -status-code -title -tech-detect -web-server \
  -content-length -line-count -word-count -content-type \
  -location -ip -asn -cdn -response-time \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

Prioritize results with:

- `401` and `403`: authentication gates, admin panels, protected APIs, staging environments, or misconfigured access control.
- `3xx` with interesting `-location`: SSO flows, admin/login redirects, old domains, cloud buckets, or third-party apps.
- Odd titles: default pages, error pages, stack traces, dashboards, old product names, or internal environment labels.
- Unusual technologies: legacy frameworks, admin products, debug stacks, or unexpected CMS/app servers.
- Response size, line, and word anomalies: one host that differs from many similar hosts can indicate a distinct app, error state, or hidden surface.
- Content type surprises: JSON, XML, plain text, downloads, or non-HTML responses on web hosts can indicate APIs or exposed artifacts.
- CDN/WAF/IP/ASN mismatches: unexpected infrastructure can reveal acquisitions, forgotten hosting, edge-protected assets, or third-party ownership.

### Match interesting status codes

#sh #httpx #web

Use matchers when you want only a subset of responses in the output.

```sh title:"Keep only common interesting status codes"
httpx -l "$url_list" \
  -status-code -title -web-server -location \
  -match-code 200,204,301,302,307,308,401,403,500 \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

Avoid filtering too early during first-pass recon. A boring `404` on one host can still be interesting if the title, server, content type, or infrastructure differs from the rest of the environment.

### Filter common noisy status codes

#sh #httpx #web

Use filters after you understand the baseline noise in your results. For example, remove repetitive unauthorized and forbidden responses only when they are not useful for the current pass.

```sh title:"Filter common noisy status codes"
httpx -l "$url_list" \
  -status-code -title -content-length -web-server \
  -filter-code 401,403 \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### Remove near-duplicate responses

#sh #httpx #web

Filter near-duplicate responses when a wildcard, parked page, default edge page, or fleet-wide error page dominates the output.

```sh title:"Remove near-duplicate responses"
httpx -l "$url_list" \
  -status-code -title -content-length -filter-duplicates \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### Filter detected error pages

#sh #httpx #web

Use `-filter-error-page` for ML-assisted error-page filtering.

```sh title:"Filter detected error pages"
httpx -l "$url_list" \
  -status-code -title -content-length \
  -filter-error-page \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### Collect response shape fields

#sh #httpx #web

Response length, line count, and word count are useful for grouping similar pages and spotting outliers.

```sh title:"Collect response shape fields"
httpx -l "$url_list" \
  -status-code -title \
  -content-length -line-count -word-count \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### Match a known interesting response size

#sh #httpx #web

Use matchers for a focused second pass after you identify a size or word-count range worth keeping.

```sh title:"Match a known interesting response size"
httpx -l "$url_list" \
  -status-code -title -content-length \
  -match-length "$content_lengths" \
  -o "$output_file"
```
<!-- cheat
import url_list
var content_lengths
var output_file
-->

### Filter a repeated baseline response size

#sh #httpx #web

Use filters to remove a repeated baseline size after verifying that the baseline is truly noise.

```sh title:"Filter a repeated baseline response size"
httpx -l "$url_list" \
  -status-code -title -content-length \
  -filter-length "$noise_lengths" \
  -o "$output_file"
```
<!-- cheat
import url_list
var noise_lengths
var output_file
-->

### Technology and server prioritization

#sh #httpx #web

Technology and server headers help identify legacy apps, unusual stacks, and systems that deserve manual review.

```sh title:"Collect technology and server signals"
httpx -l "$url_list" \
  -status-code -title -tech-detect -web-server \
  -content-type -ip -cdn \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

Treat missing or generic technology output as normal. `-tech-detect` depends on recognizable fingerprints and should guide prioritization, not replace manual validation.

### Collect redirect destinations

#sh #httpx #web

Redirects often explain how an asset is used: SSO, login portals, admin surfaces, legacy domains, parked infrastructure, and third-party applications.

```sh title:"Collect redirect destinations"
httpx -l "$url_list" \
  -status-code -title -location -web-server \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### Follow redirects for final-page metadata

#sh #httpx #web

Follow redirects only when you want the final page metadata. Keep the non-followed redirect pass too, because the original `Location` header is often the clue.

```sh title:"Follow redirects for final-page metadata"
httpx -l "$url_list" \
  -status-code -title -location -tech-detect \
  -follow-redirects -max-redirects 5 \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### Follow same-host redirects only

#sh #httpx #web

Follow only same-host redirects when you want to avoid drifting into third-party identity providers or external apps.

```sh title:"Follow same-host redirects only"
httpx -l "$url_list" \
  -status-code -title -location \
  -follow-host-redirects -max-redirects 5 \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### Infrastructure clues

#sh #httpx #web

Use IP, ASN, CNAME, CDN/WAF, and web-server signals to understand where live web assets actually terminate.

```sh title:"Collect infrastructure metadata"
httpx -l "$url_list" \
  -status-code -title -ip -asn -cname -cdn -web-server \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

Useful interpretation patterns:

- SSO redirects: asset may still expose pre-auth routes, metadata, or misconfigured callbacks.
- Admin/login redirects: prioritize if the host, title, or path suggests internal tooling or privileged access.
- Third-party infrastructure: check whether ownership and exposure are expected before assuming it is in scope.
- Protected edge assets: CDN/WAF presence can explain `403`s and rate limits; it does not prove the origin is uninteresting.
- Unexpected hosting providers or ASNs: good candidates for forgotten acquisitions, vendor systems, or stale deployments.

### Write structured JSONL output

#sh #httpx #web

Use JSONL when results need to be diffed, scripted, dashboarded, reviewed later, or enriched by another process. Each line is a separate JSON object.

```sh title:"Write structured JSONL output"
httpx -l "$url_list" \
  -status-code -title -tech-detect -web-server \
  -content-length -content-type -location \
  -ip -asn -cdn -response-time \
  -json -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### List JSON output fields supported by this httpx version

#sh #httpx #web

Inspect field names for your installed version before writing scripts that depend on a specific schema.

```sh title:"List JSON output fields supported by this httpx version"
httpx -list-output-fields
```

### Include redirect chain in JSONL output

#sh #httpx #web

For redirect-chain review in JSONL, include the chain explicitly.

```sh title:"Include redirect chain in JSONL output"
httpx -l "$url_list" \
  -status-code -title -location \
  -follow-redirects -include-chain \
  -json -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

Avoid including full responses in normal triage JSONL. `-include-response`, `-include-response-header`, and `-include-response-base64` can create large files and may capture sensitive data.

### Store responses for selected review

#sh #httpx #web

Store responses only for a smaller reviewed subset. It is useful for evidence and offline review, but it can consume disk and may capture sensitive content.

```sh title:"Store responses for selected targets"
httpx -l "$url_list" \
  -status-code -title -store-response \
  -store-response-dir "$output_dir" \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_dir
var output_file
-->

### Capture screenshots for selected targets

#sh #httpx #web

Screenshots are expensive compared with metadata probes. Run them after you narrow the target list.

```sh title:"Capture screenshots for selected targets"
httpx -l "$url_list" \
  -screenshot -system-chrome \
  -store-response-dir "$output_dir" \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_dir
var output_file
-->

### Capture screenshots with compact JSONL metadata

#sh #httpx #web

Use `-exclude-screenshot-bytes` with JSONL screenshot runs when you do not want base64 screenshot bytes embedded in the JSON output.

```sh title:"Capture screenshots with compact JSONL metadata"
httpx -l "$url_list" \
  -screenshot -system-chrome -exclude-screenshot-bytes \
  -json -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### Higher-throughput pass with explicit rate limit

#sh #httpx #web

> Warning: use aggressive settings only on authorized targets and only when the network, scope, and rules of engagement allow it. Higher concurrency, lower timeouts, alternate ports, and broad paths can create noise, trigger defenses, or miss slow but valid services.

Increase concurrency and rate only after a conservative pass works cleanly.

```sh title:"Higher-throughput pass with explicit rate limit"
httpx -l "$url_list" \
  -status-code -title -web-server \
  -threads 100 -rate-limit 200 -timeout 5 -retries 1 \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### Probe common alternate web ports

#sh #httpx #web

Probe common alternate HTTP/S ports when the scope explicitly allows port-based web probing.

```sh title:"Probe common alternate web ports"
httpx -l "$url_list" \
  -status-code -title -web-server \
  -ports http:80,8080,8000,8888,https:443,8443,9443 \
  -threads 50 -rate-limit 100 \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### Slow down requests for fragile targets

#sh #httpx #web

Use `-delay` or lower `-rate-limit` instead of higher threads when targets show instability, throttling, WAF blocks, or inconsistent results.

```sh title:"Slow down requests for fragile targets"
httpx -l "$url_list" \
  -status-code -title -web-server \
  -threads 10 -rate-limit 20 -delay 200ms -timeout 15 \
  -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

Do not use aggressive settings as defaults for third-party infrastructure, shared SaaS, fragile production systems, small scopes, or tests with strict rate limits.

### Common mistakes

#sh #httpx #web

- Confusing the macOS Python `httpx` CLI with ProjectDiscovery `httpx`. For these examples, use the ProjectDiscovery Linux binary.
- Treating `uv tool install httpx` or `uv tool run httpx` as ProjectDiscovery `httpx`. That installs Python's HTTPX client, not the offsec recon tool used here.
- Filtering too early and losing `401`, `403`, redirects, odd `404`s, or other useful clues.
- Treating `-tech-detect` as complete inventory instead of fingerprint-based hints.
- Following redirects before saving the original redirect destinations.
- Running screenshots, broad ports, or high concurrency during the first pass.
- Assuming CDN/WAF means “not interesting.” Protected edge assets can still identify important systems.
- Depending on JSONL field names without checking `-list-output-fields` for the installed version.

### Practical workflow checklist

#sh #httpx #web

1. Start with the conservative metadata pass and save output with `-o`.
2. Review status, title, server, technology, content type, redirect, IP/ASN, CDN/WAF, and response-time signals.
3. Run a second pass for interesting status codes, response-size anomalies, redirects, or infrastructure clues.
4. Switch to `-json` when you need repeatable automation or future diffing.
5. Store responses or screenshots only for narrowed target sets.
6. Use aggressive settings only after confirming authorization, stability, and rate-limit expectations.
7. Re-check `httpx -h` or `httpx -list-output-fields` after upgrading because ProjectDiscovery tools change over time.
