#!/usr/bin/env bash
# 编译所有学位示例与主模板，任一失败则返回非零退出码

files=(
  "examples/bachelor.tex"
  "examples/master-academic.tex"
  "examples/master-professional.tex"
  "examples/doctor.tex"
  "cauc_thesis.tex"
)
out_dir="build/check"
failed=()

rm -rf "${out_dir}"
mkdir -p "${out_dir}"

for f in "${files[@]}"; do
  echo "--- Compiling ${f} ---"
  if latexmk -xelatex -interaction=batchmode "-outdir=${out_dir}" "${f}"; then
    echo "  OK"
  else
    echo "  FAILED"
    failed+=("${f}")
  fi
done

if [[ ${#failed[@]} -gt 0 ]]; then
  echo ""
  echo "Failed: ${failed[*]}"
  echo "Logs kept in ${out_dir}"
  exit 1
fi

rm -rf "${out_dir}"
echo ""
echo "All compilations passed."
