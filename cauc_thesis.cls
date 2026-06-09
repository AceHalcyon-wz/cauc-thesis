\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cauc_thesis}
              [2025/06/01 Unified LaTeX Template for CAUC Thesis]
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
\DeclareStringOption[thesis]{Type}[thesis]
\DeclareStringOption[final]{period}[final]

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

\newcommand{\cauc@linespacing}{}
\newcommand{\cauc@headertext}{}
\newcommand{\cauc@captionlabelsep}{}
\newcommand{\cauc@draftwatermark}{DRAFT}
\newcommand{\cauc@coverlogo}{./pic/pic1.jpg}
\newcommand{\cauc@coverimage}{./pic/pic2.png}
\newif\ifcauc@margin@pending
\cauc@margin@pendingfalse

\newcommand{\caucsetup}[1]{%
    \pgfkeys{
        /caucsetup/.cd,
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
        Type/.store in=\cauc@Type,
        Type/.append code={\def\cauc@@temp{design}\ifx\cauc@Type\cauc@@temp\cauc@designtrue\else\cauc@designfalse\fi},
        localfonts/.store in=\cauc@localfonts,
        mathfont/.store in=\cauc@mathfont,
        period/.store in=\cauc@period,
        period/.append code={\ifdefstring{\cauc@period}{proposal}{\cauc@proposaltrue\cauc@finalfalse}{\cauc@proposalfalse\cauc@finaltrue}},
        coverlogo/.store in=\cauc@coverlogo,
        coverimage/.store in=\cauc@coverimage,
        coverinfowidth/.code={\setlength{\cauc@cover@infowidth}{##1}},
        coverlabelwidth/.code={\setlength{\cauc@cover@labelwidth}{##1}},
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
        /.unknown/.code={\cauc@warning{Unknown key '\pgfkeyscurrentkey' in caucsetup}},
        #1
    }%
}

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
  \newcommand{\cauc@topmargin}{2.5cm}
  \newcommand{\cauc@bottommargin}{2.5cm}
  \newcommand{\cauc@leftmargin}{3cm}
  \newcommand{\cauc@rightmargin}{2.5cm}
\else
  \newcommand{\cauc@topmargin}{2.5cm}
  \newcommand{\cauc@bottommargin}{2.5cm}
  \newcommand{\cauc@leftmargin}{2.5cm}
  \newcommand{\cauc@rightmargin}{2.5cm}
\fi

\ifcauc@openright
  \ifcauc@twoside
    \PassOptionsToClass{openright}{ctexrep}
  \else
    \PassOptionsToClass{openright,oneside}{ctexrep}
  \fi
\else
  \ifcauc@twoside
    \PassOptionsToClass{openany}{ctexrep}
  \else
    \PassOptionsToClass{openany,oneside}{ctexrep}
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
    \ifcauc@bachelor
        \pagestyle{empty}%
        % 本科前置页面：临时将plain样式重定义为empty，避免\chapter*触发页眉
        \fancypagestyle{plain}{%
            \fancyhf{}%
            \renewcommand{\headrulewidth}{0pt}%
        }%
    \else
        \pagenumbering{Roman}%
        \pagestyle{fancy}%
    \fi
}
\newcommand{\mainmatter}{%
    \pagenumbering{arabic}%
    \zihao{-4}%
    \pagestyle{fancy}%
    % 恢复plain样式：章节起始页显示页眉（与原始模板一致）
    \ifcauc@headeronplain
      \fancypagestyle{plain}{
          \fancyhf{}
          \fancyhead[C]{\cauc@header@text}
          \fancyfoot[C]{\thepage}
          \renewcommand{\headrulewidth}{0.5pt}
      }%
    \fi
}
\newcommand{\backmatter}{%
}

\input{settings/packages}
\input{settings/fonts}
\input{settings/format}
\input{settings/contents}
\input{settings/commands}

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

\ifcauc@bachelor
  \@tfor\cauc@field:={StudentName}{StudentID}{Title}{Major}{Department}{AdvisorName}{SubmitYear}{SubmitMonth}\do{%
    \expandafter\cauc@validate@field\expandafter{\cauc@field}{bachelor}%
  }%
  \@tfor\cauc@field:={StudentNameEng}{AdvisorNameEng}{AdvisorNameOut}\do{%
    \expandafter\cauc@warn@unused\expandafter{\cauc@field}{degree=bachelor}%
  }%
\fi

\ifcauc@graduate
  \@tfor\cauc@field:={StudentName}{StudentID}{AdvisorName}{AdvisorNameEng}{Department}{SubmitYear}{SubmitMonth}{StudentNameEng}{DefenseYear}{CLCNumber}{UDCNumber}{ResearchInterest}{DepartmentEng}{Title}{TitleEng}{Major}{DefenseDateEng}\do{%
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
  \cauc@warn@unused{AdvisorNameOut}{degree=master-academic}%
  \cauc@warn@unused{AdvisorNameEngOut}{degree=master-academic}%
\fi

\newcommand{\makefrontmatter}{%
    \ifcauc@listcontents
        \ifcauc@bachelor
            % 本科目录页：去除页码，调整页眉间距（与原始模板一致）
            \setlength{\cauc@saved@headsep}{\headsep}%
            \setlength{\headsep}{-0.3cm}%
            \pagenumbering{gobble}%
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
        \ifcauc@bachelor
            % 本科插图目录页：去除页码
            \pagenumbering{gobble}%
        \fi
        \listoffigures
        \ifcauc@bachelor
            % 本科插图目录页：强制使用empty页面样式
            \thispagestyle{empty}%
        \fi
        \clearpage
    \fi
    \ifcauc@listtables
        \ifcauc@bachelor
            % 本科表格目录页：去除页码
            \pagenumbering{gobble}%
        \fi
        \listoftables
        \ifcauc@bachelor
            % 本科表格目录页：强制使用empty页面样式
            \thispagestyle{empty}%
        \fi
        \clearpage
    \fi
    % 所有前置目录完成后，重置页码为阿拉伯数字从1开始
    \pagenumbering{arabic}%
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

\IfFileExists{cauc_thesis.cfg}{\input{cauc_thesis.cfg}}{%
  \ClassInfo{cauc_thesis}{No cauc_thesis.cfg found. Please copy cauc_thesis.cfg.example to cauc_thesis.cfg and fill in your personal information.}%
}

\endinput
