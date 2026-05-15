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

### AWS

| Variable | Description |
|----------|-------------|
| `$aws_profile` | AWS CLI profile name used for authenticated AWS API calls. |
| `$aws_profile_file` | File containing AWS profile names, one per line. |
| `$aws_account_id` | AWS account ID. |
| `$aws_account_ids` | Multiple AWS account IDs, formatted as the target tool expects. |
| `$aws_role_name` | IAM role name. |
| `$aws_role_names` | Multiple IAM role names, formatted as the target tool expects. |
| `$aws_role_arn` | Full IAM role ARN. |
| `$aws_mfa_serial_arn` | MFA device serial ARN for AWS role assumption. |
| `$aws_mfa_token_code` | MFA token code for AWS role assumption. |
| `$aws_region` | AWS region. |
| `$aws_region_one` | First AWS region when a command compares or combines regions. |
| `$aws_region_two` | Second AWS region when a command compares or combines regions. |
| `$aws_region_list` | Multiple AWS regions, formatted as the target tool expects. |
| `$aws_access_key_id` | AWS access key ID. |
| `$aws_secret_access_key` | AWS secret access key. |
| `$aws_session_token` | AWS temporary session token. |
| `$aws_iam_action` | Single IAM action name. |
| `$aws_iam_action_query` | IAM action search pattern or list, formatted as the target tool expects. |
| `$s3_bucket` | S3 bucket name. |
| `$s3_bucket_names` | Multiple S3 bucket names, formatted as the target tool expects. |
| `$s3_bucket_file` | File containing S3 bucket names, one per line. |
| `$s3_object_key` | S3 object key inside a bucket. |
| `$aws_instance_id` | EC2 instance ID. |
| `$aws_source_ip` | Source IP or CIDR to allow, whitelist, or probe from during AWS testing. |
| `$aws_principal_arn` | AWS principal ARN used in trust, permission, or backdoor testing. |
| `$aws_sns_topic_arn` | SNS topic ARN. |
| `$aws_sns_email` | Email address used for SNS subscription testing. |
| `$aws_callback_url` | Operator-controlled callback URL for approved AWS testing. |
| `$aws_userdata_script_file` | Local script file used as EC2 user data during approved AWS testing. |
| `$aws_policy_folder` | Folder containing exported IAM policy JSON for offline analysis. |

### Kubernetes

| Variable | Description |
|----------|-------------|
| `$kube_context` | Kubernetes kubeconfig context name. |
| `$kubeconfig_file` | Explicit kubeconfig file path. |
| `$kube_cluster_name` | Kubernetes cluster name. |
| `$kube_results_json` | Kubernetes result export JSON file. |

## Style Guide

* Use lowercase variable names: `$user`, `$rhost_ip`.
* Follow the variable standards above for Identity, Networking, AWS, and Kubernetes variables.
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
