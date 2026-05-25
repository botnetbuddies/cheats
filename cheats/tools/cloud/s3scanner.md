# S3Scanner

## setup

### Install with Homebrew

Install S3Scanner with homebrew.

```sh title:"S3Scanner Install with Homebrew"
brew install s3scanner
```
<!-- cheat -->

### Install on Kali

Install S3Scanner on kali.

```sh title:"S3Scanner Install on Kali"
sudo apt install s3scanner
```
<!-- cheat -->

### Install with Go

Install S3Scanner with go.

```sh title:"S3Scanner Install with Go"
go install -v github.com/sa7mon/s3scanner@latest
```
<!-- cheat -->

### Build from source

Build S3Scanner from source.

```sh title:"S3Scanner Build from Source"
git clone https://github.com/sa7mon/S3Scanner.git && cd S3Scanner && go build -o s3scanner .
```
<!-- cheat -->

### Docker smoke test

Scan docker smoke test with S3Scanner.

```sh title:"S3Scanner Scan Docker Smoke Test"
docker run --rm ghcr.io/sa7mon/s3scanner -h
```
<!-- cheat -->

### Help

Show help with S3Scanner.

```sh title:"S3Scanner Show Help"
s3scanner -h
```
<!-- cheat -->

### Version

Show version with S3Scanner.

```sh title:"S3Scanner Show Version"
s3scanner -version
```
<!-- cheat -->

## input prep

### Candidate names from domains

Generate candidate names from domains with S3Scanner.

```sh title:"S3Scanner Generate Candidate Names from Domains"
sed 's/^www\.//' "$domain_file" | awk '{print; print $0"-assets"; print $0"-backup"; print $0"-backups"; print $0"-dev"; print $0"-prod"; print $0"-staging"; print $0"-static"; print $0"-uploads"}' | sort -u > "$s3_bucket_file"
```
<!-- cheat
var domain_file
var s3_bucket_file := buckets.txt
-->

### Candidate names from company root

Generate candidate names from company root with S3Scanner.

```sh title:"S3Scanner Generate Candidate Names from Company Root"
printf '%s\n' "$company_root" "$company_root-assets" "$company_root-backup" "$company_root-backups" "$company_root-dev" "$company_root-prod" "$company_root-public" "$company_root-stage" "$company_root-staging" "$company_root-static" "$company_root-uploads" | sort -u > "$s3_bucket_file"
```
<!-- cheat
var company_root
var s3_bucket_file := buckets.txt
-->

### Normalize bucket list

List normalize bucket list with S3Scanner.

```sh title:"S3Scanner List Normalize Bucket List"
tr '[:upper:]' '[:lower:]' < "$raw_s3_bucket_file" | sed '/^$/d' | sort -u > "$s3_bucket_file"
```
<!-- cheat
var raw_s3_bucket_file
var s3_bucket_file := buckets.txt
-->

### Merge CloudFox buckets

Scan merge CloudFox buckets with S3Scanner.

```sh title:"S3Scanner Scan Merge CloudFox Buckets"
awk -F, 'NR>1 {print $3}' "cloudfox-output/aws/$aws_profile/csv/buckets.csv" | sed '/^$/d' | sort -u >> "$s3_bucket_file"
```
<!-- cheat
var aws_profile
var s3_bucket_file := buckets.txt
-->

### Count targets

Run count targets with S3Scanner.

```sh title:"S3Scanner Run Count Targets"
sort -u "$s3_bucket_file" | wc -l
```
<!-- cheat
var s3_bucket_file := buckets.txt
-->

## aws triage

### Single bucket

Scan single bucket with S3Scanner.

```sh title:"S3Scanner Scan Single Bucket"
s3scanner -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

### Single bucket JSON

Scan single bucket JSON with S3Scanner.

```sh title:"S3Scanner Scan Single Bucket JSON"
s3scanner -bucket "$s3_bucket" -json
```
<!-- cheat
var s3_bucket
-->

### Bucket file

Scan bucket file with S3Scanner.

```sh title:"S3Scanner Scan Bucket File"
s3scanner -bucket-file "$s3_bucket_file"
```
<!-- cheat
var s3_bucket_file := buckets.txt
-->

### Bucket file JSON

Scan bucket file JSON with S3Scanner.

```sh title:"S3Scanner Scan Bucket File JSON"
s3scanner -bucket-file "$s3_bucket_file" -json | tee "$json_file"
```
<!-- cheat
var s3_bucket_file := buckets.txt
var json_file := s3scanner.jsonl
-->

### Higher concurrency

Read higher concurrency with S3Scanner.

```sh title:"S3Scanner Read Higher Concurrency"
s3scanner -bucket-file "$s3_bucket_file" -threads "$threads"
```
<!-- cheat
var s3_bucket_file := buckets.txt
var threads := 16
-->

### Conservative concurrency

Read conservative concurrency with S3Scanner.

```sh title:"S3Scanner Read Conservative Concurrency"
s3scanner -bucket-file "$s3_bucket_file" -threads 2
```
<!-- cheat
var s3_bucket_file := buckets.txt
-->

### Verbose debug

Scan verbose debug with S3Scanner.

```sh title:"S3Scanner Scan Verbose Debug"
s3scanner -bucket "$s3_bucket" -verbose
```
<!-- cheat
var s3_bucket
-->

## enumeration

### Enumerate one bucket

Enumerate one bucket with S3Scanner.

```sh title:"S3Scanner Enumerate One Bucket"
s3scanner -bucket "$s3_bucket" -enumerate
```
<!-- cheat
var s3_bucket
-->

### Enumerate one bucket JSON

Enumerate one bucket JSON with S3Scanner.

```sh title:"S3Scanner Enumerate One Bucket JSON"
s3scanner -bucket "$s3_bucket" -enumerate -json | tee "$json_file"
```
<!-- cheat
var s3_bucket
var json_file := s3scanner-enum.jsonl
-->

### Enumerate bucket file

Enumerate bucket file with S3Scanner.

```sh title:"S3Scanner Enumerate Bucket File"
s3scanner -bucket-file "$s3_bucket_file" -enumerate
```
<!-- cheat
var s3_bucket_file := buckets.txt
-->

### Enumerate bucket file JSON

Enumerate bucket file JSON with S3Scanner.

```sh title:"S3Scanner Enumerate Bucket File JSON"
s3scanner -bucket-file "$s3_bucket_file" -enumerate -json | tee "$json_file"
```
<!-- cheat
var s3_bucket_file := buckets.txt
var json_file := s3scanner-enum.jsonl
-->

### Enumerate with safe threads

Enumerate S3Scanner with safe threads.

```sh title:"S3Scanner Enumerate with Safe Threads"
s3scanner -bucket-file "$s3_bucket_file" -enumerate -threads "$threads"
```
<!-- cheat
var s3_bucket_file := buckets.txt
var threads := 4
-->

## results triage

### Existing buckets

Extract existing buckets with S3Scanner.

```sh title:"S3Scanner Extract Existing Buckets"
jq -r 'select(.bucket.exists==1) | [.bucket.name, .bucket.region] | @tsv' "$json_file"
```
<!-- cheat
var json_file := s3scanner.jsonl
-->

### Potentially public buckets

Scan potentially public buckets with S3Scanner.

```sh title:"S3Scanner Scan Potentially Public Buckets"
jq -c 'select((tostring | test("Public|public")))' "$json_file"
```
<!-- cheat
var json_file := s3scanner.jsonl
-->

### Readable or listable leads

Read readable or listable leads with S3Scanner.

```sh title:"S3Scanner Read Readable or Listable Leads"
grep -iE 'read|list|get|public|full control' "$json_file"
```
<!-- cheat
var json_file := s3scanner.jsonl
-->

### Writable leads

Read writable leads with S3Scanner.

```sh title:"S3Scanner Read Writable Leads"
grep -iE 'write|put|full control|write acp' "$json_file"
```
<!-- cheat
var json_file := s3scanner.jsonl
-->

### Bucket names from JSON

Extract bucket names from JSON with S3Scanner.

```sh title:"S3Scanner Extract Bucket Names from JSON"
jq -r '.bucket.name // empty' "$json_file" | sort -u
```
<!-- cheat
var json_file := s3scanner.jsonl
-->

### Object names from enumeration

Extract object names from enumeration with S3Scanner.

```sh title:"S3Scanner Extract Object Names from Enumeration"
jq -r '.. | objects | .key? // empty' "$json_file" | sort -u
```
<!-- cheat
var json_file := s3scanner-enum.jsonl
-->

## manual verification

### AWS anonymous list

List AWS anonymous list with S3Scanner.

```sh title:"S3Scanner List AWS Anonymous List"
aws s3 ls "s3://$s3_bucket" --no-sign-request
```
<!-- cheat
var s3_bucket
-->

### AWS anonymous recursive list

List AWS anonymous recursive list with S3Scanner.

```sh title:"S3Scanner List AWS Anonymous Recursive List"
aws s3 ls "s3://$s3_bucket" --recursive --human-readable --summarize --no-sign-request
```
<!-- cheat
var s3_bucket
-->

### AWS anonymous object head

Read AWS anonymous object head with S3Scanner.

```sh title:"S3Scanner Read AWS Anonymous Object Head"
aws s3api head-object --bucket "$s3_bucket" --key "$s3_object_key" --no-sign-request
```
<!-- cheat
var s3_bucket
var s3_object_key
-->

### AWS anonymous object download

Download AWS anonymous object download with S3Scanner.

```sh title:"S3Scanner Download AWS Anonymous Object Download"
aws s3 cp "s3://$s3_bucket/$s3_object_key" "$output_file" --no-sign-request
```
<!-- cheat
var s3_bucket
var s3_object_key
var output_file
-->

### AWS authenticated list

List AWS authenticated list with S3Scanner.

```sh title:"S3Scanner List AWS Authenticated List"
aws --profile "$aws_profile" s3 ls "s3://$s3_bucket" --recursive --human-readable --summarize
```
<!-- cheat
var aws_profile
var s3_bucket
-->

### AWS safe write probe

Read AWS safe write probe with S3Scanner.

```sh title:"S3Scanner Read AWS Safe Write Probe"
printf 'authorized security test\n' > "$proof_file" && aws s3 cp "$proof_file" "s3://$s3_bucket/$proof_key" --no-sign-request && aws s3 rm "s3://$s3_bucket/$proof_key" --no-sign-request
```
<!-- cheat
var proof_file := s3scanner-proof.txt
var s3_bucket
var proof_key := s3scanner-proof.txt
-->

### AWS authenticated write probe

Read AWS authenticated write probe with S3Scanner.

```sh title:"S3Scanner Read AWS Authenticated Write Probe"
printf 'authorized security test\n' > "$proof_file" && aws --profile "$aws_profile" s3 cp "$proof_file" "s3://$s3_bucket/$proof_key" && aws --profile "$aws_profile" s3 rm "s3://$s3_bucket/$proof_key"
```
<!-- cheat
var proof_file := s3scanner-proof.txt
var aws_profile
var s3_bucket
var proof_key := s3scanner-proof.txt
-->

## providers

### GCP bucket

Scan GCP bucket with S3Scanner.

```sh title:"S3Scanner Scan GCP Bucket"
s3scanner -provider gcp -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

### GCP enumerate and save DB

Scan GCP enumerate and save DB with S3Scanner.

```sh title:"S3Scanner Scan GCP Enumerate and Save DB"
s3scanner -provider gcp -db -bucket "$s3_bucket" -enumerate
```
<!-- cheat
var s3_bucket
-->

### DigitalOcean Spaces

Scan DigitalOcean spaces with S3Scanner.

```sh title:"S3Scanner Scan DigitalOcean Spaces"
s3scanner -provider digitalocean -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

### Linode object storage

Scan linode object storage with S3Scanner.

```sh title:"S3Scanner Scan Linode Object Storage"
s3scanner -provider linode -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

### Scaleway object storage

Scan scaleway object storage with S3Scanner.

```sh title:"S3Scanner Scan Scaleway Object Storage"
s3scanner -provider scaleway -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

### DreamHost object storage

Scan DreamHost object storage with S3Scanner.

```sh title:"S3Scanner Scan DreamHost Object Storage"
s3scanner -provider dreamhost -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

### Custom provider

Scan custom provider with S3Scanner.

```sh title:"S3Scanner Scan Custom Provider"
s3scanner -provider custom -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

## config and scale

### Config file template

Scan config file template with S3Scanner.

```sh title:"S3Scanner Scan Config File Template"
cat > config.yml <<'YAML'
db:
  uri: "postgresql://user:pass@db.host.name:5432/schema_name"
mq:
  queue_name: "aws"
  uri: "amqp://user:pass@localhost:5672"
providers:
  custom:
    address_style: "path"
    endpoint_format: "https://$REGION.example-object-store.local"
    insecure: false
    regions:
      - "region1"
YAML
```
<!-- cheat
var REGION
-->

### Database output

Scan database output with S3Scanner.

```sh title:"S3Scanner Scan Database Output"
s3scanner -bucket-file "$s3_bucket_file" -db
```
<!-- cheat
var s3_bucket_file := buckets.txt
-->

### JSON and DB output

Scan JSON and DB output with S3Scanner.

```sh title:"S3Scanner Scan JSON and DB Output"
s3scanner -bucket-file "$s3_bucket_file" -db -json | tee "$json_file"
```
<!-- cheat
var s3_bucket_file := buckets.txt
var json_file := s3scanner.jsonl
-->

### RabbitMQ input

Scan RabbitMQ input with S3Scanner.

```sh title:"S3Scanner Scan RabbitMQ Input"
s3scanner -mq
```
<!-- cheat -->

### RabbitMQ JSON output

Scan RabbitMQ JSON output with S3Scanner.

```sh title:"S3Scanner Scan RabbitMQ JSON Output"
s3scanner -mq -json
```
<!-- cheat -->

## docker

### Docker single bucket

Scan docker single bucket with S3Scanner.

```sh title:"S3Scanner Scan Docker Single Bucket"
docker run --rm ghcr.io/sa7mon/s3scanner -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

### Docker bucket file

Scan docker bucket file with S3Scanner.

```sh title:"S3Scanner Scan Docker Bucket File"
docker run --rm -v "$(pwd):/data" ghcr.io/sa7mon/s3scanner -bucket-file "/data/$s3_bucket_file"
```
<!-- cheat
var s3_bucket_file := buckets.txt
-->

### Docker JSON output

Scan docker JSON output with S3Scanner.

```sh title:"S3Scanner Scan Docker JSON Output"
docker run --rm -v "$(pwd):/data" ghcr.io/sa7mon/s3scanner -bucket-file "/data/$s3_bucket_file" -json | tee "$json_file"
```
<!-- cheat
var s3_bucket_file := buckets.txt
var json_file := s3scanner.jsonl
-->

### Docker config mount

Scan docker config mount with S3Scanner.

```sh title:"S3Scanner Scan Docker Config Mount"
docker run --rm -v "$(pwd):/data" -w /data ghcr.io/sa7mon/s3scanner -provider custom -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->
