\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mythesis}[2025/01/11]

\def\mythesis@baseclass{book}

% Define boolean switches for options
\newif\ifshowlinenum
\newif\ifshowframe
\newif\ifwatermark
\newif\ifprovisional
% Set default to final (not provisional)
\provisionalfalse

% Declare options
\DeclareOption{showlinenum}{\showlinenumtrue}
\DeclareOption{showframe}{\showframetrue}
\DeclareOption{watermark}{\watermarktrue}
\DeclareOption{provisional}{\provisionaltrue}
\DeclareOption{final}{\provisionalfalse}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\mythesis@baseclass}}

\ProcessOptions\relax
\LoadClass[a4paper, 12pt, twoside]{\mythesis@baseclass}

% Set front page and cover page based on provisional flag
\ifprovisional
  \newcommand{\frontpagefile}{frontpage_provisional}%
  \newcommand{\coverpagefile}{coverpage_provisional}%
\else
  \newcommand{\frontpagefile}{frontpage_final}%
  \newcommand{\coverpagefile}{coverpage_final}%
\fi

% Load packages based on options
\ifshowlinenum
  \RequirePackage[switch, modulo, pagewise]{lineno}
  \linenumbers
\fi

\ifshowframe
  \RequirePackage{showframe}
\fi

\ifwatermark
  \RequirePackage[hpos={\ifodd\thepage \dimexpr0.92\paperwidth\else \dimexpr0.07\paperwidth\fi}, vpos=0.5\paperheight, angle=90, vanchor=m, hanchor=c, fontsize=0.8\marginparwidth, text={\normalfont DRAFT - {\today}\, - DRAFT}]{draftwatermark}
\fi

%% All the languages you need go here
\RequirePackage[utf8]{inputenc}
\RequirePackage[portuguese,british]{babel}  % Last one listed is the one initially used
\addto\captionsbritish{% Replace "british" with the language you use
        \renewcommand{\contentsname}{Contents}  % rename 'Contents'
        \renewcommand{\listfigurename}{List of figures}  % rename 'List of Figures' in ToC
        \renewcommand{\listtablename}{List of tables}  % rename 'List of Tables' in ToC
}

\RequirePackage{setspace} %% Space between lines of text for main text and bibliography
\setstretch{1.5}  % Use 1.241 for 1.5 spacing at 12pt font following https://www.overleaf.com/learn/latex/Articles/How_to_change_paragraph_spacing_in_LaTeX#Understanding_and_calculating_values_for_\baselinestretch

% Font configuration for captions
\RequirePackage[font={singlespacing}]{caption}
\DeclareCaptionFont{myfont}{\fontsize{9pt}{11pt}\selectfont}
\captionsetup{font=myfont}
\RequirePackage{subcaption}
\subcaptionsetup{font=myfont, position=top, skip=0pt}

\parindent 1cm % Indentation space
\raggedbottom % Avoid correction of text spacing

%% FONTS
%% This loads a font for both text and math modes. The website https://tug.org/FontCatalogue/ lists all available fonts.
% \RequirePackage[sc]{example_font}
% Loads text fonts
\RequirePackage[T1]{fontenc}
% One option is loading directly Times News Roman-like fonts
\RequirePackage{newtxtext,newtxmath}
% Another option uses fontspec package (only with LuaLaTeX or XeLaTeX)
% \RequirePackage{fontspec}
% Set the main font to a Times New Roman-like font
% \setmainfont{Times New Roman} % or another Times New Roman-like font

% Select font families. Select according to University rules
%\renewcommand*{\sfdefault}{ptm}
%\newcommand*{\numfont}{\fontfamily{ptm}\selectfont}
%\newcommand*{\headfont}{\bfseries\fontfamily{ptm}\selectfont}
%\newcommand*{\secfont}{\bfseries\fontfamily{ptm}\selectfont}
% add lowercase black-board letters
\DeclareFontFamily{U}{stix2bb}{\skewchar\font127 }
\DeclareFontShape{U}{stix2bb}{m}{n} {<-> stix2-mathbb}{}
\DeclareMathAlphabet{\mathbb}{U}{stix2bb}{m}{n}

\RequirePackage{xcolor}
% custom colours definitions
\definecolor{violet}{rgb}{0.38, 0.31, 0.86}
\definecolor{mauve}{RGB}{161, 164, 209}
\definecolor{black}{rgb}{0.0, 0.0, 0.0}
\definecolor{reddish}{HTML}{C70039}
\definecolor{lightblue}{HTML}{2D77A8}
\definecolor{burgundy}{rgb}{0.3,0,0}
\definecolor{softblue}{HTML}{3D4AAF}
\definecolor{light-gray}{gray}{0.5}

% Hack to permit automatic hyphenation after an actual hyphen. From TUGboat
\newcommand{\hyph}{-\penalty\z@\hskip\z@skip }
\renewcommand{\slash}{/\penalty\z@\hskip\z@skip } % "breakable" slash

% Define Chapter, Section, and Subsection headings
% There are no regulations for these configurations,
% Thus, users can change them as wanted.
\RequirePackage{titlesec}
\RequirePackage{etoolbox}
\RequirePackage{fix-cm}  % Helps in fixing paging issues

%Customize chapter headings
\titleformat{\chapter}[display]
  {\normalfont\huge\bfseries}
  {\vspace{-2.5cm}\filleft{\fontsize{50}{20}\selectfont\textnormal{\thechapter}}} % Include chapter number
  {0pt}
  {\vspace*{-1cm}\color{black}\rule{\textwidth}{1pt}\vspace*{-0.35cm}\\\filcenter}
  [\vspace*{-0.75cm}\color{black}\rule{\textwidth}{1pt}\vspace*{-1cm}]

%Customize numberless chapter headings
\titleformat{name=\chapter, numberless}[display]
  {\normalfont\huge\bfseries}
  {} % Do not include chapter number
  {0pt}
  {\vspace*{-5.3cm}\color{black}\rule{\textwidth}{1pt}\vspace*{-0.35cm}\\\filcenter}
  [\vspace*{-0.75cm}\color{black}\rule{\textwidth}{1pt}\vspace*{-1cm}]

% Customize sections and subsections (if needed)
\titleformat{\section}[hang]
  {\normalfont\LARGE\bfseries}
  {\thesection}
  {1em}
  {}
  []

\titleformat{\subsection}[hang]
  {\normalfont\Large\bfseries}
  {\thesubsection}
  {1em}
  {}
  []

\titleformat{\subsubsection}[hang]
  {\normalfont\large\bfseries}
  {}
  {1em}
  {}
  []

% To make cites and references
\RequirePackage[hidelinks, pdfusetitle, pdfdisplaydoctitle, breaklinks=true, linktoc=all]{hyperref} % If you want clickable links in the .pdf file
% select colours in hyperlinks
\hypersetup{
    colorlinks=true,
    linkcolor=softblue,
    citecolor=softblue,
    filecolor=.,      
    urlcolor=softblue% color we defined above
}

\RequirePackage{breakcites}  % references do not go through margins
\RequirePackage{csquotes}  % Quotation marks management
\RequirePackage{doi}  % Add good DOI styling to bibliography
\renewcommand*{\doitext}{} % to make doi addresses links

%% The following two lines ensure that you set your page dimensions and margins *exactly* as for University requirements.
\RequirePackage{geometry}
\geometry{margin=2.5cm, headheight=0.75cm}

\RequirePackage{aas_macros}  % Journals naming
\RequirePackage{adjustbox}
\RequirePackage{array}
\RequirePackage{color}
\RequirePackage[shortlabels]{enumitem}
% Indentation for first line of Chapter
\RequirePackage{indentfirst}

% Bibliography (and not ToC) to the ToC
\RequirePackage[nottoc]{tocbibind}
\RequirePackage{afterpage}
% To add to-do notes and comment blocks
\setlength{\marginparwidth}{2cm}
\RequirePackage[colorinlistoftodos]{todonotes}
\RequirePackage{comment}
% To make pretty tables
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{longtable}
\RequirePackage{rotating}
\RequirePackage{pdflscape}
\RequirePackage{threeparttable}  % Notes in tables
\RequirePackage{threeparttablex}  % Notes in longtables
\hfuzz=6.001pt
\RequirePackage{etoolbox}
\appto\TPTnoteSettings{\fontsize{9pt}{11pt}\selectfont}  % Font size notes in tables
% Floats
\RequirePackage{float}
\restylefloat{figure}
\RequirePackage{wrapfig}
\RequirePackage{graphicx}

% Glossary and acronyms
\RequirePackage[acronym, abbreviations, symbols, nogroupskip, sort=standard, hyperfirst=true, shortcuts, nonumberlist]{glossaries-extra}
\setabbreviationstyle[acronym]{long-short}
\setabbreviationstyle[abbreviation]{long-short}
\glssetcategoryattribute{general}{glossdesc}{firstuc} % first letter upper case in LoG
\glssetcategoryattribute{acronym}{glossdesc}{firstuc} % first letter upper case in LoG
\glssetcategoryattribute{symbol}{glossdesc}{firstuc} % first letter upper case in LoG
\setlength{\glsdescwidth}{0.8\textwidth}
\newcommand*\myglsentry[1]{%
  \protect\ifglsused{#1}{%
    \glsentryshort{#1}%
  }{%
    \glsentrylong{#1}%
  }%
}

% Define details of thesis
% Usage: \command{<value>}
\newcommand*{\authorlongname}[1]{
            \def\@authorlongname{#1}
}
\newcommand*{\authorshortname}[1]{
            \def\@authorshortname{#1}
}
\newcommand*{\thesistitle}[1]{
            \def\@thesistitle{#1}
}
\newcommand*{\degree}[1]{
            \def\@degree{#1}
}
\newcommand*{\speciality}[1]{
            \def\@speciality{#1}
}
\newcommand*{\supervisors}[3]{
            \def\@supervisorA{#1}
            \def\@supervisorB{#2}
            \def\@supervisorC{#3}
}
\newcommand*{\supervisorA}[1]{
            \def\@supervisorA{#1}
}
\newcommand*{\supervisorB}[1]{
            \def\@supervisorB{#1}
}
\newcommand*{\supervisorC}[1]{
            \def\@supervisorC{#1}
}
\newcommand*{\jurypresident}[1]{
            \def\@jurypresident{#1}
}
\newcommand*{\jurymembers}[6]{
              \def\@jurymemberA{#1}
              \def\@jurymemberB{#2}
              \def\@jurymemberC{#3}
              \def\@jurymemberD{#4}
              \def\@jurymemberE{#5}
              \def\@jurymemberF{#6}
}
\newcommand*{\jurymemberA}[1]{
              \def\@jurymemberA{#1}
}
\newcommand*{\jurymemberB}[1]{
              \def\@jurymemberB{#1}
}
\newcommand*{\jurymemberC}[1]{
              \def\@jurymemberC{#1}
}
\newcommand*{\jurymemberD}[1]{
              \def\@jurymemberD{#1}
}
\newcommand*{\jurymemberE}[1]{
              \def\@jurymemberE{#1}
}
\newcommand*{\jurymemberF}[1]{
              \def\@jurymemberF{#1}
}
\newcommand*{\coveracknowledgement}[1]{
              \def\@coveracknowledgement{#1}
}

\newcommand*{\showdegree}{
  \textbf{\@degree}\\
  \ifthenelse{\isundefined{\@speciality} \OR \equal{\@speciality}{}}
    {}
    {\@speciality\\}
}

\newcommand*{\showthesistitle}{
  \textbf{\foreignlanguage{british}{\@thesistitle}}\\% can change language
}

\newcommand*{\showauthorlongname}{
  \@authorlongname\\%
}

\newcommand*{\showsupervisors}{
  \@supervisorA\\
  \ifthenelse{\isundefined{\@supervisorB} \OR \equal{\@supervisorB}{}}
    {}
    {\@supervisorB\\}
  \ifthenelse{\isundefined{\@supervisorC} \OR \equal{\@supervisorC}{}}
    {}
    {\@supervisorC\\}
}

\newcommand*{\showjury}{
  \begin{raggedright}
    \begin{singlespace}
        Juri:\\% de acordo com o edital da prova
        \begin{description}[leftmargin=!, labelwidth=\widthof{Presidente:}, font=\normalfont, nosep]
            \item[Presidente:] \@jurypresident
        \end{description}
        \begin{description}[leftmargin=!, labelwidth=\widthof{Vogais:}, font=\normalfont, nosep]
            \item[Vogais:] \@jurymemberA
            \item \@jurymemberB
            \item \@jurymemberC
            \item \@jurymemberD
            \ifthenelse{\isundefined{\@jurymemberD} \OR \equal{\@jurymemberD}{}}
            {}
            {\item \@jurymemberD}
            \ifthenelse{\isundefined{\@jurymemberE} \OR \equal{\@jurymemberE}{}}
            {}
            {\item \@jurymemberE}
        \end{description}
    \end{singlespace}
  \end{raggedright}
}

\newcommand*{\showcoveracknowledgement}{
  \begin{singlespace}
    \@coveracknowledgement\\% also \foreignlanguage{british}{@coveracknowledgement\\}
  \end{singlespace}
}

\newcommand*{\blankpage}{%
    \null
    \thispagestyle{empty}%
    \addtocounter{page}{-1}%
    \newpage
}

\newcommand\@shorttitle{}
% define \theshorttitle to what is given
\newcommand\shorttitle[1]{\renewcommand\@shorttitle{#1}}

\AtEndPreamble{
  \hypersetup{
      pdftitle=\@thesistitle,
      pdfauthor=\@authorshortname,
      pdfsubject={FCUL thesis}
  }
}

%% Bibliography at the end of the thesis:
\RequirePackage[natbib=true, sorting=nymt, backend=biber, maxcitenames=2, maxbibnames=3, minbibnames=2, mincitenames=1, style=authoryear-comp, sortcites=ymn, uniquename=false, uniquelist=false, giveninits=true, citetracker=true, backref=true, eprint=false]{biblatex}
\DeclareNameAlias{sortname}{family-given}
\renewcommand*{\bibfont}{\normalfont\footnotesize}
\renewcommand*{\compcitedelim}{\addcomma\space} %semicolon and non-breaking space between compressed multiple citations by the same author
\DefineBibliographyExtras{british}{\def\finalandcomma{\addcomma}}  % Oxford comma
\DefineBibliographyStrings{british}{citedas = {hereafter}}

\addbibresource{PhD_thesis_FCUL_template.bib} % Bibliography file!!
%\AtEveryBibitem{\clearfield{eprint}}
\DeclareDelimFormat{nameyeardelim}{\addspace}
\DeclareDelimFormat[textcite]{postnotedelim}{\addcolon\space}
\DeclareDelimFormat[textcites]{postnotedelim}{\addcolon\space}
\DeclareDelimFormat[parencite]{postnotedelim}{\addsemicolon\space}
\DeclareDelimFormat[parencites]{postnotedelim}{\addsemicolon\space}
\DeclareFieldFormat{postnote}{\mknormrange{#1}}
\DeclareFieldFormat{multipostnote}{\mknormrange{#1}}
%% If you need one bibliography per chapter add the following at the end of each chapter
%\printbibliography[heading=subbibintoc]
% Show DOI. If not availabe, show URL (when present)
\renewbibmacro*{doi+eprint+url}{%
\iftoggle{bbx:url}
{\iffieldundef{doi}{\usebibmacro{url+urldate}}
{}}     {}%
\newunit\newblock
\iftoggle{bbx:eprint}
{\usebibmacro{eprint}}     {}%
\newunit\newblock
\iftoggle{bbx:doi}
{\printfield{doi}}
{}}
% Re-defiine cedilla for bibliography entries
\newcommand\cedilla{}
\let\cedilla\c
\DeclareUnicodeCharacter{0229}{\c{e}}
% Use following commands to break long url links
\setcounter{biburllcpenalty}{7000}
\setcounter{biburlucpenalty}{8000}
% If want to show the pages of citation in bibliography entries (with backref=true in hyperref call) and change text
%\DefineBibliographyStrings{british}{%
%  backrefpage = {page},% originally "cited on page"
%  backrefpages = {pages},% originally "cited on pages"
%}
% Non-default sorting option instead of nyt. It now includes month.
\DeclareSortingTemplate{nymt}{
  \sort{
    \field{presort}
  }
  \sort[final]{
    \field{sortkey}
  }
  \sort{
    \field{sortname}
    \field{author}
    \field{editor}
    \field{translator}
    \field{sorttitle}
    \field{title}
  }
  \sort{
    \field{sortyear}
    \field{year}
  }
  \sort{
    \field[padside=left,padwidth=2,padchar=0]{month}
    \literal{00}
  }
  \sort{
    \field{sorttitle}
    \field{title}
  }
  \sort{
    \field[padside=left,padwidth=4,padchar=0]{volume}
    \literal{0000}
  }
}

\DeclareSortingTemplate{ymn}{
  \sort{
    \field{presort}
  }
  \sort[final]{
    \field{sortkey}
  }
  \sort{
    \field{sortyear}
    \field{year}
  }
  \sort{
    \field[padside=left,padwidth=2,padchar=0]{month}
    \literal{00}
  }
  \sort{
    \field{sortname}
    \field{author}
    \field{editor}
    \field{translator}
    \field{sorttitle}
    \field{title}
  }
}

% Allows put list of tables and figures as all caps in ToC
\let\oldaddcontentsline\addcontentsline
\newcommand{\ADDCONTENTSLINE}[3]{%
  \oldaddcontentsline{#1}{#2}{\MakeUppercase{#3}}%
}
\newcommand{\CAPinToC}{\let\addcontentsline\ADDCONTENTSLINE}
\newcommand{\noCAPinToC}{\let\addcontentsline\oldaddcontentsline}

% Define headers and footers
\RequirePackage{fancyhdr}
\renewcommand{\chaptermark}[1]{\markboth{\thechapter.\space#1}{}} % Remove "CHAPTER" in header
%\renewcommand{\chaptermark}[1]{\markboth{#1}{}}  % Remove Chapter number in header
\fancypagestyle{MyThesisStyle}{%
    \fancyhead{} %Clean headers
    \fancyfoot[C]{\thepage}
    \fancyhead[LE]{\LastMark{2e-left}} % \leftmark
    \fancyhead[RO]{\FirstMark{2e-right}} % \rightmark
    \fancyhead[LO]{\MakeUppercase{\@authorshortname}}
    \fancyhead[RE]{}
}
\fancypagestyle{FirstPages}{%
    \fancyhead{} %Clean headers
    \fancyhead[LE, RO, LO, RE]{}  % empty headers
    \fancyfoot[C]{\the\year{}}  % \fancyfoot[C]{\Romanyear}
    \renewcommand{\headrule}{\hrule height 0pt \vspace{0mm}\hrule height 0pt}
    \renewcommand{\headrulewidth}{0.0pt}
}
\fancypagestyle{NoNumberChapStyle}{%
    \fancyhead{} %Clean headers
    \fancyfoot[C]{\thepage}
    \fancyhead[LE]{\LastMark{2e-left}}
    \fancyhead[RO]{}
    \fancyhead[LO]{\MakeUppercase{\@authorshortname}}
    \fancyhead[RE]{}
}
\fancypagestyle{ReferencesStyle}{%
    \fancyhead{} %Clean headers
    \fancyfoot[C]{\thepage}
    \fancyhead[LE]{\LastMark{2e-left}}
    \fancyhead[RO]{\FirstMark{2e-right}}
    \fancyhead[LO,RE]{}
}

% Redefinition of "\cleardoublepage" to add the message "This page intentionally left blank"
\makeatletter
    \def\cleardoublepage{\clearpage%
        \if@twoside
            \ifodd\c@page\else
                \vspace*{\fill}
                \hfill
                \begin{center}
                This page intentionally left blank.
                \end{center}
                \vspace{\fill}
                \thispagestyle{empty}
                \newpage
                \if@twocolumn\hbox{}\newpage\fi
            \fi
        \fi
    }
\makeatother

\RequirePackage[page, toc, header]{appendix} %Extremely useful if you need appendices in some of the chapters, otherwise they will not be numbered properly!
\renewcommand{\appendixtocname}{APPENDICES}  % rename 'Appendices' in ToC
\renewcommand{\appendixpagename}{Appendices} % rename name in first Appendices page
\renewcommand*{\appendixname}{APPENDIX}  % rename each appendix in ToC

% Add the message "This page intentionally left blank" after first Appendix page (if page=true)
\makeatletter
  \renewcommand{\@chap@pppage}{%
  \clear@ppage
  \thispagestyle{plain}%
  \if@twocolumn\onecolumn\@tempswatrue\else\@tempswafalse\fi
  \null\vfil
  \markboth{}{}%
  {\centering
  \interlinepenalty \@M
  \normalfont
  \Huge \bfseries \appendixpagename\par}
  \if@dotoc@pp
    \addappheadtotoc
  \fi
  \vfil\newpage
  \if@twoside
    \if@openright
    \vspace*{\fill}
    \hfill
    \begin{center}
      This page intentionally left blank.
    \end{center}
    \vspace{\fill}
      \thispagestyle{plain}%
      \newpage
    \fi
  \fi
  \if@tempswa
    \twocolumn
  \fi
  }
\makeatother

\let\olddiameter\diameter
%% Define units (with siunitx)
% Useful in tables and alignment
\RequirePackage{siunitx}
\sisetup{table-figures-uncertainty=1, table-alignment=center, uncertainty-mode = separate, list-final-separator={,\, \text{and}\, }, group-digits=integer}
\DeclareSIUnit\erg{erg}
\DeclareSIUnit\magnitude{mag}
\DeclareSIUnit\jansky{Jy}
\DeclareSIUnit\beam{beam}
\DeclareSIUnit\dex{dex}
\DeclareSIUnit{\deg}{deg}
\DeclareSIUnit{\asec}{arcsec}
\DeclareSIUnit{\yr}{yr}
\DeclareSIUnit{\msun}{\ensuremath{\mathrm{M}_{\odot}}}
\DeclareSIUnit\cpu{CPU}
\DeclareSIUnit\angstrom{\text{Å}}
\DeclareSIUnit\parsec{pc}

%% Astronomical commands
\newcommand{\esp}[1]{\mbox{\large{e}}^{#1}}
\newcommand{\leaveblank}{\newpage\thispagestyle{empty}\mbox{}}
\newcommand{\micron}{\mu\mbox{m}}
%\newcommand{\url}[1]{\sf{#1}}
\newcommand{\tauboo}{$\tau$ Bo{\"o}tis}
\newcommand{\kepler}{{\sl Kepler}}
\newcommand*\sun{\ensuremath{\odot}}
\newcommand*\degr{\ensuremath{^\circ}}
\newcommand*\arcmin{\ensuremath{^\prime}}
\newcommand*\arcsec{\ensuremath{^{\prime\prime}}}
\def\utw{\ensuremath{\smash{\rlap{\lower5pt\hbox{$\sim$}}}}}
\def\udtw{\ensuremath{\smash{\rlap{\lower6pt\hbox{$\approx$}}}}}
\newcommand*\fd{\ensuremath{\overset{\text{d}}{.}}}
\newcommand*\fh{\ensuremath{\overset{\text{h}}{.}}}
\newcommand*\fm{\ensuremath{\overset{\text{m}}{.}}}
\newcommand*\fs{\ensuremath{\overset{\text{s}}{.}}}
\newcommand*\fdg{\ensuremath{\overset{\circ}{.}}}
\newcommand*\farcm{\ensuremath{\overset{\prime}{.}}}
\newcommand*\farcs{\ensuremath{\overset{\prime\prime}{.}}}
\newcommand*\fp{\ensuremath{\overset{\scriptscriptstyle\text{p}}{.}}}
\newcommand*\cor{\ensuremath{\mathrel{\widehat{=}}}}
\newcommand\smion[2]{#1$\;$\protect \footnotesize{\rmfamily\@Roman{#2}}\small}% 
\newcommand\scion[2]{#1$\;$\protect \tiny{\rmfamily\@Roman{#2}}\scriptsize}%
% \ion{<element symbol>}{<degree of ionization>}
\DeclareRobustCommand{\ion}[2]{\textup{#1\,\textsc{\lowercase{#2}}}}
% \element[<element symbol>]{<electrical charge>}{<number of nucleons>}{<number of protons>}{<number of neutrons>}
\newcommand*\element[5][]{%
  \ensuremath{%
    \vphantom{x}^{#3}_{#4}
    \mathrm{#1}
    \vphantom{x}^{#2}_{#5}
  }%
}

\endinput
