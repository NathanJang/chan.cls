%% chan.cls
%% Copyright 2016 Jonathan Chan
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Jonathan Chan.
%
% This work consists of the file chan.cls.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{chan}[2016/10/15 Chanathan's Paper]

%% declare option(s)

%%%% initialise conditionals
\newif\if@haspartners
\newif\if@hasdate
\@hasdatetrue
\newif\if@shouldmaketitle
\@shouldmaketitletrue
\newif\if@shouldmakeheader
\@shouldmakeheadertrue
\newif\if@shouldmakeheadertitle
\@shouldmakeheadertitletrue
\newif\if@shouldmakeheaderdate
\@shouldmakeheaderdatetrue

%%%% actually declare options
\DeclareOption{a4paper}{%
    \PassOptionsToClass{a4paper}{article}%
}
\DeclareOption{notitle}{%
    \@shouldmaketitlefalse%
}
\DeclareOption{noheader}{%
    \@shouldmakeheaderfalse%
}
\DeclareOption{noheadertitle}{%
    \@shouldmakeheadertitlefalse%
}
\DeclareOption{nodate}{%
    \@hasdatefalse%
}
\DeclareOption{noheaderdate}{%
    \@shouldmakeheaderdatefalse%
}
\ExecuteOptions{letterpaper, 11pt} % because we're in 'Murica now
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{article}%
}

%%%% execute
\ProcessOptions{}


%% load the default packages
\LoadClass{article}

%%%% geometries
\RequirePackage[margin=2.5cm]{geometry}

\RequirePackage{fix-cm}

%%%% ISO date
\RequirePackage[english]{isodate}
\dateinputformat{LaTeX}
\renewcommand{\date}[1]{\global\def\@date{\isodate\printdate{#1}}}
\global\def\@date{\isodate{\today}}

%%%% url
\RequirePackage{url}

%%%% ifthen
\RequirePackage{ifthen}


%% redefine maketitle
\global\def\@author{Jonathan Chan}
\renewcommand{\author}[1]{\global\def\@author{#1}}

\global\def\@course{Course Title}
\newcommand{\course}[1]{\global\def\@course{#1}}

\global\def\@instructor{Instructor's Name}
\newcommand{\instructor}[1]{\global\def\@instructor{#1}}

\global\def\@ta{TA's Name}
\newcommand{\ta}[1]{\global\def\@ta{#1}}

\newcommand{\partners}[1]{\@haspartnerstrue\global\def\@partners{#1}}

%%%% shorttitle for headers
\global\def\@title{Title}
\renewcommand{\title}[1]{\global\def\@title{#1}}

\global\def\@subtitle{Subtitle}
\newcommand{\subtitle}[1]{\global\def\@subtitle{#1}}

\global\def\@headername{Chan}
\newcommand{\headername}[1]{\global\def\@headername{#1}}


%% Make title by default
\AtBeginDocument{\if@shouldmaketitle\maketitle\fi}

\renewcommand\maketitle{{%
    \setlength{\parskip}{0cm}%
    \noindent\@author\par%
    \if@haspartners%
        \noindent Partner(s): \@partners\par% chktex 36
    \fi%
    \noindent\@instructor\par%
    \noindent TA:~\@ta\par%
    \noindent\@course\par%
    \if@hasdate%
        \noindent\@date\par%
    \fi%
    \begin{center}%
        \@title%
        \ifthenelse{\equal{\@subtitle}{}}{}{:\\\@subtitle}%
    \end{center}%
}}

%% headers
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\if@shouldmakeheadertitle%
    \lhead{\protect\@title}%
\fi
\if@hasdate\if@shouldmakeheaderdate%
    \chead{\protect\@date}%
\fi\fi
\rhead{\protect\@headername\ \thepage}
\renewcommand{\headrulewidth}{0cm}

\cfoot{}

\setlength{\voffset}{0.3cm}
\setlength{\headsep}{0.5cm}

%% watermarks
\RequirePackage{draftwatermark}
\newcommand\watermark[1]{\SetWatermarkText{#1}}
\newcommand\watermarkscale[1]{\SetWatermarkScale{#1}}
\newcommand\draft[1]{\watermark{DRAFT #1}}
\watermark{}

%% section headings
\RequirePackage{titlesec}
\setcounter{secnumdepth}{4}

\titleformat{\section}{\Large\bfseries}{\thesection}{.5cm}{}
\titlespacing*{\section}{0pt}{.5cm}{.25cm}

\titleformat{\subsection}{\large\bfseries}{\thesubsection}{.5cm}{}
\titlespacing*{\subsection}{0pt}{.5cm}{.25cm}

\titleformat{\subsubsection}{\normalsize\bfseries}{\thesubsubsection}{.5cm}{}
\titlespacing*{\subsubsection}{0pt}{.5cm}{.25cm}

\titleformat{\paragraph}{\normalsize\bfseries}{\theparagraph}{.5cm}{}
\titlespacing{\paragraph}{0pt}{.5cm}{.25cm}

%% table of contents
\setcounter{tocdepth}{4}
\newcommand{\usection}[1]{\pagebreak\section*{#1}\addcontentsline{toc}{section}{#1}}
\newcommand{\usubsection}[1]{\subsection*{#1}\addcontentsline{toc}{subsection}{#1}}
\newcommand{\usubsubsection}[1]{\subsubsection*{#1}\addcontentsline{toc}{subsubsection}{#1}}
\newcommand{\uparagraph}[1]{\paragraph*{#1}\addcontentsline{toc}{paragraph}{#1}}

%% paragraph styles
\raggedright{}
\RequirePackage{setspace}
\RequirePackage{indentfirst}
\onehalfspacing{}

\setlength{\parindent}{1cm}

%% items
\RequirePackage{enumitem}
\setlist{leftmargin=1cm}


%% footnotes
\renewcommand{\thefootnote}{\fnsymbol{footnote}}


%% abstracts
\renewcommand{\abstract}[1]{\noindent\emph{#1}\vspace{0.25cm}}


%% word count
\newcommand{\wordcount}[1]{\begin{flushright}(#1\ words)\end{flushright}} % chktex 36


\endinput
