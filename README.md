# cheats

A minimal, repo-local collection of [CheatMD](https://github.com/Gubarz/cheatmd) markdown cheat sheets for common offensive/ops tasks.

## What this is

* Markdown `.md` files consumbed by `CheatMD`.
* Fuzzy-searchable snippets with code blocks and metadata.
* Variables are prompted at use time; shared variables can be imported across cheats.

## Requirements

* CheatMD installed and on `PATH`.
* Bash or Zsh.

## Variable Standards

### Identity & Access

| Variable | Description |
|----------|-------------|
| `$user` | The "Actor." The credential you are currently using to authenticate or execute commands. |
| `$target_user` | The "Subject." The account being modified, attacked, created, or audited. |
| `$actor_user` | (Rare) Used in impersonation/delegation scenarios when you need a third user identity. |
| `$pass` | The cleartext password for `$user`. |
| `$hash` | The NTLM/MD4/MD5 credential for `$user`. |
| `$target_pass` | The cleartext password for `$target_user`. |
| `$target_hash` | The NTLM/MD4/MD5 credential for `$target_user`. |
| `$domain` | The Active Directory or DNS domain context (FQDN). |

### Networking

| Variable | Description |
|----------|-------------|
| `$rhost_ip` | The Remote Host IP address. (Use for tools that struggle with DNS resolution). |
| `$rhost_name` | The Remote Hostname or FQDN. (Use for Kerberos-based attacks). |
| `$lhost` | Your local listener IP (for shells or file serving). |
| `$rport` | Remote port. |
| `$lport` | Local port. |

## Style Guide

* Use lowercase variable names: `$user`, `$rhost_ip`.
* Follow the variable standards above for Identity & Networking variables.
* Keep commands copy-pastable and shell-safe; quote values that can contain spaces.
* Provide short descriptions; avoid tool theory here.
* Avoid destructive defaults. Gate destructive commands behind explicit confirmation.
* Use `import` for common variables instead of redefining them.

## Adding a New Cheat

1. Create `toolname.md` in the repo root.
2. Group commands under `## category` sections.
3. Add commands in fenced code blocks with `sh title:"description"`.
4. Add metadata in `<!-- cheat -->` blocks below each code block.
5. Import common modules (`users`, `domain_ip`, `passwords`) where applicable.

## Credits

* https://lolbas-project.github.io/
* https://gtfobins.org
* https://hacktricks.wiki/en/index.html
* Botnet Buddies

## Licensing

* See `LICENSE` for terms.
