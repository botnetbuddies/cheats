# Swaks

## swaks - phishing attacks(Email Attacks)

### Send phishing email

Run send phishing email with Swaks.

Send a phishing email through swaks against the named SMTP server. Useful for testing open relays and internal mail submission paths.

```sh title:"Swaks Run Send Phishing Email"
swaks --to $user@$domain --from botnetbuddies@hacker.com --server $domain --data "Subject: Test\n\nCheck this link: $malicious_link"
```
<!-- cheat
import users
import domain_ip
var malicious_link
-->

