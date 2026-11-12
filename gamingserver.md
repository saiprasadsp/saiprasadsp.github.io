---
layout: page
title: "TryHackMe GamingServer Walkthrough"
page_class: walkthrough
permalink: /gamingserver
---

/* ============================================================
   CTF / VAPT Writeup Theme — dark terminal aesthetic
   Drop this in your Jekyll assets (e.g. assets/css/ctf-writeup.css)
   and import/link it from the post layout, or scope it to a
   wrapper div like <div class="writeup"> ... </div> if you don't
   want it applying site-wide.
   ============================================================ */

:root {
  --bg: #0d1117;
  --bg-alt: #161b22;
  --fg: #c9d1d9;
  --fg-dim: #8b949e;
  --accent: #39ff14;      /* terminal green */
  --accent-dim: #2ea043;
  --accent-alt: #58a6ff;  /* cyan-blue for links */
  --warn: #f78166;
  --border: #30363d;
  --code-bg: #010409;
  --font-mono: "Fira Code", "JetBrains Mono", "Source Code Pro", Consolas, monospace;
}

.writeup {
  background: var(--bg);
  color: var(--fg);
  font-family: var(--font-mono);
  line-height: 1.65;
  padding: 2rem 1.5rem;
  max-width: 860px;
  margin: 0 auto;
}

/* Headings */
.writeup h1,
.writeup h2,
.writeup h3 {
  color: var(--accent);
  font-weight: 600;
  border-bottom: 1px solid var(--border);
  padding-bottom: 0.3rem;
  margin-top: 2.2rem;
}

.writeup h1::before { content: "$ "; color: var(--accent-dim); }
.writeup h2::before { content: "## "; color: var(--accent-dim); }
.writeup h3::before { content: "### "; color: var(--accent-dim); }

.writeup h1 { font-size: 1.8rem; }
.writeup h2 { font-size: 1.4rem; }
.writeup h3 { font-size: 1.15rem; }

/* Byline / meta row */
.writeup .meta {
  color: var(--fg-dim);
  font-size: 0.85rem;
  margin-bottom: 1.5rem;
}

/* Paragraphs & lists */
.writeup p { margin: 0.9rem 0; }

.writeup ul,
.writeup ol {
  padding-left: 1.4rem;
  margin: 0.8rem 0;
}

.writeup li { margin: 0.35rem 0; }

/* Inline code */
.writeup code {
  background: var(--code-bg);
  color: var(--accent);
  padding: 0.1rem 0.35rem;
  border-radius: 4px;
  font-size: 0.92em;
  border: 1px solid var(--border);
}

/* Code blocks */
.writeup pre {
  background: var(--code-bg);
  border: 1px solid var(--border);
  border-left: 3px solid var(--accent-dim);
  border-radius: 6px;
  padding: 1rem 1.2rem;
  overflow-x: auto;
  margin: 1.2rem 0;
}

.writeup pre code {
  background: none;
  border: none;
  padding: 0;
  color: var(--fg);
}

/* Terminal-prompt styling for shell blocks:
   add class="language-bash" (Jekyll/Rouge does this automatically) */
.writeup pre.language-bash code::before {
  content: "";
}

/* Links */
.writeup a {
  color: var(--accent-alt);
  text-decoration: none;
  border-bottom: 1px dashed var(--accent-alt);
}
.writeup a:hover {
  color: var(--accent);
  border-bottom-color: var(--accent);
}

/* Tables (flags, ports, etc.) */
.writeup table {
  width: 100%;
  border-collapse: collapse;
  margin: 1.2rem 0;
  font-size: 0.92rem;
}

.writeup th,
.writeup td {
  border: 1px solid var(--border);
  padding: 0.5rem 0.8rem;
  text-align: left;
}

.writeup th {
  background: var(--bg-alt);
  color: var(--accent);
}

.writeup tr:nth-child(even) {
  background: rgba(255, 255, 255, 0.02);
}

/* Flags — highlight as a callout */
.writeup .flag {
  background: var(--bg-alt);
  border: 1px solid var(--accent-dim);
  border-radius: 6px;
  padding: 0.6rem 1rem;
  margin: 0.6rem 0;
  font-size: 0.95rem;
}
.writeup .flag code {
  color: var(--warn);
}

/* Blockquotes (e.g. tool output snippets, notes) */
.writeup blockquote {
  border-left: 3px solid var(--fg-dim);
  margin: 1rem 0;
  padding: 0.3rem 1rem;
  color: var(--fg-dim);
  font-style: italic;
}

/* Horizontal rule between major sections */
.writeup hr {
  border: none;
  border-top: 1px dashed var(--border);
  margin: 2rem 0;
}

/* Scrollbar (webkit) to match theme */
.writeup pre::-webkit-scrollbar { height: 8px; }
.writeup pre::-webkit-scrollbar-thumb {
  background: var(--border);
  border-radius: 4px;
}

/* Mobile */
@media (max-width: 600px) {
  .writeup { padding: 1.2rem 1rem; }
  .writeup h1 { font-size: 1.5rem; }
  .writeup h2 { font-size: 1.2rem; }
}

