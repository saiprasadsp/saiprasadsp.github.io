---
layout: page
title: "Homepage"
permalink: /
---

<style>
  @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap');

  :root{
    --bg:#f7f9fb;
    --surface:#ffffff;
    --text:#0f1720;
    --muted:#50606a;
    --accent:#2ea67a; /* green accent; change to any color */
  }
  body { background:var(--bg); color:var(--text); font-family:Inter,system-ui,Arial; }
  .hero { max-width:1100px; margin:60px auto; display:flex; gap:40px; align-items:center; padding:0 24px; }
  .hero-left{ flex:1; }
  .meta { color:var(--muted); font-size:14px; display:flex; gap:12px; align-items:center; margin-bottom:12px; }
  .dot{ width:10px;height:10px;background:var(--accent);border-radius:50%; display:inline-block; box-shadow:0 0 8px rgba(46,166,122,.12) }
  h1{ font-size:64px; margin:0 0 8px 0; line-height:0.95; font-weight:800; color:var(--text) }
  .subtitle{ font-size:18px; color:var(--text); margin-bottom:12px; font-weight:600; }
  .lead { color:var(--muted); margin-bottom:18px; font-size:16px; max-width:620px; line-height:1.7; }
  .cta-row{ display:flex; gap:12px; margin-top:18px; flex-wrap:wrap; }
  .btn{ padding:10px 18px; border-radius:28px; background:transparent; color:var(--text); border:1px solid rgba(10,10,10,.06); text-decoration:none; font-weight:600; }
  .btn.primary{ background:var(--accent); color:white; border:none; }
  .hero-right{ width:420px; display:flex; justify-content:center; align-items:center; }
  @media (max-width:900px){
    .hero{ flex-direction:column-reverse; text-align:center; padding:32px; }
    h1{ font-size:42px }
    .hero-right{ width:100%; margin-bottom:24px }
  }
</style>

<div class="hero">
  <div class="hero-left">
    <div class="meta"><span class="dot"></span><span>Location · Open to opportunities</span></div>
    <h1>Your Name</h1>
    <div class="subtitle">Role · Short Tagline</div>
    <div class="lead">
      A short paragraph about you: what you do, what you care about, and a couple of notable projects or interests. Replace this text with your own bio.
    </div>

    <div class="cta-row">
      <a class="btn primary" href="/blog">Read the blog</a>
      <a class="btn" href="https://github.com/saiprasadsp">GitHub</a>
      <a class="btn" href="https://www.linkedin.com">LinkedIn</a>
      <a class="btn" href="mailto:you@example.com">Email</a>
    </div>
  </div>

  <div class="hero-right">
    <!-- simple static SVG placeholder (replace with custom SVG if you like) -->
    <svg width="260" height="260" viewBox="0 0 360 360" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
      <circle cx="180" cy="180" r="130" fill="#f0fbf4" stroke="rgba(46,166,122,.12)"/>
      <g>
        <line stroke="rgba(46,166,122,.25)" x1="80" y1="200" x2="240" y2="140"/>
        <circle cx="240" cy="140" r="6" fill="#2ea67a"/>
        <circle cx="80" cy="200" r="5" fill="#2ea67a"/>
      </g>
    </svg>
  </div>
</div>
