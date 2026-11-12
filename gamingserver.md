---
layout: page
title: "TryHackMe GamingServer Walkthrough"
page_class: walkthrough
permalink: /gamingserver
---

*Nov 12, 2026 · @Otter*

## Overview

**Room:** GamingServer (TryHackMe)  
**Goal:** Obtain the user and root flags.

The foothold comes from discovering an encrypted SSH key and its passphrase wordlist in unlinked web paths. After gaining SSH access, membership in the `lxd` group provides the privilege-escalation path in this intentionally vulnerable lab.

## Recon

An `nmap` scan identified two open ports:

| Port | Service |
| --- | --- |
| 22 | SSH |
| 80 | HTTP |

## Enumeration

Running `feroxbuster` against the web root surfaced three paths that were not linked from the site:

- `/secretkey` served an encrypted RSA private key.
- `/uploads` contained `dict.lst`, a wordlist used to recover the key's passphrase.
- `/secret` was also discovered during enumeration.

## Foothold

Convert the private key into a format John the Ripper can check, then use the discovered wordlist:

```bash
python3 /usr/share/john/ssh2john.py SecretKey > keyhash
john keyhash -w=dict.lst
```

After recovering the passphrase, connect over SSH with the key:

```bash
ssh -i SecretKey <user>@<target-ip>
```

This provides a shell as the key's owner and access to the user flag.

## Privilege Escalation

`linpeas.sh` reported membership in the `lxd` group. In this lab, that membership allows a privileged container to access the host filesystem.

The walkthrough used an Alpine image built with [saghul's lxd-alpine-builder](https://raw.githubusercontent.com/saghul/lxd-alpine-builder/master/build-alpine), transferred it to the target, and imported it into LXD:

```bash
lxc image import alpine-v3.13-x86_64-20210218_0139.tar.gz --alias myimage
```

A public LXD privilege-escalation script (Exploit-DB EDB-ID 46978) was then run against the image:

```bash
./exploit.sh -f alpine-v3.13-x86_64-20210218_0139.tar.gz
```

The script starts a privileged container with the host filesystem mounted inside it. The root flag can then be read from the mounted filesystem.

## Flags

- **User flag:** `THM{...}`
- **Root flag:** `THM{...}`

## Lessons Learned

- Hidden, unlinked web paths such as `/secretkey` and `/uploads` can expose critical foothold material. Run directory discovery early.
- Check group membership with `id` during privilege-escalation enumeration, alongside tools such as `linpeas.sh`.
- In this lab, `lxd` group membership is effectively root because it enables mounting the host filesystem in a privileged container.
