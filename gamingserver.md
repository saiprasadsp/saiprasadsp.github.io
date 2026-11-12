
---
layout: page
title: "TryHackme-GamingServer Walkthrough"
page_class: Walkthrough
permalink: /gamingserver
---
TryHackMe: GamingServer — Walkthrough
Nov 12, 2026 · @Otter
Overview
Room: GamingServer (TryHackMe). Goal: obtain the user and root flags. Attack chain: web content discovery exposed secrets (an RSA key and a wordlist) under undisclosed paths, the key's encrypted passphrase was cracked offline, SSH access gave the user flag, and membership in the lxd group allowed an LXD container-based escalation to a root shell.
Recon
An nmap scan of the target showed two open ports: 22 (SSH) and 80 (HTTP).
Enumeration
Running feroxbuster against the web root surfaced three paths not linked anywhere on the site: /uploads, /secret, and /secretkey.
• /secretkey served an encrypted RSA private key.
• /uploads contained dict.lst, a wordlist later used to crack that key's passphrase.
Foothold
Converted the key into a crackable hash and ran it against the wordlist found under /uploads:
python3 /usr/share/john/ssh2john.py SecretKey > keyhash
john keyhash -w=dict.lst
John recovered the key's passphrase, which unlocked it for SSH login:
ssh -i SecretKey <user>@<target-ip>
This gave a shell as the key's owner and the user flag.
Privilege Escalation
Running linpeas.sh flagged membership in the lxd group — effectively root on most systems, since an unprivileged member of that group can create a container with security.privileged=true and mount the host's root filesystem into it.
Steps taken:
1. Pulled the Alpine image builder from saghul's lxd-alpine-builder (https://raw.githubusercontent.com/saghul/lxd-alpine-builder/master/build-alpine) and built an Alpine image (alpine-v3.13-x86_64-20210218_0139.tar.gz).
2. Served the image from the attacking machine with Python's HTTP server and pulled it onto the target.
3. Imported the image into the target's LXD:
   lxc image import alpine-v3.13-x86_64-20210218_0139.tar.gz --alias myimage
4. Used a known public LXD privilege-escalation script (Exploit-DB EDB-ID 46978), saved locally as exploit.sh, against the imported image:
   ./exploit.sh -f alpine-v3.13-x86_64-20210218_0139.tar.gz
   The script launches a privileged container with the host filesystem mounted inside it, dropping into a root shell on the host.
5. Read the root flag from the mounted filesystem.
Flags
• User flag: THM{...}
• Root flag: THM{...}
Lessons learned
• lxd group membership is effectively root: any unprivileged user in that group can mount the host's / into a privileged container.
• Hidden, unlinked web paths (/secretkey, /uploads) held the entire foothold chain — directory brute-forcing should run early and thoroughly, even against a site that looks content-free.
• Checking group memberships (id) is a fast, high-value step in privilege-escalation enumeration alongside automated tools like linpeas.sh.
