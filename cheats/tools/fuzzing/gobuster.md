# Gobuster

## dir

### Basic

Run basic directory fuzzing.

```sh title:"Basic gobuster directory fuzz"
gobuster dir -u "$url" -w "$wordlist"
```
<!-- cheat
var url
var wordlist
-->

### Common extensions

Run directory fuzzing with common web extensions.

```sh title:"Gobuster directory fuzz with common extensions"
gobuster dir -u "$url" -w "$wordlist" -x json,html,php,txt,xml,md
```
<!-- cheat
var url
var wordlist
-->

### Higher threads

Run directory fuzzing with 30 threads.

```sh title:"Gobuster directory fuzz with 30 threads"
gobuster dir -u "$url" -w "$wordlist" -t 30
```
<!-- cheat
var url
var wordlist
-->
