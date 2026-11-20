#!/usr/bin/env python3
"""扫描 posts/*.html 的 <meta name="tags">，统计后重写 index.html 的标签云。"""
import re, glob, os
from collections import Counter

BASE = os.path.dirname(os.path.abspath(__file__))
posts = glob.glob(os.path.join(BASE, "posts", "*.html"))

counts = Counter()
for p in posts:
    if os.path.basename(p) == "template.html":
        continue
    s = open(p, encoding="utf-8", errors="ignore").read()
    m = re.search(r'<meta\s+name=["\']tags["\']\s+content=["\']([^"\']+)["\']', s, re.I)
    if m:
        for t in m.group(1).split(","):
            t = t.strip()
            if t:
                counts[t] += 1

if not counts:
    print("没有找到任何 tags，index.html 未改动")
    raise SystemExit

# 按数量降序，取前 12
items = counts.most_common(12)
maxn = items[0][1]
lines = []
for t, n in items:
    hot = ' hot' if n >= maxn and maxn > 1 else ''
    lines.append(f'  <a class="tag{hot}" href="#">{t} <span class="n">{n}</span></a>')
block = '<section class="tags" id="tags">\n' + "\n".join(lines) + "\n</section>"

idx = os.path.join(BASE, "index.html")
s = open(idx, encoding="utf-8").read()
new, cnt = re.subn(
    r'<section class="tags" id="tags">.*?</section>',
    block, s, flags=re.S
)
if cnt == 0:
    print("index.html 中找不到标签云区块，未改动")
    raise SystemExit
open(idx, "w", encoding="utf-8").write(new)
print(f"统计完成：{len(posts)} 篇文章，{len(items)} 个标签")
for t, n in items:
    print(f"  {t}: {n}")
