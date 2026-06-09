# 常见问题

## 编译相关

### Q1: 编译报错 "Neither XeLaTeX nor LuaLaTeX detected"

**A:** 本模板要求使用 XeLaTeX（推荐）或 LuaLaTeX 引擎编译。请确认：

1. 已安装 TeX Live 2022 或更高版本
2. 编译命令使用 `latexmk -xelatex` 而非 `pdflatex`
3. 如果使用 VS Code LaTeX Workshop，在 settings.json 中配置 `"latex-workshop.latex.tools"` 使用 xelatex

### Q2: 编译报错 "fontspec Error: The font "FangSong" cannot be found"

**A:** 这是字体缺失问题。Windows 11 部分版本未预装仿宋字体。解决方案：

1. **推荐**：将字体文件放入 `fonts/` 目录，模板会自动使用本地字体
2. **备选**：安装华文仿宋（STFangSong），模板会自动回退
3. **最终回退**：模板会自动使用宋体替代仿宋，并输出警告

### Q3: 参考文献显示 [?] 而非正常编号

**A:** 参考文献需要多次编译才能正确显示。请使用 `latexmk` 自动处理编译次数：

```bash
latexmk -xelatex cauc_thesis
```

如果仍有问题，检查：
1. `reference.bib` 文件中条目格式是否正确
2. `.tex` 文件中 `\cite{key}` 的 key 是否与 .bib 文件中一致
3. 是否使用了正确的参考文献样式（本科使用 `gbt7714-2005-numerical`，研究生使用 `gbt7714-numerical`）

> 编译产物在 `build/` 目录中，参考文献相关的 `.bbl`/`.blg` 文件也在该目录下。

### Q4: 编译时出现 "Use of \reserved@a doesn't match its definition"

**A:** 这通常是由于 `\g@addto@macro` 与 natbib 冲突。本模板已修复此问题。如果仍然出现，请确认使用的是最新版本的模板。

### Q5: Overleaf 编译报错

**A:** 在 Overleaf 上使用本模板：

1. 下载最新版本的 zip 包上传到 Overleaf
2. 在 Menu 中将 Compiler 设置为 XeLaTeX
3. 将 TeX Live version 设置为 2022 或更高
4. 上传字体文件到 `fonts/` 目录（Overleaf 不包含本地字体）

## 格式相关

### Q6: 如何修改封面信息下划线宽度

**A:** 使用 `\caucsetup` 命令调整：

```latex
\caucsetup{
  coverinfowidth=260pt,   % 信息表格宽度（默认：本科240pt，研究生300pt）
  coverlabelwidth=12em,   % 标签下划线宽度（默认：11em）
}
```

### Q7: 如何切换开题报告模式

**A:** 在 `\documentclass` 选项中设置 `period=proposal`：

```latex
\documentclass[degree=bachelor,period=proposal]{cauc_thesis}
```

或使用 `\caucsetup`：

```latex
\caucsetup{period=proposal}
```

开题报告模式下，封面标题和页眉会自动显示"开题报告"字样。

### Q8: 如何使用盲审模式

**A:** 在 `\documentclass` 选项中设置 `blind=true`：

```latex
\documentclass[degree=master-academic,blind=true]{cauc_thesis}
```

盲审模式下，封面上的个人信息（姓名、学号等）会被隐藏。

### Q9: 如何生成 PDF/A 格式

**A:** 在 `\documentclass` 选项中设置 `pdfa=true`：

```latex
\documentclass[degree=doctor,pdfa=true]{cauc_thesis}
```

## 内容相关

### Q10: 如何使用 body/ 目录组织章节

**A:** 模板提供 `body/` 目录用于内容分离。在主文件中使用 `\input` 引用：

```latex
\mainmatter
\input{body/chap01}
\input{body/chap02}
\input{body/chap03}
\input{body/chap04}
\input{body/chap05}
```

每个章节文件只需包含 `\chapter` 和 `\section` 等内容，不需要 `\documentclass` 或导言区。

### Q11: 如何使用配置文件

**A:** 在项目根目录创建 `cauc_thesis.cfg` 文件，模板会自动加载：

```latex
\caucsetup{
  StudentName=张三,
  StudentID=202012345,
  Title=基于XX的YY研究,
  AdvisorName=李四~教授
}
```

这样无需修改 .cls 文件即可设置个人信息。

### Q12: 如何添加答辩评语页

**A:** 研究生论文可使用 `\makereviewpage` 命令添加答辩评语页：

```latex
\makereviewpage
```

此命令仅对研究生（硕士/博士）有效，本科论文调用时不会产生任何输出。

### Q13: 如何检查模板配置

**A:** 在导言区调用 `\cauccheck` 命令：

```latex
\cauccheck
```

编译后查看 .log 文件，会输出当前学位类型、个人信息设置状态、字体加载状态等配置摘要。

## 字体相关

### Q14: 如何使用系统字体而非本地字体

**A:** 有两种方式：

1. 设置 `localfonts=false` 选项，强制使用系统字体：
```latex
\documentclass[degree=bachelor,localfonts=false]{cauc_thesis}
```

2. 删除或清空 `fonts/` 目录，模板会自动回退到系统字体。

`localfonts` 选项支持三种值：
- `auto`（默认）：自动检测 `fonts/` 目录是否存在字体文件
- `true`：强制使用本地字体（缺失时报错）
- `false`：强制使用系统字体（跳过本地字体检测）

### Q15: 如何仅启用行号而不添加草稿水印

**A:** 使用 `lineno` 选项：

```latex
\documentclass[degree=bachelor,lineno]{cauc_thesis}
```

`lineno` 仅启用行号，不添加 DRAFT 水印。`draft` 选项同时启用行号和水印。两者可同时使用。

### Q16: 如何使用 Times 风格的数学字体

**A:** 设置 `mathfont=times` 选项：

```latex
\documentclass[degree=master-academic,mathfont=times]{cauc_thesis}
```

默认数学字体为 Computer Modern（`mathfont=cm`），与正文 Times New Roman 风格不完全匹配。设置 `mathfont=times` 后会加载 `newtxmath` 宏包，使数学公式中的字母与正文 Times 风格一致。

### Q17: Linux/macOS 上编译报字体错误

**A:** Linux 和 macOS 的中文字体与 Windows 不同。建议：

1. 将 Windows 字体文件复制到 `fonts/` 目录
2. 或安装对应的中文字体包（如 `fonts-noto-cjk`）
3. 模板会自动检测并回退到可用字体

### Q18: VS Code LaTeX Workshop 如何配置

**A:** 在 VS Code 的 settings.json 中添加以下配置：

```json
{
  "latex-workshop.latex.tools": [
    {
      "name": "latexmk",
      "command": "latexmk",
      "args": ["-xelatex", "-synctex=1", "-interaction=nonstopmode", "-outdir=build", "%DOC%"]
    }
  ],
  "latex-workshop.latex.recipes": [
    {
      "name": "latexmk + xelatex",
      "tools": ["latexmk"]
    }
  ],
  "latex-workshop.latex.outDir": "%DIR%/build"
}
```

### Q19: Overleaf 上传大文件（字体）失败

**A:** Overleaf 对单文件大小有限制。如果 fonts/ 目录上传失败：
1. 将项目打包为 .zip 上传（Overleaf 会自动解压）
2. 如果 zip 仍然过大，可以删除 fonts/ 目录中的字体文件，设置 `localfonts=false` 使用 Overleaf 的系统字体
3. Overleaf 的 TeX Live 环境已包含部分中文字体

### Q20: 如何在 Linux 上安装中文字体

**A:** Linux 系统需要手动安装中文字体：

```bash
# Ubuntu/Debian
sudo apt install fonts-noto-cjk fonts-wqy-microhei fonts-wqy-zenhei

# Fedora
sudo dnf install google-noto-sans-cjk-fonts wqy-microhei-fonts

# Arch Linux
sudo pacman -S noto-fonts-cjk wqy-microhei
```

或者将 Windows 字体文件复制到 `fonts/` 目录，模板会自动使用本地字体。

### Q21: 如何在 macOS 上使用本模板

**A:** macOS 默认不包含 Windows 中文字体。建议：
1. 将 Windows 字体文件复制到 `fonts/` 目录
2. 或安装 Homebrew Cask 字体：`brew install --cask font-noto-sans-cjk-sc`
3. 设置 `localfonts=true` 强制使用本地字体
