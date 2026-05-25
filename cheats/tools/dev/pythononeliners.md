# Pythononeliners

## python - oneliner

### Password to NT hash

Dump password to NT hash with Pythononeliners.

Compute the NT hash of a cleartext password using openssl + iconv (UTF-16LE then MD4). No Python needed.

```sh title:"Pythononeliners Dump Password to NT Hash"
printf '%s' '$pass' | iconv -t UTF-16LE | openssl dgst -md4 | awk '{print toupper($2)}'
```
<!-- cheat
var pass
-->

### Hex SID to string

Decode hex SID to string with Pythononeliners.

Decode a hex-encoded SID blob into the canonical `S-1-5-21-...` form. Useful when a tool prints the raw bytes.

```sh title:"Pythononeliners Decode Hex SID to String"
python3 - <<'PY'
def dec(h):
    if h.startswith(("0x","0X")):
        h = h[2:]
    b = bytes.fromhex(h)
    rev = b[0]
    count = b[1]
    auth = int.from_bytes(b[2:8], 'big')
    subs = [int.from_bytes(b[8+4*i:12+4*i], 'little') for i in range(count)]
    print('S-{}-{}'.format(rev, auth) + ''.join('-{}'.format(s) for s in subs))
dec('$hex_sid')
PY
```
<!-- cheat
var hex_sid
-->

### Stabilize Shell

Spawn stabilize shell with Pythononeliners.

Upgrade a dumb reverse shell to a full PTY using Python's `pty.spawn`, then background and reset stty so tab completion and ctrl-c work.

```sh title:"Pythononeliners Spawn Stabilize Shell"
python3 -c 'import pty; pty.spawn("/bin/bash")'
\# ^Z
\# stty raw -echo; fg; reset
```
<!-- cheat -->
