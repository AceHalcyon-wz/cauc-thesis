# CAUC Thesis

[![Compile](https://github.com/AceHalcyon-wz/cauc-thesis/actions/workflows/compile.yml/badge.svg)](https://github.com/AceHalcyon-wz/cauc-thesis/actions/workflows/compile.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

中国民航大学学位论文 LaTeX 模板，一份 `.cls` 覆盖本科、学术学位硕士、专业学位硕士、博士四种学位类型。模板在 [dengjon/cauc-thesis](https://github.com/dengjon/cauc-thesis) 及学校各学位原始模板基础上整理统一，遵循 MIT License。

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

`.latexmkrc` 默认使用 XeLaTeX，因此也可直接运行 `latexmk cauc_thesis.tex`。使用 LuaLaTeX 编译：

```bash
latexmk -lualatex cauc_thesis.tex
```

手动编译需执行完整流程（统一输出到 `build/`）：

```bash
xelatex -output-directory=build cauc_thesis.tex
bibtex build/cauc_thesis
xelatex -output-directory=build cauc_thesis.tex
xelatex -output-directory=build cauc_thesis.tex
```

> 直接运行 `xelatex cauc_thesis.tex` 且不加 `-output-directory` 时，产物会输出到项目根目录。建议始终使用 `latexmk` 或上述命令。

研究生论文若使用符号说明（`\printnomenclature`），需在首次 `xelatex` 与 `bibtex` 之后、最终两次 `xelatex` 之前插入 `makeindex` 步骤：

```bash
xelatex -output-directory=build cauc_thesis.tex
bibtex build/cauc_thesis
makeindex -s nomencl.ist -o build/cauc_thesis.nls build/cauc_thesis.nlo
xelatex -output-directory=build cauc_thesis.tex
xelatex -output-directory=build cauc_thesis.tex
```

`makeindex` 读取首次 `xelatex` 生成的 `.nlo`，随后仍需两次 `xelatex` 以稳定目录与页码。latexmk 会自动处理此步骤，无需手动执行。

> 请勿安装 CTEX 集成包（与 TeX Live 冲突），此处 CTEX 指集成工具包，非 LaTeX 中的 `ctex` 宏包。

### Overleaf 使用

1. 将项目打包为 `.zip` 上传至 Overleaf
2. 在菜单中将编译器设置为 **XeLaTeX**
3. 将主文档设置为 `cauc_thesis.tex`
4. 如需固定字体，确保 `fonts/` 目录中的字体文件完整上传；否则模板会回退到 Overleaf 的 TeX Live 字体

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

> **重要**：LaTeX 会在处理文档类选项时删除其中的空格，因此 ` = ` 两侧不要加空格，否则英文姓名、英文学院名等值中的空格也会被删除。含空格的值应写成 `StudentNameEng={San Zhang}`（`=` 两侧无空格）；也可以改用 `\caucsetup`（pgfkeys 会保留值中的空格）。

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

3. 模板在加载文档类和宏包之前自动读取 `cauc_thesis.cfg`，无需在主文件中手动 `\input`；因此该文件也可用于设置 `pdfa`、`twoside`、`localfonts` 等加载期选项

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

> **引用格式**：本科模式使用 natbib 的 `super` 模式，`\cite{key}` 本身即为上标引用，`\upcite{key}` 与 `\cite{key}` 等价；研究生模式 `\cite{key}` 为内联编号，`\upcite{key}` 输出单层上标引用 `\textsuperscript{\cite{key}}`。两种方式的实际字号一致，避免双重上标导致字号过小。

使用 `\bibliography{reference}` 时，"参考文献"会自动出现在目录中，无需手动添加 `\addcontentsline`。手动添加会导致目录中出现重复条目。

> 示例文件：`examples/bachelor.tex` 包含完整的 BibTeX 演示；研究生示例为避免不同 TeX Live 版本 BibTeX 对大型 bst 的兼容性差异，未放置 `\bibliography`。需要时在 `\backmatter` 后加入 `\bibliography{reference}` 即可。

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

研究生跨页长表使用 `thesislongtable`。表体行直接写在 5 个必选参数之后，**不要**再套一层花括号：

```tex
\begin{thesislongtable}{中文表标题}{English Title}{tab:label}{cc}{表头1 & 表头2}
数据1 & 数据2 \\
数据3 & 数据4 \\
\end{thesislongtable}
```

> 图题位于图下方，表题位于表上方，符合学位论文排版规范。研究生模式下 `thesisfigure`、`thesistable` 和 `thesislongtable` 自动生成中英文双语图题/表题；直接使用 `\caption` 的浮动体仍需手动调用 `\bicaption`。英文图题/表题不会重复写入插图目录和表格目录。

> 各环境的完整参数说明和用法示例请参阅 [使用指南](docs/usage.md)。

### 其他排版环境

模板还提供以下排版环境：

| 环境/命令 | 说明 |
|-----------|------|
| `theorem`/`lemma`/`corollary` 等 | 定理类环境，编号与章节关联 |
| `algorithm`（algorithm2e） | 算法排版，支持 `\KwIn`/`\KwOut`/`\If`/`\For` 等命令（仅研究生） |
| `sidewaystable`/`sidewaysfigure` | 横排图表，内容在页面内旋转 90° 排版 |
| `lstlisting`（listings） | 代码排版，清单标题为“代码 X-1/X.1”，支持中文注释（`(*@中文@*)` 转义） |
| `\appendix` | 附录模式，章节编号自动切换为大写字母 |

> 各环境的详细用法请参阅 [使用指南](docs/usage.md)。

### 论文声明页

- 本科模式默认不生成声明页，添加 `declaration` 选项启用：

```tex
\documentclass[degree=bachelor, declaration, ...]{cauc_thesis}
```

- 研究生模式声明页默认包含在封面流程中，无需额外设置。

### PDF/A 输出

添加 `pdfa` 选项生成 PDF/A-2b 文档：

```tex
\documentclass[degree=bachelor, pdfa, ...]{cauc_thesis}
```

模板在加载 `hyperref` 之前加载 `pdfx`，确保 PDF/A 模式生效。PDF/A 输出需要：

- `colorprofiles` 宏包（TeX Live 2022 及以上通常自带；MiKTeX 需安装 `colorprofiles`）；
- 完整的 `hyperref` 安装（XeLaTeX 还需要 `puenc-greek.def`，部分 MiKTeX 安装缺失）；
- 若发行版没有 `colorprofiles`，需将 `sRGB_IEC61966-2-1_black_scaled.icc` 放在**项目根目录**（不是 `fonts/`），否则模板会给出明确错误提示。

> `pdfx` 在 XeLaTeX 下可能输出 `xdvipdfmx:warning: Could not find any valid object`，且 XMP 元数据默认不完整。若需要严格的 PDF/A 校验或完整元数据，建议使用 LuaLaTeX，并在主文件旁提供 `<主文件名>.xmpdata`（如 `cauc_thesis.xmpdata`）：
>
> ```tex
> \Title{论文中文题目}
> \Author{张三}
> \Subject{中国民航大学学位论文}
> \Keywords{关键词1, 关键词2}
> ```
>
> 模板不自动生成 `.xmpdata`；缺少该文件时 `pdfx` 会提示 `Metadata will be incomplete!`。Overleaf 上使用 PDF/A 还可能受 ICC 色彩配置文件路径限制，建议本地编译。

### 草稿模式

添加 `draft` 选项启用行号和草稿水印，便于论文撰写期间审阅：

```tex
\documentclass[degree=bachelor, draft, ...]{cauc_thesis}
```

水印文字默认为 `DRAFT`，可通过 `\caucsetup` 自定义：

```tex
\caucsetup{draftwatermark=草稿}
```

封面页不参与行号编号，避免行号覆盖封面信息。

### 盲审模式

添加 `blind` 选项启用盲审模式，封面页隐藏学生姓名、学号等个人信息，PDF 元数据中的作者字段也会留空，适用于论文盲审场景：

```tex
\documentclass[degree=doctor, blind, ...]{cauc_thesis}
```

### 双面打印

添加 `twoside` 选项启用双面打印模式，页面布局切换为双面排版，页眉与页码按双面版心居中排列：

```tex
\documentclass[degree=master-academic, twoside, ...]{cauc_thesis}
```

### 章首奇数页起排

添加 `openright` 选项使章节从奇数页（右手页）开始，不足时自动插入空白页。该选项隐含启用双面排版（`twoside`）。所有学位类型默认关闭此选项（与原始模板一致）：

```tex
\documentclass[degree=doctor, openright, ...]{cauc_thesis}
```

> `openright` 和 `twoside` 是**加载期选项**，必须写在 `\documentclass` 或 `cauc_thesis.cfg` 中。在导言区用 `\caucsetup{openright=true}` 无法改变已经加载的文档类选项；单独设置 `openright` 时会自动启用 `twoside`。

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
\caucsetup{coverinfowidth=260pt}   % 调整信息表格宽度（本科默认 240pt，研究生默认 300pt）
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

### 符号说明

研究生模式使用 `\printnomenclature` 生成符号说明，模板会自动将其加入目录（无需手动 `\addcontentsline`）。

### 便捷命令

模板提供以下快捷命令，简化常见操作：

| 命令 | 说明 |
|------|------|
| `\makefrontpages` | 一键生成封面、目录、插图目录、表格目录（不含摘要） |
| `\makereviewpage` | 生成答辩评语页（仅研究生模式） |
| `\cauccheck` | 输出当前配置摘要到 `.log` 文件，便于排查问题 |

### 字数统计

模板提供字数统计脚本，基于 `texcount` 统计正文字数：

```bash
bash scripts/word_count.sh
bash scripts/word_count.sh examples/doctor.tex
```

也可通过 Makefile 调用：

```bash
make wordcount
```

> `texcount` 由 TeX Live 直接提供；MiKTeX 用户需安装 `texcount` 包，并确保 Perl 解释器可用，否则 `texcount.exe` 无法启动。

### 用户配置命令

模板提供 `\caucsetup{key=value}` 命令，允许在导言区微调格式参数，无需修改 settings 文件：

```tex
\caucsetup{linespacing=1.5}
```

常用配置键包括：`linespacing`（行距，所有学位类型默认 1.389 即 baselineskip=20pt）、`blankpage`（空白页样式）、`headeronplain`（章节起始页页眉）、`coverinfowidth`/`coverlabelwidth`（封面尺寸），以及 `StudentName`、`Title` 等个人信息字段。

> **加载期选项**：`degree`、`localfonts`、`mathfont`、`pdfa`、`twoside`、`openright` 会影响文档类或宏包加载，必须写在 `\documentclass` 选项或 `cauc_thesis.cfg` 中（配置文件在文档类与宏包加载前读取）。在 `\documentclass` 之后的导言区用 `\caucsetup` 设置这些键不会生效；单独设置 `openright` 会自动启用 `twoside`。`declaration`、`draft`、`blind`、`lineno`、`linespacing`、`Type`、`period`、`headeronplain`、`blankpage` 和目录开关则可以在导言区设置。

> **行距与间距说明**：所有学位类型正文行距均为 1.389（baselineskip=20pt），摘要行距均为 1.389（baselineskip=20pt），与原始模板规范一致。摘要标题与正文间距：本科由 `\begin{center}` 排版标题后手动添加 21pt 间距，研究生由 `\chapter*` 的 afterskip=30pt 自动提供。关键词与摘要正文间距：本科空一行，研究生仅换行，与原始模板规范一致。摘要标题字体：中文摘要标题使用黑体（\heiti），英文摘要标题使用粗体（\textbf），与原始模板规范一致。英文关键词字体：本科和硕士使用宋体（\songti），博士使用默认 Times New Roman，与原始模板规范一致。页码格式：封面不显示页码，也不生成 PDF 页面锚点；封面结束后前置部分从罗马数字 I 重新编号，因此研究生摘要为第 I 页，目录、插图目录、表格目录和符号说明依次编号。正文从阿拉伯数字 1 开始。本科前置页面不显示页码（与原始模板规范一致，原始模板本科前置页面使用 `\pagestyle{empty}`），但内部仍使用罗马数字编号以避免 PDF 页面锚点重名。正文字号：所有学位类型正文均为小四号（12pt）。目录深度：本科 tocdepth=2（目录显示到 subsection），研究生 tocdepth=4（目录显示到 paragraph），与原始模板规范一致。

> **字体管理说明**：模板使用 `fontset=none` 选项加载 ctex，由模板自行管理所有 CJK 字体定义，避免与 ctex 默认字体集冲突产生编译警告。宋体斜体自动映射为楷体，避免 "Font shape undefined" 警告。`localfonts=true` 要求 `fonts/` 中的中文与 Times 字体完整，缺失时直接报错而不会静默回退；`localfonts=auto` 才会在字体不完整时回退至系统字体。研究生四级标题（`\subsubsubsection`）采用换行标题格式（标题独占一行，正文另起一行），与原始模板规范一致。

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
| `make lintindent` | 缩进与行尾检查 |
| `make wordcount` | 统计正文字数 |
| `make view` | 编译并打开 PDF |
| `make check` | 编译所有学位类型示例和主模板，任一失败返回非零 |

> Windows 默认不提供 `make`。未安装 make 时可直接运行 `scripts/check.ps1`（编译检查）、`scripts/check_indent.ps1`（缩进检查）或 `scripts/word_count.sh`（需 bash）。

### PDF 关键词

通过 `Keywords` 和 `KeywordsEng` 选项设置 PDF 元数据中的关键词：

```tex
\documentclass[degree=bachelor, Keywords=关键词1;关键词2, KeywordsEng=keyword1;keyword2, ...]{cauc_thesis}
```

## 选项参考

模板支持以下主要功能选项：`degree`（学位类型）、`Type`（本科论文/设计）、`pdfa`、`declaration`、`draft`、`lineno`、`blind`、`twoside`、`openright`、`headeronplain`（章节起始页页眉）、`nocontents`/`nofigures`/`notables`、`period`（论文阶段）、`localfonts`、`mathfont`。

个人信息选项包括：`StudentName`、`StudentID`、`AdvisorName`、`Major`、`Department`、`Title`、`TitleEng`、`SubmitYear`/`SubmitMonth`、`DefenseYear`/`DefenseMonth`、`Keywords`/`KeywordsEng` 等。

> `mathfont=times` 会加载 `newtxmath`；TeX Live 需安装 `texlive-fonts-extra`，MiKTeX 会自动安装 `newtx`。
>
> 完整的选项列表、类型、默认值及适用学位请参阅 [使用指南](docs/usage.md)。

## 文件结构

```
cauc-thesis/
├── cauc_thesis.cls              统一文档类，通过 degree 选项切换学位类型
├── cauc_thesis.tex              论文主文件
├── cauc_thesis.cfg.example      配置文件模板（复制为 cauc_thesis.cfg 使用）
├── Makefile                     构建脚本（`make` / `make clean` / `make wordcount`）
├── .latexmkrc                   latexmk 编译配置
├── .gitattributes               行尾与二进制文件属性
├── gbt7714-2005-numerical.bst   国标参考文献样式（本科）
├── gbt7714-numerical.bst        国标参考文献样式（研究生）
├── reference.bib                参考文献数据库
├── pic/                         校徽与校名图片
├── figures/                     论文插图目录
├── fonts/                       嵌入字体文件（宋体、黑体、楷体、隶书、Times 等）
├── build/                       编译产物输出目录（PDF、辅助文件等，已 gitignore）
├── scripts/                     工具脚本
│   ├── word_count.sh            字数统计脚本
│   ├── check_indent.sh          缩进检查脚本（bash）
│   ├── check_indent.ps1         缩进检查脚本（Windows PowerShell）
│   ├── check.sh                 全量编译检查脚本（bash）
│   └── check.ps1                全量编译检查脚本（Windows PowerShell）
├── settings/                    配置模块
│   ├── packages.tex             宏包导入
│   ├── fonts.tex                字体配置与字体命令重定义
│   ├── format.tex               页面格式（页眉、行距、页边距等）
│   ├── contents.tex             目录格式设置
│   ├── commands.tex             自定义与重定义命令
│   └── cover.tex                封面页（按学位类型自动切换）
├── body/                        章节内容（各章独立 .tex 文件，含 acknowledgement.tex）
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

模板优先从 `fonts/` 目录加载本地字体文件。`localfonts=auto`（默认）在字体不完整时会回退至系统字体（SimSun、SimHei、KaiTi 等）并发出编译警告；`localfonts=true` 则要求字体完整，缺失时直接报错而不会静默回退。如需使用本地字体，请将字体文件放入 `fonts/` 目录。

> Windows 系统通常已预装所需字体，回退机制可正常工作。Linux/macOS 会优先使用 Noto CJK，其次使用 TeX Live 自带的 Fandol 字体（`texlive-lang-chinese`）。

**参考文献显示问号**

需要完整编译流程（`xelatex → bibtex → xelatex → xelatex`），或使用 `latexmk` 自动处理。

**CTEX 集成包与 TeX Live 冲突**

请使用 TeX Live 而非 CTEX 集成包。此处 CTEX 指集成工具包，非 LaTeX 中的 `ctex` 宏包。

**Overleaf 字体上传**

在 Overleaf 上使用时，如需固定本地字体，需将 `fonts/` 目录中的所有字体文件完整上传；不上传时模板会回退到 Overleaf 的 TeX Live 字体。Overleaf 文件系统区分大小写，字体文件名需使用小写（如 `simsun.ttf` 而非 `SimSun.ttf`），否则模板无法正确加载字体。

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
