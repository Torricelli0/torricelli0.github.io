# 博客排版规范

> 这是本站的设计契约。任何新文章、页面改动都应遵循本文件。
> 把这份文档交给任意 Agent，说"按这个规范写/改"，即可复现同样的风格。

---

## 两套风格：按内容类型选择

本站有**两套并行的视觉语言**，按文章类型分流。

| 风格 | 用于 | 核心气质 |
|---|---|---|
| **A · Terminal**（默认） | 技术笔记、软件清单、实用教程 | 克制、信息密度高、工具感 |
| **B · Cosmic** | 科普、深度长文、思想性内容 | 排版讲究、有仪式感、杂志感 |

### 判断标准

```
这篇是"工具/操作/清单"  → A · Terminal（实用主义，别花里胡哨）
这篇是"概念/原理/思考"  → B · Cosmic（值得细读，给点仪式感）
```

---

# 风格 A · Terminal（默认）

## 配色

```css
--bg: #0a0a0a;                      /* 纯黑背景 */
--fg: #fff;                          /* 主文字 */
--fg2: rgba(255,255,255,.72);        /* 次要文字 */
--fg3: rgba(255,255,255,.48);        /* 辅助文字 */
--brand: #6799fe;                    /* 唯一强调色：蓝 */
--bd: rgba(255,255,255,.09);         /* 极淡边框 */
```

**原则**：黑底 + 三档灰 + 单一蓝。不加第二种强调色、不用渐变背景。

## 首页结构

1. **顶部导航**：sticky、`backdrop-filter: blur(12px)`、60px 高
2. **Hero**：左大标题 `Bridge between code & ideas`，右终端面板（Currently）
3. **文章列表**：分隔线式（`.item`），**不用卡片堆叠**
4. **标签云**：高频标签蓝色高亮 + 淡底
5. **页脚**：GitHub 图标单独居中一行

## 文章页结构

1. **顶部 2px 蓝色进度条**
2. **元信息行**：`笔记  2026-11-17 · 约 8 分钟`（等宽字体）
3. **大标题** + **斜体衬线 dek**（关键！杂志感来源）
4. **小标签胶囊**：灰色描边
5. **正文**：max-width 720px
6. **h2 前有 24×1px 蓝色细线**
7. **右侧 TOC**：fixed、滚动高亮、<1100px 隐藏
8. **页脚**：GitHub 图标居中

### 软件/条目清单的写法（重要）

每个条目用 **h3 + 三段式**：

```html
<h3>
  <span class="swname">Obsidian</span>
  <span class="swdesc">— 让笔记变成能被 AI 直接读的知识库</span>
</h3>
<p><strong>痛点</strong>：你会遇到什么问题</p>
<p><strong>怎么解决</strong>：具体机制（一句）</p>
<p><strong>为什么是它</strong>：和竞品的差异</p>
```

**CSS 要点**：
- `.swname` 用蓝色 `--brand`（软件名）
- `.swdesc` 用白色 `--fg`（说明保持可读）
- h3 上间距 **52px**（条目之间留白）
- **不要**把整个 h3 染色——14 个蓝色标题会变成噪音

---

# 风格 B · Cosmic（科普/长文）

## 配色

```css
--black: #0A0A0A;      /* 纯黑 */
--cream: #F0EAD8;      /* 奶油纸白（正文色，比纯白柔和） */
--blue: #2B4F91;       /* 钴蓝（轨道线/深色点缀） */
--blue-lt: #5B7FC7;    /* 亮钴蓝（时间戳/强调） */
--dim: #8A8272;        /* 暗金灰（辅助文字） */
--rule: rgba(240,234,216,.16);  /* 极淡边框 */
```

**和 A 的核心差异**：正文不用纯白而用**奶油色**，强调色用**更深的钴蓝**，整体像旧天文图录。

## 字体（关键差异）

| 用途 | 字体 |
|---|---|
| 标题/正文 | **Cormorant Garamond**（高反差衬线，斜体为主） |
| 编号/标签 | **Space Mono**（等宽，全大写 + 字距 3-4px） |

**这是 Cosmic 风格的灵魂**——衬线体带来"古籍/图录"气质，等宽体负责"档案编号"的克制感。

## 必备元素

### 1. SVG 天体轨道背景（fixed，opacity .5）

```html
<div class="orbit-bg">
<svg viewBox="0 0 1100 1000" preserveAspectRatio="xMidYMid slice">
  <ellipse cx="550" cy="420" rx="660" ry="250" fill="none"
           stroke="#2B4F91" stroke-width="0.7" opacity="0.4"
           transform="rotate(-16 550 420)"/>
  <!-- 2-3 条不同角度的椭圆 + 几个小圆点 -->
</svg>
</div>
```

### 2. 标题区结构与装饰

```
[发光蓝点 planet]
[No. 002 · Technical Notes]     ← 全大写 + 宽字距
[大标题，部分词用 emissive italic 蓝]
[斜体 dek，宽度 580px 居中]
[—— · · · ——]                   ← 圆点分隔装饰
[标签胶囊：全大写]
```

### 3. 章节标题带编号

```html
<h2 id="s1">
  <span class="h2num">一、</span>vLLM 册子是什么
</h2>
```

`.h2num` 用 Space Mono + 亮钴蓝 + 独立一行。

### 4. 引用块

左侧 1px 亮钴蓝竖线，正文用斜体衬线，字号 22px（比正文大）。

---

## 文案风格（两套通用）

- 大标题用英文，小字用中文（"英文高级感 + 中文信息量"）
- 英文连接用 `&` 不用 `and`
- 中文标点极简：可用顿号、少用句号
- **不用 emoji**
- 分类标签用英文大写：`NOTE` / `LOG` / `IDEA` / `INFRA`

## 禁止事项（两套通用）

- ❌ 大圆角卡片 + 彩色渐变（那是 glassmorphism，已弃用）
- ❌ 多种强调色
- ❌ 自动播放音乐
- ❌ 过度动画（只允许：淡入、进度条、hover 颜色过渡）

---

## 技术实现

### 风格 A（Terminal）

```
assets/post.css          共用样式
posts/*.html             引用 ../assets/post.css
```

### 风格 B（Cosmic）

```
assets/post-cosmic.css   独立样式（字体 + 轨道背景 + 衬线）
posts/*.html             引用 ../assets/post-cosmic.css
```

**两套 CSS 独立，互不影响**。文章用哪个由 `<link>` 决定。

### 新增文章时

```html
<!-- 技术/工具类 -->
<link rel="stylesheet" href="../assets/post.css">

<!-- 科普/长文类 -->
<link rel="stylesheet" href="../assets/post-cosmic.css">
```

---

## 设计参照

| 风格 | 参照 |
|---|---|
| **A · Terminal** | Linear、Vercel、DeepSeek Harness |
| **B · Cosmic** | Perplexity Comet 发布站、《2001 太空漫游》片头、老式天文图录 |

两者都属于「Developer Aesthetic」大方向，但 B 更偏**出版级排版**。
