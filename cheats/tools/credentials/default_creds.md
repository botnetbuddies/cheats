# Default_creds

## default creds tool

### Default creds lookup

Find default creds lookup with Default_creds.

Search a local default-creds database for known vendor/application logins. Optionally export the matches for use with hydra or another spraying tool.

```sh title:"Default Creds Find Default Creds Lookup"
creds search $app $template
```
<!-- cheat
var template = printf '%s\n' '--export $app.creds # Yes, please' ' # No' --- --header 'Export to file?'
var app
-->

