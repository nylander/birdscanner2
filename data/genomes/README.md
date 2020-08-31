# Genomes folder

- Last modified: mån aug 31, 2020  09:25
- Sign: JN

## Description

Add compressed (gzip) genome files (contig files in fasta format, nucleotide
data) in the folder `data/genomes/`. Files need to be named `<name>.gz`. The
`<name>` should contain no periods, and will be used in the output as part of
the fasta header for the extracted sequences. Examples: `apa_genome.gz`,
`bpa.gz` (but not, e.g., `apa.genome.fas.gz`, `bpa.tar.gz`, etc).
