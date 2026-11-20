$out_dir = 'build';

# Windows + MiKTeX 环境下，latexmk 可能由 Git 自带的 MSYS Perl 解释执行，
# 该 Perl 会把路径转换为 MSYS 风格（如 /d/Users/...），MiKTeX 的 bibtex 无法识别。
# 仅在 MSYS/Cygwin Perl 下关闭 bibtex 的工作目录切换；Linux/TeX Live 保持默认行为。
$bibtex_fudge = 0 if $^O =~ /^(msys|cygwin)$/;

$xelatex = 'xelatex -synctex=1 -file-line-error -interaction=nonstopmode';
$lualatex = 'lualatex -synctex=1 -file-line-error -interaction=nonstopmode';
$bibtex = 'bibtex';
# 默认使用 XeLaTeX；命令行 -lualatex 会由 latexmk 自身切换为 LuaLaTeX，
# 此处不要再根据 $lualatex 变量改写 $pdf_mode，否则默认引擎会被错误地设为 LuaLaTeX。
$pdf_mode = 5;

$clean_ext = 'aux log out toc lof lot bbl blg fls fdb_latexmk synctex.gz xdv nlo nls ilg idx ind thm bcf run.xml xmpdata xmp xmpi glo ist acn acr alg loa fgs';

add_cus_dep( 'nlo', 'nls', 0, 'makenomenclature' );
sub makenomenclature {
    system( "makeindex -s nomencl.ist -o \"$_[0].nls\" \"$_[0].nlo\"" );
    return 0;
}
