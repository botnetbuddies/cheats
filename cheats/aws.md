# AWS

## ec2 metadata

### List IAM roles

List IAM roles available from the EC2 metadata service.

```sh title:"List EC2 metadata IAM roles"
curl http://169.254.169.254/latest/meta-data/iam/security-credentials/
```
<!-- cheat -->

### Dump IAM role

Dump temporary credentials for an IAM role from the EC2 metadata service.

```sh title:"Dump EC2 metadata IAM role credentials"
curl "http://169.254.169.254/latest/meta-data/iam/security-credentials/$aws_role_name"
```
<!-- cheat
var aws_role_name
-->
