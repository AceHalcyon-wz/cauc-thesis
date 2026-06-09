# 使用手册

## 快速开始

### 环境要求

- TeX Live 2022 或更高版本
- XeLaTeX 引擎（推荐）或 LuaLaTeX
- 推荐编辑器：VS Code + LaTeX Workshop 插件

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
| `Type` | `thesis` | 论文类型（thesis/design） |
| `period` | `final` | 学位阶段（final/proposal） |
| `blind` | `false` | 盲审模式 |
| `draft` | `false` | 草稿模式（添加 DRAFT 水印） |
| `lineno` | `false` | 仅启用行号，不添加草稿水印 |
| `pdfa` | `false` | PDF/A 格式输出 |
| `twoside` | `false` | 双面打印模式 |
| `openright` | `false` | 章节从奇数页开始 |
| `localfonts` | `auto` | 字体加载策略（auto/true/false） |
| `mathfont` | `cm` | 数学字体（cm/times） |

### 行距说明

所有学位类型正文行距均为 1.389（baselineskip=20pt），摘要行距均为 1.389（baselineskip=20pt），与原始模板规范一致。可通过 `\caucsetup{linespacing=值}` 覆盖默认行距。

摘要标题与正文间距：本科由 `\begin{center}` 排版标题后手动添加 21pt 间距，研究生由 `\chapter*` 的 afterskip=30pt 自动提供，无需手动间距。关键词与摘要正文间距：本科使用 `\newline\newline`，研究生使用 `\newline`，与原始模板规范一致。摘要标题字体：中文摘要标题使用黑体（\heiti），英文摘要标题使用粗体（\textbf），与原始模板规范一致。英文关键词字体：本科和硕士使用宋体（\songti），博士使用默认 Times New Roman，与原始模板规范一致。

宋体斜体替代：宋体（SimSun）无斜体变体，模板自动将宋体斜体映射为楷体（KaiTi），避免编译时出现 "Font shape undefined" 警告。

字体管理：模板使用 `fontset=none` 选项加载 ctex，由模板自行管理所有 CJK 字体定义（包括主字体、无衬线字体、等宽字体），避免与 ctex 默认字体集冲突产生 "Redefining CJKfamily" 编译警告。

研究生四级标题：`\subsubsubsection` 采用换行标题格式（标题独占一行，正文另起一行），与原始模板规范一致。本科未定义 subsubsection 格式，使用 ctex 默认值。

目录深度：本科 tocdepth=2（目录显示到 subsection），研究生 tocdepth=4（目录显示到 paragraph），与原始模板规范一致。原始模板中研究生 tocdepth 在 commands.tex 中设为 4，覆盖 contents.tex 中的初始值 2。

页码格式：研究生前置页面（封面、摘要等）使用罗马数字页码（I, II, ...），正文从阿拉伯数字 1 开始编号，与原始模板规范一致。本科前置页面不显示页码（与原始模板规范一致，原始模板本科前置页面使用 `\pagestyle{empty}`），目录页使用 `\pagenumbering{gobble}` 隐藏页码，正文从阿拉伯数字 1 开始编号。正文字号：所有学位类型正文均为小四号（12pt），与原始模板规范一致。

### 示例

```latex
\documentclass[degree=bachelor]{cauc_thesis}
\documentclass[degree=master-academic,blind=true]{cauc_thesis}
\documentclass[degree=doctor,pdfa=true,twoside=true]{cauc_thesis}
\documentclass[degree=bachelor,period=proposal]{cauc_thesis}
```

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

以下选项可通过 `\caucsetup{选项=true/false}` 或 `\documentclass[选项]{cauc_thesis}` 设置：

| 选项 | 默认值 | 说明 |
|------|--------|------|
| `declaration` | `false` | 是否包含原创性声明和使用授权页（研究生默认包含，无需设置） |
| `draft` | `false` | 草稿模式，显示行号和 DRAFT 水印 |
| `blind` | `false` | 盲审模式，隐藏个人信息 |
| `pdfa` | `false` | 生成 PDF/A 兼容文档 |
| `twoside` | `false` | 双面打印模式 |
| `openright` | `false` | 章节从奇数页开始 |
| `blankpage` | `false` | 双面排版时空白页是否显示页眉页脚 |
| `headeronplain` | `true` | 章节起始页是否显示页眉（默认 true 与原始模板一致） |
| `listcontents` | `true` | 是否生成目录 |
| `listfigures` | `true` | 是否生成插图目录 |
| `listtables` | `true` | 是否生成表格目录 |
| `lineno` | `false` | 启用行号 |

### 方式三：配置文件

创建 `cauc_thesis.cfg` 文件：

```latex
\caucsetup{
  StudentName=张三,
  StudentID=202012345,
  Title=基于XX的YY研究
}
```

模板编译时自动加载此文件，无需修改 .cls。

### 完整字段列表

| 字段 | 说明 | 适用学位 |
|------|------|----------|
| `StudentName` | 学生姓名 | 全部 |
| `StudentNameEng` | 学生姓名（英文） | 研究生 |
| `StudentID` | 学号 | 全部 |
| `Title` | 中文论文标题 | 全部 |
| `TitleEng` | 英文论文标题 | 全部 |
| `AdvisorName` | 指导教师 | 全部 |
| `AdvisorNameEng` | 指导教师（英文） | 研究生 |
| `AdvisorNameEngSecond` | 第二指导教师（英文） | 学术学位硕士 |
| `AdvisorNameOut` | 校外指导教师 | 专业学位硕士 |
| `AdvisorNameEngOut` | 校外指导教师（英文） | 专业学位硕士、博士 |
| `Grade` | 年级 | 本科 |
| `Major` | 专业 | 全部 |
| `Department` | 学院 | 全部 |
| `DepartmentEng` | 学院（英文） | 研究生 |
| `Keywords` | 中文关键词（分号分隔） | 全部 |
| `KeywordsEng` | 英文关键词（分号分隔） | 全部 |
| `SubmitYear` | 提交年份 | 全部（默认当前年） |
| `SubmitMonth` | 提交月份 | 全部（默认当前月） |
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
| `coverinfowidth` | 封面信息表格宽度 | 全部 |
| `coverlabelwidth` | 封面标签下划线宽度 | 全部 |
| `period` | 学位阶段（final/proposal） | 全部 |

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

## 便捷命令

| 命令 | 说明 |
|------|------|
| `\makecover` | 生成封面页 |
| `\makefrontmatter` | 生成前置页面（目录等） |
| `\makefrontpages` | 一键生成封面+前置页面 |
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
\cite{key}                        % 不上浮引用
\textsuperscript{\cite{key}}      % 上浮引用
```

> **注意**：`\upcite` 命令在所有学位类型下均输出双重上标引用 `\textsuperscript{\textsuperscript{\cite{key}}}`，与原始模板规范一致。

> **注意**：使用 `\bibliography{reference}` 时，"参考文献"会自动出现在目录中，无需手动添加 `\addcontentsline`。手动添加会导致目录中出现重复条目。

## 编译命令

```bash
# 标准编译
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
```

> 编译产物统一输出到 `build/` 目录（由 `.latexmkrc` 配置）。若直接使用 `xelatex` 而非 `latexmk`，编译产物将输出到项目根目录。

## 常见问题

详见 [FAQ.md](FAQ.md)。
