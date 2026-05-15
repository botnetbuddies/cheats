# ScoutSuite

## setup

### Install with uv tool

Install Scout Suite as an isolated uv-managed CLI tool.

```sh title:"Install Scout Suite with uv tool"
uv tool install scoutsuite
```
<!-- cheat -->

### Install from Git

Clone Scout Suite and run it with uv-managed dependencies from source.

```sh title:"Run Scout Suite from GitHub source with uv"
git clone https://github.com/nccgroup/ScoutSuite.git && cd ScoutSuite && uv run --with-requirements requirements.txt python scout.py --help
```
<!-- cheat -->

### Help

Show Scout Suite CLI help.

```sh title:"Show Scout Suite help"
scout --help
```
<!-- cheat -->

### AWS help

Show AWS provider options.

```sh title:"Show Scout Suite AWS help"
scout aws --help
```
<!-- cheat -->

### Kubernetes help

Show Kubernetes provider options.

```sh title:"Show Scout Suite Kubernetes help"
scout kubernetes --help
```
<!-- cheat -->

### macOS file descriptors

Increase the shell file descriptor limit when Scout errors on DNS or socket resolution.

```sh title:"Raise macOS file descriptor limit for Scout Suite"
ulimit -Sn 1000
```
<!-- cheat -->

## aws auth

### AWS default credentials

Run Scout Suite with the default boto3/AWS CLI credential chain.

```sh title:"Run Scout Suite AWS with default credentials"
scout aws --no-browser
```
<!-- cheat -->

### AWS named profile

Run against one named AWS profile.

```sh title:"Run Scout Suite AWS with named profile"
scout aws --profile "$profile" --no-browser
```
<!-- cheat
var profile
-->

### AWS role profile

Run against an AWS CLI profile that assumes a role from `~/.aws/config`.

```sh title:"Run Scout Suite AWS with role-assuming profile"
scout aws --profile "$role_profile" --no-browser
```
<!-- cheat
var role_profile
-->

### AWS environment keys

Run with access keys already exported in the environment.

```sh title:"Run Scout Suite AWS with environment credentials"
AWS_ACCESS_KEY_ID="$access_key_id" AWS_SECRET_ACCESS_KEY="$secret_access_key" AWS_SESSION_TOKEN="$session_token" scout aws --no-browser
```
<!-- cheat
var access_key_id
var secret_access_key
var session_token
-->

### AWS access keys CLI

Run with access keys passed directly on the command line. Prefer profiles or environment variables when possible.

```sh title:"Run Scout Suite AWS with access keys"
scout aws --access-keys --access-key-id "$access_key_id" --secret-access-key "$secret_access_key" --session-token "$session_token" --no-browser
```
<!-- cheat
var access_key_id
var secret_access_key
var session_token
-->

### AWS caller check

Confirm the identity Scout will use before launching a long run.

```sh title:"Confirm AWS caller identity before Scout Suite"
aws --profile "$profile" sts get-caller-identity
```
<!-- cheat
var profile
-->

### AWS required policy reminder

List the AWS managed policies Scout Suite expects for broad coverage.

```sh title:"Print Scout Suite AWS recommended policies"
printf '%s\n' 'ReadOnlyAccess' 'SecurityAudit'
```
<!-- cheat -->

## aws engagement runs

### AWS profile report

Run an AWS assessment for one profile and write output to an engagement directory.

```sh title:"Run Scout Suite AWS report to directory"
scout aws --profile "$profile" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var profile
var report_dir := scoutsuite-report
-->

### AWS named report

Use a stable report name for account, role, or phase tracking.

```sh title:"Run Scout Suite AWS report with report name"
scout aws --profile "$profile" --report-name "$report_name" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var profile
var report_name
var report_dir := scoutsuite-report
-->

### AWS debug report

Run with debug output when credential, throttling, or API errors need triage.

```sh title:"Run Scout Suite AWS with debug output"
scout aws --profile "$profile" --debug --report-dir "$report_dir" --no-browser
```
<!-- cheat
var profile
var report_dir := scoutsuite-report
-->

### AWS trusted CIDRs

Load engagement trusted CIDRs so unknown security group exposure is easier to spot.

```sh title:"Run Scout Suite AWS with trusted CIDR list"
scout aws --profile "$profile" --ip-ranges "$ip_ranges_file" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var profile
var ip_ranges_file := trusted-cidrs.json
var report_dir := scoutsuite-report
-->

### AWS trusted CIDR name key

Use a custom display key from the trusted CIDR JSON.

```sh title:"Run Scout Suite AWS with trusted CIDR name key"
scout aws --profile "$profile" --ip-ranges "$ip_ranges_file" --ip-ranges-name-key "$name_key" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var profile
var ip_ranges_file := trusted-cidrs.json
var name_key := name
var report_dir := scoutsuite-report
-->

### AWS custom ruleset

Run with an engagement-specific ruleset to emphasize red-team-relevant findings.

```sh title:"Run Scout Suite AWS with custom ruleset"
scout aws --profile "$profile" --ruleset "$ruleset_file" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var profile
var ruleset_file
var report_dir := scoutsuite-report
-->

### AWS local reanalysis

Re-run the rule engine on previously fetched data without calling AWS APIs again.

```sh title:"Reanalyze Scout Suite AWS data locally"
scout aws --profile "$profile" --local --ruleset "$ruleset_file" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var profile
var ruleset_file
var report_dir := scoutsuite-report
-->

### AWS exceptions reanalysis

Apply exported exceptions to a previously fetched AWS report.

```sh title:"Reanalyze Scout Suite AWS data with exceptions"
scout aws --profile "$profile" --local --exceptions "$exceptions_file" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var profile
var exceptions_file
var report_dir := scoutsuite-report
-->

### AWS report file

Open the generated AWS HTML report path for a named profile.

```sh title:"Print Scout Suite AWS HTML report path"
find "$report_dir" -maxdepth 1 -type f -name "aws*$profile*.html" -print
```
<!-- cheat
var report_dir := scoutsuite-report
var profile
-->

## aws report triage

### Results JS files

List Scout Suite AWS result payloads for parsing.

```sh title:"List Scout Suite AWS result JavaScript files"
find "$report_dir/scoutsuite-results" -type f -name 'scoutsuite_results_aws*.js' -print
```
<!-- cheat
var report_dir := scoutsuite-report
-->

### Convert results to JSON

Strip the JavaScript variable assignment and save valid JSON for command-line triage.

```sh title:"Convert Scout Suite result JS to JSON"
tail -n +2 "$results_js" > "$results_json"
```
<!-- cheat
var results_js
var results_json := scoutsuite-results.json
-->

### Pretty print results

Pretty print the extracted Scout Suite JSON.

```sh title:"Pretty print Scout Suite results JSON"
jq '.' "$results_json" | less
```
<!-- cheat
var results_json := scoutsuite-results.json
-->

### List service keys

List service keys present in an AWS results file.

```sh title:"List Scout Suite AWS services in results JSON"
jq -r '.services | keys[]' "$results_json"
```
<!-- cheat
var results_json := scoutsuite-results.json
-->

### Find danger findings

Search Scout Suite results for danger-level findings.

```sh title:"Search Scout Suite results for danger findings"
jq '.. | objects | select(.level? == "danger")' "$results_json"
```
<!-- cheat
var results_json := scoutsuite-results.json
-->

### Find warning findings

Search Scout Suite results for warning-level findings.

```sh title:"Search Scout Suite results for warning findings"
jq '.. | objects | select(.level? == "warning")' "$results_json"
```
<!-- cheat
var results_json := scoutsuite-results.json
-->

### Public exposure grep

Search extracted results for public, internet, unrestricted, anonymous, and wildcard indicators.

```sh title:"Search Scout Suite results for exposure keywords"
grep -RniE '0\.0\.0\.0/0|::/0|public|internet|unrestricted|anonymous|wildcard|\*' "$report_dir/scoutsuite-results"
```
<!-- cheat
var report_dir := scoutsuite-report
-->

### AWS security groups jq

Pretty print EC2 security groups from Scout Suite JSON for manual exposure review.

```sh title:"Print Scout Suite EC2 security groups"
jq '.services.ec2.regions[].vpcs[].security_groups[]?' "$results_json"
```
<!-- cheat
var results_json := scoutsuite-results.json
-->

### AWS S3 grep

Search Scout Suite result payloads for S3 bucket public or logging findings.

```sh title:"Search Scout Suite S3 findings"
grep -RniE 's3|bucket|public|anonymous|logging|encryption' "$report_dir/scoutsuite-results"
```
<!-- cheat
var report_dir := scoutsuite-report
-->

### AWS IAM grep

Search Scout Suite result payloads for IAM privilege and trust leads.

```sh title:"Search Scout Suite IAM findings"
grep -RniE 'iam|admin|administrator|assume|trust|mfa|access.?key|policy|privilege' "$report_dir/scoutsuite-results"
```
<!-- cheat
var report_dir := scoutsuite-report
-->

## kubernetes auth

### Kube contexts

List kubeconfig contexts before selecting a cluster.

```sh title:"List Kubernetes contexts"
kubectl config get-contexts
```
<!-- cheat -->

### Current kube context

Confirm the context Scout Suite will use by default.

```sh title:"Show current Kubernetes context"
kubectl config current-context
```
<!-- cheat -->

### Switch kube context

Switch to the engagement-approved cluster context before running Scout Suite.

```sh title:"Switch Kubernetes context"
kubectl config use-context "$context"
```
<!-- cheat
var context
-->

### Kube caller check

Confirm cluster API access before launching Scout Suite.

```sh title:"Check Kubernetes API access before Scout Suite"
kubectl auth can-i --list
```
<!-- cheat -->

### EKS kubeconfig

Create or update kubeconfig for an EKS cluster before scanning Kubernetes.

```sh title:"Update kubeconfig for EKS cluster"
aws --profile "$profile" eks update-kubeconfig --region "$region" --name "$cluster_name"
```
<!-- cheat
var profile
var region := us-east-1
var cluster_name
-->

## kubernetes engagement runs

### Kubernetes current context

Run Scout Suite against the current Kubernetes context.

```sh title:"Run Scout Suite Kubernetes current context"
scout kubernetes --report-dir "$report_dir" --no-browser
```
<!-- cheat
var report_dir := scoutsuite-report
-->

### Kubernetes named context

Run Scout Suite against a specific kubeconfig context.

```sh title:"Run Scout Suite Kubernetes named context"
scout kubernetes --context "$context" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var context
var report_dir := scoutsuite-report
-->

### Kubernetes config file

Run Scout Suite with an explicit kubeconfig file.

```sh title:"Run Scout Suite Kubernetes with config file"
scout kubernetes --config-file "$kubeconfig" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var kubeconfig
var report_dir := scoutsuite-report
-->

### Kubernetes config no persist

Run without allowing Scout Suite to persist kubeconfig token refreshes or config changes.

```sh title:"Run Scout Suite Kubernetes without persisting config changes"
scout kubernetes --context "$context" --do-not-persist-config --report-dir "$report_dir" --no-browser
```
<!-- cheat
var context
var report_dir := scoutsuite-report
-->

### Kubernetes AWS control plane

Scan Kubernetes control plane data with AWS provider support when the cluster is AWS-hosted and the AWS identity has required permissions.

```sh title:"Run Scout Suite Kubernetes with AWS control-plane support"
scout kubernetes -c aws --context "$context" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var context
var report_dir := scoutsuite-report
-->

### Kubernetes custom ruleset

Run Kubernetes analysis with a custom Scout Suite ruleset.

```sh title:"Run Scout Suite Kubernetes with custom ruleset"
scout kubernetes --context "$context" --ruleset "$ruleset_file" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var context
var ruleset_file
var report_dir := scoutsuite-report
-->

### Kubernetes local reanalysis

Re-run Kubernetes analysis locally after adjusting rules without fetching from the cluster again.

```sh title:"Reanalyze Scout Suite Kubernetes data locally"
scout kubernetes --context "$context" --local --ruleset "$ruleset_file" --report-dir "$report_dir" --no-browser
```
<!-- cheat
var context
var ruleset_file
var report_dir := scoutsuite-report
-->

### Kubernetes report file

Print the generated Kubernetes HTML report path.

```sh title:"Print Scout Suite Kubernetes HTML report path"
find "$report_dir" -maxdepth 1 -type f -name 'kubernetes*.html' -print
```
<!-- cheat
var report_dir := scoutsuite-report
-->

## kubernetes report triage

### Kubernetes results JS files

List Scout Suite Kubernetes result payloads for parsing.

```sh title:"List Scout Suite Kubernetes result JavaScript files"
find "$report_dir/scoutsuite-results" -type f -name 'scoutsuite_results_kubernetes*.js' -print
```
<!-- cheat
var report_dir := scoutsuite-report
-->

### Convert Kubernetes results

Strip the JavaScript variable assignment and save Kubernetes results as JSON.

```sh title:"Convert Scout Suite Kubernetes results to JSON"
tail -n +2 "$results_js" > "$results_json"
```
<!-- cheat
var results_js
var results_json := scoutsuite-kubernetes-results.json
-->

### Kubernetes service keys

List top-level services/resources in Kubernetes Scout Suite output.

```sh title:"List Scout Suite Kubernetes services in JSON"
jq -r '.services | keys[]' "$results_json"
```
<!-- cheat
var results_json := scoutsuite-kubernetes-results.json
-->

### Kubernetes danger findings

Search Kubernetes results for danger-level findings.

```sh title:"Search Scout Suite Kubernetes danger findings"
jq '.. | objects | select(.level? == "danger")' "$results_json"
```
<!-- cheat
var results_json := scoutsuite-kubernetes-results.json
-->

### Kubernetes warning findings

Search Kubernetes results for warning-level findings.

```sh title:"Search Scout Suite Kubernetes warning findings"
jq '.. | objects | select(.level? == "warning")' "$results_json"
```
<!-- cheat
var results_json := scoutsuite-kubernetes-results.json
-->

### Kubernetes RBAC grep

Search Kubernetes report data for RBAC and privileged access leads.

```sh title:"Search Scout Suite Kubernetes RBAC leads"
grep -RniE 'cluster-admin|clusterrole|rolebinding|serviceaccount|privileged|hostpath|hostnetwork|secret|token' "$report_dir/scoutsuite-results"
```
<!-- cheat
var report_dir := scoutsuite-report
-->

### Kubernetes exposed workload grep

Search Kubernetes report data for exposure and workload-risk leads.

```sh title:"Search Scout Suite Kubernetes exposure leads"
grep -RniE 'LoadBalancer|NodePort|hostPort|hostNetwork|privileged|runAsRoot|capabilities|secret|configmap' "$report_dir/scoutsuite-results"
```
<!-- cheat
var report_dir := scoutsuite-report
-->

## docker

### Build Scout Suite Docker image

Build the Scout Suite Docker image from a local source clone.

```sh title:"Build Scout Suite Docker image"
cd ScoutSuite/docker && docker compose up --build
```
<!-- cheat -->

### Docker AWS profile

Run Scout Suite in Docker with local AWS credentials mounted and write the report to the host.

```sh title:"Run Scout Suite Docker against AWS profile"
docker run --rm -v "$HOME/.aws:/root/.aws:ro" -v "$(pwd)/$report_dir:/root/scout-report" scoutsuite scout aws --profile "$profile" --no-browser --report-dir /root/scout-report
```
<!-- cheat
var report_dir := scoutsuite-report
var profile
-->

### Docker Kubernetes context

Run Scout Suite in Docker with local kubeconfig mounted and write the report to the host.

```sh title:"Run Scout Suite Docker against Kubernetes context"
docker run --rm -v "$HOME/.kube:/root/.kube:ro" -v "$(pwd)/$report_dir:/root/scout-report" scoutsuite scout kubernetes --context "$context" --no-browser --report-dir /root/scout-report
```
<!-- cheat
var report_dir := scoutsuite-report
var context
-->
