#!/bin/bash

# File: bs2-convert.sh
#
# Last modified: ons okt 14, 2020  05:51
#
# Sign: JN
#
# Usage: ./bs2-convert.sh
#
# Description: Convert and concatenate fasta, create hmms.
# To be used with birdscanner2 workflow as an ad-hoc script to
# avoid running a lot of calls to rules when on a Slurm system.
# The script basically runs rules OO1_convert_fas, OO2_fasta_to_stockholm,
# OO3_create_hmms, and OO4_cat_reference_fas -- but without snakemake.
#
# Requirements: nucleotide fasta files (suffix .fas) in folder data/references,
# and softwares awk, bs2-fas-to-sto.pl, hmmbuild, and gnuparallel.
#
# Copyright (C) 2020 Johan Nylander <johan.nylander@nrm.se>
# Distributed under terms of the MIT license. 

set -euo pipefail

command -v hmmbuild > /dev/null 2>&1 || { echo >&2 "Error: hmmbuild not found."; exit 1; }
command -v parallel > /dev/null 2>&1 || { echo >&2 "Error: parallel not found."; exit 1; }

scriptsdir=$(dirname "$(readlink -f "$0")")
f2s="${scriptsdir}/bs2-fas-to-sto.pl"
command -v "${f2s}" > /dev/null 2>&1 || { echo >&2 "Error: bs2-fas-to-sto.pl not found."; exit 1; }

if [ -e run/tmp/reference.fas ] ; then
    echo "Warning: file run/tmp/reference.fas already exists. Will not concatenate fasta files."
fi

mkdir -p run/tmp

do_parallel() {
    input="$1"
    f2s="$2"
    fname=$(basename "${input}" .fas)
    fastafile="run/tmp/${fname}.fasta"
    stofile="run/tmp/${fname}.sto"
    hmmfile="run/tmp/${fname}.hmm"
    awk -v a="${fname}" "/>/{\$0=\">\"a\"__\"++i}1" "${input}" > "${fastafile}"
    "${f2s}" "${input}" > "${stofile}"
    hmmbuild --dna "${hmmfile}" "${stofile}" > /dev/null 2>&1
}
export -f do_parallel

find data/references -type f -name \*.fas | \
    parallel do_parallel {} "${f2s}"

if [ ! -e run/tmp/reference.fas ] ; then
    #find run/tmp -type f -name \*.fasta -print0 | xargs -0 cat -- >> run/tmp/reference.fas
    ## timing: 1m21.205s
    find run/tmp -type f -name \*.fasta -exec cat {} \+ > run/tmp/reference.fas
    ## timing: 0m32.374s
fi

echo "End of script init.sh"
