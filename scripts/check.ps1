# 编译所有学位示例与主模板，任一失败则返回非零退出码
$files = @(
    'examples/bachelor.tex',
    'examples/master-academic.tex',
    'examples/master-professional.tex',
    'examples/doctor.tex',
    'cauc_thesis.tex'
)
$outDir = 'build/check'
$failed = @()

if (Test-Path $outDir) {
    Remove-Item -Recurse -Force $outDir
}
New-Item -ItemType Directory -Force $outDir | Out-Null

foreach ($f in $files) {
    Write-Host "--- Compiling $f ---"
    & latexmk -xelatex -interaction=batchmode "-outdir=$outDir" $f
    if ($LASTEXITCODE -ne 0) {
        Write-Host '  FAILED'
        $failed += $f
    } else {
        Write-Host '  OK'
    }
}

if ($failed.Count -gt 0) {
    Write-Host ''
    Write-Host "Failed: $($failed -join ', ')"
    Write-Host "Logs kept in $outDir"
    exit 1
}

if (Test-Path $outDir) {
    Remove-Item -Recurse -Force $outDir
}
Write-Host ''
Write-Host 'All compilations passed.'
