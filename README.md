# $\LaTeX$ Template FCUL PhD thesis

PhD Thesis $\LaTeX$ template document for the Faculdade de Ciências at the Universidade de Lisboa (FCUL). All the documents in this repository follow the [indications](https://ciencias.ulisboa.pt/pt/admissao-provas-academicas-3-ciclo) and [regulations](https://ciencias.ulisboa.pt/sites/default/files/fcul/institucional/legislacao/d_3098_2018.pdf) from FCUL.

The design of the main `.tex` and `.cls` files has been inspired by the [`thesis_template`](https://github.com/racarvajal/thesis_template) Github repository.

The files in this repository have been optimised to be compiled using [`latexmk`](https://ctan.org/pkg/latexmk). A nice description of how to use it can be found at, for instance [https://mg.readthedocs.io/latexmk.html](https://mg.readthedocs.io/latexmk.html). The main point is that, maybe, `latexmk` is already installed in the machine used to compile the files in this repository and no further configurations or changes are needed.

The need for using `latexmk` and not just plain $\LaTeX$ commands comes from the use of the `glossaries` and `glossaries-extra` packages.

Text for different chapters is separated in files as well as the figures used throughout the document. The user should modify as much of the file as needed for their purposes.

The file `mythesis.cls` contains most of the configurations for the document and the file `thesis_FCUL_template.bib` includes all `BibTeX` entries.
