# CloudFox

## setup

### Install with Homebrew

Install CloudFox with homebrew.

```sh title:"CloudFox Install with Homebrew"
brew install cloudfox
```
<!-- cheat -->


### Install with Go

Install CloudFox with go.

```sh title:"CloudFox Install with Go"
go install github.com/BishopFox/cloudfox@latest
```
<!-- cheat -->

### Install release binary

Install release binary with CloudFox.

```sh title:"CloudFox Install Release Binary"
open https://github.com/BishopFox/cloudfox/releases/latest
```
<!-- cheat -->

### Build from source

Build CloudFox from source.

```sh title:"CloudFox Build from Source"
git clone https://github.com/BishopFox/cloudfox.git && cd cloudfox && go build .
```
<!-- cheat -->

### AWS help

List AWS help with CloudFox.

```sh title:"CloudFox List AWS Help"
cloudfox aws -h
```
<!-- cheat -->

### AWS command help

Show AWS command help with CloudFox.

```sh title:"CloudFox Show AWS Command Help"
cloudfox aws "$command_name" -h
```
<!-- cheat
var command_name := all-checks
-->

### GCP help

List GCP help with CloudFox.

```sh title:"CloudFox List GCP Help"
cloudfox gcp -h
```
<!-- cheat -->

### Azure help

List azure help with CloudFox.

```sh title:"CloudFox List Azure Help"
cloudfox azure -h
```
<!-- cheat -->

## aws engagement workflow

### All checks profile

Check all checks profile with CloudFox.

```sh title:"CloudFox Check All Checks Profile"
cloudfox aws --profile "$aws_profile" all-checks
```
<!-- cheat
var aws_profile
-->

### All checks verbose

Check all checks verbose with CloudFox.

```sh title:"CloudFox Check All Checks Verbose"
cloudfox aws --profile "$aws_profile" -v2 all-checks
```
<!-- cheat
var aws_profile
-->

### All profiles

Check all profiles with CloudFox.

```sh title:"CloudFox Check All Profiles"
cloudfox aws -a all-checks
```
<!-- cheat -->

### Profile list

List profile list with CloudFox.

```sh title:"CloudFox List Profile List"
cloudfox aws -l "$aws_profile_file" all-checks
```
<!-- cheat
var aws_profile_file
-->

### Output folder

Check output folder with CloudFox.

```sh title:"CloudFox Check Output Folder"
cloudfox aws --profile "$aws_profile" --outdir "$output_dir" all-checks
```
<!-- cheat
var aws_profile
var output_dir := cloudfox-output
-->

### Inventory first pass

Run inventory first pass with CloudFox.

```sh title:"CloudFox Run Inventory First Pass"
cloudfox aws --profile "$aws_profile" inventory
```
<!-- cheat
var aws_profile
-->

### Tags first pass

Enumerate tags first pass with CloudFox.

```sh title:"CloudFox Enumerate Tags First Pass"
cloudfox aws --profile "$aws_profile" tags
```
<!-- cheat
var aws_profile
-->

### Output triage

List output triage with CloudFox.

```sh title:"CloudFox List Output Triage"
find "cloudfox-output/aws/$aws_profile" -maxdepth 3 -type f | sort
```
<!-- cheat
var aws_profile
-->

### Error log

Run error log with CloudFox.

```sh title:"CloudFox Run Error Log"
tail -n 100 "$HOME/.cloudfox/cloudfox-error.log"
```
<!-- cheat -->

## aws identity and iam

### Principals

List principals with CloudFox.

```sh title:"CloudFox List Principals"
cloudfox aws --profile "$aws_profile" principals
```
<!-- cheat
var aws_profile
-->

### Permissions

Enumerate permissions with CloudFox.

```sh title:"CloudFox Enumerate Permissions"
cloudfox aws --profile "$aws_profile" permissions
```
<!-- cheat
var aws_profile
-->

### Access keys

Run access keys with CloudFox.

```sh title:"CloudFox Run Access Keys"
cloudfox aws --profile "$aws_profile" access-keys
```
<!-- cheat
var aws_profile
-->

### Find one access key

Find one access key with CloudFox.

```sh title:"CloudFox Find One Access Key"
cloudfox aws --profile "$aws_profile" access-keys --filter "$aws_access_key_id"
```
<!-- cheat
var aws_profile
var aws_access_key_id
-->

### Role trusts

Enumerate role trusts with CloudFox.

```sh title:"CloudFox Enumerate Role Trusts"
cloudfox aws --profile "$aws_profile" role-trusts
```
<!-- cheat
var aws_profile
-->

### Resource trusts

Enumerate resource trusts with CloudFox.

```sh title:"CloudFox Enumerate Resource Trusts"
cloudfox aws --profile "$aws_profile" resource-trusts
```
<!-- cheat
var aws_profile
-->

### Resource trusts with KMS

Enumerate resource trusts with KMS with CloudFox.

```sh title:"CloudFox Enumerate Resource Trusts with KMS"
cloudfox aws --profile "$aws_profile" resource-trusts --include-kms
```
<!-- cheat
var aws_profile
-->

### IAM simulator

Execute IAM simulator with CloudFox.

```sh title:"CloudFox Execute IAM Simulator"
cloudfox aws --profile "$aws_profile" iam-simulator --action "$aws_iam_action"
```
<!-- cheat
var aws_profile
var aws_iam_action := s3:GetObject
-->

### Pmapper summary

Run pmapper summary with CloudFox.

```sh title:"CloudFox Run Pmapper Summary"
cloudfox aws --profile "$aws_profile" pmapper
```
<!-- cheat
var aws_profile
-->

### Build pmapper graph

Build pmapper graph with CloudFox.

```sh title:"CloudFox Build Pmapper Graph"
pmapper --profile "$aws_profile" graph create
```
<!-- cheat
var aws_profile
-->

## aws attack surface

### Endpoints

Enumerate endpoints with CloudFox.

```sh title:"CloudFox Enumerate Endpoints"
cloudfox aws --profile "$aws_profile" endpoints
```
<!-- cheat
var aws_profile
-->

### API gateways

Enumerate API gateways with CloudFox.

```sh title:"CloudFox Enumerate API Gateways"
cloudfox aws --profile "$aws_profile" api-gws
```
<!-- cheat
var aws_profile
-->

### Route53

Enumerate route53 with CloudFox.

```sh title:"CloudFox Enumerate Route53"
cloudfox aws --profile "$aws_profile" route53
```
<!-- cheat
var aws_profile
-->

### Network ports

Enumerate network ports with CloudFox.

```sh title:"CloudFox Enumerate Network Ports"
cloudfox aws --profile "$aws_profile" network-ports
```
<!-- cheat
var aws_profile
-->

### EC2 instances

Enumerate EC2 instances with CloudFox.

```sh title:"CloudFox Enumerate EC2 Instances"
cloudfox aws --profile "$aws_profile" instances
```
<!-- cheat
var aws_profile
-->

### Elastic network interfaces

Enumerate elastic network interfaces with CloudFox.

```sh title:"CloudFox Enumerate Elastic Network Interfaces"
cloudfox aws --profile "$aws_profile" elastic-network-interfaces
```
<!-- cheat
var aws_profile
-->

### Workloads with powerful roles

Find workloads with powerful roles with CloudFox.

```sh title:"CloudFox Find Workloads with Powerful Roles"
cloudfox aws --profile "$aws_profile" workloads
```
<!-- cheat
var aws_profile
-->

## aws workload loot

### Environment variables

Run environment variables with CloudFox.

```sh title:"CloudFox Run Environment Variables"
cloudfox aws --profile "$aws_profile" env-vars
```
<!-- cheat
var aws_profile
-->

### Lambda

Enumerate lambda with CloudFox.

```sh title:"CloudFox Enumerate Lambda"
cloudfox aws --profile "$aws_profile" lambda
```
<!-- cheat
var aws_profile
-->

### ECS tasks

Enumerate ECS tasks with CloudFox.

```sh title:"CloudFox Enumerate ECS Tasks"
cloudfox aws --profile "$aws_profile" ecs-tasks
```
<!-- cheat
var aws_profile
-->

### EKS clusters

Enumerate EKS clusters with CloudFox.

```sh title:"CloudFox Enumerate EKS Clusters"
cloudfox aws --profile "$aws_profile" eks
```
<!-- cheat
var aws_profile
-->

### ECR repositories

Enumerate ECR repositories with CloudFox.

```sh title:"CloudFox Enumerate ECR Repositories"
cloudfox aws --profile "$aws_profile" ecr
```
<!-- cheat
var aws_profile
-->

### CodeBuild

Enumerate CodeBuild with CloudFox.

```sh title:"CloudFox Enumerate CodeBuild"
cloudfox aws --profile "$aws_profile" codebuild
```
<!-- cheat
var aws_profile
-->

### CloudFormation

Enumerate CloudFormation with CloudFox.

```sh title:"CloudFox Enumerate CloudFormation"
cloudfox aws --profile "$aws_profile" cloudformation
```
<!-- cheat
var aws_profile
-->

## aws data and exfil targets

### Buckets

Dump buckets with CloudFox.

```sh title:"CloudFox Dump Buckets"
cloudfox aws --profile "$aws_profile" buckets
```
<!-- cheat
var aws_profile
-->

### Bucket loot commands

Dump bucket loot commands with CloudFox.

```sh title:"CloudFox Dump Bucket Loot Commands"
sed -n '1,220p' "cloudfox-output/aws/$aws_profile/loot/bucket-commands.txt"
```
<!-- cheat
var aws_profile
-->

### Secrets

Dump secrets with CloudFox.

```sh title:"CloudFox Dump Secrets"
cloudfox aws --profile "$aws_profile" secrets
```
<!-- cheat
var aws_profile
-->

### Secret loot commands

Download secret loot commands with CloudFox.

```sh title:"CloudFox Download Secret Loot Commands"
sed -n '1,220p' "cloudfox-output/aws/$aws_profile/loot/pull-secrets-commands.txt"
```
<!-- cheat
var aws_profile
-->

### Databases

Dump databases with CloudFox.

```sh title:"CloudFox Dump Databases"
cloudfox aws --profile "$aws_profile" databases
```
<!-- cheat
var aws_profile
-->

### File systems

Dump file systems with CloudFox.

```sh title:"CloudFox Dump File Systems"
cloudfox aws --profile "$aws_profile" filesystems
```
<!-- cheat
var aws_profile
-->

### RAM shared resources

Dump RAM shared resources with CloudFox.

```sh title:"CloudFox Dump RAM Shared Resources"
cloudfox aws --profile "$aws_profile" ram
```
<!-- cheat
var aws_profile
-->

### SNS topics

Dump SNS topics with CloudFox.

```sh title:"CloudFox Dump SNS Topics"
cloudfox aws --profile "$aws_profile" sns
```
<!-- cheat
var aws_profile
-->

### SQS queues

Dump SQS queues with CloudFox.

```sh title:"CloudFox Dump SQS Queues"
cloudfox aws --profile "$aws_profile" sqs
```
<!-- cheat
var aws_profile
-->

## aws cross-account

### Organizations

Enumerate organizations with CloudFox.

```sh title:"CloudFox Enumerate Organizations"
cloudfox aws --profile "$aws_profile" orgs
```
<!-- cheat
var aws_profile
-->

### Outbound assumed roles

Enumerate outbound assumed roles with CloudFox.

```sh title:"CloudFox Enumerate Outbound Assumed Roles"
cloudfox aws --profile "$aws_profile" outbound-assumed-roles
```
<!-- cheat
var aws_profile
-->

### CAPE pmapper prep

List CAPE pmapper prep with CloudFox.

```sh title:"CloudFox List CAPE Pmapper Prep"
xargs -I{} pmapper --profile "{}" graph create < "$aws_profile_file"
```
<!-- cheat
var aws_profile_file
-->

### CAPE admin paths

Find CAPE admin paths with CloudFox.

```sh title:"CloudFox Find CAPE Admin Paths"
cloudfox aws -l "$aws_profile_file" cape --admin-only
```
<!-- cheat
var aws_profile_file
-->

### CAPE all paths

Find CAPE all paths with CloudFox.

```sh title:"CloudFox Find CAPE All Paths"
cloudfox aws -l "$aws_profile_file" cape
```
<!-- cheat
var aws_profile_file
-->

### CAPE TUI

Run CAPE TUI with CloudFox.

```sh title:"CloudFox Run CAPE TUI"
cloudfox aws -l "$aws_profile_file" cape tui --admin-only
```
<!-- cheat
var aws_profile_file
-->

## aws output review

### Interesting CSV grep

Find interesting CSV grep with CloudFox.

```sh title:"CloudFox Find Interesting CSV Grep"
grep -RniE 'admin|CanPrivEscToAdmin|public|interesting|secret|token|password|key' "cloudfox-output/aws/$aws_profile/csv" "cloudfox-output/aws/$aws_profile/loot"
```
<!-- cheat
var aws_profile
-->

### Loot files

List loot files with CloudFox.

```sh title:"CloudFox List Loot Files"
find "cloudfox-output/aws/$aws_profile/loot" -type f | sort
```
<!-- cheat
var aws_profile
-->

### Public endpoints

Show public endpoints with CloudFox.

```sh title:"CloudFox Show Public Endpoints"
cat "cloudfox-output/aws/$aws_profile/loot/endpoints-UrlsOnly.txt"
```
<!-- cheat
var aws_profile
-->

### IP target lists

Show IP target lists with CloudFox.

```sh title:"CloudFox Show IP Target Lists"
cat "cloudfox-output/aws/$aws_profile/loot/instances-ec2PublicIPs.txt"
```
<!-- cheat
var aws_profile
-->

## azure quick refs

### Azure VMs

Enumerate azure VMs with CloudFox.

```sh title:"CloudFox Enumerate Azure VMs"
cloudfox azure --subscription "$subscription_id" vms
```
<!-- cheat
var subscription_id
-->

### Azure command help

Show azure command help with CloudFox.

```sh title:"CloudFox Show Azure Command Help"
cloudfox azure "$command_name" -h
```
<!-- cheat
var command_name := vms
-->

## gcp quick refs

### GCP project all checks

Check GCP project all checks with CloudFox.

```sh title:"CloudFox Check GCP Project All Checks"
cloudfox gcp --project "$project_id" all-checks
```
<!-- cheat
var project_id
-->

### GCP project list all checks

List GCP project list all checks with CloudFox.

```sh title:"CloudFox List GCP Project List All Checks"
cloudfox gcp -l "$project_file" all-checks
```
<!-- cheat
var project_file
-->

### GCP organization whoami

Enumerate GCP organization whoami with CloudFox.

```sh title:"CloudFox Enumerate GCP Organization Whoami"
cloudfox gcp --organization "$organization_id" whoami
```
<!-- cheat
var organization_id
-->

### GCP attack paths

Execute GCP attack paths with CloudFox.

```sh title:"CloudFox Execute GCP Attack Paths"
cloudfox gcp --project "$project_id" --attack-paths iam
```
<!-- cheat
var project_id
-->

### GCP flat output

Execute GCP flat output with CloudFox.

```sh title:"CloudFox Execute GCP Flat Output"
cloudfox gcp --project "$project_id" --flat instances
```
<!-- cheat
var project_id
-->
