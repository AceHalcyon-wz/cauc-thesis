#!/bin/bash
# CAUC Thesis Word Count Script
# Uses texcount to count words in the thesis

MAIN_TEX="${1:-cauc_thesis.tex}"

if [ ! -f "$MAIN_TEX" ]; then
    echo "Error: $MAIN_TEX not found"
    echo "Usage: bash scripts/word_count.sh [main.tex]"
    exit 1
fi

if ! command -v texcount &> /dev/null; then
    echo "Error: texcount not found."
    echo ""
    echo "Installation options:"
    echo "  - Linux (Debian/Ubuntu): sudo apt install texlive-extra-utils"
    echo "  - macOS (Homebrew):      brew install --cask mactex || tlmgr install texcount"
    echo "  - Windows:               Use WSL or install TeX Live and run: tlmgr install texcount"
    echo ""
    echo "Windows users: You can also run texcount directly if TeX Live is installed:"
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

echo "=== CAUC Thesis Word Count ==="
echo "Source: $MAIN_TEX"
if [ "$FILE_SIZE" != "unknown" ]; then
    echo "File size: $FILE_SIZE bytes"
fi
echo ""

texcount -v0 -ch -sum "$MAIN_TEX" 2>/dev/null

echo ""
echo "=== Summary ==="
texcount -v0 -ch -1 -sum "$MAIN_TEX" 2>/dev/null | tail -1
