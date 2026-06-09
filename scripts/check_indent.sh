#!/usr/bin/env bash
set -euo pipefail

files=(
  "cauc_thesis.cls"
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

  if grep -Pq '\t' "$f"; then
    issues+=("hasTab")
  fi

  if grep -Pq '\s+$' "$f"; then
    issues+=("trailingWhitespace")
  fi

  if [[ -s "$f" ]] && [[ "$(tail -c 1 "$f" | xxd -p)" != "0a" ]]; then
    issues+=("missingFinalNewline")
  fi

  crlf_count=$(grep -cP '\r\n' "$f" || true)
  lf_count=$(grep -cP '(?<!\r)\n' "$f" || true)
  if [[ $crlf_count -gt 0 ]] && [[ $lf_count -gt 0 ]]; then
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
