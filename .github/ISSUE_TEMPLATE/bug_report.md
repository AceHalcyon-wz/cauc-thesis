---
name: Bug 报告
about: 报告编译错误或排版异常
title: ''
labels: bug
assignees: ''

---

**问题描述**

简要说明出现了什么问题。

**复现步骤**

1. 使用的 `degree` 选项：`bachelor` / `master-academic` / `master-professional` / `doctor`
2. 使用的其他选项：`twoside` / `openright` / `blind` / `pdfa` / `localfonts` 等
3. 执行 `latexmk -xelatex 文件名.tex`
4. 观察到的现象

**最小复现文件**

请提供能复现问题的最小 `.tex` 片段，或说明基于哪个示例文件修改。

```latex
% 在此粘贴最小复现代码
```

**编译环境**

- TeX 发行版及版本：例如 TeX Live 2025、MiKTeX 26.2
- 编译引擎：XeLaTeX / LuaLaTeX
- 操作系统：Windows 11 / Ubuntu 24.04 / macOS
- 模板版本或提交哈希：

**日志与截图**

请粘贴 `.log` 文件中的首个错误信息及相关上下文；如为排版问题，请附截图。
