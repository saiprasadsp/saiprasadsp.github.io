---
layout: page
title: "TryHackMe GamingServer Walkthrough"
page_class: walkthrough
permalink: /gamingserver
---

<header class="walkthrough-intro">
  <p class="walkthrough-kicker">TryHackMe · Room walkthrough</p>
  <p class="walkthrough-deck">A guided path from initial discovery to the user and root flags, with the key findings and commands grouped by stage.</p>
  <p class="walkthrough-meta"><span>Updated Nov 12, 2026</span><span>Written by @Otter</span></p>
</header>

<div class="walkthrough-summary" aria-label="Walkthrough summary">
  <div><span class="summary-label">Target</span><strong>GamingServer</strong></div>
  <div><span class="summary-label">Open services</span><strong>SSH · HTTP</strong></div>
  <div><span class="summary-label">Attack path</span><strong>Web discovery → SSH → LXD</strong></div>
</div>

## Overview

The goal is to retrieve both flags. The foothold comes from discovering an encrypted SSH key and its passphrase wordlist in unlinked web directories. After logging in, LXD group membership provides the privilege-escalation path in this intentionally vulnerable lab.

<div class="walkthrough-notice"><strong>Lab context</strong><p>These steps are for the authorized TryHackMe GamingServer room. Use them only in the provided lab environment.</p></div>

## 1. Recon

An Nmap scan identified two open ports:

| Port | Service | What it suggests |
| --- | --- | --- |
| 22 | SSH | Remote shell access may be possible with valid credentials. |
| 80 | HTTP | Enumerate the site and its publicly served content. |

## 2. Web enumeration

Directory discovery with `feroxbuster` revealed paths that were not linked from the visible site:

- `/secretkey` served an encrypted RSA private key.
- `/uploads` contained `dict.lst`, a wordlist used to recover the key's passphrase.
- `/secret` was also discovered during enumeration.

## 3. Foothold: recover the SSH passphrase

Convert the private key into a format John the Ripper can check, then use the discovered wordlist:

```bash
python3 /usr/share/john/ssh2john.py SecretKey > keyhash
john keyhash -w=dict.lst
```

John recovered the passphrase. Use the unlocked key to connect over SSH:

```bash
ssh -i SecretKey <user>@<target-ip>
```

This provides a shell as the key's owner, where the user flag can be read.

## 4. Privilege escalation: LXD group membership

`linpeas.sh` reported membership in the `lxd` group. In this lab, that membership allows a privileged container to access the host filesystem. The walkthrough used an Alpine image built with [saghul's lxd-alpine-builder](https://raw.githubusercontent.com/saghul/lxd-alpine-builder/master/build-alpine), transferred it to the target, and imported it into LXD.

```bash
lxc image import alpine-v3.13-x86_64-20210218_0139.tar.gz --alias myimage
```

A local copy of the public Exploit-DB LXD lab script (EDB-ID 46978) was then run against the imported image:

```bash
./exploit.sh -f alpine-v3.13-x86_64-20210218_0139.tar.gz
```

The script starts a privileged container with the host filesystem mounted. From the lab shell, read the root flag from that mounted filesystem.

## Flags

<div class="walkthrough-flags">
  <div><span class="flag-label">User</span><code>THM{...}</code></div>
  <div><span class="flag-label">Root</span><code>THM{...}</code></div>
</div>

## Key takeaways

- Check for unlinked web paths early; `/secretkey` and `/uploads` contained the foothold chain.
- Review group memberships with `id` as part of privilege-escalation enumeration.
- In this lab, membership in `lxd` is highly privileged because it can be used to mount the host filesystem in a privileged container.

