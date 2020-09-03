# Genomes folder

- Last modified: tor sep 03, 2020  01:58
- Sign: JN

## Description

Add compressed (gzip) genome files (contig files in fasta format, nucleotide
data) in the folder `data/genomes/`. Files need to be named `<name>.gz`. The
`<name>` should contain no periods, and will be used in the output as part of
the fasta header for the extracted sequences. Examples: `apa_genome.gz`,
`bpa.gz` (but not, e.g., `apa.genome.fas.gz`, `bpa.tar.gz`, etc).

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

