# TORRICELLI / LAB

个人博客，代码与想法之间的桥。

线上地址：https://torricelli0.github.io/

## 这是什么

一个记录想法、文章和正在发生的事情的个人站点。纯静态，零依赖，GitHub Pages 托管。

## 两种排版风格（重要）

本站有**两套并行的视觉语言**，按文章类型分流。

### 风格 A · Terminal（工具/实用类）

**用于**：技术笔记、软件清单、操作教程、实用主义内容

**视觉特征**：
- 纯黑底 `#0a0a0a` + 纯白字 + **单一蓝** `#6799fe`
- 无衬线体（系统 sans-serif）
- 2px 蓝色阅读进度条
- h2 前 24×1px 蓝色细线
- 文章列表用分隔线，不用卡片

**气质**：克制、信息密度高、工具感。参照 Linear / Vercel / DeepSeek Harness。

**示例文章**：`posts/my-software-collection.html`

### 风格 B · Cosmic（科普/长文类）

**用于**：概念解释、深度长文、经验分享、思想性内容

**视觉特征**：
- 冷调黑底 `#0C0C0E` + 冷白字 `#D8D8D2` + **亮钴蓝** `#6E9AE8`
- **Cormorant Garamond 高反差衬线体**（标题和正文）+ Space Mono（编号/标签）
- **SVG 天体轨道背景**（fixed，opacity .5）
- 标题区：发光蓝点 → 全大写 kicker → 大标题（部分词斜体蓝）→ 斜体 dek → 圆点分隔 → 标签胶囊
- 章节编号：`0.5em` 相对字号 + 灰色 + 与标题同行
- 引用块：左侧 1px 蓝竖线 + 斜体 22px

**气质**：出版级排版、有仪式感、杂志感。参照 Perplexity Comet 发布站 / 《2001 太空漫游》/ 老式天文图录。

**示例文章**：`posts/vllm-and-rl-basics.html`、`posts/thesis-guide.html`

### 怎么选

```
这篇是"工具/操作/清单"  → A · Terminal（实用主义，别花里胡哨）
这篇是"概念/原理/思考"  → B · Cosmic（值得细读，给点仪式感）
```

**完整的设计规范见 [BLOG-STYLE.md](BLOG-STYLE.md)**，包括配色变量、字体、结构、SVG 代码、禁止事项。

## 设计理念

**黑底、单一强调色、分隔线而非卡片。**

- **黑底**让内容成为主角，也符合开发者工具的视觉语言
- **单一强调色**避免视觉噪音（A 用蓝、B 用钴蓝，都只有一种）
- **分隔线而非卡片**是刻意的：文章列表用细线分隔，比一堆圆角卡片更克制
- **衬线 vs 无衬线的分流**：工具类用无衬线（读得快），科普类用衬线（读得慢、更有分量）

完整规范见 [BLOG-STYLE.md](BLOG-STYLE.md)。

## 技术栈

纯 static HTML/CSS，**无构建步骤、无框架、无依赖**。

```
index.html              首页
posts/*.html            文章
assets/post.css         风格 A 样式（Terminal）
assets/post-cosmic.css  风格 B 样式（Cosmic）
new-post.sh             一键发布脚本
BLOG-STYLE.md           排版规范（改页面前必读）
```

托管在 GitHub Pages，推送到 `main` 分支即自动部署（`.nojekyll` 确保静态文件不被 Jekyll 处理）。

## 如何新增文章

### 方式一：脚本（快速，简单排版）

1. 把文案写到任意 txt/md 文件
2. 运行：
   ```bash
   ./new-post.sh "文章标题" ~/Desktop/my-post.txt note
   ```
   第三个参数：`note` / `debug` / `idea` / `log`
3. 脚本自动生成 HTML、估算阅读时间、加首页链接、commit + push

### 方式二：手动（完整控制，推荐给 Cosmic 风格）

1. 复制 `posts/vllm-and-rl-basics.html` 作为模板
2. 替换 `<title>`、`<h1>`、`<p class="dek">`、正文内容
3. 保留：`.orbit-bg` 的 SVG、`<aside class="toc">`、底部 `<script>`
4. **关键**：CSS 引用要带版本号 `post-cosmic.css?v=5`（防缓存）

## 给其他 AI/Agent 的说明

**如果你要使用 AI 复现这个博客的排版**：

1. 把 [BLOG-STYLE.md](BLOG-STYLE.md) 给它
2. 明确说「用风格 A」或「用风格 B」
3. 给它一个参考文件：
   - 风格 A → `posts/my-software-collection.html`
   - 风格 B → `posts/vllm-and-rl-basics.html`

**BLOG-STYLE.md 已包含**：两套配色的 CSS 变量、字体选择、页面结构、SVG 轨道背景代码、软件清单的三段式写法、禁止事项。

## 文件说明

| 文件 | 作用 |
|---|---|
| `index.html` | 首页 |
| `posts/` | 所有文章 |
| `assets/post.css` | **风格 A**（Terminal）文章样式 |
| `assets/post-cosmic.css` | **风格 B**（Cosmic）文章样式 |
| `new-post.sh` | 快速发布脚本（仅风格 A） |
| `BLOG-STYLE.md` | **排版规范（改页面前先读）** |
