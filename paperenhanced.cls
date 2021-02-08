% IDENTIFICATION =======================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{paperenhanced}[
    2021/02/05 Improvement of the paper documentclass
]

% Preliminary declarations =============================================
\RequirePackage{palatino}
\RequirePackage{tabularx}
\RequirePackage{cuted}
\RequirePackage{etoolbox}
\RequirePackage{pgffor}
\RequirePackage{array}
%\RequirePackage{enumitem}

\newif\iftoc
\newif\iftof
\newif\iftos

\tocfalse
\toffalse
\tosfalse


% Options ==============================================================

\DeclareOption{toc}{\toctrue}
\DeclareOption{tof}{\toftrue}
\DeclareOption{tos}{\tostrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{paper}}
\ProcessOptions\relax

\LoadClass{paper}

% Layout ===============================================================

\newcommand{\textbsf}[1]{\textbf{\textsf{#1}}}

% Set section font
\sectionfont{\large\textbsf}
\subsectionfont{\textbsf}
\subsubsectionfont{\textit}

%set font family to Palatino
\fontfamily{ppl}

% Force line justification
\emergencystretch=\maxdimen
\hyphenpenalty=0

% Set narrow margin
\usepackage[margin=2.5cm]{geometry}

% Black triangle as enumeration icon
\renewcommand{\labelitemi}{$\blacktriangleright$}


% Set bibliograpy font size to \footnotesize
%\renewcommand*{\bibfont}{\footnotesize}

% Title ================================================================


\makeatletter
\def\@maketitle{%
    \newpage
    \null
    \begin{flushleft}%
        \textbsf{\LARGE\ignorespaces\@title}\par%
        \smallskip
        \textsf{\large\ignorespaces\@subtitle}\par%
        \bigskip
        \textsf{\large\ignorespaces\@author}\par%
        \bigskip
        \hrule
    \end{flushleft}
}
\makeatother


% Front matter =========================================================

\newcommand{\theabstract}{Abstract}
\renewcommand{\abstract}[1]{\renewcommand{\theabstract}{#1}}
\newcommand{\thekeywords}{Keywords}
\renewcommand{\keywords}[1]{\renewcommand{\thekeywords}{#1}}

\newcommand{\tablerow}[2]{
    \begin{tabularx}{\linewidth}{@{}p{3.5cm}X@{}}
        \textbsf{#1} & #2 \\
    \end{tabularx}
}

\newcommand{\fmextras}{}
\newcommand{\fmextra}[2]{%
    \ifdefempty{\fmextras}
    {\appto\fmextras{\tablerow{#1}{#2}}}
    {\appto\fmextras{,\tablerow{#1}{#2}}}
}

\newcommand{\makefrontmatter}{
    \subsubsectionfont{\textbsf}
    \begin{strip}
        \textbsf{Abstract}\smallskip

        \theabstract\bigskip

        \textbsf{Keywords}\smallskip

        \thekeywords

        \iftoc\smalltableofcontents\fi
        \iftof\smalllistoftables\fi
        \iftos\smalllistoffigures\fi
        \bigskip

        \foreach \row in \fmextras {
            \row \smallskip

        }

        \hrule\bigskip

    \end{strip}
    \subsubsectionfont{\textit}

}

