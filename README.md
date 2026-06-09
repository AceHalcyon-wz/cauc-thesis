# CAUC Thesis

[![Compile](https://github.com/dengjon/cauc-thesis/actions/workflows/compile.yml/badge.svg)](https://github.com/dengjon/cauc-thesis/actions/workflows/compile.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

中国民航大学学位论文 LaTeX 模板，一份 `.cls` 覆盖本科、学术学位硕士、专业学位硕士、博士四种学位类型。

## 简介

本模板是中国民航大学学位论文的统一 LaTeX 模板，通过 `\documentclass` 的 `degree` 选项一键切换学位类型：

| `degree` 选项值 | 学位类型 |
|---|---|
| `bachelor` | 本科毕业设计（论文） |
| `master-academic` | 学术学位硕士 |
| `master-professional` | 专业学位硕士 |
| `doctor` | 博士学位 |

## 快速开始

### 环境要求

- TeX Live 2022 及以上版本，或 MiKTeX
- XeLaTeX 或 LuaLaTeX 引擎

### 编译

推荐使用 latexmk 自动编译，编译产物统一输出到 `build/` 目录：

```bash
latexmk -xelatex cauc_thesis.tex
```

使用 LuaLaTeX 编译：

```bash
latexmk -lualatex cauc_thesis.tex
```

手动编译需执行完整流程：

```bash
xelatex cauc_thesis.tex
bibtex build/cauc_thesis
xelatex cauc_thesis.tex
xelatex cauc_thesis.tex
```

> 手动编译时，辅助文件和 PDF 输出在 `build/` 目录中（由 `.latexmkrc` 配置）。若直接使用 `xelatex` 而非 `latexmk`，编译产物将输出到项目根目录。

研究生论文若使用符号说明（`\printnomenclature`），需在 `bibtex` 之后额外执行：

```bash
makeindex -s nomencl.ist -o build/cauc_thesis.nls build/cauc_thesis.nlo
xelatex cauc_thesis.tex
```

latexmk 会自动处理此步骤，无需手动执行。

> 请勿安装 CTEX 集成包（与 TeX Live 冲突），此处 CTEX 指集成工具包，非 LaTeX 中的 `ctex` 宏包。

### Overleaf 使用

1. 将项目打包为 `.zip` 上传至 Overleaf
2. 在菜单中将编译器设置为 **XeLaTeX**
3. 将主文档设置为 `cauc_thesis.tex`
4. 确保 `fonts/` 目录中的字体文件完整上传

> Overleaf 不支持自定义输出目录，编译产物将输出到项目根目录。本地编译时，`latexmk` 会自动将产物输出到 `build/` 目录。

### Dev Container 使用

项目提供 Dev Container 配置，支持在 GitHub Codespace 或本地 VS Code 中一键启动开发环境：

1. 在 GitHub 仓库页面点击 **Code → Codespaces → New codespace**
2. 或在本地 VS Code 中执行 **Dev Containers: Reopen in Container**

容器内预装 TeX Live、中文字体和 LaTeX Workshop 插件，可直接使用 `latexmk` 编译论文。

## 使用说明

### 学位类型选择

在 `\documentclass` 中通过 `degree` 选项指定：

```tex
\documentclass[degree=bachelor, ...]{cauc_thesis}
\documentclass[degree=master-academic, ...]{cauc_thesis}
\documentclass[degree=master-professional, ...]{cauc_thesis}
\documentclass[degree=doctor, ...]{cauc_thesis}
```

### 个人信息填写

个人信息通过 `\documentclass` 选项集中填写，模板自动补全下划线：

```tex
\documentclass[degree=bachelor, StudentName=姓名, ...]{cauc_thesis}
```

如需调整下划线宽度，可在 `settings/cover.tex` 中修改对应的 `tabularx` 或 `\underlineFixlen` 环境。

也可在导言区通过 `\caucsetup` 设置个人信息：

```tex
\caucsetup{StudentName=姓名, Title=论文标题, Major=专业}
```

日期字段（`SubmitYear`、`SubmitMonth`）如未设置，将自动使用编译时的当前日期。

### 配置文件

模板支持通过 `cauc_thesis.cfg` 文件管理个人信息，避免将个人信息写入主文件：

1. 复制 `cauc_thesis.cfg.example` 为 `cauc_thesis.cfg`
2. 在其中使用 `\caucsetup{...}` 设置个人信息：

```tex
% cauc_thesis.cfg
\caucsetup{
  StudentName=张三,
  StudentID=2023010001,
  AdvisorName=李教授,
  Major=计算机科学与技术,
  Title=论文标题,
}
```

3. 模板编译时自动加载 `cauc_thesis.cfg`，无需在主文件中手动 `\input`

> `cauc_thesis.cfg` 已加入 `.gitignore`，可将个人信息与模板代码分离，避免提交到版本库。项目提供 `cauc_thesis.cfg.example` 作为模板参考，首次使用时复制为 `cauc_thesis.cfg` 即可。

### 内容分离

模板提供 `body/` 目录用于存放各章节内容，将正文与主文件分离：

- `body/` 目录存放各章节的 `.tex` 文件
- 主文件通过 `\input{body/chap01}` 引用各章节
- 模板提供 `body/chap01.tex` ~ `body/chap05.tex` 示例文件

示例目录结构：

```
body/
├── chap01.tex    第一章
├── chap02.tex    第二章
├── chap03.tex    第三章
├── chap04.tex    第四章
└── chap05.tex    第五章
```

### 参考文献管理

模板使用国标参考文献样式，本科模式使用 `gbt7714-2005-numerical` 样式（GB/T 7714-2005），研究生模式使用 `gbt7714-numerical` 样式（GB/T 7714-2015），模板会根据学位类型自动选择：

1. 在 `reference.bib` 中添加 BibTeX 条目
2. 在正文中使用 `\cite{key}` 引用
3. 编译时需完整执行 `xelatex → bibtex → xelatex → xelatex`（latexmk 自动处理）

> **`\upcite` 引用格式**：所有学位类型下 `\upcite{key}` 均输出双重上标引用 `\textsuperscript{\textsuperscript{\cite{key}}}`，与原始模板规范一致。

使用 `\bibliography{reference}` 时，"参考文献"会自动出现在目录中，无需手动添加 `\addcontentsline`。手动添加会导致目录中出现重复条目。

### 图表环境

模板提供 `thesisfigure` 和 `thesistable` 环境用于排版图和表格，支持中英文双语标题、自定义宽度、图注/表注等功能。本科模式还提供 `\threelinetable` 快捷命令（标准三线表：顶线、中线、底线），研究生模式提供 `thesislongtable` 跨页长表环境。

> **编号格式差异**：图编号所有学位类型均使用 `-` 分隔（如 `1-1`）；表编号和公式编号本科使用 `-` 分隔（如 `1-1`），研究生使用 `.` 分隔（如 `1.1`）。模板自动处理，无需手动干预。

> **子图包差异**：本模板使用 `subcaption` 宏包（提供 `subfigure`/`subtable` 环境），与原始模板使用的 `subfig` 宏包（提供 `\subfloat` 命令）不兼容。从原始模板迁移时，需将 `\subfloat[标题]{内容}` 改为 `\begin{subfigure}{宽度}\caption{标题}\end{subfigure}`。

```tex
\begin{thesisfigure}{中文图标题}{English Title}{fig:label}
    \includegraphics[width=\linewidth]{example.png}
\end{thesisfigure}

\begin{thesistable}{中文表标题}{English Title}{tab:label}{cc}{
    \toprule
    表头1 & 表头2 \\
    \midrule
    数据1 & 数据2 \\
    \bottomrule
}
\end{thesistable}
```

> 各环境的完整参数说明和用法示例请参阅 [使用指南](docs/usage.md)。

### 其他排版环境

模板还提供以下排版环境：

| 环境/命令 | 说明 |
|-----------|------|
| `theorem`/`lemma`/`corollary` 等 | 定理类环境，编号与章节关联 |
| `algorithm`（algorithm2e） | 算法排版，支持 `\KwIn`/`\KwOut`/`\If`/`\For` 等命令 |
| `sidewaystable`/`sidewaysfigure` | 横排图表，内容以横向页面显示 |
| `lstlisting`（listings） | 代码排版，支持中文注释（`(*@中文@*)` 转义） |
| `\appendix` | 附录模式，章节编号自动切换为大写字母 |

> 各环境的详细用法请参阅 [使用指南](docs/usage.md)。

### 论文声明页

- 本科模式默认不生成声明页，添加 `declaration` 选项启用：

```tex
\documentclass[degree=bachelor, declaration, ...]{cauc_thesis}
```

- 研究生模式声明页默认包含在封面中，无需额外设置。

### PDF/A 输出

添加 `pdfa` 选项生成符合 PDF/A-2b 标准的归档文档：

```tex
\documentclass[degree=bachelor, pdfa, ...]{cauc_thesis}
```

> `pdfa` 选项建议在本地编译使用，Overleaf 可能因 ICC 色彩配置文件路径问题无法正常工作。

### 草稿模式

添加 `draft` 选项启用行号和草稿水印，便于论文撰写期间审阅：

```tex
\documentclass[degree=bachelor, draft, ...]{cauc_thesis}
```

水印文字默认为 `DRAFT`，可通过 `\caucsetup` 自定义：

```tex
\caucsetup{draftwatermark=草稿}
```

### 盲审模式

添加 `blind` 选项启用盲审模式，封面页隐藏学生姓名、学号等个人信息，摘要页隐藏作者信息，适用于论文盲审场景：

```tex
\documentclass[degree=doctor, blind, ...]{cauc_thesis}
```

### 双面打印

添加 `twoside` 选项启用双面打印模式，页面布局切换为双面排版，页码在奇数页右侧、偶数页左侧，页眉内容相应调整：

```tex
\documentclass[degree=master-academic, twoside, ...]{cauc_thesis}
```

### 章首奇数页起排

添加 `openright` 选项使章节从奇数页（右手页）开始，不足时自动插入空白页。所有学位类型默认关闭此选项（与原始模板一致）：

```tex
\documentclass[degree=doctor, openright, ...]{cauc_thesis}
```

如需启用此行为：

```tex
\caucsetup{openright=true}
```

### 空白页样式

双面排版时插入的空白页默认不显示页眉、页脚和页码。如需空白页正常显示页眉页脚，可通过 `\caucsetup` 设置：

```tex
\caucsetup{blankpage=true}
```

### 章节起始页页眉

默认情况下，章节起始页（如每章第一页）显示页眉（与原始模板一致）。如需隐藏章节起始页的页眉，可通过 `\caucsetup` 设置：

```tex
\caucsetup{headeronplain=false}
```

或在 `\documentclass` 中使用 `headeronplain=false` 选项：

```tex
\documentclass[degree=bachelor, headeronplain=false, ...]{cauc_thesis}
```

### 本科论文/设计切换

本科模式通过 `Type` 选项切换论文和设计类型，影响封面标题文字：

```tex
\documentclass[degree=bachelor, Type=thesis, ...]{cauc_thesis}
\documentclass[degree=bachelor, Type=design, ...]{cauc_thesis}
```

- `Type=thesis`（默认）：封面显示"本科毕业设计（论文）"
- `Type=design`：封面显示"本科毕业设计"

### 封面尺寸调整

封面信息区域的宽度可通过 `\caucsetup` 调整，适配不同长度的姓名、专业等信息：

```tex
\caucsetup{coverinfowidth=260pt}   % 调整信息表格宽度（默认 240pt）
\caucsetup{coverlabelwidth=12em}    % 调整标签下划线宽度（默认 11em）
```

### 目录开关

模板提供三个布尔选项控制是否生成目录、插图目录和表格目录，默认全部启用。如需禁用：

```tex
\caucsetup{listfigures=false}
\caucsetup{listtables=false}
\caucsetup{listcontents=false}
```

或在 `\documentclass` 中使用 `nofigures`、`notables`、`nocontents` 选项：

```tex
\documentclass[degree=bachelor, nofigures, notables, ...]{cauc_thesis}
```

同时提供对应的用户命令，替代 `\tableofcontents`、`\listoffigures`、`\listoftables`：

```tex
\maketableofcontents
\makelistoffigures
\makelistoftables
```

### 前置页面一键生成

模板提供 `\makefrontmatter` 命令，一键生成目录、插图目录、表格目录：

```tex
\makefrontmatter
```

该命令根据 `nocontents`、`nofigures`、`notables` 选项自动决定生成哪些目录，各目录后自动换页。也可单独使用 `\maketableofcontents`、`\makelistoffigures`、`\makelistoftables` 命令。

### 便捷命令

模板提供以下快捷命令，简化常见操作：

| 命令 | 说明 |
|------|------|
| `\makefrontpages` | 一键生成封面和前置页面（声明、摘要、目录等） |
| `\makereviewpage` | 生成答辩评语页（仅研究生模式） |
| `\cauccheck` | 输出当前配置摘要到 `.log` 文件，便于排查问题 |

### 字数统计

模板提供字数统计脚本，基于 `texcount` 统计正文字数：

```bash
bash scripts/word_count.sh
bash scripts/word_count.sh doctor.tex
```

也可通过 Makefile 调用：

```bash
make wordcount
```

### 用户配置命令

模板提供 `\caucsetup{key=value}` 命令，允许在导言区微调格式参数，无需修改 settings 文件：

```tex
\caucsetup{linespacing=1.5}
```

常用配置键包括：`linespacing`（行距，所有学位类型默认 1.389 即 baselineskip=20pt）、`localfonts`（字体策略）、`mathfont`（数学字体）、`openright`（奇数页起排）、`blankpage`（空白页样式）、`headeronplain`（章节起始页页眉）、`coverinfowidth`/`coverlabelwidth`（封面尺寸），以及 `StudentName`、`Title` 等个人信息字段。

> **行距与间距说明**：所有学位类型正文行距均为 1.389（baselineskip=20pt），摘要行距均为 1.389（baselineskip=20pt），与原始模板规范一致。摘要标题与正文间距：本科由 `\begin{center}` 排版标题后手动添加 21pt 间距，研究生由 `\chapter*` 的 afterskip=30pt 自动提供。关键词与摘要正文间距：本科使用 `\newline\newline`，研究生使用 `\newline`，与原始模板规范一致。摘要标题字体：中文摘要标题使用黑体（\heiti），英文摘要标题使用粗体（\textbf），与原始模板规范一致。英文关键词字体：本科和硕士使用宋体（\songti），博士使用默认 Times New Roman，与原始模板规范一致。页码格式：研究生前置页面使用罗马数字页码（I, II, ...），正文从阿拉伯数字 1 开始；本科前置页面不显示页码（与原始模板规范一致，原始模板本科前置页面使用 `\pagestyle{empty}`），正文从阿拉伯数字 1 开始。正文字号：所有学位类型正文均为小四号（12pt）。目录深度：本科 tocdepth=2（目录显示到 subsection），研究生 tocdepth=4（目录显示到 paragraph），与原始模板规范一致。

> **字体管理说明**：模板使用 `fontset=none` 选项加载 ctex，由模板自行管理所有 CJK 字体定义，避免与 ctex 默认字体集冲突产生编译警告。宋体斜体自动映射为楷体，避免 "Font shape undefined" 警告。研究生四级标题（`\subsubsubsection`）采用换行标题格式（标题独占一行，正文另起一行），与原始模板规范一致。

> 完整的配置键列表及说明请参阅 [使用指南](docs/usage.md)。

### Makefile 目标

| 目标 | 说明 |
|------|------|
| `make` / `make all` | 编译论文 |
| `make bachelor` | 编译本科示例 |
| `make master-academic` | 编译学术硕士示例 |
| `make master-professional` | 编译专业硕士示例 |
| `make doctor` | 编译博士示例 |
| `make clean` | 删除中间文件（保留 PDF） |
| `make distclean` | 深度清理，删除 `build/` 目录（含 PDF） |
| `make lint` | LaTeX 代码检查（chktex） |
| `make wordcount` | 统计正文字数 |
| `make view` | 编译并打开 PDF |
| `make check` | 编译所有学位类型示例并检查是否成功 |

### PDF 关键词

通过 `Keywords` 和 `KeywordsEng` 选项设置 PDF 元数据中的关键词：

```tex
\documentclass[degree=bachelor, Keywords=关键词1;关键词2, KeywordsEng=keyword1;keyword2, ...]{cauc_thesis}
```

## 选项参考

模板支持以下主要功能选项：`degree`（学位类型）、`Type`（本科论文/设计）、`pdfa`、`declaration`、`draft`、`lineno`、`blind`、`twoside`、`openright`、`headeronplain`（章节起始页页眉）、`nocontents`/`nofigures`/`notables`、`period`（论文阶段）、`localfonts`、`mathfont`。

个人信息选项包括：`StudentName`、`StudentID`、`AdvisorName`、`Major`、`Department`、`Title`、`TitleEng`、`SubmitYear`/`SubmitMonth`、`DefenseYear`/`DefenseMonth`、`Keywords`/`KeywordsEng` 等。

> 完整的选项列表、类型、默认值及适用学位请参阅 [使用指南](docs/usage.md)。

## 文件结构

```
cauc-thesis/
├── cauc_thesis.cls              统一文档类，通过 degree 选项切换学位类型
├── cauc_thesis.tex              论文主文件
├── cauc_thesis.cfg.example      配置文件模板（复制为 cauc_thesis.cfg 使用）
├── Makefile                     构建脚本（`make` / `make clean` / `make wordcount`）
├── .latexmkrc                   latexmk 编译配置
├── gbt7714-2005-numerical.bst   国标参考文献样式（本科）
├── gbt7714-numerical.bst        国标参考文献样式（研究生）
├── reference.bib                参考文献数据库
├── pic/                         校徽与校名图片
├── figures/                     论文插图目录
├── fonts/                       嵌入字体文件（宋体、黑体、楷体、隶书、Times 等）
├── build/                       编译产物输出目录（PDF、辅助文件等，已 gitignore）
├── scripts/                     工具脚本
│   ├── word_count.sh            字数统计脚本
│   └── check_indent.ps1         缩进检查脚本（Windows）
├── settings/                    配置模块
│   ├── packages.tex             宏包导入
│   ├── fonts.tex                字体配置与字体命令重定义
│   ├── format.tex               页面格式（页眉、行距、页边距等）
│   ├── contents.tex             目录格式设置
│   ├── commands.tex             自定义与重定义命令
│   └── cover.tex                封面页（按学位类型自动切换）
├── body/                        章节内容（各章独立 .tex 文件）
├── examples/                    各学位类型示例文件
│   ├── bachelor.tex             本科毕业设计示例
│   ├── master-academic.tex      学术学位硕士示例
│   ├── master-professional.tex  专业学位硕士示例
│   └── doctor.tex               博士学位示例
├── docs/                        文档
│   ├── FAQ.md                   常见问题
│   └── usage.md                 使用指南
├── .devcontainer/               Dev Container 配置（GitHub Codespace）
├── .github/                     GitHub Actions CI/CD 配置
└── LICENSE                      MIT License
```

## 常见问题

**编译报错"字体未找到"**

模板优先从 `fonts/` 目录加载本地字体文件。若该目录缺失或字体文件不完整，模板会自动回退至系统字体（SimSun、SimHei、KaiTi 等）并发出编译警告。如需使用本地字体，请将字体文件放入 `fonts/` 目录。

> Windows 系统通常已预装所需字体，回退机制可正常工作。Linux 系统可能需要手动安装中文字体包（如 `fonts-wqy-microhei`）。

**参考文献显示问号**

需要完整编译流程（`xelatex → bibtex → xelatex → xelatex`），或使用 `latexmk` 自动处理。

**CTEX 集成包与 TeX Live 冲突**

请使用 TeX Live 而非 CTEX 集成包。此处 CTEX 指集成工具包，非 LaTeX 中的 `ctex` 宏包。

**Overleaf 字体上传**

在 Overleaf 上使用时，必须将 `fonts/` 目录中的所有字体文件完整上传。Overleaf 文件系统区分大小写，字体文件名需使用小写（如 `simsun.ttf` 而非 `SimSun.ttf`），否则模板无法正确加载字体。

**研究生符号说明编译**

研究生论文使用 `\printnomenclature` 生成符号说明时，需要完整的编译链（`xelatex → bibtex → makeindex → xelatex → xelatex`），手动编译需额外执行 `makeindex` 步骤。推荐使用 `latexmk` 自动处理，无需手动执行 `makeindex` 命令。

更多问题请参阅 [FAQ](docs/FAQ.md)，详细使用说明请参阅 [使用指南](docs/usage.md)。

## 贡献指南

欢迎提交 Issue 和 Pull Request 参与贡献。

- **Bug 报告**：请使用 [Bug Report 模板](.github/ISSUE_TEMPLATE/bug_report.md)，包含复现步骤、预期行为和实际行为
- **功能建议**：请使用 [Feature Request 模板](.github/ISSUE_TEMPLATE/feature_request.md)，描述需求场景和期望方案
- **代码贡献**： Fork 本仓库，创建功能分支，提交 PR 前请确保本地编译通过，并遵循现有代码风格

## License

[MIT License](LICENSE)
