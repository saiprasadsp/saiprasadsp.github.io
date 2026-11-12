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

The goal was to obtain both the user and root flags. The foothold came from discovering an encrypted SSH key and a wordlist in hidden web paths. After logging in, the `lxd` group membership provided the privilege-escalation route in this intentionally vulnerable lab.

<div class="walkthrough-notice"><strong>Lab context</strong><p>These steps are for the authorized TryHackMe GamingServer room and should only be used in the provided environment.</p></div>

## 1. Recon

An `nmap` scan showed two open ports:

| Port | Service | Notes |
| --- | --- | --- |
| 22 | SSH | Remote shell access may be possible with valid credentials. |
| 80 | HTTP | The web application should be enumerated before attack execution. |

## 2. Web enumeration

A `feroxbuster` scan against the website root surfaced paths that were not linked from the normal site:

- `/secretkey` served an encrypted RSA private key.
- `/uploads` contained `dict.lst`, which was later used to recover the passphrase.
- `/secret` was also discovered during enumeration.

## 3. Foothold: recover the SSH passphrase

The private key had to be converted to a format John the Ripper could process:

```bash
python3 /usr/share/john/ssh2john.py SecretKey > keyhash
john keyhash -w=dict.lst
```

Once the passphrase was recovered, the key was used for SSH access:

```bash
ssh -i SecretKey <user>@<target-ip>
```

This gave a shell as the key owner and allowed access to the user flag.

## 4. Privilege escalation: LXD group membership

`linpeas.sh` identified the user as a member of the `lxd` group. In this lab, that is effectively a path to root on the host because unprivileged users in the group can run a container with privileged settings and mount the host filesystem.

The workflow used an Alpine image built with [saghul's lxd-alpine-builder](https://raw.githubusercontent.com/saghul/lxd-alpine-builder/master/build-alpine), transferred it into the target, then imported it into LXD:

```bash
lxc image import alpine-v3.13-x86_64-20210218_0139.tar.gz --alias myimage
```

A public LXD privilege-escalation script (EDB-ID 46978) was executed against the imported image:

```bash
./exploit.sh -f alpine-v3.13-x86_64-20210218_0139.tar.gz
```

This launched a privileged container with the host filesystem mounted inside it, granting a root shell. The root flag was then read from the mounted filesystem.

## Flags

<div class="walkthrough-flags">
  <div><span class="flag-label">User</span><code>THM{...}</code></div>
  <div><span class="flag-label">Root</span><code>THM{...}</code></div>
</div>

## Key takeaways

- Hidden or unlinked web paths can hold the entire foothold chain.
- `id` and group membership checks are fast, high-value privilege-escalation checks.
- A user in `lxd` can become root in the lab environment when a privileged container is created.

