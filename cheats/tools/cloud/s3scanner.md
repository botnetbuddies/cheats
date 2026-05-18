# S3Scanner

## setup

### Install with Homebrew

Install S3Scanner on macOS with Homebrew.

```sh title:"Install S3Scanner with Homebrew"
brew install s3scanner
```
<!-- cheat -->

### Install on Kali

Install S3Scanner from Kali or Parrot package repositories.

```sh title:"Install S3Scanner with apt"
sudo apt install s3scanner
```
<!-- cheat -->

### Install with Go

Install the latest S3Scanner binary with Go.

```sh title:"Install S3Scanner with Go"
go install -v github.com/sa7mon/s3scanner@latest
```
<!-- cheat -->

### Build from source

Clone and build S3Scanner from source.

```sh title:"Build S3Scanner from source"
git clone https://github.com/sa7mon/S3Scanner.git && cd S3Scanner && go build -o s3scanner .
```
<!-- cheat -->

### Docker smoke test

Run the container image and print help.

```sh title:"Run S3Scanner Docker help"
docker run --rm ghcr.io/sa7mon/s3scanner -h
```
<!-- cheat -->

### Help

Show S3Scanner options.

```sh title:"Show S3Scanner help"
s3scanner -h
```
<!-- cheat -->

### Version

Print S3Scanner version information.

```sh title:"Print S3Scanner version"
s3scanner -version
```
<!-- cheat -->

## input prep

### Candidate names from domains

Generate common bucket-name candidates from in-scope domains and root names.

```sh title:"Generate S3 bucket candidates from domains"
sed 's/^www\.//' "$domain_file" | awk '{print; print $0"-assets"; print $0"-backup"; print $0"-backups"; print $0"-dev"; print $0"-prod"; print $0"-staging"; print $0"-static"; print $0"-uploads"}' | sort -u > "$s3_bucket_file"
```
<!-- cheat
var domain_file
var s3_bucket_file := buckets.txt
-->

### Candidate names from company root

Generate quick mutations for one company or product root string.

```sh title:"Generate S3 bucket candidates from root name"
printf '%s\n' "$company_root" "$company_root-assets" "$company_root-backup" "$company_root-backups" "$company_root-dev" "$company_root-prod" "$company_root-public" "$company_root-stage" "$company_root-staging" "$company_root-static" "$company_root-uploads" | sort -u > "$s3_bucket_file"
```
<!-- cheat
var company_root
var s3_bucket_file := buckets.txt
-->

### Normalize bucket list

Lowercase, deduplicate, and remove blank lines before scanning.

```sh title:"Normalize S3 bucket candidate list"
tr '[:upper:]' '[:lower:]' < "$raw_s3_bucket_file" | sed '/^$/d' | sort -u > "$s3_bucket_file"
```
<!-- cheat
var raw_s3_bucket_file
var s3_bucket_file := buckets.txt
-->

### Merge CloudFox buckets

Merge CloudFox-discovered bucket names into an S3Scanner candidate list.

```sh title:"Merge CloudFox bucket names into S3Scanner list"
awk -F, 'NR>1 {print $3}' "cloudfox-output/aws/$aws_profile/csv/buckets.csv" | sed '/^$/d' | sort -u >> "$s3_bucket_file"
```
<!-- cheat
var aws_profile
var s3_bucket_file := buckets.txt
-->

### Count targets

Count unique bucket candidates before running a large scan.

```sh title:"Count unique S3 bucket targets"
sort -u "$s3_bucket_file" | wc -l
```
<!-- cheat
var s3_bucket_file := buckets.txt
-->

## aws triage

### Single bucket

Check permissions for one AWS bucket name.

```sh title:"Scan one AWS S3 bucket"
s3scanner -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

### Single bucket JSON

Scan one bucket and emit JSON lines for evidence capture and parsing.

```sh title:"Scan one AWS S3 bucket as JSON"
s3scanner -bucket "$s3_bucket" -json
```
<!-- cheat
var s3_bucket
-->

### Bucket file

Check permissions for bucket names listed one per line. Duplicate names are scanned once.

```sh title:"Scan AWS S3 buckets from file"
s3scanner -bucket-file "$s3_bucket_file"
```
<!-- cheat
var s3_bucket_file := buckets.txt
-->

### Bucket file JSON

Scan a bucket list and save machine-readable JSON lines for reporting.

```sh title:"Scan AWS S3 buckets from file as JSON"
s3scanner -bucket-file "$s3_bucket_file" -json | tee "$json_file"
```
<!-- cheat
var s3_bucket_file := buckets.txt
var json_file := s3scanner.jsonl
-->

### Higher concurrency

Increase concurrent bucket checks. This speeds up permission checks, not object enumeration.

```sh title:"Scan bucket file with more S3Scanner threads"
s3scanner -bucket-file "$s3_bucket_file" -threads "$threads"
```
<!-- cheat
var s3_bucket_file := buckets.txt
var threads := 16
-->

### Conservative concurrency

Use low concurrency for sensitive production windows or noisy providers.

```sh title:"Scan bucket file with conservative threading"
s3scanner -bucket-file "$s3_bucket_file" -threads 2
```
<!-- cheat
var s3_bucket_file := buckets.txt
-->

### Verbose debug

Enable verbose logging only when troubleshooting scanner behavior.

```sh title:"Run S3Scanner with verbose logging"
s3scanner -bucket "$s3_bucket" -verbose
```
<!-- cheat
var s3_bucket
-->

## enumeration

### Enumerate one bucket

Check permissions and enumerate object names if listing is allowed. Large buckets can take a long time.

```sh title:"Scan and enumerate one S3 bucket"
s3scanner -bucket "$s3_bucket" -enumerate
```
<!-- cheat
var s3_bucket
-->

### Enumerate one bucket JSON

Enumerate one bucket and preserve object evidence as JSON lines.

```sh title:"Enumerate one S3 bucket as JSON"
s3scanner -bucket "$s3_bucket" -enumerate -json | tee "$json_file"
```
<!-- cheat
var s3_bucket
var json_file := s3scanner-enum.jsonl
-->

### Enumerate bucket file

Scan bucket names from a file and enumerate accessible objects.

```sh title:"Scan and enumerate S3 buckets from file"
s3scanner -bucket-file "$s3_bucket_file" -enumerate
```
<!-- cheat
var s3_bucket_file := buckets.txt
-->

### Enumerate bucket file JSON

Enumerate accessible objects across a bucket list and save JSON lines.

```sh title:"Scan and enumerate S3 bucket file as JSON"
s3scanner -bucket-file "$s3_bucket_file" -enumerate -json | tee "$json_file"
```
<!-- cheat
var s3_bucket_file := buckets.txt
var json_file := s3scanner-enum.jsonl
-->

### Enumerate with safe threads

Object enumeration is single-threaded per bucket; control total bucket concurrency with `-threads`.

```sh title:"Enumerate S3 buckets with controlled threading"
s3scanner -bucket-file "$s3_bucket_file" -enumerate -threads "$threads"
```
<!-- cheat
var s3_bucket_file := buckets.txt
var threads := 4
-->

## results triage

### Existing buckets

Print bucket name and region for buckets that exist from JSON output.

```sh title:"Extract existing buckets from S3Scanner JSON"
jq -r 'select(.bucket.exists==1) | [.bucket.name, .bucket.region] | @tsv' "$json_file"
```
<!-- cheat
var json_file := s3scanner.jsonl
-->

### Potentially public buckets

Print JSON records that mention public user permissions.

```sh title:"Find S3Scanner public permission records"
jq -c 'select((tostring | test("Public|public")))' "$json_file"
```
<!-- cheat
var json_file := s3scanner.jsonl
-->

### Readable or listable leads

Search JSON output for read/list indicators for manual verification.

```sh title:"Search S3Scanner output for read/list indicators"
grep -iE 'read|list|get|public|full control' "$json_file"
```
<!-- cheat
var json_file := s3scanner.jsonl
-->

### Writable leads

Search JSON output for write, put, or full-control indicators for manual verification and careful exploitation planning.

```sh title:"Search S3Scanner output for write indicators"
grep -iE 'write|put|full control|write acp' "$json_file"
```
<!-- cheat
var json_file := s3scanner.jsonl
-->

### Bucket names from JSON

Extract bucket names from JSON output for downstream AWS CLI or CloudFox follow-up.

```sh title:"Extract bucket names from S3Scanner JSON"
jq -r '.bucket.name // empty' "$json_file" | sort -u
```
<!-- cheat
var json_file := s3scanner.jsonl
-->

### Object names from enumeration

Extract object names from enumeration output for sampling and sensitive-name review.

```sh title:"Extract object names from S3Scanner JSON"
jq -r '.. | objects | .key? // empty' "$json_file" | sort -u
```
<!-- cheat
var json_file := s3scanner-enum.jsonl
-->

## manual verification

### AWS anonymous list

Manually verify anonymous list access for one bucket.

```sh title:"Manually list S3 bucket anonymously"
aws s3 ls "s3://$s3_bucket" --no-sign-request
```
<!-- cheat
var s3_bucket
-->

### AWS anonymous recursive list

Manually verify recursive anonymous object listing with size summary.

```sh title:"Recursively list S3 bucket anonymously"
aws s3 ls "s3://$s3_bucket" --recursive --human-readable --summarize --no-sign-request
```
<!-- cheat
var s3_bucket
-->

### AWS anonymous object head

Manually verify anonymous object metadata access.

```sh title:"Head S3 object anonymously"
aws s3api head-object --bucket "$s3_bucket" --key "$s3_object_key" --no-sign-request
```
<!-- cheat
var s3_bucket
var s3_object_key
-->

### AWS anonymous object download

Download one approved sample object anonymously for proof. Avoid bulk download unless authorized.

```sh title:"Download one S3 object anonymously"
aws s3 cp "s3://$s3_bucket/$s3_object_key" "$output_file" --no-sign-request
```
<!-- cheat
var s3_bucket
var s3_object_key
var output_file
-->

### AWS authenticated list

Verify access using a specific AWS profile when testing compromised or assumed-role credentials.

```sh title:"List S3 bucket with AWS profile"
aws --profile "$aws_profile" s3 ls "s3://$s3_bucket" --recursive --human-readable --summarize
```
<!-- cheat
var aws_profile
var s3_bucket
-->

### AWS safe write probe

If explicitly authorized, upload a harmless proof file to validate write access, then remove it.

```sh title:"Safely probe S3 write access"
printf 'authorized security test\n' > "$proof_file" && aws s3 cp "$proof_file" "s3://$s3_bucket/$proof_key" --no-sign-request && aws s3 rm "s3://$s3_bucket/$proof_key" --no-sign-request
```
<!-- cheat
var proof_file := s3scanner-proof.txt
var s3_bucket
var proof_key := s3scanner-proof.txt
-->

### AWS authenticated write probe

If explicitly authorized, validate write access with a specific AWS profile and remove the proof object.

```sh title:"Safely probe authenticated S3 write access"
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

Check a Google Cloud Storage bucket using S3Scanner's provider option.

```sh title:"Scan GCP bucket with S3Scanner"
s3scanner -provider gcp -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

### GCP enumerate and save DB

Scan a GCP bucket, enumerate objects, and save results to the configured Postgres database.

```sh title:"Scan GCP bucket, enumerate, and save to DB"
s3scanner -provider gcp -db -bucket "$s3_bucket" -enumerate
```
<!-- cheat
var s3_bucket
-->

### DigitalOcean Spaces

Scan a DigitalOcean Spaces bucket.

```sh title:"Scan DigitalOcean Spaces bucket"
s3scanner -provider digitalocean -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

### Linode object storage

Scan a Linode object storage bucket.

```sh title:"Scan Linode object storage bucket"
s3scanner -provider linode -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

### Scaleway object storage

Scan a Scaleway object storage bucket.

```sh title:"Scan Scaleway object storage bucket"
s3scanner -provider scaleway -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

### DreamHost object storage

Scan a DreamHost object storage bucket.

```sh title:"Scan DreamHost object storage bucket"
s3scanner -provider dreamhost -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

### Custom provider

Scan an S3-compatible custom provider using `config.yml` from `.`, `/etc/s3scanner/`, or `$HOME/.s3scanner/`.

```sh title:"Scan custom S3-compatible provider"
s3scanner -provider custom -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

## config and scale

### Config file template

Create a local config file for database, RabbitMQ, or custom-provider runs.

```sh title:"Create S3Scanner config template"
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

Save scan results to Postgres. Use a dedicated schema because S3Scanner runs Gorm automigration.

```sh title:"Scan bucket file and save results to database"
s3scanner -bucket-file "$s3_bucket_file" -db
```
<!-- cheat
var s3_bucket_file := buckets.txt
-->

### JSON and DB output

Save results to the configured database and keep a JSON-lines evidence file.

```sh title:"Scan bucket file to DB and JSON"
s3scanner -bucket-file "$s3_bucket_file" -db -json | tee "$json_file"
```
<!-- cheat
var s3_bucket_file := buckets.txt
var json_file := s3scanner.jsonl
-->

### RabbitMQ input

Consume bucket scan jobs from RabbitMQ. Requires `mq.uri` and `mq.queue_name` in config.

```sh title:"Run S3Scanner with RabbitMQ input"
s3scanner -mq
```
<!-- cheat -->

### RabbitMQ JSON output

Consume bucket scan jobs from RabbitMQ and emit JSON lines for centralized collection.

```sh title:"Run S3Scanner MQ input with JSON output"
s3scanner -mq -json
```
<!-- cheat -->

## docker

### Docker single bucket

Run S3Scanner from the GitHub Container Registry image.

```sh title:"Scan one bucket with S3Scanner Docker image"
docker run --rm ghcr.io/sa7mon/s3scanner -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->

### Docker bucket file

Run S3Scanner in Docker against a mounted bucket list.

```sh title:"Scan bucket file with S3Scanner Docker image"
docker run --rm -v "$(pwd):/data" ghcr.io/sa7mon/s3scanner -bucket-file "/data/$s3_bucket_file"
```
<!-- cheat
var s3_bucket_file := buckets.txt
-->

### Docker JSON output

Run S3Scanner in Docker and write JSON-lines output to the host.

```sh title:"Run S3Scanner Docker with JSON output"
docker run --rm -v "$(pwd):/data" ghcr.io/sa7mon/s3scanner -bucket-file "/data/$s3_bucket_file" -json | tee "$json_file"
```
<!-- cheat
var s3_bucket_file := buckets.txt
var json_file := s3scanner.jsonl
-->

### Docker config mount

Run S3Scanner in Docker with a mounted config file for custom provider, DB, or MQ use.

```sh title:"Run S3Scanner Docker with config file"
docker run --rm -v "$(pwd):/data" -w /data ghcr.io/sa7mon/s3scanner -provider custom -bucket "$s3_bucket"
```
<!-- cheat
var s3_bucket
-->
