$files = @('cauc_thesis.cls','settings\packages.tex','settings\fonts.tex','settings\format.tex','settings\contents.tex','settings\commands.tex','settings\cover.tex','examples\bachelor.tex','examples\master-academic.tex','examples\master-professional.tex','examples\doctor.tex','body\chap01.tex','body\chap02.tex','body\chap03.tex','body\chap04.tex','body\chap05.tex','body\acknowledgement.tex')
$errorCount = 0

foreach ($f in $files) {
    if (-not (Test-Path $f)) {
        Write-Output "SKIP ${f}: file not found"
        continue
    }

    $raw = [System.IO.File]::ReadAllBytes((Resolve-Path $f).Path)
    $text = Get-Content $f -Raw

    $hasTab = $text -match "`t"
    $hasTrailingWhitespace = $false
    $missingFinalNewline = $false
    $hasCRLF = $false
    $hasLF = $false
    $mixedLineEndings = $false

    $lines = Get-Content $f
    foreach ($line in $lines) {
        if ($line -match '\s+$') {
            $hasTrailingWhitespace = $true
            break
        }
    }

    if ($raw.Length -gt 0 -and $raw[-1] -ne 10) {
        $missingFinalNewline = $true
    }

    for ($i = 0; $i -lt $raw.Length - 1; $i++) {
        if ($raw[$i] -eq 13 -and $raw[$i + 1] -eq 10) {
            $hasCRLF = $true
            $i++
        } elseif ($raw[$i] -eq 10) {
            $hasLF = $true
        }
    }
    if ($hasCRLF -and $hasLF) {
        $mixedLineEndings = $true
    }

    $issues = @()
    if ($hasTab) { $issues += 'hasTab' }
    if ($hasTrailingWhitespace) { $issues += 'trailingWhitespace' }
    if ($missingFinalNewline) { $issues += 'missingFinalNewline' }
    if ($mixedLineEndings) { $issues += 'mixedLineEndings' }

    if ($issues.Count -gt 0) {
        Write-Output "${f}: $($issues -join ', ')"
        $errorCount += $issues.Count
    } else {
        Write-Output "${f}: OK"
    }
}

if ($errorCount -gt 0) {
    Write-Output ""
    Write-Output "Total issues: $errorCount"
    exit 1
}
