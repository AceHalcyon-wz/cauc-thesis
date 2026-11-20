#!/bin/bash
# CAUC 学位论文字数统计脚本
# 使用 texcount 统计论文正文中文字数

MAIN_TEX="${1:-cauc_thesis.tex}"

if [ ! -f "$MAIN_TEX" ]; then
    echo "错误：未找到 $MAIN_TEX"
    echo "用法：bash scripts/word_count.sh [主文件.tex]"
    exit 1
fi

if ! command -v texcount &> /dev/null; then
    echo "错误：未找到 texcount 命令"
    echo ""
    echo "安装方式："
    echo "  - Linux (Debian/Ubuntu): sudo apt install texlive-extra-utils"
    echo "  - macOS (Homebrew):      brew install --cask mactex || tlmgr install texcount"
    echo "  - Windows:               使用 WSL 或安装 TeX Live 后运行：tlmgr install texcount"
    echo ""
    echo "Windows 用户也可直接运行 texcount（需已安装 TeX Live）："
    echo "  texcount -v0 -ch -sum $MAIN_TEX"
    exit 1
fi

detect_stat_flag() {
    if stat --version &> /dev/null 2>&1; then
        STAT_SIZE_FLAG="-c%s"
    else
        STAT_SIZE_FLAG="-f%z"
    fi
    echo "$STAT_SIZE_FLAG"
}

STAT_FLAG=$(detect_stat_flag)
FILE_SIZE=$(stat $STAT_FLAG "$MAIN_TEX" 2>/dev/null || echo "unknown")

echo "=== CAUC 学位论文字数统计 ==="
echo "源文件：$MAIN_TEX"
if [ "$FILE_SIZE" != "unknown" ]; then
    echo "文件大小：$FILE_SIZE 字节"
fi
echo ""

TEXCOUNT_OUTPUT=$(texcount -v0 -ch -sum "$MAIN_TEX" 2>&1)
TEXCOUNT_STATUS=$?
if [ "$TEXCOUNT_STATUS" -ne 0 ]; then
    echo "错误：texcount 运行失败（退出码 $TEXCOUNT_STATUS）"
    echo "$TEXCOUNT_OUTPUT"
    echo ""
    echo "Windows 用户请确认已安装 Perl 解释器；MiKTeX 的 texcount.exe 依赖 Perl 运行。"
    exit 1
fi
echo "$TEXCOUNT_OUTPUT"

echo ""
echo "=== 汇总 ==="
texcount -v0 -ch -1 -sum "$MAIN_TEX" 2>/dev/null | tail -1
