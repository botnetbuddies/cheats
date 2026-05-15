# CloudFox

## setup

### Install with Homebrew

Install CloudFox on macOS with Homebrew.

```sh title:"Install CloudFox with Homebrew"
brew install cloudfox
```
<!-- cheat -->


### Install with Go

Install CloudFox on Linux or any Go-supported platform. Ensure `$HOME/go/bin` is on your `PATH`.

```sh title:"Install CloudFox with Go"
go install github.com/BishopFox/cloudfox@latest
```
<!-- cheat -->

### Install release binary

Download the latest CloudFox release binary for the current platform.

```sh title:"Open CloudFox releases"
open https://github.com/BishopFox/cloudfox/releases/latest
```
<!-- cheat -->

### Build from source

Build CloudFox from a local clone.

```sh title:"Build CloudFox from source"
git clone https://github.com/BishopFox/cloudfox.git && cd cloudfox && go build .
```
<!-- cheat -->

### AWS help

List CloudFox AWS commands and global flags.

```sh title:"List CloudFox AWS commands"
cloudfox aws -h
```
<!-- cheat -->

### AWS command help

Show help for one CloudFox AWS command.

```sh title:"Show CloudFox AWS command help"
cloudfox aws "$command_name" -h
```
<!-- cheat
var command_name := all-checks
-->

### GCP help

List CloudFox GCP commands and global flags.

```sh title:"List CloudFox GCP commands"
cloudfox gcp -h
```
<!-- cheat -->

### Azure help

List CloudFox Azure commands and global flags.

```sh title:"List CloudFox Azure commands"
cloudfox azure -h
```
<!-- cheat -->

## aws engagement workflow

### All checks profile

Run most AWS checks against one profile and write table, CSV, JSON, and loot output locally.

```sh title:"Run CloudFox AWS all-checks for one profile"
cloudfox aws --profile "$aws_profile" all-checks
```
<!-- cheat
var aws_profile
-->

### All checks verbose

Run all checks with verbose output so errors and follow-up files are easier to triage live.

```sh title:"Run verbose CloudFox AWS all-checks"
cloudfox aws --profile "$aws_profile" -v2 all-checks
```
<!-- cheat
var aws_profile
-->

### All profiles

Run all checks against every configured AWS profile.

```sh title:"Run CloudFox AWS all-checks for all profiles"
cloudfox aws -a all-checks
```
<!-- cheat -->

### Profile list

Run all checks against profiles listed one per line in a file.

```sh title:"Run CloudFox AWS all-checks from profile list"
cloudfox aws -l "$aws_profile_file" all-checks
```
<!-- cheat
var aws_profile_file
-->

### Output folder

Run all checks and write output under an engagement-specific directory.

```sh title:"Run CloudFox AWS all-checks to output folder"
cloudfox aws --profile "$aws_profile" --outdir "$output_dir" all-checks
```
<!-- cheat
var aws_profile
var output_dir := cloudfox-output
-->

### Inventory first pass

Find which supported services and regions appear active before deeper enumeration.

```sh title:"Inventory active AWS services with CloudFox"
cloudfox aws --profile "$aws_profile" inventory
```
<!-- cheat
var aws_profile
-->

### Tags first pass

Use tags as service-owner, environment, and application hints during scoping and target selection.

```sh title:"Enumerate AWS tags with CloudFox"
cloudfox aws --profile "$aws_profile" tags
```
<!-- cheat
var aws_profile
-->

### Output triage

List CloudFox result and loot files for a profile after a run.

```sh title:"List CloudFox AWS output files"
find "cloudfox-output/aws/$aws_profile" -maxdepth 3 -type f | sort
```
<!-- cheat
var aws_profile
-->

### Error log

Review CloudFox API or permission errors from the latest runs.

```sh title:"Tail CloudFox error log"
tail -n 100 "$HOME/.cloudfox/cloudfox-error.log"
```
<!-- cheat -->

## aws identity and iam

### Principals

List IAM users and roles for target selection and role-chaining analysis.

```sh title:"List AWS IAM principals with CloudFox"
cloudfox aws --profile "$aws_profile" principals
```
<!-- cheat
var aws_profile
-->

### Permissions

Enumerate unique IAM permissions for users and roles.

```sh title:"Enumerate AWS IAM permissions with CloudFox"
cloudfox aws --profile "$aws_profile" permissions
```
<!-- cheat
var aws_profile
-->

### Access keys

Map active IAM access key IDs to users; use as seed material for repo, Slack, drive, and secret-store searches.

```sh title:"Map AWS access keys with CloudFox"
cloudfox aws --profile "$aws_profile" access-keys
```
<!-- cheat
var aws_profile
-->

### Find one access key

Identify whether a discovered AWS access key ID belongs to the in-scope account.

```sh title:"Look up one AWS access key ID"
cloudfox aws --profile "$aws_profile" access-keys --filter "$aws_access_key_id"
```
<!-- cheat
var aws_profile
var aws_access_key_id
-->

### Role trusts

Enumerate roles that trust principals, services, or federated identities; review `IsAdmin?` and `CanPrivEscToAdmin?` columns.

```sh title:"Enumerate AWS role trusts with CloudFox"
cloudfox aws --profile "$aws_profile" role-trusts
```
<!-- cheat
var aws_profile
-->

### Resource trusts

Enumerate resource policies for services CloudFox prioritizes offensively, including S3, SNS, SQS, Lambda, ECR, EFS, Glue, CodeBuild, and Secrets Manager.

```sh title:"Enumerate AWS resource trusts with CloudFox"
cloudfox aws --profile "$aws_profile" resource-trusts
```
<!-- cheat
var aws_profile
-->

### Resource trusts with KMS

Include KMS key policies in resource trust enumeration when key access is in scope.

```sh title:"Enumerate AWS resource trusts including KMS"
cloudfox aws --profile "$aws_profile" resource-trusts --include-kms
```
<!-- cheat
var aws_profile
-->

### IAM simulator

Run CloudFox IAM simulator checks for high-value actions; can be slow, but produces pmapper follow-up commands.

```sh title:"Run CloudFox IAM simulator"
cloudfox aws --profile "$aws_profile" iam-simulator --action "$aws_iam_action"
```
<!-- cheat
var aws_profile
var aws_iam_action := s3:GetObject
-->

### Pmapper summary

Use local pmapper graph data to identify principals with admin or paths to admin.

```sh title:"Summarize pmapper paths with CloudFox"
cloudfox aws --profile "$aws_profile" pmapper
```
<!-- cheat
var aws_profile
-->

### Build pmapper graph

Create pmapper graph data CloudFox can reuse for role-trusts, workloads, instances, lambdas, ECS, and CAPE analysis.

```sh title:"Build pmapper graph for one AWS profile"
pmapper --profile "$aws_profile" graph create
```
<!-- cheat
var aws_profile
-->

## aws attack surface

### Endpoints

Enumerate internet-facing and internal endpoints from App Runner, API Gateway, CloudFront, EKS, ELB, Lambda, MQ, OpenSearch, Redshift, RDS, and related services.

```sh title:"Enumerate AWS endpoints with CloudFox"
cloudfox aws --profile "$aws_profile" endpoints
```
<!-- cheat
var aws_profile
-->

### API gateways

Enumerate API Gateway routes and generate cURL commands for follow-up testing.

```sh title:"Enumerate AWS API Gateway routes with CloudFox"
cloudfox aws --profile "$aws_profile" api-gws
```
<!-- cheat
var aws_profile
-->

### Route53

Enumerate public and private hosted zones and write A-record loot files for application discovery.

```sh title:"Enumerate Route53 records with CloudFox"
cloudfox aws --profile "$aws_profile" route53
```
<!-- cheat
var aws_profile
-->

### Network ports

Enumerate security-group-exposed ports and produce target lists for service testing.

```sh title:"Enumerate exposed AWS network ports with CloudFox"
cloudfox aws --profile "$aws_profile" network-ports
```
<!-- cheat
var aws_profile
-->

### EC2 instances

List EC2 instances, IPs, roles, and generated public/private IP loot files.

```sh title:"Enumerate AWS EC2 instances with CloudFox"
cloudfox aws --profile "$aws_profile" instances
```
<!-- cheat
var aws_profile
-->

### Elastic network interfaces

List ENIs and IPs for broader network mapping.

```sh title:"Enumerate AWS ENIs with CloudFox"
cloudfox aws --profile "$aws_profile" elastic-network-interfaces
```
<!-- cheat
var aws_profile
-->

### Workloads with powerful roles

Find EC2, ECS, Lambda, and App Runner workloads with admin roles or paths to admin.

```sh title:"Find AWS workloads with admin paths"
cloudfox aws --profile "$aws_profile" workloads
```
<!-- cheat
var aws_profile
-->

## aws workload loot

### Environment variables

Collect environment variables from App Runner, ECS, Lambda, Lightsail Containers, and SageMaker for secret hunting.

```sh title:"Collect AWS workload environment variables with CloudFox"
cloudfox aws --profile "$aws_profile" env-vars
```
<!-- cheat
var aws_profile
-->

### Lambda

List Lambda functions and generate get-function commands for code retrieval.

```sh title:"Enumerate AWS Lambda functions with CloudFox"
cloudfox aws --profile "$aws_profile" lambda
```
<!-- cheat
var aws_profile
-->

### ECS tasks

List ECS task definitions, roles, IPs, and useful ECS loot files.

```sh title:"Enumerate AWS ECS tasks with CloudFox"
cloudfox aws --profile "$aws_profile" ecs-tasks
```
<!-- cheat
var aws_profile
-->

### EKS clusters

Enumerate EKS clusters and generate kubeconfig update commands.

```sh title:"Enumerate AWS EKS clusters with CloudFox"
cloudfox aws --profile "$aws_profile" eks
```
<!-- cheat
var aws_profile
-->

### ECR repositories

Enumerate ECR repos and generate docker pull/login commands.

```sh title:"Enumerate AWS ECR repositories with CloudFox"
cloudfox aws --profile "$aws_profile" ecr
```
<!-- cheat
var aws_profile
-->

### CodeBuild

Enumerate CodeBuild projects/builds and review environment variables, service roles, and generated loot.

```sh title:"Enumerate AWS CodeBuild with CloudFox"
cloudfox aws --profile "$aws_profile" codebuild
```
<!-- cheat
var aws_profile
-->

### CloudFormation

List stacks and loot stack templates, parameters, and outputs; search for secrets and privileged roles.

```sh title:"Enumerate CloudFormation stacks with CloudFox"
cloudfox aws --profile "$aws_profile" cloudformation
```
<!-- cheat
var aws_profile
-->

## aws data and exfil targets

### Buckets

List S3 buckets and generate commands for selective listing or download with whichever profile later has object access.

```sh title:"Enumerate AWS S3 buckets with CloudFox"
cloudfox aws --profile "$aws_profile" buckets
```
<!-- cheat
var aws_profile
-->

### Bucket loot commands

Open the generated S3 follow-up command file after running `buckets`.

```sh title:"Show CloudFox bucket loot commands"
sed -n '1,220p' "cloudfox-output/aws/$aws_profile/loot/bucket-commands.txt"
```
<!-- cheat
var aws_profile
-->

### Secrets

List Secrets Manager and SSM Parameter Store secrets and generate pull commands for later use with stronger credentials.

```sh title:"List AWS secrets with CloudFox"
cloudfox aws --profile "$aws_profile" secrets
```
<!-- cheat
var aws_profile
-->

### Secret loot commands

Open the generated commands to pull specific secrets.

```sh title:"Show CloudFox secret pull commands"
sed -n '1,220p' "cloudfox-output/aws/$aws_profile/loot/pull-secrets-commands.txt"
```
<!-- cheat
var aws_profile
-->

### Databases

Enumerate AWS database services for data target selection.

```sh title:"Enumerate AWS databases with CloudFox"
cloudfox aws --profile "$aws_profile" databases
```
<!-- cheat
var aws_profile
-->

### File systems

Enumerate EFS and FSx and generate mount commands for accessible file systems.

```sh title:"Enumerate AWS file systems with CloudFox"
cloudfox aws --profile "$aws_profile" filesystems
```
<!-- cheat
var aws_profile
-->

### RAM shared resources

Find inbound and outbound AWS RAM resource shares that can create cross-account attack paths.

```sh title:"Enumerate AWS RAM shares with CloudFox"
cloudfox aws --profile "$aws_profile" ram
```
<!-- cheat
var aws_profile
-->

### SNS topics

Enumerate SNS topics, summarize policies, and generate subscribe/publish commands where permitted.

```sh title:"Enumerate AWS SNS topics with CloudFox"
cloudfox aws --profile "$aws_profile" sns
```
<!-- cheat
var aws_profile
-->

### SQS queues

Enumerate SQS queues, summarize policies, and generate receive/send commands where permitted.

```sh title:"Enumerate AWS SQS queues with CloudFox"
cloudfox aws --profile "$aws_profile" sqs
```
<!-- cheat
var aws_profile
-->

## aws cross-account

### Organizations

Enumerate AWS Organizations accounts, management account context, OUs, and service control policy clues.

```sh title:"Enumerate AWS Organizations with CloudFox"
cloudfox aws --profile "$aws_profile" orgs
```
<!-- cheat
var aws_profile
-->

### Outbound assumed roles

Look for roles in other accounts that this account's principals can assume. This is intentionally excluded from all-checks because it is slow.

```sh title:"Enumerate outbound assumed roles with CloudFox"
cloudfox aws --profile "$aws_profile" outbound-assumed-roles
```
<!-- cheat
var aws_profile
-->

### CAPE pmapper prep

Build pmapper graphs for every in-scope profile before CAPE.

```sh title:"Build pmapper graphs from profile list"
xargs -I{} pmapper --profile "{}" graph create < "$aws_profile_file"
```
<!-- cheat
var aws_profile_file
-->

### CAPE admin paths

Find cross-account privilege escalation paths that lead to admin across a profile list.

```sh title:"Find cross-account admin paths with CloudFox CAPE"
cloudfox aws -l "$aws_profile_file" cape --admin-only
```
<!-- cheat
var aws_profile_file
-->

### CAPE all paths

Find cross-account privilege escalation paths without filtering to admin-only results. This can take hours.

```sh title:"Find all cross-account paths with CloudFox CAPE"
cloudfox aws -l "$aws_profile_file" cape
```
<!-- cheat
var aws_profile_file
-->

### CAPE TUI

Open the CloudFox terminal UI for CAPE results.

```sh title:"Open CloudFox CAPE TUI"
cloudfox aws -l "$aws_profile_file" cape tui --admin-only
```
<!-- cheat
var aws_profile_file
-->

## aws output review

### Interesting CSV grep

Search CSV output for admin, public, interesting, secret, token, and password indicators.

```sh title:"Search CloudFox CSV output for red-team leads"
grep -RniE 'admin|CanPrivEscToAdmin|public|interesting|secret|token|password|key' "cloudfox-output/aws/$aws_profile/csv" "cloudfox-output/aws/$aws_profile/loot"
```
<!-- cheat
var aws_profile
-->

### Loot files

List generated loot files, which often contain next-step AWS CLI, curl, kubectl, docker, mount, and pull commands.

```sh title:"List CloudFox loot files"
find "cloudfox-output/aws/$aws_profile/loot" -type f | sort
```
<!-- cheat
var aws_profile
-->

### Public endpoints

Print URL-only endpoint loot after running `endpoints`.

```sh title:"Show CloudFox endpoint URL loot"
cat "cloudfox-output/aws/$aws_profile/loot/endpoints-UrlsOnly.txt"
```
<!-- cheat
var aws_profile
-->

### IP target lists

Print generated EC2 public IPs after running `instances`.

```sh title:"Show CloudFox EC2 public IP loot"
cat "cloudfox-output/aws/$aws_profile/loot/instances-ec2PublicIPs.txt"
```
<!-- cheat
var aws_profile
-->

## azure quick refs

### Azure VMs

Run the Azure VM command against a subscription.

```sh title:"Enumerate Azure VMs with CloudFox"
cloudfox azure --subscription "$subscription_id" vms
```
<!-- cheat
var subscription_id
-->

### Azure command help

Show help for one Azure command.

```sh title:"Show CloudFox Azure command help"
cloudfox azure "$command_name" -h
```
<!-- cheat
var command_name := vms
-->

## gcp quick refs

### GCP project all checks

Run all GCP checks against one project.

```sh title:"Run CloudFox GCP all-checks for one project"
cloudfox gcp --project "$project_id" all-checks
```
<!-- cheat
var project_id
-->

### GCP project list all checks

Run all GCP checks against project IDs listed one per line in a file.

```sh title:"Run CloudFox GCP all-checks from project list"
cloudfox gcp -l "$project_file" all-checks
```
<!-- cheat
var project_file
-->

### GCP organization whoami

Identify current access across a GCP organization.

```sh title:"Run CloudFox GCP whoami for organization"
cloudfox gcp --organization "$organization_id" whoami
```
<!-- cheat
var organization_id
-->

### GCP attack paths

Include CloudFox GCP attack-path columns when supported by the command.

```sh title:"Run CloudFox GCP with attack paths"
cloudfox gcp --project "$project_id" --attack-paths iam
```
<!-- cheat
var project_id
-->

### GCP flat output

Use flat output instead of hierarchical org/folder/project output.

```sh title:"Run CloudFox GCP flat output"
cloudfox gcp --project "$project_id" --flat instances
```
<!-- cheat
var project_id
-->
