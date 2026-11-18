# TORRICELLI / LAB

个人博客，代码与想法之间的桥。

线上地址：https://torricelli0.github.io/

## 这是什么

一个记录想法、文章和正在发生的事情的个人站点。纯静态，零依赖，GitHub Pages 托管。

## 设计理念

**黑底、单一蓝色、终端面板、分隔线而非卡片。**

- **黑底**让内容成为主角，也符合开发者工具的视觉语言
- **单一蓝色**（`#6799fe`）作为唯一强调色，避免视觉噪音
- **终端面板**（首页右侧的 Currently 卡片）呼应 Harness / IDE 的工作场景
- **分隔线而非卡片**是刻意的：文章列表用细线分隔，比一堆圆角卡片更克制、更像阅读

这套设计抽自 DeepSeek Harness 官方界面的 CSS 变量，属于 "Developer / Terminal Aesthetic" 流派，与 Linear、Vercel 的设计语言同源。

完整规范见 [BLOG-STYLE.md](BLOG-STYLE.md)。

## 技术栈

纯 static HTML/CSS，**无构建步骤、无框架、无依赖**。

```
index.html           首页
posts/*.html         文章
assets/post.css      文章页样式
new-post.sh          一键发布脚本
BLOG-STYLE.md        排版规范
```

托管在 GitHub Pages，推送到 `main` 分支即自动部署（`.nojekyll` 确保静态文件不被 Jekyll 处理）。

## 如何新增文章

1. 把文案写到任意 txt/md 文件，例如 `~/Desktop/my-post.txt`
2. 运行：
   ```bash
   ./new-post.sh "文章标题" ~/Desktop/my-post.txt note
   ```
   第三个参数：`note` / `debug` / `idea` / `log`
3. 脚本会自动：生成 HTML、估算阅读时间、加首页链接、commit + push

**注意**：目前脚本生成的文章已有基础样式（进度条/TOC/页脚图标由 `post.css` 提供）。
如果你要手动加小标签，在 dek 下方插入：
```html
<div class="tags-inline"><span>标签1</span><span>标签2</span></div>
```

## 文件说明

| 文件 | 作用 |
|---|---|
| `index.html` | 首页 |
| `posts/` | 所有文章 |
| `assets/post.css` | 文章页统一样式 |
| `new-post.sh` | 发布脚本 |
| `BLOG-STYLE.md` | **排版规范（改页面前先读）** |
