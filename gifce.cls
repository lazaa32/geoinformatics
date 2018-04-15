% gifce.cls
%
% Copyright 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018
%           Ales Cepek and Martin Landa
%
% You may use, modify, and redistribute this file in any way you please, so
% long as this copyright notice is maintained.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gifce}[2018/03/10 v2.7 Geoinformatics FCE CTU class]% YY/MM/DD
\LoadClass[11pt,a4paper]{book}

\RequirePackage[backend=biber,style=numeric]{biblatex}
\RequirePackage[utf8]{inputenc}
\RequirePackage{csquotes}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage[english]{babel}
\RequirePackage{amsmath}
\RequirePackage{amssymb,amsfonts,textcomp}
\RequirePackage{color}
\RequirePackage{array}
\RequirePackage{hhline}
\RequirePackage[pdftex,unicode,breaklinks=true,colorlinks=true,urlcolor=blue,
                citecolor=black,linkcolor=black]{hyperref}
\RequirePackage[pdftex]{graphicx}
\RequirePackage{alltt}
\RequirePackage{parskip}
\RequirePackage{multirow}
\RequirePackage{longtable}
\RequirePackage{supertabular}
\RequirePackage[normalem]{ulem}
\RequirePackage{a4wide}
\RequirePackage{fancyhdr}
\RequirePackage{latexsym}
\RequirePackage{wrapfig}
\RequirePackage{sectsty}
\RequirePackage{fncychap}
\RequirePackage{fancyvrb}
\RequirePackage{listings}
\RequirePackage{colortbl}
\RequirePackage{fancyvrb}
\RequirePackage{rotating}
\RequirePackage[tableposition=top]{caption}
\RequirePackage{subscript}
\RequirePackage{epstopdf}
\RequirePackage{verbatim}
\RequirePackage{siunitx}

%RequirePackage{doi}
\typeout{}
\typeout{gifce.cls : using edited version of doi.sty with preferred short url}
\typeout{----------- https://doi.org/10.123/456}
\typeout{}
%--- \NeedsTeXFormat{LaTeX2e}
%--- \ProvidesPackage{doi}[2007/07/24 handle doi numbers]

%% This style file is based original code written by Heiko Oberdiek
%% and published on comp.text.tex. It was packaged with permission
%% as a style file by Maarten Sneep, with some minor changes suggested
%% by Bruno Voisin to accomodate the Apple pdf framework
%%
%% This code is placed under the LPPL.
%%
%% Original discussion on Google under:
%% http://groups.google.com/group/comp.text.tex/msg/922919daa207d613
%%
%% You can hyperlink DOI numbers to dx.doi.org. Some publishers have elected to
%% use some nasty characters in their doi numbering scheme (<, >, ; have all
%% been spotted). This will either upset (La)TeX, or your pdf reader. This style
%% file contains a user-level command \doi{}, which takes a doi number,
%% and creates a hyperlink from it. The format of the doi can be controlled by
%% redefining the \doitext command, which does not take an argument (unlike the
%% command with the same name in the doipubmed package).
%%
%% Note: the \doi{} command connot be used within other macros.

%% Change history:
%% December 15, 2003: original code posted on Usenet (see link above)
%% Somewhere in 2005: Bruno Voisin suggests some changes to accomodate the
%%     Apple pdf framework on the Tex on Mac OS X mailing list.
%% April 2007: Maarten packages the lot, and Karl Ove Hufthammer fixes a
%%     few bugs introduced by Maarten (oops).
%%     A \doitext command is added, following the example from doipubmed.
%%     Some comments are added to make the code a little more readable.
%% July 2007: Michael Orlov sends in a patch to correctly handle underscores.

%% We need hyperref, but you probably want to load hyperref
%% beforehand, or set some options later on.
\RequirePackage{hyperref}

%% to change the default prefix, redefine this command within your own code.
%% It takes no argument, which is different from the doipubmed package.
\newcommand{\doitext}{doi:}

%% the meat of the code
%% the first command opens a group, and changes a few catcodes.
\newcommand*{\doi}{%
  \begingroup
  \lccode`\~=`\#\relax
  \lowercase{\def~{\#}}%
  \lccode`\~=`\_\relax
  \lowercase{\def~{\_}}%
  \lccode`\~=`\<\relax
  \lowercase{\def~{\textless}}%
  \lccode`\~=`\>\relax
  \lowercase{\def~{\textgreater}}%
  \lccode`\~=0\relax
  \catcode`\#=\active
  \catcode`\_=\active
  \catcode`\<=\active
  \catcode`\>=\active
  \@doi
}

%% this is the actual command which processes the argument, with the catcodes
%% set in the previous command
%% it closes the group, and spits out the url.
\def\@doi#1{%
  \let\#\relax
  \let\_\relax
  \let\textless\relax
  \let\textgreater\relax
  \edef\x{\toks0={{#1}}}%
  \x
  \edef\#{\@percentchar23}%
  \edef\_{_}%
  \edef\textless{\@percentchar3C}% instead of {\string<} for Apple
  \edef\textgreater{\@percentchar3E}% instead of {\sting>} for Apple
  \edef\x{\toks1={\noexpand\href{https://doi.org/#1}}}%
  \x
  \edef\x{\endgroup\doitext\the\toks1 \the\toks0}%
  \x
}

%--- %% that's all folks.
%--- \endinput


\newif\ifgifcejournalArticle
\gifcejournalArticletrue

\fancyhf{}
\fancyhead[L]{{\sc \leftmark}}
\fancyfoot[R]{\thepage}
\fancyfoot[L]{Geoinformatics FCE CTU {%
    \gifcejournalVolume(\gifcejournalIssue),
    \gifcejournalYear}}

% getting the "Chapter" and chapter number out of the chapter text
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\footrulewidth}{0.5pt}

\fancypagestyle{plain}{
  \fancyhf{} % clear all fields
  \fancyhead[L]{\gifceChapterHead}
  \fancyfoot[R]{\ifgifcejournalArticle\gifcejournalLicense\fi\thepage}
  \fancyfoot[L]{Geoinformatics FCE CTU {%
      \gifcejournalVolume(\gifcejournalIssue), %
      \gifcejournalYear\ifgifcejournalArticle\gifceDOI\fi}}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0.5pt}
}

% Code for creating empty pages
% No headers on empty pages before new chapter
% v 2.4 added \gifcejournalArticlefalse to suppress printing DOI and licence
\makeatletter
\def\cleardoublepage{%
  \clearpage\if@twoside \ifodd\c@page\else
  \hbox{}\gifcejournalArticlefalse%
  \thispagestyle{plain}
  \newpage
  \if@twocolumn\hbox{}\newpage\fi\fi\fi}
\makeatother \clearpage{\pagestyle{plain}\cleardoublepage}

% \breakslash is used for URLs to allow linebreaking
\newcommand{\breakslash}{\discretionary{/}{}{/}}

% defines the colour for the background of code examples
\definecolor{LightGrey}{gray}{0.9}

\lstdefinestyle{gifceC++}{%
%\lstset{%
language=C++,
showstringspaces=false,
basicstyle=\small\ttfamily,
commentstyle=\color[named]{BrickRed}\ttfamily,
keywordstyle=\color[named]{Purple}\ttfamily,
identifierstyle=\color[named]{Blue}\ttfamily,
%functionstyle=\color[named]{Blue}\ttfamily,
%typestyle=\color[named]{ForestGreen}\ttfamily,
stringstyle=\color[named]{Tan}\ttfamily,%
morekeywords={,complex,}%
frame=none,%
backgroundcolor=\color{LightGrey}%
}

% this implements nicely formatted C++ code
\lstnewenvironment{codeCpp}{\lstset{style=myC++}}{}

\makeatletter
\ChTitleVar{\huge\bf\centering}   % sets the style for title
\renewcommand{\DOCH}{%
}
\renewcommand{\DOTI}[1]{%
  \CTV\FmTi{#1}\par\nobreak
  \vskip 10\p@}
\renewcommand{\DOTIS}[1]{%
  \CTV\FmTi{#1}\par\nobreak
  \vskip 10\p@}
\makeatother

\pagestyle{fancy}

\newcommand{\gifcejournalYear}{XXXX}
\newcommand{\gifcejournalVolume}{X}
\newcommand{\gifcejournalIssue}{X}
\newcommand{\gifcejournalTitle}{}
\newcommand{\gifcejournalShortTitle}{}
\newcommand{\gifcejournalKeywords}{}
\newcommand{\gifcejournalAuthors}{}
\newcommand{\gifcejournalLicense}{%
           \ifgifceRelease%
           \href{http://creativecommons.org/licenses/by/4.0/}%
                {\raisebox{-2ex}{%
                    \IfFileExists{by.pdf}%
                       {\includegraphics[height=4ex]{by.pdf}}%
                       {\IfFileExists{../by.pdf}%
                         {\includegraphics[height=4ex]{../by.pdf}}{}}%
                }}%
                \hspace{1.2em}\fi}

\newcommand{\gifceAuthors}[1]{\renewcommand{\gifcejournalAuthors}%
  {#1}\renewcommand{\gifcejournalAuthors}{\ignorespaces#1}}
\newcommand{\gifceYear}[1]{\renewcommand{\gifcejournalYear}{#1}}
\newcommand{\gifceVolume}[1]{\renewcommand{\gifcejournalVolume}{#1}}
\newcommand{\gifceIssue}[1]{\renewcommand{\gifcejournalIssue}{#1}}
\newcommand{\gifceTitle}[1]{\renewcommand{\gifcejournalTitle}{#1}}
\newcommand{\gifceShortTitle}[2]{\renewcommand{\gifcejournalShortTitle}%
  {\ifgifceNames#1\fi: #2}}
\newcommand{\gifceKeywords}[1]{\renewcommand{\gifcejournalKeywords}{#1}}
\newcommand{\gifceChapterNumber}[1]{\setcounter{chapter}{#1}%
                                    \addtocounter{chapter}{-1}}
\newcommand{\gifceChapterPage}[1]{\setcounter{page}{#1}}

% to be possibly redefined in gifce.def
\newcommand{\gifceChapterHead}{}
\IfFileExists{gifce.def}{\input{gifce.def}}{
  \IfFileExists{../gifce.def}{\input{../gifce.def}}{}
}

% sectioning ------------------------------------------------------------------

\setcounter{secnumdepth}{2}
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\arabic{section}.\arabic{subsection}}
\renewcommand{\theequation}{\arabic{equation}}
\renewcommand{\thefigure}{\arabic{figure}}
\renewcommand{\thetable}{\arabic{table}}

\RequirePackage[compact]{titlesec}
\titleformat{\chapter}[display]%
   {\fontsize{18}{20}\bfseries}%
   {}%
   {0em}%
   {}%
\titlespacing*{\chapter}{0pt}{-16ex}{0pt}
\titleformat{\section}[block]%
  {\fontsize{12}{15}\bfseries}%
  {\thesection.}%
  {0.5em}%
  {}%
\titleformat{\subsection}[block]%
  {\fontsize{12}{15}\itshape}%
  {\thesubsection.}%
  {0.5em}%
  {}%
\titleformat{\subsubsection}[block]%
  {\fontsize{12}{15}\itshape}%
  {\thesubsusection.}%
  {0.5em}%
  {}%

% abstract, keywords and akcnowledgements
\newenvironment{abstract}%
    {\vspace{2em}\hrule\textbf{\abstractname.}}%
    {\\[0.5em]%
    \keywords{\gifcejournalKeywords}}
\newcommand{\keywords}[1]{%
      \if\relax #1\relax\else%
      \noindent\textbf{Keywords:} #1.\null\\[-0.5em]\fi\hrule}
\newenvironment{acknowledgements}%
    {\section*{Acknowledgements}}%
    {}


% end of sections definitions -------------------------------------------------

% name, affiliation, ID, separator
\newcommand{\gifceAuthor}[4]{#1\if\relax #4\relax\else;\ \fi}
\newcommand{\gifceResetAuthor}{
\renewcommand{\gifceAuthor}[4]{%
  \ifx&##2##3&##1##4%       ##2 and #3 both empty --> return #1     name
  \else%
  \ifx&##3&##1\textsuperscript{##2}##4%  #3 empty --> #1^#2  name^affiliation
  \else%
  \ifx&##2&\href{##3}{##1}##4%           #2 empty --> \href{affiliation}{name}
  \else%
  \href{##3}{##1{\color{black}\textsuperscript{##2}}}##4%
  \fi\fi\fi}
}

\newcommand{\gifceAffiliation}[1]{\noindent{\def\leftShift{1.2ex}%
    \makebox[-\leftShift]{\textsuperscript{#1}}\makebox[\leftShift]{}}}

\newcommand{\gifceDOI}{, \doi{\gifcedoi}}
\newcommand{\gifcedoi}{10.14311/gi.%
  \ifgifceRelease\gifcejournalVolume.\gifcejournalIssue.\thechapter%
  \else{...}\fi}

% watermark -------------------------------------------------------------------

\newcommand{\gifceConditionalWaterMark}{
\ifgifceWatermark
%usepackage{blindtext}
%usepackage[pagewise]{lineno}
%\linenumbers
%usepackage{graphicx}
%usepackage{color}
%usepackage{type1cm}
\RequirePackage{eso-pic}
\makeatletter
  \AddToShipoutPicture{%\
    \setlength{\unitlength}{1cm}%
    \put(10,18){%
      \makebox(0,0){\rotatebox{45}{\textcolor[gray]{0.85}%
          {\fontsize{3cm}{3cm}\selectfont{\normalfont%
              \ifgifceRelease{Future Issue}\else{Preview}\fi}}}}%
    }
    \put(10,14.5){%
      \makebox(0,0){\rotatebox{45}{\textcolor[gray]{0.85}%
           {\fontsize{1.5cm}{1.5cm}%
                \selectfont{\normalfont\makebox(4,0){}\today}}}}
    }
\makeatother
}
\fi
}

% end of gifceConditionalWaterMark definition ------------------------------


% for double-blind review set \gifceNamesfalse
\newif\ifgifceNames
\gifceNamestrue
%
\newif\ifgifceRelease
\gifceReleasetrue
%
\newif\ifgifceWatermark
\gifceWatermarktrue

% bibtex / biber -------------------------------------------------------------

\DeclareFieldFormat{doi}{%
  \mkbibacro{DOI}\addcolon\space
  \ifhyperref
    {\href{https://doi.org/#1}{\nolinkurl{#1}}}
    {\nolinkurl{#1}}}

\DeclareSourcemap{
  \maps[datatype=bibtex]{
    \map{% removes url + urldate field from all entries that have a doi field
       \step[fieldsource=doi, final]
       \step[fieldset=url, null]
       \step[fieldset=urldate, null]
    }
  }
}

% end of bibtex / biber -------------------------------------------------------
