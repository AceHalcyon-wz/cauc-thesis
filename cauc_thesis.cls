\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cauc_thesis}
              [2026/11/20 Unified LaTeX Template for CAUC Thesis]
\newcommand{\cauc@warning}[1]{\ClassWarning{cauc_thesis}{#1}}
\newcommand{\cauc@error}[2]{\ClassError{cauc_thesis}{#1}{#2}}

\RequirePackage{kvoptions}
\RequirePackage{etoolbox}

\SetupKeyvalOptions{
    family=cauc_thesis,
    prefix=cauc@
}

\DeclareStringOption[bachelor]{degree}
\DeclareStringOption{StudentName}
\DeclareStringOption{StudentNameEng}
\DeclareStringOption{StudentID}
\DeclareStringOption{AdvisorName}
\DeclareStringOption{AdvisorNameEng}
\DeclareStringOption{AdvisorNameEngSecond}
\DeclareStringOption{AdvisorNameOut}
\DeclareStringOption{AdvisorNameEngOut}
\DeclareStringOption{Grade}
\DeclareStringOption{Major}
\DeclareStringOption{Department}
\DeclareStringOption{DepartmentEng}
\DeclareStringOption{Title}
\DeclareStringOption{TitleEng}
\DeclareStringOption{SubmitYear}
\DeclareStringOption{SubmitMonth}
\DeclareStringOption{SubmitDay}
\DeclareStringOption{DefenseYear}
\DeclareStringOption{DefenseMonth}
\DeclareStringOption{DefenseDay}
\DeclareStringOption{DefenseDateEng}
\DeclareStringOption{ResearchInterest}
\DeclareStringOption{CLCNumber}
\DeclareStringOption{UDCNumber}
\DeclareStringOption[auto]{localfonts}
\DeclareStringOption[cm]{mathfont}
\DeclareStringOption{Keywords}
\DeclareStringOption{KeywordsEng}
\DeclareStringOption[thesis]{Type}
\DeclareStringOption[final]{period}

\DeclareBoolOption[false]{lineno}
\DeclareBoolOption[false]{pdfa}
\DeclareBoolOption[false]{declaration}
\DeclareBoolOption[false]{draft}
\DeclareBoolOption[false]{blind}
\DeclareBoolOption[false]{twoside}
\DeclareBoolOption[false]{openright}
\DeclareBoolOption[true]{headeronplain}

\newif\ifcauc@blankpagestandard

\newif\ifcauc@listcontents
\cauc@listcontentstrue
\DeclareVoidOption{nocontents}{\cauc@listcontentsfalse}

\newif\ifcauc@listfigures
\cauc@listfigurestrue
\DeclareVoidOption{nofigures}{\cauc@listfiguresfalse}

\newif\ifcauc@listtables
\cauc@listtablestrue
\DeclareVoidOption{notables}{\cauc@listtablesfalse}

\ProcessKeyvalOptions*

% 阻断文档类选项向宏包的全局泄漏：模板的 draft 选项不应触发
% hyperref/graphicx 的 draft 模式（否则会关闭超链接、PDF 元数据并替换图片）。
% 显式传给 ctexrep 的 twoside/openright 由后续 \PassOptionsToClass 重新加入。
\let\@unusedoptionlist\@empty
\let\@classoptionslist\@empty

\ifx\cauc@SubmitYear\@empty
  \edef\cauc@SubmitYear{\the\year}%
\fi
\ifx\cauc@SubmitMonth\@empty
  \edef\cauc@SubmitMonth{\the\month}%
\fi

\ifx\cauc@degree\@empty
  \cauc@warning{degree option not set, defaulting to bachelor}
\fi

\RequirePackage{pgfkeys}

% 封面尺寸：需在读取 cauc_thesis.cfg 前定义，供 coverinfowidth/coverlabelwidth 使用
\newlength{\cauc@cover@infowidth}
\newlength{\cauc@cover@infowidth@second}
\newlength{\cauc@cover@labelwidth}
\newif\ifcauc@cover@infowidth@set
\newif\ifcauc@cover@labelwidth@set

\newcommand{\cauc@linespacing}{}
\newcommand{\cauc@headertext}{}
\newcommand{\cauc@captionlabelsep}{}
\newcommand{\cauc@draftwatermark}{DRAFT}
\newcommand{\cauc@coverlogo}{./pic/pic1.jpg}
\newcommand{\cauc@coverimage}{./pic/pic2.png}
\newif\ifcauc@margin@pending
\cauc@margin@pendingfalse

% 学位类型与附录状态标志（\caucsetup 的 Type/period 回调需要）
\newif\ifcauc@design
\newif\ifcauc@bachelor
\newif\ifcauc@graduate
\newif\ifcauc@doctor
\newif\ifcauc@master
\newif\ifcauc@masteracademic
\newif\ifcauc@masterprofessional
\newif\ifcauc@proposal
\newif\ifcauc@final
\cauc@finaltrue
\newif\ifcauc@appendix
\newcommand{\cauc@chapnum}{\ifcauc@appendix\thechapter\else\arabic{chapter}\fi}

% 枚举型选项在解析时去掉空格，避免 cauc_thesis.cfg 中换行/缩进产生的
% 尾部空格导致 \ifx / \ifdefstring 比较失败。
\newcommand{\cauc@applytype}{%
  \def\cauc@@temp{design}%
  \ifx\cauc@Type\cauc@@temp
    \cauc@designtrue
  \else
    \cauc@designfalse
  \fi
}
\newcommand{\cauc@applyperiod}{%
  \ifdefstring{\cauc@period}{proposal}{%
    \cauc@proposaltrue\cauc@finalfalse
  }{%
    \cauc@proposalfalse\cauc@finaltrue
  }%
}

\newcommand{\caucsetup}[1]{%
    \pgfkeys{
        /caucsetup/.cd,
        degree/.code={\edef\cauc@degree{\zap@space##1 \@empty}},
        linespacing/.store in=\cauc@linespacing,
        topmargin/.code={\def\cauc@topmargin{##1}\cauc@margin@pendingtrue},
        bottommargin/.code={\def\cauc@bottommargin{##1}\cauc@margin@pendingtrue},
        leftmargin/.code={\def\cauc@leftmargin{##1}\cauc@margin@pendingtrue},
        rightmargin/.code={\def\cauc@rightmargin{##1}\cauc@margin@pendingtrue},
        headertext/.store in=\cauc@headertext,
        captionlabelsep/.store in=\cauc@captionlabelsep,
        draftwatermark/.store in=\cauc@draftwatermark,
        StudentName/.store in=\cauc@StudentName,
        StudentNameEng/.store in=\cauc@StudentNameEng,
        StudentID/.store in=\cauc@StudentID,
        AdvisorName/.store in=\cauc@AdvisorName,
        AdvisorNameEng/.store in=\cauc@AdvisorNameEng,
        AdvisorNameEngSecond/.store in=\cauc@AdvisorNameEngSecond,
        AdvisorNameOut/.store in=\cauc@AdvisorNameOut,
        AdvisorNameEngOut/.store in=\cauc@AdvisorNameEngOut,
        Grade/.store in=\cauc@Grade,
        Major/.store in=\cauc@Major,
        Department/.store in=\cauc@Department,
        DepartmentEng/.store in=\cauc@DepartmentEng,
        Title/.store in=\cauc@Title,
        TitleEng/.store in=\cauc@TitleEng,
        SubmitYear/.store in=\cauc@SubmitYear,
        SubmitMonth/.store in=\cauc@SubmitMonth,
        SubmitDay/.store in=\cauc@SubmitDay,
        DefenseYear/.store in=\cauc@DefenseYear,
        DefenseMonth/.store in=\cauc@DefenseMonth,
        DefenseDay/.store in=\cauc@DefenseDay,
        DefenseDateEng/.store in=\cauc@DefenseDateEng,
        ResearchInterest/.store in=\cauc@ResearchInterest,
        CLCNumber/.store in=\cauc@CLCNumber,
        UDCNumber/.store in=\cauc@UDCNumber,
        Keywords/.store in=\cauc@Keywords,
        KeywordsEng/.store in=\cauc@KeywordsEng,
        Type/.code={\edef\cauc@Type{\zap@space##1 \@empty}\cauc@applytype},
        localfonts/.code={\edef\cauc@localfonts{\zap@space##1 \@empty}},
        mathfont/.code={\edef\cauc@mathfont{\zap@space##1 \@empty}},
        period/.code={\edef\cauc@period{\zap@space##1 \@empty}\cauc@applyperiod},
        coverlogo/.store in=\cauc@coverlogo,
        coverimage/.store in=\cauc@coverimage,
        coverinfowidth/.code={\setlength{\cauc@cover@infowidth}{##1}\cauc@cover@infowidth@settrue},
        coverlabelwidth/.code={\setlength{\cauc@cover@labelwidth}{##1}\cauc@cover@labelwidth@settrue},
        openright/.is if=cauc@openright,
        headeronplain/.is if=cauc@headeronplain,
        blankpage/.is if=cauc@blankpagestandard,
        listcontents/.is if=cauc@listcontents,
        listfigures/.is if=cauc@listfigures,
        listtables/.is if=cauc@listtables,
        lineno/.is if=cauc@lineno,
        declaration/.is if=cauc@declaration,
        draft/.is if=cauc@draft,
        blind/.is if=cauc@blind,
        pdfa/.is if=cauc@pdfa,
        twoside/.is if=cauc@twoside,
        /.unknown/.code={\cauc@warning{Unknown key '\pgfkeyscurrentkey' in caucsetup}}%
    }%
    % 逐项处理，利用 etoolbox 去掉每项开头的空格/换行，
    % 使 cauc_thesis.cfg 中缩进书写的键值也能正确识别。
    \forcsvlist{\cauc@setup@item}{#1}%
}
\newcommand{\cauc@setup@item}[1]{%
    \pgfkeys{/caucsetup/.cd, #1}%
}

% 先读取用户配置，使 \caucsetup 中的加载期选项（degree/localfonts/mathfont/
% pdfa/twoside/openright/linespacing 等）与个人信息在后续处理前生效。
\IfFileExists{cauc_thesis.cfg}{\input{cauc_thesis.cfg}}{%
  \ClassInfo{cauc_thesis}{No cauc_thesis.cfg found. Please copy cauc_thesis.cfg.example to cauc_thesis.cfg and fill in your personal information.}%
}

\def\cauc@parse@degree{%
  \ifdefstring{\cauc@degree}{bachelor}{%
    \cauc@bachelortrue
  }{%
    \cauc@graduatetrue
    \ifdefstring{\cauc@degree}{doctor}{%
      \cauc@doctortrue
    }{%
      \ifdefstring{\cauc@degree}{master-academic}{%
        \cauc@mastertrue
        \cauc@masteracademictrue
      }{%
        \ifdefstring{\cauc@degree}{master-professional}{%
          \cauc@mastertrue
          \cauc@masterprofessionaltrue
        }{%
          \cauc@error{Unknown degree type '\cauc@degree', expected: bachelor, doctor, master-academic, master-professional}{Use one of: degree=bachelor, degree=doctor, degree=master-academic, degree=master-professional}%
        }%
      }%
    }%
  }%
}
\cauc@parse@degree
\def\cauc@@temp{design}%
\ifx\cauc@Type\cauc@@temp
  \cauc@designtrue
\fi
\ifdefstring{\cauc@period}{proposal}{\cauc@proposaltrue}{\cauc@finaltrue}

\ifcauc@bachelor
  \providecommand{\cauc@topmargin}{2.5cm}
  \providecommand{\cauc@bottommargin}{2.5cm}
  \providecommand{\cauc@leftmargin}{3cm}
  \providecommand{\cauc@rightmargin}{2.5cm}
\else
  \providecommand{\cauc@topmargin}{2.5cm}
  \providecommand{\cauc@bottommargin}{2.5cm}
  \providecommand{\cauc@leftmargin}{2.5cm}
  \providecommand{\cauc@rightmargin}{2.5cm}
\fi

\ifcauc@openright
  \ifcauc@twoside
    \PassOptionsToClass{twoside,openright}{ctexrep}
  \else
    \PassOptionsToClass{oneside,openright}{ctexrep}
  \fi
\else
  \ifcauc@twoside
    \PassOptionsToClass{twoside,openany}{ctexrep}
  \else
    \PassOptionsToClass{oneside,openany}{ctexrep}
  \fi
\fi

\PassOptionsToPackage{no-math}{fontspec}
\PassOptionsToPackage{AutoFakeBold}{xeCJK}

% fontset=none: 由模板自行管理字体定义，避免ctex预定义字体与fonts.tex重定义冲突
\LoadClass[a4paper,punct,space,heading=true,fontset=none]{ctexrep}

% ctexrep(report类)无\frontmatter/\mainmatter/\backmatter命令，需手动定义
% 原始模板基于ctexrep，项目模板兼容book类写法
% 研究生前置页面使用罗马数字页码，并显示页眉（与原始模板一致）
% 本科前置页面不显示页眉和页码（与原始模板一致，原始模板本科前置页面使用pagestyle=empty）
\newcommand{\frontmatter}{%
    % 前置页面统一使用罗马数字编号。本科虽不显示页码，但保留内部编号，
    % 避免 \pagenumbering{gobble} 造成 PDF 页面锚点重名。
    \pagenumbering{Roman}%
    \ifcauc@bachelor
        \pagestyle{empty}%
        % 本科前置页面：临时将plain样式重定义为empty，避免\chapter*触发页眉
        \fancypagestyle{plain}{%
            \fancyhf{}%
            \renewcommand{\headrulewidth}{0pt}%
        }%
    \else
        \pagestyle{fancy}%
    \fi
}
\newcommand{\mainmatter}{%
    % 先结束前置部分当前页，再切换页码与页面样式；
    % 否则在未生成目录（或目录被禁用）时，最后一页摘要会被改成正文页码和 fancy 页眉。
    % 使用 \clearpage 而不是 \cleardoublepage：openright 下的空白页由
    % 随后第一个 \chapter 的 \cleardoublepage 处理，避免 openany 时多插一页。
    \clearpage
    \pagenumbering{arabic}%
    \zihao{-4}%
    \pagestyle{fancy}%
    % 恢复plain样式：按当前的 headeronplain 设置重新定义（见 settings/format.tex）
    \cauc@setplainstyle
}
\newcommand{\backmatter}{%
}

\input{settings/packages}
\input{settings/fonts}
\input{settings/format}
\input{settings/contents}
\input{settings/commands}

% 封面页环境：封面不显示页码，也不生成 PDF 页面锚点；
% 封面结束后页码从罗马数字 I 重新开始，使摘要成为前置部分第 I 页。
% 关闭封面页锚点可避免与重置后的页码产生重复 destination。
\newenvironment{cauc@coverpage}{%
    \clearpage
    \pagenumbering{gobble}%
    \hypersetup{pageanchor=false}%
    \thispagestyle{empty}%
}{%
    \clearpage
    \pagenumbering{Roman}%
    \hypersetup{pageanchor=true}%
    % 封面各页会修改 headsep 与字号，这里恢复正文默认值
    \setlength{\headsep}{0.624cm}%
    \zihao{-4}%
}

\newcommand{\makecover}{%
    \makeatletter
    \input{settings/cover}%
    \makeatother
}

\def\cauc@validate@field#1#2{%
  \expandafter\ifx\csname cauc@#1\endcsname\@empty
    \ClassError{cauc_thesis}{%
      Required field '#1' is not set for #2 thesis%
      \MessageBreak
      Please set it via \string\caucsetup{#1=value} or \string\documentclass[#1=value]{cauc_thesis}%
    }{%
      #1 is required on the #2 cover page.%
    }%
  \fi
}
\def\cauc@warn@unused#1#2{%
  \expandafter\ifx\csname cauc@#1\endcsname\@empty\else
    \ClassWarning{cauc_thesis}{%
      Field '#1' is set but ignored for #2.%
      \MessageBreak
      You can safely remove it from your configuration.%
    }%
  \fi
}

% 必填字段检查放在 \AtBeginDocument，使导言区中的 \caucsetup 也能设置个人信息。
\AtBeginDocument{%
  \ifcauc@bachelor
    \@tfor\cauc@field:={StudentName}{StudentID}{Title}{Major}{Department}{AdvisorName}{SubmitYear}{SubmitMonth}\do{%
      \expandafter\cauc@validate@field\expandafter{\cauc@field}{bachelor}%
    }%
    \@tfor\cauc@field:={StudentNameEng}{AdvisorNameEng}{AdvisorNameOut}\do{%
      \expandafter\cauc@warn@unused\expandafter{\cauc@field}{degree=bachelor}%
    }%
  \fi

  \ifcauc@graduate
    \@tfor\cauc@field:={StudentName}{StudentID}{AdvisorName}{AdvisorNameEng}{Department}{SubmitYear}{SubmitMonth}{SubmitDay}{StudentNameEng}{DefenseYear}{DefenseMonth}{DefenseDay}{CLCNumber}{UDCNumber}{ResearchInterest}{DepartmentEng}{Title}{TitleEng}{Major}{DefenseDateEng}\do{%
      \expandafter\cauc@validate@field\expandafter{\cauc@field}{graduate}%
    }%
  \fi

  \ifcauc@masterprofessional
    \cauc@validate@field{AdvisorNameOut}{master-professional}%
    \cauc@validate@field{AdvisorNameEngOut}{master-professional}%
    \cauc@warn@unused{AdvisorNameEngSecond}{degree=master-professional}%
  \fi

  \ifcauc@doctor
    \cauc@validate@field{AdvisorNameEngOut}{doctor}%
    \cauc@warn@unused{AdvisorNameEngSecond}{degree=doctor}%
  \fi

  \ifcauc@masteracademic
    \cauc@validate@field{AdvisorNameEngSecond}{master-academic}%
    \cauc@warn@unused{AdvisorNameOut}{degree=master-academic}%
    \cauc@warn@unused{AdvisorNameEngOut}{degree=master-academic}%
  \fi
}

\newcommand{\makefrontmatter}{%
    \ifcauc@listcontents
        \ifcauc@bachelor
            % 本科目录页：调整页眉间距（与原始模板一致）
            \setlength{\cauc@saved@headsep}{\headsep}%
            \setlength{\headsep}{-0.3cm}%
        \fi
        \tableofcontents
        \ifcauc@bachelor
            \setlength{\headsep}{\cauc@saved@headsep}%
            % 本科目录页：强制使用empty页面样式（与原始模板一致）
            \thispagestyle{empty}%
        \fi
        \clearpage
    \fi
    \ifcauc@listfigures
        \listoffigures
        \ifcauc@bachelor
            % 本科插图目录页：强制使用empty页面样式
            \thispagestyle{empty}%
        \fi
        \clearpage
    \fi
    \ifcauc@listtables
        \listoftables
        \ifcauc@bachelor
            % 本科表格目录页：强制使用empty页面样式
            \thispagestyle{empty}%
        \fi
        \clearpage
    \fi
    % 页码保持前置页面的罗马数字，由 \mainmatter 切换为阿拉伯数字，
    % 避免符号说明等后续前置内容出现重复页码。
}
\newcommand{\maketableofcontents}{\ifcauc@listcontents\tableofcontents\fi}
\newcommand{\makelistoffigures}{\ifcauc@listfigures\listoffigures\fi}
\newcommand{\makelistoftables}{\ifcauc@listtables\listoftables\fi}

\newcommand{\StudentName}{\cauc@StudentName}
\newcommand{\StudentNameEng}{\cauc@StudentNameEng}
\newcommand{\StudentID}{\cauc@StudentID}
\newcommand{\AdvisorName}{\cauc@AdvisorName}
\newcommand{\AdvisorNameEng}{\cauc@AdvisorNameEng}
\newcommand{\AdvisorNameEngSecond}{\cauc@AdvisorNameEngSecond}
\newcommand{\AdvisorNameOut}{\cauc@AdvisorNameOut}
\newcommand{\AdvisorNameEngOut}{\cauc@AdvisorNameEngOut}
\newcommand{\Grade}{\cauc@Grade}
\newcommand{\Major}{\cauc@Major}
\newcommand{\Department}{\cauc@Department}
\newcommand{\DepartmentEng}{\cauc@DepartmentEng}
\newcommand{\Title}{\cauc@Title}
\newcommand{\TitleEng}{\cauc@TitleEng}
\newcommand{\SubmitYear}{\cauc@SubmitYear}
\newcommand{\SubmitMonth}{\cauc@SubmitMonth}
\newcommand{\SubmitDay}{\cauc@SubmitDay}
\newcommand{\DefenseYear}{\cauc@DefenseYear}
\newcommand{\DefenseMonth}{\cauc@DefenseMonth}
\newcommand{\DefenseDay}{\cauc@DefenseDay}
\newcommand{\DefenseDateEng}{\cauc@DefenseDateEng}
\newcommand{\ResearchInterest}{\cauc@ResearchInterest}
\newcommand{\CLCNumber}{\cauc@CLCNumber}
\newcommand{\UDCNumber}{\cauc@UDCNumber}
\newcommand{\Keywords}{\cauc@Keywords}
\newcommand{\KeywordsEng}{\cauc@KeywordsEng}

\AtBeginDocument{%
    \ifcauc@margin@pending
        \newgeometry{%
            top=\cauc@topmargin,
            bottom=\cauc@bottommargin,
            left=\cauc@leftmargin,
            right=\cauc@rightmargin
        }%
    \fi
    \ifcauc@bachelor
        \IfFileExists{gbt7714-2005-numerical.bst}{}{%
            \cauc@warning{Bibliography style gbt7714-2005-numerical.bst not found. Citations may not render correctly.}%
        }%
    \else
        \IfFileExists{gbt7714-numerical.bst}{}{%
            \cauc@warning{Bibliography style gbt7714-numerical.bst not found. Citations may not render correctly.}%
        }%
    \fi
}

\endinput
