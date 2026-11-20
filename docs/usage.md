# 使用手册

## 快速开始

### 环境要求

- TeX Live 2022 或更高版本，或 MiKTeX
- XeLaTeX 引擎（推荐）或 LuaLaTeX
- 推荐编辑器：VS Code + LaTeX Workshop 插件

> PDF/A 输出建议使用 LuaLaTeX；XeLaTeX + `pdfx` 的 ICC 嵌入支持有限，详见后文“PDF/A 输出”。

### 最小编译流程

1. 克隆或下载模板
2. 编辑 `cauc_thesis.tex`，填写个人信息
3. 运行编译命令：

```bash
latexmk -xelatex cauc_thesis
```

编译产物（PDF 及辅助文件）统一输出到 `build/` 目录。

## 文档类选项

在 `\documentclass` 中设置选项：

```latex
\documentclass[选项1=值1,选项2=值2]{cauc_thesis}
```

### 必选选项

| 选项 | 可选值 | 说明 |
|------|--------|------|
| `degree` | `bachelor` | 本科 |
| | `master-academic` | 学术学位硕士 |
| | `master-professional` | 专业学位硕士 |
| | `doctor` | 博士学位 |

### 可选选项

| 选项 | 默认值 | 说明 |
|------|--------|------|
| `Type` | `thesis` | 本科论文类型（thesis/design） |
| `period` | `final` | 学位阶段（final/proposal） |
| `blind` | `false` | 盲审模式 |
| `draft` | `false` | 草稿模式（添加 DRAFT 水印，封面不显示行号） |
| `lineno` | `false` | 仅启用行号，不添加草稿水印 |
| `pdfa` | `false` | PDF/A-2b 输出 |
| `twoside` | `false` | 双面打印模式 |
| `openright` | `false` | 章节从奇数页开始（自动启用 `twoside`） |
| `declaration` | `false` | 本科是否包含原创性声明页（研究生默认包含） |
| `headeronplain` | `true` | 章节起始页是否显示页眉 |
| `nocontents` | 未设置 | 关闭目录 |
| `nofigures` | 未设置 | 关闭插图目录 |
| `notables` | 未设置 | 关闭表格目录 |
| `localfonts` | `auto` | 字体加载策略（auto/true/false） |
| `mathfont` | `cm` | 数学字体（cm/times，times 需 `newtxmath`） |

### 行距说明

所有学位类型正文行距均为 1.389（baselineskip=20pt），摘要行距均为 1.389（baselineskip=20pt），与原始模板规范一致。可通过 `\caucsetup{linespacing=值}` 覆盖默认行距。

摘要标题与正文间距：本科由 `\begin{center}` 排版标题后手动添加 21pt 间距，研究生由 `\chapter*` 的 afterskip=30pt 自动提供，无需手动间距。关键词与摘要正文间距：本科空一行，研究生仅换行，与原始模板规范一致。摘要标题字体：中文摘要标题使用黑体（\heiti），英文摘要标题使用粗体（\textbf），与原始模板规范一致。英文关键词字体：本科和硕士使用宋体（\songti），博士使用默认 Times New Roman，与原始模板规范一致。

宋体斜体替代：宋体（SimSun）无斜体变体，模板自动将宋体斜体映射为楷体（KaiTi），避免编译时出现 "Font shape undefined" 警告。

字体管理：模板使用 `fontset=none` 选项加载 ctex，由模板自行管理所有 CJK 字体定义（包括主字体、无衬线字体、等宽字体），避免与 ctex 默认字体集冲突产生 "Redefining CJKfamily" 编译警告。

研究生四级标题：`\subsubsubsection` 采用换行标题格式（标题独占一行，正文另起一行），与原始模板规范一致。本科未定义 subsubsection 格式，使用 ctex 默认值。

目录深度：本科 tocdepth=2（目录显示到 subsection），研究生 tocdepth=4（目录显示到 paragraph），与原始模板规范一致。原始模板中研究生 tocdepth 在 commands.tex 中设为 4，覆盖 contents.tex 中的初始值 2。

页码格式：封面不显示页码，也不生成 PDF 页面锚点；封面结束后前置部分从罗马数字 I 重新编号，研究生摘要为第 I 页，目录、插图目录、表格目录和符号说明依次编号。正文从阿拉伯数字 1 开始编号。本科前置页面不显示页码（与原始模板规范一致，原始模板本科前置页面使用 `\pagestyle{empty}`），内部仍使用罗马数字编号以避免 PDF 页面锚点重名。正文字号：所有学位类型正文均为小四号（12pt），与原始模板规范一致。

### 示例

```latex
\documentclass[degree=bachelor]{cauc_thesis}
\documentclass[degree=master-academic,blind=true]{cauc_thesis}
\documentclass[degree=doctor,pdfa=true,twoside=true]{cauc_thesis}
\documentclass[degree=bachelor,period=proposal]{cauc_thesis}
```

> **选项空格**：`\documentclass` 选项由 LaTeX 预处理，`=` 两侧的空格会导致值中的空格被删除。含空格的值请写成 `StudentNameEng={San Zhang}`（`=` 两侧无空格），或改用 `\caucsetup`。

## 个人信息设置

### 方式一：\documentclass 选项

```latex
\documentclass[
  degree=bachelor,
  StudentName=张三,
  StudentID=202012345,
  Title=基于XX的YY研究,
  AdvisorName=李四~教授
]{cauc_thesis}
```

> 注意 `degree=bachelor` 中 `=` 两侧不要加空格；英文名等含空格的值写成 `StudentNameEng={San Zhang}`。

### 方式二：\caucsetup 命令

在导言区使用：

```latex
\caucsetup{
  StudentName=张三,
  StudentID=202012345,
  Title=基于XX的YY研究,
  TitleEng=Research on YY Based on XX,
  AdvisorName=李四~教授,
  Major=计算机科学与技术,
  Department=计算机科学与技术学院,
  Keywords=关键词1；关键词2；关键词3,
  KeywordsEng=keyword1; keyword2; keyword3
}
```

### 布尔选项

以下布尔选项可在 `\caucsetup` 中设置。其中 `declaration`、`draft`、`blind`、`headeronplain`、`lineno` 也可直接写在 `\documentclass` 选项中；`pdfa`、`twoside`、`openright` 属于加载期选项，必须写在 `\documentclass` 或 `cauc_thesis.cfg` 中（`openright` 会自动启用 `twoside`）。`blankpage`、`listcontents`、`listfigures`、`listtables` 仅在 `\caucsetup` 中可用；`\documentclass` 中可使用 `nocontents`、`nofigures`、`notables` 关闭对应目录。

| 选项 | 默认值 | 说明 |
|------|--------|------|
| `declaration` | `false` | 是否包含原创性声明和使用授权页（研究生默认包含，无需设置） |
| `draft` | `false` | 草稿模式，显示行号和 DRAFT 水印（封面不显示行号） |
| `blind` | `false` | 盲审模式，隐藏个人信息 |
| `pdfa` | `false` | 生成 PDF/A-2b 文档 |
| `twoside` | `false` | 双面打印模式 |
| `openright` | `false` | 章节从奇数页开始（自动启用 `twoside`） |
| `blankpage` | `false` | 双面排版时空白页是否显示页眉页脚（仅 `\caucsetup`） |
| `headeronplain` | `true` | 章节起始页是否显示页眉（默认 true 与原始模板一致） |
| `listcontents` | `true` | 是否生成目录（仅 `\caucsetup`） |
| `listfigures` | `true` | 是否生成插图目录（仅 `\caucsetup`） |
| `listtables` | `true` | 是否生成表格目录（仅 `\caucsetup`） |
| `lineno` | `false` | 启用行号 |

> **加载期选项**：`degree`、`localfonts`、`mathfont`、`pdfa`、`twoside`、`openright` 会影响文档类或宏包加载，必须写在 `\documentclass` 或 `cauc_thesis.cfg` 中；在 `\documentclass` 之后的导言区用 `\caucsetup` 设置不会生效（`openright` 会自动启用 `twoside`）。其余键（`declaration`、`draft`、`blind`、`lineno`、`linespacing`、`Type`、`period`、`headeronplain`、`blankpage`、目录开关等）可以在导言区或 `cauc_thesis.cfg` 中设置。

### 方式三：配置文件

创建 `cauc_thesis.cfg` 文件：

```latex
\caucsetup{
  StudentName=张三,
  StudentID=202012345,
  Title=基于XX的YY研究
}
```

模板在加载文档类和宏包之前自动读取此文件，无需修改 .cls；因此也可在此设置 `pdfa`、`twoside`、`localfonts` 等加载期选项。

### 完整字段列表

| 字段 | 说明 | 适用学位 |
|------|------|----------|
| `StudentName` | 学生姓名 | 全部 |
| `StudentNameEng` | 学生姓名（英文） | 研究生（本科设置时忽略并警告） |
| `StudentID` | 学号 | 全部 |
| `Title` | 中文论文标题 | 全部 |
| `TitleEng` | 英文论文标题 | 本科（选填，第二封面）、研究生（必填） |
| `AdvisorName` | 指导教师 | 全部 |
| `AdvisorNameEng` | 指导教师（英文） | 研究生（本科设置时忽略并警告） |
| `AdvisorNameEngSecond` | 第二指导教师（英文） | 学术学位硕士 |
| `AdvisorNameOut` | 校外指导教师 | 专业学位硕士 |
| `AdvisorNameEngOut` | 校外指导教师（英文） | 专业学位硕士、博士 |
| `Major` | 专业 | 全部 |
| `Department` | 学院 | 全部 |
| `DepartmentEng` | 学院（英文） | 研究生 |
| `Keywords` | 中文关键词（分号分隔，仅写入 PDF 元数据） | 全部（选填） |
| `KeywordsEng` | 英文关键词（分号分隔，仅写入 PDF 元数据） | 全部（选填） |
| `SubmitYear` | 提交年份 | 全部（留空自动取当前年） |
| `SubmitMonth` | 提交月份 | 全部（留空自动取当前月） |
| `SubmitDay` | 提交日期 | 研究生 |
| `DefenseYear` | 答辩年份 | 研究生 |
| `DefenseMonth` | 答辩月份 | 研究生 |
| `DefenseDay` | 答辩日期 | 研究生 |
| `DefenseDateEng` | 答辩日期（英文） | 研究生 |
| `ResearchInterest` | 研究方向 | 研究生 |
| `CLCNumber` | 中图分类号 | 研究生 |
| `UDCNumber` | UDC 分类号 | 研究生 |
| `coverlogo` | 封面校徽图片路径 | 全部 |
| `coverimage` | 封面图片路径 | 全部 |
| `coverinfowidth` | 第一封面信息表格宽度（本科默认 240pt，研究生默认 300pt） | 全部 |
| `coverlabelwidth` | 本科第一封面标签下划线宽度（默认 11em） | 本科 |
| `period` | 学位阶段（final/proposal） | 全部 |

### 高级配置键

以下键通过 `\caucsetup{键=值}` 设置，可在导言区或 `cauc_thesis.cfg` 中使用（加载期选项除外）：

| 键 | 默认值 | 说明 |
|----|--------|------|
| `linespacing` | `1.389` | 正文行距（baselineskip=20pt） |
| `topmargin` / `bottommargin` | `2.5cm` | 上下页边距 |
| `leftmargin` / `rightmargin` | 本科 `3cm`/`2.5cm`，研究生 `2.5cm`/`2.5cm` | 左右页边距 |
| `headertext` | 自动 | 自定义页眉文字（留空则按学位类型自动生成） |
| `captionlabelsep` | `quad`（图）/`space`（表） | 图题/表题标签与标题的间距 |
| `draftwatermark` | `DRAFT` | 草稿水印文字 |
| `blankpage` | `false` | 双面排版空白页是否显示页眉页脚 |
| `listcontents` | `true` | 是否生成目录 |
| `listfigures` | `true` | 是否生成插图目录 |
| `listtables` | `true` | 是否生成表格目录 |

> `coverinfowidth` 只影响第一封面；研究生第二封面的信息表宽度固定为 240pt。`coverlabelwidth` 只影响本科第一封面的下划线宽度。

## 文档结构

### 推荐的文件组织

```
项目根目录/
├── cauc_thesis.tex    # 主文件
├── cauc_thesis.cls    # 文档类
├── cauc_thesis.cfg    # 用户配置（可选）
├── reference.bib      # 参考文献
├── body/              # 章节内容
│   ├── chap01.tex     # 第一章
│   ├── chap02.tex     # 第二章
│   ├── chap03.tex     # 第三章
│   ├── chap04.tex     # 第四章
│   ├── chap05.tex     # 第五章
│   ├── acknowledgement.tex  # 致谢
├── figures/           # 图片
├── fonts/             # 字体文件
├── pic/               # 校徽等图片
├── settings/          # 模板配置文件
└── examples/          # 示例文件
```

### 主文件模板

```latex
\documentclass[degree=bachelor]{cauc_thesis}

\caucsetup{
  StudentName=张三,
  StudentID=202012345,
  Title=基于XX的YY研究,
  AdvisorName=李四~教授,
  Major=计算机科学与技术,
  Department=计算机科学与技术学院
}

\begin{document}

\frontmatter

\makecover

\begin{abstract-zh}
中文摘要内容

\keywordszh{关键词1；关键词2；关键词3}
\end{abstract-zh}

\begin{abstract-en}
English abstract content

\keywordsen{Keyword1; Keyword2; Keyword3}
\end{abstract-en}

\makefrontmatter

\mainmatter
\pagestyle{fancy}

\input{body/chap01}
\input{body/chap02}
\input{body/chap03}
\input{body/chap04}
\input{body/chap05}

\backmatter

\bibliography{reference}

\begin{acknowledgment}
致谢内容
\end{acknowledgment}

\end{document}
```

## 图表、代码与长表环境

### `thesisfigure`

参数顺序为：中文图题、英文图题、标签、可选宽度（默认 `0.8\textwidth`）、可选图注。

```latex
\begin{thesisfigure}{中文图题}{English Title}{fig:label}[0.9\textwidth]
    \includegraphics[width=\linewidth]{figures/example}
\end{thesisfigure}
```

需要图注时在宽度之后再给一个可选参数：

```latex
\begin{thesisfigure}{中文图题}{English Title}{fig:label}[0.9\textwidth][数据来源：作者整理]
    \includegraphics[width=\linewidth]{figures/example}
\end{thesisfigure}
```

### `thesistable`

参数顺序为：中文表题、英文表题、标签、列格式、表格内容、可选表注、可选表格宽度。

```latex
\begin{thesistable}{中文表题}{English Title}{tab:label}{cccc}{
    \toprule
    表头1 & 表头2 & 表头3 & 表头4 \\
    \midrule
    数据1 & 数据2 & 数据3 & 数据4 \\
    \bottomrule
}[数据来源：实验室测试]
\end{thesistable}
```

列格式中含 `X` 时自动使用 `tabularx`。只指定宽度、不写表注时可写成 `[][0.9\textwidth]`。

### `thesislongtable`（仅研究生）

用于跨页长表。参数顺序为：中文表题、英文表题、标签、列格式、表头、可选表注。表体行直接写在参数之后，**不要再套一层花括号**：

```latex
\begin{thesislongtable}{跨页长表}{Long Table}{tab:long}{cc}{表头1 & 表头2}[数据来源：作者整理]
数据1 & 数据2 \\
数据3 & 数据4 \\
\end{thesislongtable}
```

跨页后的续表使用“表题（续）”形式重复表头，不重复编号，也不会在表格目录中生成额外条目。

### `\threelinetable`（仅本科）

本科三线表快捷命令，参数顺序为：列格式、中文表题、标签、表头、表体。表头行无需手动添加 `\\`，命令会自动补行结束符：

```latex
\threelinetable{cc}{三线表示例}{tab:three}{表头1 & 表头2}{
    数据1 & 数据2 \\
    数据3 & 数据4 \\
}
```

### 子图与代码

- 子图使用 `subcaption` 宏包的 `subfigure` 环境；从 `subfig` 的 `\subfloat` 迁移时需改写。
- 代码清单使用 `listings` 的 `lstlisting` 环境，清单标题统一为“代码 X-1”（本科）或“代码 X.1”（研究生）：

```latex
\begin{lstlisting}[language=Python, caption={二分查找实现}]
def binary_search(arr, target):
    ...
\end{lstlisting}
```

> 图题位于图下方，表题位于表上方。研究生模式下 `thesisfigure`、`thesistable`、`thesislongtable` 自动生成中英文双语标题；直接使用 `\caption` 的浮动体需手动调用 `\bicaption`。英文标题不会重复写入插图目录和表格目录。

## 便捷命令

| 命令 | 说明 |
|------|------|
| `\makecover` | 生成封面页 |
| `\makefrontmatter` | 生成前置页面（目录等） |
| `\makefrontpages` | 一键生成封面、目录、插图目录、表格目录（不含摘要） |
| `\makereviewpage` | 生成答辩评语页（仅研究生） |
| `\cauccheck` | 输出配置摘要到 .log 文件 |

## 参考文献

### 学位对应的样式

| 学位 | 样式文件 | 标准 |
|------|----------|------|
| 本科 | `gbt7714-2005-numerical` | GB/T 7714-2005 |
| 硕士 | `gbt7714-numerical` | GB/T 7714-2015 |
| 博士 | `gbt7714-numerical` | GB/T 7714-2015 |

### 引用方式

```latex
\cite{key}       % 本科：上标引用；研究生：内联编号
\upcite{key}     % 本科：等价于 \cite；研究生：单层上标引用
```

> **注意**：本科模式使用 natbib 的 `super` 模式，`\cite` 本身即上标，因此 `\upcite` 与 `\cite` 等价。研究生模式 `\cite` 为内联编号，`\upcite` 输出 `\textsuperscript{\cite{key}}`。两种方式的实际字号一致，避免双重上标导致字号过小。

> **注意**：使用 `\bibliography{reference}` 时，"参考文献"会自动出现在目录中，无需手动添加 `\addcontentsline`。手动添加会导致目录中出现重复条目。

> **示例文件**：`examples/bachelor.tex` 包含完整的 BibTeX 演示；研究生示例为避免不同 TeX Live 版本 BibTeX 对大型 bst 的兼容性差异，未放置 `\bibliography`。需要时在 `\backmatter` 后加入 `\bibliography{reference}` 即可。

## 符号说明

研究生模式在 `\makefrontmatter` 之后调用：

```latex
\printnomenclature
```

模板会自动把“符号说明”加入目录。`nomenclature` 条目需在正文中定义，编译时由 latexmk 自动调用 makeindex。

可选参数的首字母用于分组：`A` 组显示为“缩略语”，其余（含省略可选参数的默认组）显示为“符号”。

```latex
\nomenclature[A]{CNN}{卷积神经网络}
\nomenclature[S]{$\alpha$}{学习率}
```

## PDF/A 输出

`pdfa=true` 时模板先加载 `pdfx`、再由 `pdfx` 加载 `hyperref`，以启用 PDF/A-2b 元数据与输出意图。该功能需要：

- `colorprofiles` 宏包（TeX Live 2022 及以上通常自带；MiKTeX 需安装 `colorprofiles`）；
- 完整的 `hyperref`（XeLaTeX 还需要 `puenc-greek.def`，部分 MiKTeX 安装缺失）；
- 若发行版没有 `colorprofiles`，需将 `sRGB_IEC61966-2-1_black_scaled.icc` 放在项目根目录。

> `pdfx` 在 XeLaTeX 下可能输出 `xdvipdfmx:warning: Could not find any valid object`，且 XMP 元数据默认不完整。若需要严格校验或完整元数据，建议使用 LuaLaTeX，并在主文件旁提供 `<主文件名>.xmpdata`（例如 `cauc_thesis.xmpdata`）：
>
> ```latex
> \Title{论文中文题目}
> \Author{张三}
> \Subject{中国民航大学学位论文}
> \Keywords{关键词1, 关键词2}
> ```
>
> 模板不自动生成 `.xmpdata`；缺少时 `pdfx` 会提示 `Metadata will be incomplete!`。

## 编译命令

```bash
# 标准编译（.latexmkrc 默认 XeLaTeX）
latexmk cauc_thesis

# 显式指定 XeLaTeX
latexmk -xelatex cauc_thesis

# LuaLaTeX 编译
latexmk -lualatex cauc_thesis

# 清理辅助文件
latexmk -c

# 完全清理（删除 build/ 目录）
latexmk -C

# 使用 Makefile
make              # 编译
make clean        # 清理辅助文件
make distclean    # 删除 build/ 目录
make lint         # 代码检查
make wordcount    # 字数统计
make check        # 编译四种学位示例与主模板，任一失败返回非零
```

也可直接运行全量检查脚本：

```bash
bash scripts/check.sh                                       # Linux / macOS / Git Bash
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/check.ps1   # Windows
```

> 编译产物统一输出到 `build/` 目录（由 `.latexmkrc` 配置）。若直接使用 `xelatex` 而非 `latexmk`，编译产物将输出到项目根目录。

## 常见问题

详见 [FAQ.md](FAQ.md)。
