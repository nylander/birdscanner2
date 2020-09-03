# Phylogenomic data for the Avian Phylogenomics project

- Last modified: fre sep 04, 2020  12:07
- Sign: JN

## Description of Data sets

Genomic data sets from the publication [Jarvis et al. (2014)] [1], was downloaded and
polished into two sets; **Introns** and **Exons**.

These two data sets are available for download here:

- [Exons, compressed folder "references.tgz", 70
  MB](http://owncloud.nrm.se/index.php/s/j3Hot6BWVafW21U): 8,253 fasta files
  with 42--48 sequences per file, and seq length in the range of 99--15,777 bp.

        $ wget -O references.tgz "http://owncloud.nrm.se/index.php/s/j3Hot6BWVafW21U/download"

- [Introns, compressed folder "references.tgz" 164
  MB](http://owncloud.nrm.se/index.php/s/R4CHCmtIQUXab3t): 11,013 fasta files
  with 38--48 sequences per file, and seq length in the range of 58--38,848 bp.

        $ wget -O references.tgz "http://owncloud.nrm.se/index.php/s/R4CHCmtIQUXab3t/download"

Description of the original data can be found here
[http://gigadb.org/dataset/101041](http://gigadb.org/dataset/101041), and here
[ftp://parrot.genomics.cn/gigadb/pub/10.5524/101001_102000/101041/readme.txt](ftp://parrot.genomics.cn/gigadb/pub/10.5524/101001_102000/101041/readme.txt).

A taxon-translation file for the acronyms used in the fasta headers can be
found here: [species_list.csv](species_list.csv). The source of this file was
Table S6 from Jarvis *et al*., 2014 (Science 346, 1320). 

Two additional subsets of the exon and intron data, including only files
containing sequences of lengths between 200 and 5,000 bp (see below), are also
available here: 

- [Length-filtered Exons, compressed folder "references.tgz", 60.3 
  MB](http://owncloud.nrm.se/index.php/s/Z3w3TBebyyyFH27): 7,979 fasta files
  with 42--48 sequences per file, and seq length in the range of 201--4,989 bp.

        $ wget -O references.tgz "http://owncloud.nrm.se/index.php/s/Z3w3TBebyyyFH27/download"

- [Length-filtered Introns, compressed folder "references.tgz" 100.7
  MB](http://owncloud.nrm.se/index.php/s/y35lLlvrf0pn8VR): 9,362 fasta files
  with 38--48 sequences per file, and seq length in the range of 200--4,998 bp.

        $ wget -O references.tgz "http://owncloud.nrm.se/index.php/s/y35lLlvrf0pn8VR/download"

## How the Introns and Exons data sets were prepared

Custom scripts are from [https://github.com/Naturhistoriska/birdscanner](https://github.com/Naturhistoriska/birdscanner).

    SCRDIR=/path/to/birdscanner/src

### Exons (download file link [2])

    $ wget ftp://parrot.genomics.cn/gigadb/pub/10.5524/101001_102000/101041/FASTA_files_of_loci_datasets/Filtered_sequence_alignments/8295_Exons/pep2cds-filtered-sate-alignments-noout.tar.gz
    $ tar -I pigz -xvf pep2cds-filtered-sate-alignments-noout.tar.gz
    $ cd 8000orthologs
    $ mkdir -p fasta_files
    $ find * -name 'sate.default.pep2cds.removed.noout.aligned' | \
        parallel "cp {} fasta_files/{//}.{/}"
    $ find fasta_files -type f -name '*.aligned' | \
        parallel "sed -i 's/?/N/g' {}"
    $ find fasta_files -type f -name '*.aligned' | \
        parallel "${SRCDIR}/remove_gapped_seqs_in_fasta.pl -N {} ; rm {}"
    $ find fasta_files -type f -name '*.degapped.fas' | \
        parallel "${SRCDIR}/degap_fasta.pl -o={.} {} ; rm {}"
    $ find fasta_files -type f -name '*.degapped' | \
        parallel "sed -i '/^$/d' {}"
    $ find fasta_files -type f -name '*.degapped' | \
        parallel "mv {} {.}.fas"

### Introns (download file link [3])

    $ wget ftp://parrot.genomics.cn/gigadb/pub/10.5524/101001_102000/101041/FASTA_files_of_loci_datasets/Filtered_sequence_alignments/2516_Introns/introns-filtered-sate-alignments-with-and-without-outgroups.tar.gz
    $ tar -I pigz -xvf introns-filtered-sate-alignments-with-and-without-outgroups.tar.gz
    $ cd 2500orthologs
    # Intron files comes in one fasta file ("sate.removed.intron.noout.aligned-allgap.filtered"),
    # with partitions defined in another ("sate.removed.intron.noout-allgap.filtered.part").
    # Here we split the fasta file in parts. Output are named <part_id>.<intron_id>.fas
    $ perl ${SRCDIR}/extract_part_genes.pl
    $ find "fasta_files" -type f -name '*.fas' | \
        parallel "sed -i 's/?/N/g' {}"
    $ find fasta_files -type f -name '*.fas' | \
        parallel "${SRCDIR}/remove_gapped_seqs_in_fasta.pl -N {} ; rm {}"
    $ find fasta_files -type f -name '*.degapped.fas' | \
        parallel "${SRCDIR}/degap_fasta.pl -o={.} {} ; rm {}"
    $ find fasta_files -type f -name '*.degapped' | \
        parallel "sed -i '/^$/d' {}"
    $ find fasta_files -type f -name '*.degapped' | \
        parallel "mv {} {.}.fas"


## References

[1]: Jarvis ED; Mirarab S; Aberer AJ; Houde P; Li C; Ho SYW; Faircloth BC; Nabholz B; Howard JT; Suh A; Weber CC; da Fonseca RR; Alfaro-Nunez A; Narula N; Liu L; Burt DW; Ellegren H; Edwards SV; Stamatakis A; Mindell DP; Cracraft J; Braun EL; Warnow T; Wang J; Gilbert MTP; Zhang G (2014): Phylogenomic analyses data of the avian phylogenomics project. GigaScience Database. <http://dx.doi.org/10.5524/101041>
[2]: <ftp://parrot.genomics.cn/gigadb/pub/10.5524/101001_102000/101041/FASTA_files_of_loci_datasets/Filtered_sequence_alignments/8295_Exons/pep2cds-filtered-sate-alignments-noout.tar.gz>
[3]: <ftp://parrot.genomics.cn/gigadb/pub/10.5524/101001_102000/101041/FASTA_files_of_loci_datasets/Filtered_sequence_alignments/2516_Introns/introns-filtered-sate-alignments-with-and-without-outgroups.tar.gz>
