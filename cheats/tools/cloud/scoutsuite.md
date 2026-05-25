# ScoutSuite

## setup

### Install with uv tool

Install ScoutSuite with uv tool.

Install Scout Suite as an isolated uv-managed CLI tool.

```sh title:"ScoutSuite Install with uv Tool"
uv tool install scoutsuite
```
<!-- cheat -->

### Install from Git

Install ScoutSuite from git.

Clone Scout Suite and run it with uv-managed dependencies from source.

```sh title:"ScoutSuite Install from Git"
git clone https://github.com/nccgroup/ScoutSuite.git && cd ScoutSuite && uv run --with-requirements requirements.txt python scout.py --help
```
<!-- cheat -->

### Help

Show help with ScoutSuite.

Show Scout Suite CLI help.

```sh title:"ScoutSuite Show Help"
scout --help
```
<!-- cheat -->

### AWS help

Show AWS help with ScoutSuite.

Show AWS provider options.

```sh title:"ScoutSuite Show AWS Help"
scout aws --help
```
<!-- cheat -->

### Kubernetes help

Show kubernetes help with ScoutSuite.

Show Kubernetes provider options.

```sh title:"ScoutSuite Show Kubernetes Help"
scout kubernetes --help
```
<!-- cheat -->

### macOS file descriptors

Set macOS file descriptors with ScoutSuite.

Increase the shell file descriptor limit when Scout errors on DNS or socket resolution.

```sh title:"ScoutSuite Set MacOS File Descriptors"
ulimit -Sn 1000
```
<!-- cheat -->

## aws auth

### AWS default credentials

Dump AWS default credentials with ScoutSuite.

Run Scout Suite with the default boto3/AWS CLI credential chain.

```sh title:"ScoutSuite Dump AWS Default Credentials"
scout aws --no-browser
```
<!-- cheat -->

### AWS named profile

Execute AWS named profile with ScoutSuite.

Run against one named AWS profile.

```sh title:"ScoutSuite Execute AWS Named Profile"
scout aws --profile "$aws_profile" --no-browser
```
<!-- cheat
var aws_profile
-->

### AWS role profile

Execute AWS role profile with ScoutSuite.

Run against an AWS CLI profile that assumes a role from `~/.aws/config`.

```sh title:"ScoutSuite Execute AWS Role Profile"
scout aws --profile "$aws_profile" --no-browser
```
<!-- cheat
var aws_profile
-->

### AWS environment keys

Dump AWS environment keys with ScoutSuite.

Run with access keys already exported in the environment.

```sh title:"ScoutSuite Dump AWS Environment Keys"
AWS_ACCESS_KEY_ID="$aws_access_key_id" AWS_SECRET_ACCESS_KEY="$aws_secret_access_key" AWS_SESSION_TOKEN="$aws_session_token" scout aws --no-browser
```
<!-- cheat
var aws_access_key_id
var aws_secret_access_key
var aws_session_token
-->

### AWS access keys CLI

Execute AWS access keys CLI with ScoutSuite.

Run with access keys passed directly on the command line. Prefer profiles or environment variables when possible.

```sh title:"ScoutSuite Execute AWS Access Keys CLI"
scout aws --access-keys --access-key-id "$aws_access_key_id" --secret-access-key "$aws_secret_access_key" --session-token "$aws_session_token" --no-browser
```
<!-- cheat
var aws_access_key_id
var aws_secret_access_key
var aws_session_token
-->

### AWS caller check

Check AWS caller check with ScoutSuite.

Confirm the identity Scout will use before launching a long run.

```sh title:"ScoutSuite Check AWS Caller Check"
aws --profile "$aws_profile" sts get-caller-identity
```
<!-- cheat
var aws_profile
-->

### AWS required policy reminder

Run AWS required policy reminder with ScoutSuite.

List the AWS managed policies Scout Suite expects for broad coverage.

```sh title:"ScoutSuite Run AWS Required Policy Reminder"
printf '%s\n' 'ReadOnlyAccess' 'SecurityAudit'
```
<!-- cheat -->

## aws engagement runs

### AWS profile report

Execute AWS profile report with ScoutSuite.

Run an AWS assessment for one profile and write output to an engagement directory.

```sh title:"ScoutSuite Execute AWS Profile Report"
scout aws --profile "$aws_profile" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var aws_profile
var report_dir := scoutsuite-report
-->

### AWS named report

Execute AWS named report with ScoutSuite.

Use a stable report name for account, role, or phase tracking.

```sh title:"ScoutSuite Execute AWS Named Report"
scout aws --profile "$aws_profile" --report-name "$report_name" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var aws_profile
var report_name
var report_dir := scoutsuite-report
-->

### AWS debug report

Execute AWS debug report with ScoutSuite.

Run with debug output when credential, throttling, or API errors need triage.

```sh title:"ScoutSuite Execute AWS Debug Report"
scout aws --profile "$aws_profile" --debug --report-dir "$report_dir" --no-browser
```
<!-- cheat
var aws_profile
var report_dir := scoutsuite-report
-->

### AWS trusted CIDRs

List AWS trusted CIDRs with ScoutSuite.

Load engagement trusted CIDRs so unknown security group exposure is easier to spot.

```sh title:"ScoutSuite List AWS Trusted CIDRs"
scout aws --profile "$aws_profile" --ip-ranges "$ip_ranges_file" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var aws_profile
var ip_ranges_file := trusted-cidrs.json
var report_dir := scoutsuite-report
-->

### AWS trusted CIDR name key

Execute AWS trusted CIDR name key with ScoutSuite.

Use a custom display key from the trusted CIDR JSON.

```sh title:"ScoutSuite Execute AWS Trusted CIDR Name Key"
scout aws --profile "$aws_profile" --ip-ranges "$ip_ranges_file" --ip-ranges-name-key "$name_key" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var aws_profile
var ip_ranges_file := trusted-cidrs.json
var name_key := name
var report_dir := scoutsuite-report
-->

### AWS custom ruleset

Execute AWS custom ruleset with ScoutSuite.

Run with an engagement-specific ruleset to emphasize red-team-relevant findings.

```sh title:"ScoutSuite Execute AWS Custom Ruleset"
scout aws --profile "$aws_profile" --ruleset "$ruleset_file" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var aws_profile
var ruleset_file
var report_dir := scoutsuite-report
-->

### AWS local reanalysis

Execute AWS local reanalysis with ScoutSuite.

Re-run the rule engine on previously fetched data without calling AWS APIs again.

```sh title:"ScoutSuite Execute AWS Local Reanalysis"
scout aws --profile "$aws_profile" --local --ruleset "$ruleset_file" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var aws_profile
var ruleset_file
var report_dir := scoutsuite-report
-->

### AWS exceptions reanalysis

Execute AWS exceptions reanalysis with ScoutSuite.

Apply exported exceptions to a previously fetched AWS report.

```sh title:"ScoutSuite Execute AWS Exceptions Reanalysis"
scout aws --profile "$aws_profile" --local --exceptions "$exceptions_file" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var aws_profile
var exceptions_file
var report_dir := scoutsuite-report
-->

### AWS report file

Execute AWS report file with ScoutSuite.

Open the generated AWS HTML report path for a named profile.

```sh title:"ScoutSuite Execute AWS Report File"
find "$report_dir" -maxdepth 1 -type f -name "aws*$aws_profile*.html" -print
```
<!-- cheat
var report_dir := scoutsuite-report
var aws_profile
-->

## aws report triage

### Results JS files

List results JS files with ScoutSuite.

List Scout Suite AWS result payloads for parsing.

```sh title:"ScoutSuite List Results JS Files"
find "$report_dir/scoutsuite-results" -type f -name 'scoutsuite_results_aws*.js' -print
```
<!-- cheat
var report_dir := scoutsuite-report
-->

### Convert results to JSON

Convert results to JSON with ScoutSuite.

Strip the JavaScript variable assignment and save valid JSON for command-line triage.

```sh title:"ScoutSuite Convert Results to JSON"
tail -n +2 "$results_js" > "$results_json"
```
<!-- cheat
var results_js
var results_json := scoutsuite-results.json
-->

### Pretty print results

Show pretty print results with ScoutSuite.

Pretty print the extracted Scout Suite JSON.

```sh title:"ScoutSuite Show Pretty Print Results"
jq '.' "$results_json" | less
```
<!-- cheat
var results_json := scoutsuite-results.json
-->

### List service keys

List service keys with ScoutSuite.

List service keys present in an AWS results file.

```sh title:"ScoutSuite List Service Keys"
jq -r '.services | keys[]' "$results_json"
```
<!-- cheat
var results_json := scoutsuite-results.json
-->

### Find danger findings

Find danger findings with ScoutSuite.

Search Scout Suite results for danger-level findings.

```sh title:"ScoutSuite Find Danger Findings"
jq '.. | objects | select(.level? == "danger")' "$results_json"
```
<!-- cheat
var results_json := scoutsuite-results.json
-->

### Find warning findings

Find warning findings with ScoutSuite.

Search Scout Suite results for warning-level findings.

```sh title:"ScoutSuite Find Warning Findings"
jq '.. | objects | select(.level? == "warning")' "$results_json"
```
<!-- cheat
var results_json := scoutsuite-results.json
-->

### Public exposure grep

Find public exposure grep with ScoutSuite.

Search extracted results for public, internet, unrestricted, anonymous, and wildcard indicators.

```sh title:"ScoutSuite Find Public Exposure Grep"
grep -RniE '0\.0\.0\.0/0|::/0|public|internet|unrestricted|anonymous|wildcard|\*' "$report_dir/scoutsuite-results"
```
<!-- cheat
var report_dir := scoutsuite-report
-->

### AWS security groups jq

Run AWS security groups jq with ScoutSuite.

Pretty print EC2 security groups from Scout Suite JSON for manual exposure review.

```sh title:"ScoutSuite Run AWS Security Groups Jq"
jq '.services.ec2.regions[].vpcs[].security_groups[]?' "$results_json"
```
<!-- cheat
var results_json := scoutsuite-results.json
-->

### AWS S3 grep

Find AWS S3 grep with ScoutSuite.

Search Scout Suite result payloads for S3 bucket public or logging findings.

```sh title:"ScoutSuite Find AWS S3 Grep"
grep -RniE 's3|bucket|public|anonymous|logging|encryption' "$report_dir/scoutsuite-results"
```
<!-- cheat
var report_dir := scoutsuite-report
-->

### AWS IAM grep

Find AWS IAM grep with ScoutSuite.

Search Scout Suite result payloads for IAM privilege and trust leads.

```sh title:"ScoutSuite Find AWS IAM Grep"
grep -RniE 'iam|admin|administrator|assume|trust|mfa|access.?key|policy|privilege' "$report_dir/scoutsuite-results"
```
<!-- cheat
var report_dir := scoutsuite-report
-->

## kubernetes auth

### Kube contexts

List kube contexts with ScoutSuite.

List kubeconfig contexts before selecting a cluster.

```sh title:"ScoutSuite List Kube Contexts"
kubectl config get-contexts
```
<!-- cheat -->

### Current kube context

Show current kube context with ScoutSuite.

Confirm the context Scout Suite will use by default.

```sh title:"ScoutSuite Show Current Kube Context"
kubectl config current-context
```
<!-- cheat -->

### Switch kube context

Run switch kube context with ScoutSuite.

Switch to the engagement-approved cluster context before running Scout Suite.

```sh title:"ScoutSuite Run Switch Kube Context"
kubectl config use-context "$kube_context"
```
<!-- cheat
var kube_context
-->

### Kube caller check

Check kube caller check with ScoutSuite.

Confirm cluster API access before launching Scout Suite.

```sh title:"ScoutSuite Check Kube Caller Check"
kubectl auth can-i --list
```
<!-- cheat -->

### EKS kubeconfig

Run EKS kubeconfig with ScoutSuite.

Create or update kubeconfig for an EKS cluster before scanning Kubernetes.

```sh title:"ScoutSuite Run EKS Kubeconfig"
aws --profile "$aws_profile" eks update-kubeconfig --region "$aws_region" --name "$kube_cluster_name"
```
<!-- cheat
var aws_profile
var aws_region := us-east-1
var kube_cluster_name
-->

## kubernetes engagement runs

### Kubernetes current context

Execute kubernetes current context with ScoutSuite.

Run Scout Suite against the current Kubernetes context.

```sh title:"ScoutSuite Execute Kubernetes Current Context"
scout kubernetes --report-dir "$report_dir" --no-browser
```
<!-- cheat
var report_dir := scoutsuite-report
-->

### Kubernetes named context

Execute kubernetes named context with ScoutSuite.

Run Scout Suite against a specific kubeconfig context.

```sh title:"ScoutSuite Execute Kubernetes Named Context"
scout kubernetes --context "$kube_context" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var kube_context
var report_dir := scoutsuite-report
-->

### Kubernetes config file

Execute kubernetes config file with ScoutSuite.

Run Scout Suite with an explicit kubeconfig file.

```sh title:"ScoutSuite Execute Kubernetes Config File"
scout kubernetes --config-file "$kubeconfig_file" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var kubeconfig_file
var report_dir := scoutsuite-report
-->

### Kubernetes config no persist

Execute kubernetes config no persist with ScoutSuite.

Run without allowing Scout Suite to persist kubeconfig token refreshes or config changes.

```sh title:"ScoutSuite Execute Kubernetes Config No Persist"
scout kubernetes --context "$kube_context" --do-not-persist-config --report-dir "$report_dir" --no-browser
```
<!-- cheat
var kube_context
var report_dir := scoutsuite-report
-->

### Kubernetes AWS control plane

Execute kubernetes AWS control plane with ScoutSuite.

Scan Kubernetes control plane data with AWS provider support when the cluster is AWS-hosted and the AWS identity has required permissions.

```sh title:"ScoutSuite Execute Kubernetes AWS Control Plane"
scout kubernetes -c aws --context "$kube_context" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var kube_context
var report_dir := scoutsuite-report
-->

### Kubernetes custom ruleset

Execute kubernetes custom ruleset with ScoutSuite.

Run Kubernetes analysis with a custom Scout Suite ruleset.

```sh title:"ScoutSuite Execute Kubernetes Custom Ruleset"
scout kubernetes --context "$kube_context" --ruleset "$ruleset_file" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var kube_context
var ruleset_file
var report_dir := scoutsuite-report
-->

### Kubernetes local reanalysis

Execute kubernetes local reanalysis with ScoutSuite.

Re-run Kubernetes analysis locally after adjusting rules without fetching from the cluster again.

```sh title:"ScoutSuite Execute Kubernetes Local Reanalysis"
scout kubernetes --context "$kube_context" --local --ruleset "$ruleset_file" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var kube_context
var ruleset_file
var report_dir := scoutsuite-report
-->

### Kubernetes report file

Execute kubernetes report file with ScoutSuite.

Print the generated Kubernetes HTML report path.

```sh title:"ScoutSuite Execute Kubernetes Report File"
find "$report_dir" -maxdepth 1 -type f -name 'kubernetes*.html' -print
```
<!-- cheat
var report_dir := scoutsuite-report
-->

## kubernetes report triage

### Kubernetes results JS files

List kubernetes results JS files with ScoutSuite.

List Scout Suite Kubernetes result payloads for parsing.

```sh title:"ScoutSuite List Kubernetes Results JS Files"
find "$report_dir/scoutsuite-results" -type f -name 'scoutsuite_results_kubernetes*.js' -print
```
<!-- cheat
var report_dir := scoutsuite-report
-->

### Convert Kubernetes results

Convert kubernetes results with ScoutSuite.

Strip the JavaScript variable assignment and save Kubernetes results as JSON.

```sh title:"ScoutSuite Convert Kubernetes Results"
tail -n +2 "$results_js" > "$kube_results_json"
```
<!-- cheat
var results_js
var kube_results_json := scoutsuite-kubernetes-results.json
-->

### Kubernetes service keys

List kubernetes service keys with ScoutSuite.

List top-level services/resources in Kubernetes Scout Suite output.

```sh title:"ScoutSuite List Kubernetes Service Keys"
jq -r '.services | keys[]' "$kube_results_json"
```
<!-- cheat
var kube_results_json := scoutsuite-kubernetes-results.json
-->

### Kubernetes danger findings

Find kubernetes danger findings with ScoutSuite.

Search Kubernetes results for danger-level findings.

```sh title:"ScoutSuite Find Kubernetes Danger Findings"
jq '.. | objects | select(.level? == "danger")' "$kube_results_json"
```
<!-- cheat
var kube_results_json := scoutsuite-kubernetes-results.json
-->

### Kubernetes warning findings

Find kubernetes warning findings with ScoutSuite.

Search Kubernetes results for warning-level findings.

```sh title:"ScoutSuite Find Kubernetes Warning Findings"
jq '.. | objects | select(.level? == "warning")' "$kube_results_json"
```
<!-- cheat
var kube_results_json := scoutsuite-kubernetes-results.json
-->

### Kubernetes RBAC grep

Find kubernetes RBAC grep with ScoutSuite.

Search Kubernetes report data for RBAC and privileged access leads.

```sh title:"ScoutSuite Find Kubernetes RBAC Grep"
grep -RniE 'cluster-admin|clusterrole|rolebinding|serviceaccount|privileged|hostpath|hostnetwork|secret|token' "$report_dir/scoutsuite-results"
```
<!-- cheat
var report_dir := scoutsuite-report
-->

### Kubernetes exposed workload grep

Find kubernetes exposed workload grep with ScoutSuite.

Search Kubernetes report data for exposure and workload-risk leads.

```sh title:"ScoutSuite Find Kubernetes Exposed Workload Grep"
grep -RniE 'LoadBalancer|NodePort|hostPort|hostNetwork|privileged|runAsRoot|capabilities|secret|configmap' "$report_dir/scoutsuite-results"
```
<!-- cheat
var report_dir := scoutsuite-report
-->

## docker

### Build Scout Suite Docker image

Build scout suite docker image with ScoutSuite.

Build the Scout Suite Docker image from a local source clone.

```sh title:"ScoutSuite Build Scout Suite Docker Image"
cd ScoutSuite/docker && docker compose up --build
```
<!-- cheat -->

### Docker AWS profile

Execute docker AWS profile with ScoutSuite.

Run Scout Suite in Docker with local AWS credentials mounted and write the report to the host.

```sh title:"ScoutSuite Execute Docker AWS Profile"
docker run --rm -v "$HOME/.aws:/root/.aws:ro" -v "$(pwd)/$report_dir:/root/scout-report" scoutsuite scout aws --profile "$aws_profile" --no-browser --report-dir /root/scout-report
```
<!-- cheat
var report_dir := scoutsuite-report
var aws_profile
-->

### Docker Kubernetes context

Execute docker kubernetes context with ScoutSuite.

Run Scout Suite in Docker with local kubeconfig mounted and write the report to the host.

```sh title:"ScoutSuite Execute Docker Kubernetes Context"
docker run --rm -v "$HOME/.kube:/root/.kube:ro" -v "$(pwd)/$report_dir:/root/scout-report" scoutsuite scout kubernetes --context "$kube_context" --no-browser --report-dir /root/scout-report
```
<!-- cheat
var report_dir := scoutsuite-report
var kube_context
-->
