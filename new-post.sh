#!/bin/bash
# 新文章发布器：你只写文案，脚本负责排版 + 加首页链接 + 提交推送
# 用法：
#   1) 把文案写到任意 txt/md 文件，例如 ~/Desktop/my-post.txt
#   2) bash new-post.sh "文章标题" ~/Desktop/my-post.txt note
#      （第三个参数：note / debug / idea / log）
set -eu

TITLE="$1"
SRC="$2"
KIND="${3:-note}"

[ -f "$SRC" ] || { echo "找不到文案文件: $SRC"; exit 1; }

# 标题转文件名（去掉空格和特殊字符）
SLUG=$(echo "$TITLE" | tr ' /\\:*?"<>|' '_' | sed 's/_*$//')
[ -n "$SLUG" ] || SLUG="untitled"

ROOT="$(cd "$(dirname "$0")" && pwd)"
TARGET="$ROOT/posts/$SLUG.html"
DATE=$(date +%Y-%m-%d)

# 统计字数估算阅读时间
CHARS=$(wc -m < "$SRC" | tr -d ' ')
MINS=$(( CHARS / 400 + 1 ))

# 把纯文本转成 HTML 段落（空行分段，空行间内容合并为一段）
BODY=$(python3 - "$SRC" <<'PY'
import sys, html
lines = open(sys.argv[1], encoding="utf-8").read().splitlines()
out, para = [], []
def flush():
    if para:
        out.append("<p>" + html.escape(" ".join(x.strip() for x in para if x.strip())) + "</p>")
        para.clear()
for ln in lines:
    if not ln.strip():
        flush()
    else:
        para.append(ln)
flush()
print("\n  ".join(out))
PY
)

cat > "$TARGET" <<HTML
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>$TITLE — TORRICELLI / LAB</title>
<link rel="stylesheet" href="../assets/post.css">
</head>
<body>
<header>
  <div class="logo">TORRICELLI <span>/ LAB</span></div>
  <a class="back" href="../index.html">← 返回首页</a>
</header>
<article>
  <div class="meta"><span class="k">$KIND</span><span>$DATE</span><span>约 $MINS 分钟</span></div>
  <h1>$TITLE</h1>
  <p class="dek">$(echo "$BODY" | head -c 200 | sed 's/<[^>]*>//g')…</p>
  $BODY
</article>
<footer>
  <span>TORRICELLI / LAB</span>
  <span><a href="../index.html">← 返回首页</a></span>
</footer>
</body>
</html>
HTML

# 在首页文章列表第一行插入链接
python3 - "$ROOT/index.html" "$SLUG" "$TITLE" "$KIND" <<'PY'
import sys
p, slug, title, kind = sys.argv[1:5]
s = open(p, encoding="utf-8").read()
anchor = '<section class="section" id="notes">\n  <h2>最近写的</h2>\n'
line = f'  <a class="item" href="posts/{slug}.html"><span class="k">{kind.upper()}</span><span class="t">{title}</span><span class="d">{kind}</span></a>\n'
assert anchor in s, "首页结构变了，找不到文章区"
if f'posts/{slug}.html' not in s:
    s = s.replace(anchor, anchor + line)
    open(p, "w", encoding="utf-8").write(s)
PY

cd "$ROOT"
git add -A
git -c user.name="Torricelli0" -c user.email="torricelli0@users.noreply.github.com" \
  commit -q -m "new post: $TITLE"
git push -q
echo "✅ 已发布: https://torricelli0.github.io/posts/$SLUG.html"
