MAIN = cauc_thesis
DEGREES = bachelor master-academic master-professional doctor

.PHONY: all clean distclean view wordcount lint lintindent check bachelor master-academic master-professional doctor

all:
	latexmk -xelatex $(MAIN).tex

bachelor:
	latexmk -xelatex examples/bachelor.tex

master-academic:
	latexmk -xelatex examples/master-academic.tex

master-professional:
	latexmk -xelatex examples/master-professional.tex

doctor:
	latexmk -xelatex examples/doctor.tex

clean:
	latexmk -c

distclean:
	latexmk -C
ifeq ($(OS),Windows_NT)
	@if exist build rmdir /S /Q build
else
	@rm -rf build
endif

lint:
ifeq ($(OS),Windows_NT)
	@for %%f in (*.tex settings\*.tex) do @chktex -q %%f 2>nul
else
	@find . -name "*.tex" | xargs chktex -q 2>/dev/null
endif

lintindent:
	bash scripts/check_indent.sh

wordcount:
ifeq ($(OS),Windows_NT)
	@texcount -v0 -ch -1 -sum $(MAIN).tex 2>nul
else
	@bash scripts/word_count.sh $(MAIN).tex
endif

check:
	@echo "===== Compiling all degree types ====="
	@echo "--- Compiling bachelor ---"
	@latexmk -xelatex -interaction=nonstopmode -outdir=build/check examples/bachelor.tex > /dev/null 2>&1 && echo "  bachelor: OK" || echo "  bachelor: FAILED"
	@echo "--- Compiling master-academic ---"
	@latexmk -xelatex -interaction=nonstopmode -outdir=build/check examples/master-academic.tex > /dev/null 2>&1 && echo "  master-academic: OK" || echo "  master-academic: FAILED"
	@echo "--- Compiling master-professional ---"
	@latexmk -xelatex -interaction=nonstopmode -outdir=build/check examples/master-professional.tex > /dev/null 2>&1 && echo "  master-professional: OK" || echo "  master-professional: FAILED"
	@echo "--- Compiling doctor ---"
	@latexmk -xelatex -interaction=nonstopmode -outdir=build/check examples/doctor.tex > /dev/null 2>&1 && echo "  doctor: OK" || echo "  doctor: FAILED"
	@echo "--- Cleaning up ---"
ifeq ($(OS),Windows_NT)
	@if exist build\check rmdir /S /Q build\check
else
	@rm -rf build/check
endif
	@echo "===== Check complete ====="

view: all
ifeq ($(OS),Windows_NT)
	@start build\$(MAIN).pdf
else
	@if command -v xdg-open > /dev/null 2>&1; then \
		xdg-open build/$(MAIN).pdf; \
	elif command -v open > /dev/null 2>&1; then \
		open build/$(MAIN).pdf; \
	fi
endif
