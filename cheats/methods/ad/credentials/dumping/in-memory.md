---
technique: InMemorySecrets
category: credential-dumping
targets: Process Memory, User Sessions
protocols: Local
remote_capable: false
tags: credential-dumping memory mimipenguin lazagne linux windows ad
---

# InMemorySecrets

Applications can keep passwords, tokens, and other secrets in process memory outside LSASS. Dumping in-memory secrets usually requires local administrator or root privileges and should be treated like volatile credential access.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Elevated access | Memory scraping usually requires local admin or root |
| Live sessions | Target applications must still hold secrets in memory |
| Local execution | Most tools run directly on the target host |

## Windows

### LaZagne memory

#cmd #lazagne #memory

Run LaZagne memory modules on Windows.

```cmd title:"Dump memory secrets with LaZagne"
.\lazagne.exe memory
```
<!-- cheat -->

## Linux

### mimipenguin

#linux #memory #mimipenguin

Extract passwords from Linux process memory with mimipenguin.

```sh title:"Dump Linux memory secrets with mimipenguin"
mimipenguin
```
<!-- cheat -->

### laZagne memory

#python #lazagne #memory

Run LaZagne memory modules on Linux.

```sh title:"Dump Linux memory secrets with LaZagne"
laZagne memory
```
<!-- cheat -->
