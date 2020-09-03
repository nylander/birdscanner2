# data folder

- Last modified: tor sep 03, 2020  02:01
- Sign: JN

## Description

Put carefully formatted and named input data in the `data` folder.

Two folders are available for user input data:

### 1. `genomes` folder

Add compressed (gzip) genome files (contig files in fasta format, nucleotide
data) in the folder `data/genomes/`. Files need to be named `<name>.gz`. The
`<name>` should contain no periods, and will be used in the output as part of
the fasta header for the extracted sequences. Examples: `apa_genome.gz`,
`bpa.gz` (but not, e.g., `apa.genome.fas.gz`, `bpa.tar.gz`, etc).

### 2. `references` folder

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

## Example of file structure in folder `data/`:

    data
    ├── genomes
    │   ├── Apa.gz
    │   ├── Bpa.gz
    │   └── README.md
    └── references
        ├── 1.fas
        ├── 2.fas
        └── README.md

