# AWS

## ec2 metadata

### List IAM roles

List IAM roles with AWS.

List IAM roles available from the EC2 metadata service.

```sh title:"AWS List IAM Roles"
curl http://169.254.169.254/latest/meta-data/iam/security-credentials/
```
<!-- cheat -->

### Dump IAM role

Dump IAM role with AWS.

Dump temporary credentials for an IAM role from the EC2 metadata service.

```sh title:"AWS Dump IAM Role"
curl "http://169.254.169.254/latest/meta-data/iam/security-credentials/$aws_role_name"
```
<!-- cheat
var aws_role_name
-->
