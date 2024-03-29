# References folder

- Last modified: tor sep 03, 2020  01:57
- Sign: JN

## Description

Add reference sequence alignments (nucleotides, fasta format, file suffix
`.fas`) in the folder `data/references/`. Each alignment file would represent
one genomic region ("gene").

The name of the alignment file will be used in downstream analyses, so they
should have names that are easy to parse (do not use spaces or special
characters, not even hyphens (`-`) in the file names). Examples: `myo.fas`,
`odc.fas`, `988.fas`, `999.fas`, etc.

The fasta headers are also used in downstream analyses and should also be easy
to parse.  Examples, `>Passe`, `>Ploceu`, `>Prunell`. Use underscores (`_`)
instead of hyphens (`-`). Fasta headers needs to be unique (i.e., no duplicates
in each individual alignment), but the number of sequences doesn't need to be
the same in all files.

Example of file structure in folder `data/`:

    data
    ├── genomes
    │   ├── Apa.gz
    │   ├── Bpa.gz
    │   └── README.md
    └── references
        ├── 1.fas
        ├── 2.fas
        └── README.md

