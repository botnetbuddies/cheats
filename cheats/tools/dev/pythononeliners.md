# Pythononeliners

## python - oneliner

### Password to NT hash

Dump password to NT hash with Pythononeliners.

```sh title:"Pythononeliners Dump Password to NT Hash"
printf '%s' '$pass' | iconv -t UTF-16LE | openssl dgst -md4 | awk '{print toupper($2)}'
```
<!-- cheat
var pass
-->

### Hex SID to string

Decode hex SID to string with Pythononeliners.

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

```sh title:"Pythononeliners Spawn Stabilize Shell"
python3 -c 'import pty; pty.spawn("/bin/bash")'
\# ^Z
\# stty raw -echo; fg; reset
```
<!-- cheat -->
