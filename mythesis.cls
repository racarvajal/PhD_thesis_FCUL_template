\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mythesis}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass[a4paper,12pt,twoside]{book} % choose single or double page style

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
% \usepackage[sc]{example_font}
% Loads text fonts
\RequirePackage[T1]{fontenc}
\RequirePackage{newtxtext,newtxmath}

% Select font families. Select according to University rules
\renewcommand*{\sfdefault}{ptm}
\newcommand*{\numfont}{\fontfamily{ptm}\selectfont}
\newcommand*{\headfont}{\bfseries\fontfamily{ptm}\selectfont}
\newcommand*{\secfont}{\bfseries\fontfamily{ptm}\selectfont}
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

%this is for the number and lines above the chapter title
\renewcommand{\@makechapterhead}[1]
{{ \color{black} \ifnum \c@secnumdepth >\m@ne 
\flushright \fontsize{1.5cm}{1em} \numfont  \color{black}
%\flushright \fontsize{3cm}{1em}\numfont 
\thechapter \par \nobreak \vskip 10\p@ \fi 
\vspace{15pt}  \color{black}
\hrule \hrule   \color{black}
\vspace{20pt} \huge\centering \headfont #1\par \vspace{20pt} \color{black} \hrule \hrule \color{black}\nobreak \vskip 20\p@ }}

%% Bibliography at the end of the thesis:
\RequirePackage[natbib=true, sorting=nymt, backend=biber, maxcitenames=2, maxbibnames=3, minbibnames=2, mincitenames=1, style=authoryear-comp, sortcites=ymn, uniquename=false, uniquelist=false, giveninits=true, citetracker=true, backref=true]{biblatex}
\DeclareNameAlias{sortname}{family-given}
\renewcommand*{\bibfont}{\normalfont\footnotesize}
\renewcommand*{\compcitedelim}{\addcomma\space} %semicolon and non-breaking space between compressed multiple citations by the same author
\DefineBibliographyExtras{british}{\def\finalandcomma{\addcomma}}  % Oxford comma
\DefineBibliographyStrings{british}{citedas = {hereafter}}

\addbibresource{PhD_thesis_FCUL_template.bib} % Bibliography file!!
\AtEveryBibitem{\clearfield{eprint}}
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

\newcommand\@shorttitle{}
% define \theshorttitle to what is given
\newcommand\shorttitle[1]{\renewcommand\@shorttitle{#1}}

% %% HEADINGS
% %% Chapters with numbers
% \renewcommand{\@makechapterhead}[1]
% {{\ifnum \c@secnumdepth >\m@ne 
% \centering \fontsize{2cm}{1em}\numfont %this is if you want a font size bigger than HUGE. The important number is {2cm}. The second {1em} I think controls the spacing but I left it with the default value.
% \thechapter \par \nobreak \vskip 10\p@ \fi 
% \hrule \vspace{5pt} \huge\headfont #1\par \vspace{6pt} \hrule \nobreak \vskip 20\p@ }}
% %%Chapters without numbers
\renewcommand{\@makeschapterhead}[1]
{{\hrule \vspace{20pt} % 5pt
\headfont\huge \centering\headfont #1\par 
\vspace{20pt} \hrule \nobreak \vskip 25\p@ }} % 6pt

%% Useful to uncomment next block if you need to change the spacing between the titles of the Sections/Subsections and the text
%\renewcommand\chapter{\@startsection {chapter}{1}{\z@}%
%	{-3.5ex \@plus -1ex \@minus -.2ex}{2.3ex \@plus.2ex }	{\Large\secfont}}
%\renewcommand\section{\@startsection {section}{1}{\z@}%
%	{-3.5ex \@plus -1ex \@minus -.2ex}{2.3ex \@plus.2ex }	{\Large\secfont}}
%%Sub-sections
%\renewcommand\subsection{\@startsection {subsection}{1}{\z@}%
%	{-3.25ex \@plus -1ex \@minus -.2ex}{1.5ex \@plus.2ex }{\large\secfont}}

% Allows put list of tables and figures as all caps in ToC
\let\oldaddcontentsline\addcontentsline
\newcommand{\ADDCONTENTSLINE}[3]{%
  \oldaddcontentsline{#1}{#2}{\MakeUppercase{#3}}%
}
\newcommand{\CAPinToC}{\let\addcontentsline\ADDCONTENTSLINE}
\newcommand{\noCAPinToC}{\let\addcontentsline\oldaddcontentsline}

\RequirePackage{etoolbox}  % Modify spaces after and before chapter* titles

%\patchcmd{\@makechapterhead}{\vspace*{50\p@}}{}{}{}% Removes space above \chapter head
\patchcmd{\@makeschapterhead}{\vspace*{50\p@}}{\vspace*{4pt}}{}{}% Removes space above \chapter* head
%\patchcmd{\@makechapterhead}{\vskip 40\p@}{\bigbreak}{}{}% Removes space below \chapter head
\patchcmd{\@makeschapterhead}{\vskip 40\p@}{\vskip 4pt}{}{} % Removes space below \chapter* head
%\renewcommand{\@makeschapterhead}{\vspace*{25pt}}

% Define headers and footers
\RequirePackage{fancyhdr}
\renewcommand{\chaptermark}[1]{\markboth{\thechapter.\space#1}{}} % Remove "CHAPTER" in header
%\renewcommand{\chaptermark}[1]{\markboth{#1}{}}  % Remove Chapter number in header
\fancypagestyle{MyThesisStyle}{%
    \fancyhead{} %Clean headers
    \fancyfoot[C]{\thepage}
    \fancyhead[LE]{\LastMark{2e-left}} % \leftmark
    \fancyhead[RO]{\FirstMark{2e-right}} % \rightmark
    \fancyhead[LO]{A. NAME}
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
    \fancyhead[LO]{A. NAME}
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

%% Additional commands commonly used
\newcommand*\centerstack[2]{%
  \ensuremath{%
    \mathrel{%
      \mathchoice{%
        \vcenter{%
          \offinterlineskip
          \halign{\hfil$\displaystyle##$\hfil\cr#1\cr#2\cr}%
        }%
      }
      {%
        \vcenter{%
          \offinterlineskip
          \halign{\hfil$\textstyle##$\hfil\cr#1\cr#2\cr}%
        }%
      }
      {%
        \vcenter{%
          \offinterlineskip
          \halign{\hfil$\scriptstyle##$\hfil\cr#1\cr#2\cr}%
        }%
      }
      {%
        \vcenter{%
          \offinterlineskip
          \halign{\hfil$\scriptscriptstyle##$\hfil\cr#1\cr#2\cr}%
        }%
      }%
    }%
  }%
}
\newcommand*\centerstackskip[6]{%
  \ensuremath{%
    \mathrel{%
      \mathchoice{%
        \vcenter{%
          \offinterlineskip
          \halign{\hfil$\displaystyle##$\hfil\cr
            #1\cr\noalign{\vskip#3}#2\cr}%
        }%
      }
      {%
        \vcenter{%
          \offinterlineskip
          \halign{\hfil$\textstyle##$\hfil\cr
            #1\cr\noalign{\vskip#4}#2\cr}%
        }%
      }
      {%
        \vcenter{%
          \offinterlineskip
          \halign{\hfil$\scriptstyle##$\hfil\cr
            #1\cr\noalign{\vskip#5}#2\cr}%
        }%
      }
      {%
        \vcenter{%
          \offinterlineskip
          \halign{\hfil$\scriptscriptstyle##$\hfil\cr
            #1\cr\noalign{\vskip#6}#2\cr}%
        }%
      }%
    }%
  }%
}

\let\olddiameter\diameter
%% Define units (with siunitx)
% Useful in tables and alignment
\RequirePackage{siunitx}
\sisetup{table-figures-uncertainty=1, table-alignment=center, separate-uncertainty=true, list-final-separator={,\, \text{and}\, }}
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
\newcommand*\la{\centerstack{<}{\sim}}
\newcommand*\ga{\centerstack{>}{\sim}}
\newcommand*\sol{\centerstack{\sim}{<}}
\newcommand*\sog{\centerstack{\sim}{>}}
\newcommand*\lse{\centerstack{<}{\simeq}}
\newcommand*\gse{\centerstack{>}{\simeq}}
\newcommand*\grole{\centerstackskip{>}{<}{-1.5\p@}{-1.5\p@}{-1\p@}{-.5\p@}}
\newcommand*\leogr{\centerstackskip{<}{>}{-1.5\p@}{-1.5\p@}{-1\p@}{-.5\p@}}
\newcommand*\loa{\centerstack{<}{\approx}}
\newcommand*\goa{\centerstack{>}{\approx}}
\newcommand*\getsto{\centerstack{\gets}{\to}}
\newcommand*\lid{\centerstackskip{<}{=}{1.2\p@}{1.2\p@}{1\p@}{0.9\p@}}
\newcommand*\gid{\centerstackskip{>}{=}{1.2\p@}{1.2\p@}{1\p@}{0.9\p@}}
\newcommand\smion[2]{#1$\;$\protect \footnotesize{\rmfamily\@Roman{#2}}\small}% 
\newcommand\scion[2]{#1$\;$\protect \tiny{\rmfamily\@Roman{#2}}\scriptsize}%
% \ion{<element symbol>}{<degree of ionization>}
\DeclareRobustCommand{\ion}[2]{\textup{#1\,\textsc{\lowercase{#2}}}}
% \element[<electrical charge>][<number of nucleons>][<number of protons>][<number of neutrons>]{<element symbol>}
\newcommand*\element[1][]{%
  \def\aa@element@tr{#1}%
  \aa@element
}

\endinput
