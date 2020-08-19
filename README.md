# Birdscanner version 2

- Last modified: ons aug 19, 2020  01:21
- Sign: JN


## Description

Extract similar regions from a nucleotide fasta file ("genome") based on
one or more multiple sequence alignments (nt, fasta) using nhmmer.

![Workflow](resources/img/Diagram1.png)


## Data

Place properly named genome files (fasta format, gzip compressed, .gz) in data/genomes/
and properly named reference files (aligned fasta files, .fas) in data/reference/.
Reference files doesn't need to include the same number of taxa.

Example set up:
    data
    ├── genomes
    │   ├── Ainor_genome.gz
    │   └── CcervF_genome.gz
    └── reference
        ├── myo.fas
        └── odc.fas


## Run

    $ snakemake --jobs --reason --printshellcmds


## Prerequites

The workflow is tested on GNU/Linux (Ubuntu 18.04 and CentOS 7), and uses
standard Linux (bash) tools in addition to the main workflow manager `snakemake`.
Additional software are located in `workflow/scripts`.
