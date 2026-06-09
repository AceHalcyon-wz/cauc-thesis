$out_dir = 'build';

if ($lualatex) {
    $lualatex = 'lualatex -synctex=1 -file-line-error -interaction=nonstopmode';
    $pdf_mode = 4;
}

$xelatex = 'xelatex -synctex=1 -file-line-error -interaction=nonstopmode';
$bibtex = 'bibtex';
$pdf_mode = 5;

$clean_ext = 'aux log out toc lof lot bbl blg fls fdb_latexmk synctex.gz nlo nls ilg idx ind thm bcf run.xml xmpdata xmp xmpi glo ist acn acr alg loa fgs';

add_cus_dep( 'nlo', 'nls', 0, 'makenomenclature' );
sub makenomenclature {
    system( "makeindex -s nomencl.ist -o \"$_[0].nls\" \"$_[0].nlo\"" );
    return 0;
}
