MAIN = cauc_thesis
# chktex 对中文排版与宏包条件分支存在固定误报，以下编号为项目内已确认的误报：
# 1 命令后空格、8 短横线、9 tabular/tabularx、10 单引号、13 句间空格、
# 26 标点前空格、27 无法执行的命令、32 引号风格、36 括号前空格、
# 38 引号后标点、39 双空格。
CHKTEX_FLAGS = -q -n1 -n8 -n9 -n10 -n13 -n26 -n27 -n32 -n36 -n38 -n39

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
	@for %%f in (*.tex settings\*.tex examples\*.tex body\*.tex) do @chktex $(CHKTEX_FLAGS) %%f 2>nul
else
	@find . \( -path './中国民航大学学位论文latex模板' -o -path './build' \) -prune -o -name '*.tex' -print0 | xargs -0 chktex $(CHKTEX_FLAGS) 2>/dev/null
endif

lintindent:
ifeq ($(OS),Windows_NT)
	@powershell -ExecutionPolicy Bypass -File scripts/check_indent.ps1
else
	@bash scripts/check_indent.sh
endif

wordcount:
ifeq ($(OS),Windows_NT)
	@texcount -v0 -ch -1 -sum $(MAIN).tex
else
	@bash scripts/word_count.sh $(MAIN).tex
endif

check:
ifeq ($(OS),Windows_NT)
	@powershell -NoProfile -ExecutionPolicy Bypass -File scripts/check.ps1
else
	@bash scripts/check.sh
endif

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
