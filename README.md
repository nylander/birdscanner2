# Birdscanner version 2

- Last modified: tor aug 20, 2020  05:11
- Sign: JN


## Description

The workflow (Fig. \ref{workflow}) will try to extract known genomic regions
(based on multiple- sequence alignments and HMMs; the *Reference*) from a genome
file (the *Genome*). The approach taken is essentially a search with HMM's
against a reference genome, with an extra step where an initial similarity
search is used to reduce the input data down to matching HMM's and genomic
regions. Both the known genomic regions (multiple nucleotide-sequence
alignments in fasta format), and the genome files (fasta format, one or several
scaffolds) must be provided by the user.

If several genomes are provided, the workflow can also collect each genomic
region extracted from each genome (the *Fasta seq* files), and produce
unaligned "gene" files that can be the input to a multiple-sequence alignment
software.


![Birdscanner2 workflow\label{workflow}](resources/img/Diagram1.png)


## Installation and testing

### Alt. 1: Manual installation

1. Install prerequisites (see section [Software
   prerequisites](#software-prerequisites) for details).  On a Debian-based
   GNU/Linux system (tested on Ubuntu Linux 20.04), this can be done using

        $ sudo apt install build-essential hmmer ncbi-blast+ pigz plast snakemake
        $ git clone https://github.com/nylander/split-fasta-seq.git
        $ cd split-fasta-seq/src/ && make && sudo cp splitfast /usr/local/bin/

2. Clone birdscanner2 from GitHub:

        $ git clone --depth=1 https://github.com/Naturhistoriska/birdscanner2.git

3. Optional: Download example data (636 MB) and test the installation

        $ cd birdscanner2
        $ wget -O data.tgz "https://owncloud.nrm.se/index.php/s/YSCC6S63x3b3Jv9/download"
        $ tar xfz data.tgz && rm data.tgz
        $ snakemake -j -p --dry-run
        $ snakemake -j -p


### Alt. 2: Use Conda 

1. Install Conda

        $ ...

2. Clone birdscanner2 from GitHub:

        $ git clone --depth=1 https://github.com/Naturhistoriska/birdscanner2.git

3. Optional: Download example data (636 MB) and test the installation

        $ cd birdscanner2
        $ wget -O data.tgz "https://owncloud.nrm.se/index.php/s/YSCC6S63x3b3Jv9/download"
        $ tar xfz data.tgz && rm data.tgz
        $ snakemake --use-conda --dry-run


## Input

Place properly named genome files (fasta format, gzip compressed, `.gz`) in
`data/genomes/` and properly named reference files (aligned fasta files,
`.fas`) in `data/reference/`. See section [Data](#data) for details on the data
format.

Example set up:
```
    data
    ├── genomes
    │   ├── Ainor_genome.gz
    │   └── CcervF_genome.gz
    └── reference
        ├── myo.fas
        └── odc.fas
```

## Output

Output are written to the folders `results/genomes/` and `results/genes/`.


## Run

    $ cd birdscanner2
    $ snakemake --jobs --reason --printshellcmds

\newpage 

## Software prerequisites

The workflow is tested on GNU/Linux (Ubuntu 20.04), and uses standard Linux
(bash) tools in addition to the main workflow manager `snakemake`.  A list of
tools (and tested version) are given below.

- bash (5.0.17)
    - awk (5.0.1)
    - cat (8.30)
    - find (4.7.0)
    - grep (3.4)
    - sort (8.30)
- python (3.8.2)
- snakemake (5.10.0)
- pigz (2.4)
- makeblastdb (2.9.0+)
- blastdbcmd (2.9.0+)
- plast (2.3.2)
- hmmbuild (3.3)
- hmmpress (3.3)
- nhmmer (3.3)
- perl (5.30.0)
- fasta2stockholm.pl (1.0)
- parse_nhmmer.pl (1.0)
- gather_genes.pl (1.0)
- splitfast (Tue 14 Jan 2020)


## Data

**Note:** The pipeline is, unfortunately, very picky about the format of both
file names and file content. Safest option is to make sure they are OK before
trying to run the analyses.

### Indata

##### 1. Genomes

Add compressed (gzip) genome files (contig files in fasta format, nucleotide
data) to the folder `data/genomes/`. Files need to be named `<name>.gz`. The
`<name>` should contain no periods, and will be used in the output as part of
the fasta header for the extracted sequences. Examples: `apa_genome.gz`,
`bpa.gz` (but not, e.g., `apa.genome.fas.gz`, `bpa.tar.gz`, etc).

##### 2. Reference alignments

Add reference sequence alignments (nucleotides, fasta format, file suffix
`.fas`) in the folder `data/reference/`. Each alignment file would
represent one genomic region ("gene"). The name of the alignment file will be
used in downstream analyses, so they should have names that are easy to parse
(do not use spaces or special characters, not even hyphens (`-`) in the file
names). Examples: `myo.fas`, `odc.fas`, `988.fas`, `999.fas`, etc. The fasta
headers are also used in downstream analyses and should also be easy to parse.
Examples, `>Passe`, `>Ploceu`, `>Prunell`. Use underscores (`_`) instead of
hyphens (`-`). Fasta headers needs to be unique (i.e., no duplicates in each
individual alignment), but the number of sequences doesn't need to be the same
in all files.

##### 2.2 Jarvis data

**TEXT NOT UPDATED!** 

We also provide filtered versions of the "Jarvis data" ([Jarvis *et al*.
2015](doc/Jarvis_et_al_2015/Jarvis_et_al_2015.pdf)). If you wish to use any of
these data sets, it is recommend to download and uncompress the data
(`fasta_files.tgz`) directly inside the `data/reference/` folder.

If you wish to save some computational time, and use the
"length-filtered" data subsets, we also provide the necessary HMM's and
reference fasta file.  It is then recommended to download and uncompress the
data (`selected.tgz`) directly inside the `data/reference/` folder and ...
Please see the file
[`resources/Jarvis_et_al_2015/README.md`](resources/Jarvis_et_al_2015/README.md)
for full description.

### Outdata

**TEXT NOT UPDATED!**

Individual `gene` files (fasta format) for each `genome` are written to the
folder `out/<genome>_nhmmer_output/`, with the default name
`<genome>.<gene>.fas`. The (default) fasta header contains the genome name:
`><genome>` and, in addition, some statistics from the HMMer search. The
default filenames and fasta header format can be changed by altering the call
to the script [`parse_nhmmer.pl`](src/parse_nhmmer.pl) inside the
[`Makefile`](Makefile) (line starting with `perl $(PARSENHMMER)`). This is
mostly untested, however.

If several genome files have been run, it should be possible to gather the
individual sequences and sort them into (unaligned) data matrices.  This can be
done by using the [`gather_genes.pl`](src/gather_genes.pl) script. See examples
at the end of the [Worked Examples](#worked-examples).


## License and copyright

Copyright (c) 2020 Johan Nylander

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

