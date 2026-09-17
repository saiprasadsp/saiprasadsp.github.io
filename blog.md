---
layout: page
title: "Blog"
page_class: blog
permalink: /blog
---
<style>
  @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap');
  :root{
    --bg:#f7f9fb; --text:#0f1720; --muted:#50606a; --accent:#2ea67a;
  }
  body { background:var(--bg); color:var(--text); font-family:Inter,system-ui,Arial; }
  .wrap{ max-width:800px; margin:60px auto; padding:0 24px; }
  h1{ font-size:42px; font-weight:800; margin:0 0 8px 0; }
  .lead{ color:var(--muted); margin-bottom:36px; font-size:16px; }
  .entry{ padding:18px 0; border-bottom:1px solid rgba(10,10,10,.08); }
  .entry:last-child{ border-bottom:none; }
  .entry a{ font-size:19px; font-weight:600; color:var(--text); text-decoration:none; }
  .entry a:hover{ color:var(--accent); }
  .entry .desc{ color:var(--muted); font-size:14.5px; margin-top:4px; }
  .entry .date{ color:var(--accent); font-size:12.5px; font-weight:600; margin-right:10px; }
</style>

<div class="wrap">
  <h1>Blog</h1>
  <p class="lead">Writeups, notes, and links from CTFs and security practice.</p>

  {% for post in site.posts %}
  <div class="entry">
    <span class="date">{{ post.date | date: "%b %-d, %Y" }}</span>
    <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
    {% if post.excerpt %}<div class="desc">{{ post.excerpt | strip_html | truncatewords: 24 }}</div>{% endif %}
  </div>
  {% endfor %}

  {% for item in site.data.writeups %}
  <div class="entry">
    <a href="{{ item.url }}" {% unless item.internal %}target="_blank" rel="noopener"{% endunless %}>{{ item.title }}</a>
    {% if item.description %}<div class="desc">{{ item.description }}</div>{% endif %}
  </div>
  {% endfor %}
</div>
