---
tool: ffuf
category: tools
targets: Web Applications
protocols: HTTP, HTTPS
remote_capable: true
tags: web fuzzing ffuf content-discovery tools
---

# Ffuf

<!-- cheat
export ffuf
import scheme
import domain_ip
import wordlist_host
import wordlist_file
import wordlist_dir
import wordlist_dir_common
import wordlist_dir_medium
import wordlist_http_params
import wordlist_usernames
import wordlist_fuzz_special_chars
import wordlist_http_values
var outfile = printf '%s\n' ffuf.json "ffuf-$(date +%Y%m%d-%H%M%S).json" --- --header 'Output file'
-->

## ffuf

### HTTP input fuzzing notes

When fuzzing parameters, headers, cookies, or JSON fields, run a baseline first and then add filtering. Prefer `-ac` for dynamic applications, or use `-fc` and `-fs` after you identify repeated noisy responses. For production-like targets, slow down noisy jobs with `-rate`, reduce concurrency with `-t`, and set a bounded `-timeout`.

```sh title:"Ffuf Rate-limited baseline request for noisy HTTP input fuzzing"
ffuf -w "$wordlist_http_params" -u "$url?FUZZ=test" -t 20 -rate "$rate" -timeout "$timeout" -o ffuf-http-input-baseline-rate-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var rate
var timeout
-->

### host with ip

Vhost fuzzing: send the request to the IP and rotate the Host header to find virtual hosts behind the same listener. `-ac` auto-calibrates response filtering.

```sh title:"Ffuf Vhost fuzz via Host header against IP, auto calibrate"
ffuf -t 400 -w $wordlist_host -u $scheme://$rhost_ip -H "Host: FUZZ.$domain" -ac -o ffuf-host-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
-->

### host with url

Vhost fuzzing with an explicit wordlist.

```sh title:"Ffuf Vhost fuzz via Header against url with explicit wordlist"
ffuf -w "$wordlist_host" -u "$url" -H "Host: FUZZ.$domain" -ac -o ffuf-host-ac-$(date +%Y%m%d-%H%M%S).json 
```
<!-- cheat
import ffuf
var url
var domain
-->

### file

File-name fuzzing at the document root. Useful for hunting backups, configs, and orphaned scripts.

```sh title:"Ffuf File-name fuzz at document root, JSON output"
ffuf -t 400 -w $wordlist_file -u $scheme://$domain/FUZZ -ac -o ffuf-file-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
-->

### dir

Recursive directory fuzzing two levels deep. Good first sweep before targeted file fuzzing.

```sh title:"Ffuf Recursive directory fuzz, depth 2, JSON output"
ffuf -t 400 -w $wordlist_dir -u $scheme://$domain/FUZZ -recursion -recursion-depth 2 -ac -o ffuf-dir-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
-->

### dir common

Directory fuzzing with `dirb/common.txt`.

```sh title:"Ffuf Directory fuzz with dirb common"
ffuf -u "$url/FUZZ" -w "$wordlist_dir_common" -ac -o ffuf-dir-common-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### dir medium

Directory fuzzing with `directory-list-2.3-medium.txt`.

```sh title:"Ffuf Directory fuzz with directory-list-2.3-medium"
ffuf -u "$url/FUZZ" -w "$wordlist_dir_medium" -ac -o ffuf-dir-medium-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### GET baseline parameter names

Baseline GET fuzzing: run this first to spot repeated noisy status codes and response sizes before adding `-fc` or `-fs` filters.

```sh title:"Ffuf Baseline GET parameter-name fuzz before filtering"
ffuf -w "$wordlist_http_params" -u "$url?FUZZ=test" -o ffuf-get-param-names-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### GET baseline parameter auto-calibration

```sh title:"Ffuf GET parameter-name fuzz with auto-calibration"
ffuf -w "$wordlist_http_params" -u "$url?FUZZ=test" -ac -o ffuf-get-param-names-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### GET query parameter names

Fuzz GET query parameter values. Use `-H "Cookie: ..."` for authenticated endpoints.

```sh title:"Ffuf Fuzz GET query parameter names only"
ffuf -w "$wordlist_http_params" -u "$url?FUZZ=$param_value" -ac -o ffuf-get-query-param-names-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var param_value
-->

### GET query parameter value

```sh title:"Ffuf Fuzz GET parameter value with HTTP value wordlist"
ffuf -w "$wordlist_http_values" -u "$url?$param=FUZZ" -o ffuf-get-param-http-values-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var param
-->

### GET authenticated query parameter value

```sh title:"Ffuf Fuzz authenticated GET parameter value with cookie"
ffuf -w "$wordlist_fuzz_special_chars" -u "$url?$param=FUZZ" -H "Cookie: session=$session_token" -o ffuf-get-param-cookie-special-chars-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var param
var session_token
-->

### GET status-code filter

Filter noisy GET results after the baseline run. Use `-fc` for status codes and `-fs` for repeated response sizes.

```sh title:"Ffuf Fuzz GET parameter and filter status codes"
ffuf -w "$wordlist_http_values" -u "$url?$param=FUZZ" -fc 400,401,403 -o ffuf-get-param-http-values-fc-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var param
-->

### GET response-size filter

```sh title:"Ffuf Fuzz GET parameter and filter response size"
ffuf -w "$wordlist_http_values" -u "$url?$param=FUZZ" -fs "$response_size" -o ffuf-get-param-http-values-fs-$response_size-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var param
var response_size
-->

### GET status-code and response-size filters

```sh title:"Ffuf Fuzz GET parameter and filter status plus size"
ffuf -w "$wordlist_http_values" -u "$url?$param=FUZZ" -fc 400,404 -fs "$response_size" -o ffuf-get-param-http-values-fc-fs-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var param
var response_size
-->

### GET auto-calibration

Use `-ac` when GET responses are dynamic and simple `-fc` or `-fs` filters are not enough.

```sh title:"Ffuf Fuzz GET parameter with auto-calibration"
ffuf -w "$wordlist_http_values" -u "$url?$param=FUZZ" -ac -o ffuf-get-param-http-values-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var param
-->

### POST baseline form parameter names

Baseline POST fuzzing: run this first to spot repeated noisy status codes and response sizes before adding `-fc` or `-fs` filters.

```sh title:"Ffuf Baseline form POST fuzz before filtering"
ffuf -w "$wordlist_http_params" -u "$url" -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "FUZZ=test&password=password123" -o ffuf-post-param-names-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### POST baseline form auto-calibration

```sh title:"Ffuf Form POST parameter-name fuzz with auto-calibration"
ffuf -w "$wordlist_http_params" -u "$url" -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "FUZZ=test&password=password123" -ac -o ffuf-post-param-names-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### POST form parameter names

Fuzz form-urlencoded POST values. Use `-H "Cookie: ..."` for authenticated endpoints.

```sh title:"Ffuf Fuzz form POST parameter names only"
ffuf -w "$wordlist_http_params" -u "$url" -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "FUZZ=$param_value&submit=1" -ac -o ffuf-post-form-param-names-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var param_value
-->

### POST form username value

```sh title:"Ffuf Fuzz form POST value with SecLists usernames"
ffuf -w "$wordlist_usernames" -u "$url" -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "username=FUZZ&password=test" -o ffuf-post-form-user-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### POST form HTTP value

```sh title:"Ffuf Fuzz form POST value with HTTP value wordlist"
ffuf -w "$wordlist_http_values" -u "$url" -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "$param=FUZZ&password=test" -o ffuf-post-form-http-values-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var param
-->

### POST authenticated form value

```sh title:"Ffuf Fuzz authenticated form POST value with cookie"
ffuf -w "$wordlist_fuzz_special_chars" -u "$url" -X POST -H "Content-Type: application/x-www-form-urlencoded" -H "Cookie: session=$session_token" -d "email=FUZZ@example.com&role=user" -o ffuf-post-form-cookie-special-chars-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var session_token
-->

### POST JSON key names

Fuzz JSON POST values. Keep `FUZZ` inside the JSON field you want to test; use `-H "Authorization: Bearer ..."` for bearer-authenticated APIs.

```sh title:"Ffuf Fuzz JSON parameter names only"
ffuf -w "$wordlist_http_params" -u "$url" -X POST -H "Content-Type: application/json" -d '{"FUZZ":"test"}' -ac -o ffuf-post-json-param-names-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### POST JSON value

```sh title:"Ffuf Fuzz JSON POST value"
ffuf -w "$wordlist_http_values" -u "$url" -X POST -H "Content-Type: application/json" -d '{"query":"FUZZ"}' -o ffuf-post-json-http-values-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### POST authenticated JSON value

```sh title:"Ffuf Fuzz authenticated JSON POST value with bearer token"
ffuf -w "$wordlist_fuzz_special_chars" -u "$url" -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $access_token" -d '{"displayName":"FUZZ","bio":"test"}' -o ffuf-post-json-bearer-special-chars-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var access_token
-->

### POST status-code filter

Filter noisy POST results after the baseline run. Use `-fc` for status codes and `-fs` for repeated response sizes.

```sh title:"Ffuf Fuzz form POST and filter status codes"
ffuf -w "$wordlist_usernames" -u "$url" -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "username=FUZZ&password=test" -fc 400,401,403 -o ffuf-post-form-user-fc-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### POST response-size filter

```sh title:"Ffuf Fuzz JSON POST and filter response size"
ffuf -w "$wordlist_http_values" -u "$url" -X POST -H "Content-Type: application/json" -d '{"query":"FUZZ"}' -fs "$response_size" -o ffuf-post-json-http-values-fs-$response_size-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var response_size
-->

### POST status-code and response-size filters

```sh title:"Ffuf Fuzz JSON POST and filter status plus size"
ffuf -w "$wordlist_http_values" -u "$url" -X POST -H "Content-Type: application/json" -d '{"query":"FUZZ"}' -fc 400,404 -fs "$response_size" -o ffuf-post-json-http-values-fc-fs-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var response_size
-->

### POST auto-calibration

Use `-ac` when POST responses are dynamic and simple `-fc` or `-fs` filters are not enough.

```sh title:"Ffuf Fuzz JSON POST with auto-calibration"
ffuf -w "$wordlist_http_values" -u "$url" -X POST -H "Content-Type: application/json" -d '{"query":"FUZZ"}' -ac -o ffuf-post-json-http-values-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### Advanced HTTP GET parameter names

Use named ffuf wordlists when you need to fuzz more than one insertion point. `clusterbomb` tries every parameter-name/value combination. `pitchfork` walks both wordlists together line-by-line, which is useful when paired names and values already match.

```sh title:"Ffuf GET parameter names only with baseline value"
ffuf -w "$wordlist_http_params" -u "$url?FUZZ=$param_value" -o ffuf-get-param-names-only-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var param_value
-->

### Advanced HTTP form parameter names

```sh title:"Ffuf form POST parameter names only with baseline value"
ffuf -w "$wordlist_http_params" -u "$url" -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "FUZZ=$param_value" -o ffuf-post-form-param-names-only-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var param_value
-->

### Advanced HTTP JSON key names

```sh title:"Ffuf JSON object key names only with baseline value"
ffuf -w "$wordlist_http_params" -u "$url" -X POST -H "Content-Type: application/json" -d '{"FUZZ":"test"}' -o ffuf-json-key-names-only-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### Advanced HTTP GET parameter clusterbomb

```sh title:"Ffuf Clusterbomb GET parameter names and values"
ffuf -w "$wordlist_http_params":PNAME -w "$wordlist_http_values":PVALUE -mode clusterbomb -u "$url?PNAME=PVALUE" -ac -o ffuf-get-param-name-value-clusterbomb-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### Advanced HTTP GET parameter pitchfork

```sh title:"Ffuf Pitchfork GET parameter names and values"
ffuf -w "$wordlist_http_params":PNAME -w "$wordlist_http_values":PVALUE -mode pitchfork -u "$url?PNAME=PVALUE" -ac -o ffuf-get-param-name-value-pitchfork-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### Advanced HTTP form parameter clusterbomb

```sh title:"Ffuf Clusterbomb form POST parameter names and values"
ffuf -w "$wordlist_http_params":PNAME -w "$wordlist_http_values":PVALUE -mode clusterbomb -u "$url" -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "PNAME=PVALUE&submit=1" -ac -o ffuf-post-form-name-value-clusterbomb-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### Advanced HTTP JSON key auto-calibration

```sh title:"Ffuf JSON key fuzz with static value"
ffuf -w "$wordlist_http_params" -u "$url" -X POST -H "Content-Type: application/json" -d '{"FUZZ":"test"}' -ac -o ffuf-post-json-key-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### Advanced HTTP JSON key-value clusterbomb

```sh title:"Ffuf JSON key and value fuzz with clusterbomb"
ffuf -w "$wordlist_http_params":JKEY -w "$wordlist_http_values":JVALUE -mode clusterbomb -u "$url" -X POST -H "Content-Type: application/json" -d '{"JKEY":"JVALUE"}' -ac -o ffuf-post-json-key-value-clusterbomb-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### Advanced HTTP header-name fuzz

```sh title:"Ffuf Header-name fuzz with static header value"
ffuf -w "$wordlist_http_params" -u "$url" -H "FUZZ: test" -ac -o ffuf-header-name-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### Advanced HTTP header-value fuzz

```sh title:"Ffuf Header value fuzz with optional header name placeholder"
ffuf -w "$wordlist_http_values" -u "$url" -H "$header_name: FUZZ" -ac -o ffuf-header-value-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var header_name
-->

### Advanced HTTP cookie-name fuzz

```sh title:"Ffuf Cookie-name fuzz with static cookie value"
ffuf -w "$wordlist_http_params" -u "$url" -H "Cookie: FUZZ=test" -ac -o ffuf-cookie-name-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
-->

### Advanced HTTP cookie-value fuzz

```sh title:"Ffuf Cookie value fuzz with optional cookie name placeholder"
ffuf -w "$wordlist_http_values" -u "$url" -H "Cookie: $cookie_name=FUZZ" -ac -o ffuf-cookie-value-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var cookie_name
-->

### Advanced HTTP authenticated form clusterbomb

```sh title:"Ffuf Authenticated form parameter fuzz with cookie and bearer token"
ffuf -w "$wordlist_http_params":PNAME -w "$wordlist_http_values":PVALUE -mode clusterbomb -u "$url" -X POST -H "Content-Type: application/x-www-form-urlencoded" -H "Cookie: session=$session_token" -H "Authorization: Bearer $access_token" -d "PNAME=PVALUE" -ac -rate "$rate" -timeout "$timeout" -o ffuf-post-form-auth-name-value-ac-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
var url
var session_token
var access_token
var rate
var timeout
-->
