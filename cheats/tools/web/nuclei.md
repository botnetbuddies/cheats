---
tool: Nuclei
category: tools
targets: Web Applications, Network Services
protocols: HTTP, TCP, UDP
remote_capable: true
tags: web nuclei scanner tools
---

# Nuclei

Nuclei runs template-based checks for exposed panels, misconfigurations, known vulnerabilities, cloud issues, and technology-specific findings. Keep scans authorized and scoped; DAST, fuzzing, headless, OAST/interactsh, and authenticated scans can be noisy or leak scoped credentials if used carelessly.

<!-- cheat
export nuclei
var output_file = printf '%s\n' nuclei.jsonl nuclei.txt "nuclei-$(date +%Y%m%d-%H%M%S).jsonl" --- --header 'Nuclei output file'
var evidence_dir = printf '%s\n' nuclei-evidence nuclei-responses "nuclei-evidence-$(date +%Y%m%d-%H%M%S)" --- --header 'Nuclei evidence directory'
var nuclei_rate_templates = printf '%s\n' '-rl 25 -c 10 -bs 10 # conservative' '-rl 150 -c 25 -bs 25 # moderate authorized' '-rl 500 -c 50 -bs 50 # aggressive authorized' --- --header 'Nuclei rate profile'
var nuclei_output_templates = printf '%s\n' '-jsonl -o nuclei.jsonl # JSONL findings' '-me nuclei-markdown # Markdown report directory' '-se nuclei.sarif # SARIF output' --- --header 'Nuclei output profile'
-->

## Linux

### Install nuclei with Go

#sh #nuclei #web

Install the latest Nuclei CLI with Go.

```sh title:"Install nuclei with Go"
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
```
<!-- cheat
-->

### Install nuclei release binary

#sh #nuclei #web

Install a downloaded Linux release zip.

```sh title:"Install nuclei Linux release binary"
curl -L -o nuclei.zip "$nuclei_release_zip_url" && unzip nuclei.zip && chmod +x nuclei && sudo mv nuclei /usr/local/bin/nuclei
```
<!-- cheat
var nuclei_release_zip_url
-->

### Run nuclei with Docker

#sh #nuclei #web

Run Nuclei without a local install.

```sh title:"Run nuclei with Docker"
docker run --rm projectdiscovery/nuclei:latest -u "$url"
```
<!-- cheat
var url
-->

### Update nuclei

#sh #nuclei #web

Update the Nuclei binary and confirm the installed version.

```sh title:"Update nuclei and print version"
nuclei -update && nuclei -version
```
<!-- cheat
-->

### Update templates

#sh #nuclei #web

Update community templates and validate the local template corpus.

```sh title:"Update and validate nuclei templates"
nuclei -update-templates && nuclei -tv
```
<!-- cheat
-->

### Single target

#sh #nuclei #web

Run Nuclei against one target.

```sh title:"Run nuclei against target"
nuclei -u "$url"
```
<!-- cheat
var url
-->

### URL list

#sh #nuclei #web

Run Nuclei against a list of URLs.

```sh title:"Run nuclei against URL list"
nuclei -l "$url_list"
```
<!-- cheat
import url_list
-->

### Template directory

#sh #nuclei #web

Run Nuclei with a specific template directory.

```sh title:"Run nuclei template directory"
nuclei -u "$url" -t "$template_dir"
```
<!-- cheat
var url
var template_dir
-->

### Severity filter

#sh #nuclei #web

Run Nuclei with a severity filter.

```sh title:"Run nuclei with severity filter"
nuclei -l "$url_list" -severity "$severity"
```
<!-- cheat
import url_list
var severity
-->

### Pipe httpx results into nuclei

#sh #nuclei #web

Probe live HTTP services with httpx before scanning.

```sh title:"Pipe httpx live URLs into nuclei"
httpx -l "$url_list" -silent | nuclei -l - -severity critical,high
```
<!-- cheat
import url_list
-->

## Template Selection

### List available templates

#sh #nuclei #web

List installed templates without running them.

```sh title:"List nuclei templates"
nuclei -tl
```
<!-- cheat
-->

### List available tags

#sh #nuclei #web

List template tags for focused template selection.

```sh title:"List nuclei template tags"
nuclei -tgl
```
<!-- cheat
-->

### Preview CVE templates

#sh #nuclei #web

Preview critical and high CVE templates before scanning.

```sh title:"Preview critical and high CVE templates"
nuclei -tags cve -severity critical,high -tl
```
<!-- cheat
-->

### Run KEV templates

#sh #nuclei #web

Run known-exploited vulnerability templates against scoped targets.

```sh title:"Run KEV nuclei templates"
nuclei -l "$url_list" -tags kev,vkev -severity critical,high
```
<!-- cheat
import url_list
-->

### Run CVE templates

#sh #nuclei #web

Run critical and high CVE templates against scoped targets.

```sh title:"Run critical and high CVE templates"
nuclei -l "$url_list" -tags cve -severity critical,high
```
<!-- cheat
import url_list
-->

### Run exposures and misconfig templates

#sh #nuclei #web

Find exposed files, configuration leaks, and common misconfigurations.

```sh title:"Run exposure and misconfig templates"
nuclei -l "$url_list" -tags exposure,config,misconfig
```
<!-- cheat
import url_list
-->

### Run panels and login templates

#sh #nuclei #web

Find exposed admin panels, login portals, and management surfaces.

```sh title:"Run panel and login templates"
nuclei -l "$url_list" -tags panel,login,admin
```
<!-- cheat
import url_list
-->

### Automatic scan by technology

#sh #nuclei #web

Let Nuclei select relevant templates from detected technologies.

```sh title:"Run automatic technology-selected scan"
nuclei -l "$url_list" -as
```
<!-- cheat
import url_list
-->

### Exclude noisy or unsafe tags

#sh #nuclei #web

Exclude tags that are too noisy for a quick external pass.

```sh title:"Exclude noisy nuclei tags"
nuclei -l "$url_list" -severity critical,high,medium -exclude-tags fuzz,dos,intrusive
```
<!-- cheat
import url_list
-->

### Template condition filter

#sh #nuclei #web

Filter templates with a template condition expression.

```sh title:"Run nuclei with template condition"
nuclei -l "$url_list" -tc "$template_condition"
```
<!-- cheat
import url_list
var template_condition
-->

## Scenario Scans

### External quick triage

#sh #nuclei #web

Run a conservative external triage for likely high-impact findings.

```sh title:"Run conservative external nuclei triage"
nuclei -l "$url_list" -severity critical,high -rl 25 -c 10 -bs 10 -timeout 8 -retries 0
```
<!-- cheat
import url_list
-->

### Deep authorized web scan

#sh #nuclei #web

Run a broader authorized scan and write evidence-friendly JSONL output.

```sh title:"Run deep authorized nuclei web scan"
nuclei -l "$url_list" -severity critical,high,medium -jsonl -o "$output_file" -sresp -srd "$evidence_dir"
```
<!-- cheat
import url_list
var output_file
var evidence_dir
-->

### WordPress / CMS scan

#sh #nuclei #web

Run WordPress plugin, theme, and core templates.

```sh title:"Run WordPress nuclei templates"
nuclei -l "$url_list" -tags wordpress,wp-plugin,wp-theme
```
<!-- cheat
import url_list
-->

### API/OpenAPI scan

#sh #nuclei #web

Scan API endpoints from an OpenAPI specification.

```sh title:"Run nuclei against OpenAPI input"
nuclei -l "$openapi_file" -im openapi
```
<!-- cheat
var openapi_file
-->

### Cloud misconfiguration templates

#sh #nuclei #web

Run cloud-focused templates against scoped cloud assets.

```sh title:"Run nuclei cloud templates"
nuclei -l "$url_list" -tags cloud
```
<!-- cheat
import url_list
-->

### SSL/TLS templates

#sh #nuclei #web

Run SSL/TLS templates against HTTPS endpoints.

```sh title:"Run nuclei SSL TLS templates"
nuclei -l "$url_list" -type ssl
```
<!-- cheat
import url_list
-->

### Network service templates

#sh #nuclei #web

Run TCP network service templates against scoped host and port targets.

```sh title:"Run nuclei network service templates"
nuclei -l "$url_list" -t network/ -type tcp
```
<!-- cheat
import url_list
-->

### Newly released templates only

#sh #nuclei #web

Run templates added or updated recently after refreshing templates.

```sh title:"Run newly released nuclei templates"
nuclei -l "$url_list" -nt
```
<!-- cheat
import url_list
-->

## Authenticated Scans

### Add bearer token header

#sh #nuclei #web

Run an authenticated scan with a bearer token header.

```sh title:"Run nuclei with bearer token"
nuclei -u "$url" -H "Authorization: Bearer $token"
```
<!-- cheat
var url
var token
-->

### Add cookie header

#sh #nuclei #web

Run an authenticated scan with a supplied Cookie header.

```sh title:"Run nuclei with cookie"
nuclei -u "$url" -H "Cookie: $cookie"
```
<!-- cheat
var url
var cookie
-->

### Secret file auth

#sh #nuclei #web

Use a Nuclei secrets file so credentials are scoped outside the command line.

```sh title:"Run nuclei with secrets file"
nuclei -l "$url_list" -sf "$secrets_file"
```
<!-- cheat
import url_list
var secrets_file
-->

### Static bearer token secret file

Scope static bearer tokens to approved domains only.

```yaml title:"nuclei static bearer token secret"
static:
  - type: bearertoken
    token: "{{token}}"
    domains:
      - app.example.com
```

### Static cookie secret file

Scope cookies by exact domains or domain regexes to avoid credential bleed.

```yaml title:"nuclei static cookie secret"
static:
  - type: cookie
    cookies:
      - key: session
        value: "{{session_cookie}}"
    domains-regex:
      - '^.*\.example\.com$'
```

## Workflows, Headless, DAST

### Run workflow

#sh #nuclei #web

Run a multi-template Nuclei workflow.

```sh title:"Run nuclei workflow"
nuclei -u "$url" -w "$workflow_file"
```
<!-- cheat
var url
var workflow_file
-->

### Headless templates

#sh #nuclei #web

Run browser-backed templates with low headless concurrency.

```sh title:"Run nuclei headless templates"
nuclei -u "$url" -headless -headc 2 -hbs 2
```
<!-- cheat
var url
-->

### DAST/fuzzing templates

#sh #nuclei #web

Run active DAST fuzzing with low aggression and a tight scope regex.

```sh title:"Run scoped low-aggression nuclei DAST"
nuclei -l "$burp_file" -im burp -dast -fa low -cs "$scope_regex"
```
<!-- cheat
var burp_file
var scope_regex
-->

### DAST from URL list

#sh #nuclei #web

Run active fuzzing against scoped URLs only when explicitly authorized.

```sh title:"Run nuclei DAST against scoped URL list"
nuclei -l "$url_list" -dast -fa low -cs "$scope_regex"
```
<!-- cheat
import url_list
var scope_regex
-->

## Mass Scanning Controls

### Conservative mass scan

#sh #nuclei #web

Use conservative rate and concurrency limits for broad external scanning.

```sh title:"Run conservative nuclei mass scan"
nuclei -l "$url_list" -severity critical,high $nuclei_rate_templates -timeout 8 -retries 0
```
<!-- cheat
import nuclei
import url_list
-->

### Faster authorized scan

#sh #nuclei #web

Use a faster profile only for explicitly authorized infrastructure.

```sh title:"Run faster authorized nuclei scan"
nuclei -l "$url_list" -severity critical,high,medium -rl 500 -c 50 -bs 50
```
<!-- cheat
import url_list
-->

### Host-spray strategy

#sh #nuclei #web

Spread requests across hosts for focused templates on large target sets.

```sh title:"Run nuclei host-spray scan strategy"
nuclei -l "$url_list" -ss host-spray -c 10 -bs 10
```
<!-- cheat
import url_list
-->

### Resume scan

#sh #nuclei #web

Resume an interrupted scan from a resume file.

```sh title:"Resume nuclei scan"
nuclei -resume "$resume_file"
```
<!-- cheat
var resume_file
-->

### Project cache

#sh #nuclei #web

Enable a project cache to avoid repeating requests across recurring scans.

```sh title:"Run nuclei with project cache"
nuclei -l "$url_list" -project -project-path "$project_dir"
```
<!-- cheat
import url_list
var project_dir
-->

## Output and Reporting

### JSONL output

#sh #nuclei #web

Write machine-readable JSONL findings.

```sh title:"Write nuclei JSONL output"
nuclei -l "$url_list" -jsonl -o "$output_file"
```
<!-- cheat
import url_list
var output_file
-->

### Output profile picker

#sh #nuclei #web

Choose a reusable output profile for findings or reports.

```sh title:"Run nuclei with output profile"
nuclei -l "$url_list" $nuclei_output_templates
```
<!-- cheat
import nuclei
import url_list
-->

### Markdown report

#sh #nuclei #web

Write a Markdown report directory without raw request and response bodies.

```sh title:"Write nuclei markdown report"
nuclei -l "$url_list" -me "$report_dir" -omit-raw
```
<!-- cheat
import url_list
var report_dir
-->

### SARIF export

#sh #nuclei #web

Export findings as SARIF for security tooling ingestion.

```sh title:"Export nuclei SARIF"
nuclei -l "$url_list" -se "$sarif_file"
```
<!-- cheat
import url_list
var sarif_file
-->

### Store request/response evidence

#sh #nuclei #web

Store matched request and response evidence for later review.

```sh title:"Store nuclei request response evidence"
nuclei -l "$url_list" -sresp -srd "$evidence_dir"
```
<!-- cheat
import url_list
var evidence_dir
-->

### Redact sensitive keys

#sh #nuclei #web

Redact common sensitive keys from output before storing or sharing results.

```sh title:"Redact sensitive nuclei output keys"
nuclei -l "$url_list" -jsonl -rd token -rd password -rd authorization
```
<!-- cheat
import url_list
-->

### Report DB for recurring scans

#sh #nuclei #web

Store findings in a report database for recurring scan comparison.

```sh title:"Run nuclei with report database"
nuclei -l "$url_list" -rdb "$report_db"
```
<!-- cheat
import url_list
var report_db
-->

## Template Development

### Validate template

#sh #nuclei #web

Validate a custom template before running it.

```sh title:"Validate nuclei template"
nuclei -validate -t "$template_file"
```
<!-- cheat
var template_file
-->

### Display template

#sh #nuclei #web

Display a template after variable expansion and parsing.

```sh title:"Display nuclei template"
nuclei -td -t "$template_file"
```
<!-- cheat
var template_file
-->

### Debug template run

#sh #nuclei #web

Debug a custom template against a single authorized target and show request/response details.

```sh title:"Debug nuclei template"
nuclei -debug -svd -t "$template_file" -u "$url"
```
<!-- cheat
var template_file
var url
-->

### Minimal HTTP matcher template

Match a known body string and status code with a minimal HTTP template.

```yaml title:"minimal nuclei HTTP matcher template"
id: example-status-body-match

info:
  name: Example Status and Body Match
  author: example
  severity: info

http:
  - method: GET
    path:
      - "{{BaseURL}}/"
    matchers-condition: and
    matchers:
      - type: status
        status:
          - 200
      - type: word
        part: body
        words:
          - "Example Domain"
```

### Minimal extractor template

Extract matching response header values with a minimal template.

```yaml title:"minimal nuclei extractor template"
id: example-header-extractor

info:
  name: Example Header Extractor
  author: example
  severity: info

http:
  - method: GET
    path:
      - "{{BaseURL}}/"
    extractors:
      - type: regex
        part: header
        regex:
          - '(?i)x-powered-by:.*'
```

### Sign templates

#sh #nuclei #web

Sign local templates before sharing or enforcing signed-only execution.

```sh title:"Sign nuclei template"
nuclei -sign -t "$template_file"
```
<!-- cheat
var template_file
-->

### Only run signed templates

#sh #nuclei #web

Run only signed templates when template integrity matters.

```sh title:"Run only signed nuclei templates"
nuclei -l "$url_list" -dut
```
<!-- cheat
import url_list
-->

## Pipelines

### httpx/nuclei live URL pipeline

#sh #httpx #nuclei #web

Probe live HTTP services with httpx and scan only responsive URLs.

```sh title:"Run httpx live URLs through nuclei"
httpx -l "$url_list" -silent | nuclei -l - -severity critical,high
```
<!-- cheat
import url_list
-->

### httpx metadata-filtered nuclei pipeline

#sh #httpx #nuclei #web

Save httpx metadata, then scan the first-column URLs with focused templates.

```sh title:"Filter httpx metadata into nuclei"
httpx -l "$url_list" -silent -status-code -title -tech-detect | tee "$httpx_output_file" && awk '{print $1}' "$httpx_output_file" | nuclei -l - -tags exposure,cve -severity critical,high
```
<!-- cheat
import url_list
var httpx_output_file
-->
