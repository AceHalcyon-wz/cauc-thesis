#!/usr/bin/env bash
set -euo pipefail

files=(
  "cauc_thesis.cls"
  "cauc_thesis.tex"
  "settings/packages.tex"
  "settings/fonts.tex"
  "settings/format.tex"
  "settings/contents.tex"
  "settings/commands.tex"
  "settings/cover.tex"
  "examples/bachelor.tex"
  "examples/master-academic.tex"
  "examples/master-professional.tex"
  "examples/doctor.tex"
  "body/chap01.tex"
  "body/chap02.tex"
  "body/chap03.tex"
  "body/chap04.tex"
  "body/chap05.tex"
  "body/acknowledgement.tex"
)

error_count=0

for f in "${files[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "SKIP ${f}: file not found"
    continue
  fi

  issues=()

  if grep -q $'\t' "$f"; then
    issues+=("hasTab")
  fi

  # [[:space:]]$ 同时覆盖行尾空格、制表符与 CR；
  # 使用 POSIX 字符类以兼容 macOS/BSD grep。
  if grep -q '[[:space:]]$' "$f"; then
    issues+=("trailingWhitespace")
  fi

  if [[ -s "$f" ]] && [[ "$(tail -c 1 "$f" | od -An -tx1 | tr -d ' \n')" != "0a" ]]; then
    issues+=("missingFinalNewline")
  fi

  total_lines=$(wc -l < "$f" | tr -d ' ')
  crlf_lines=$(grep -c $'\r$' "$f" || true)
  if [[ $crlf_lines -gt 0 ]] && [[ $crlf_lines -lt $total_lines ]]; then
    issues+=("mixedLineEndings")
  fi

  if [[ ${#issues[@]} -gt 0 ]]; then
    echo "${f}: $(IFS=', '; echo "${issues[*]}")"
    error_count=$((error_count + ${#issues[@]}))
  else
    echo "${f}: OK"
  fi
done

if [[ $error_count -gt 0 ]]; then
  echo ""
  echo "Total issues: ${error_count}"
  exit 1
fi
