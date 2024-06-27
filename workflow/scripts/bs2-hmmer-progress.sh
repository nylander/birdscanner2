#!/usr/bin/bash

# Get hmmer progress
# Usage: workflow/scripts/bs2-hmmer-progress.sh
# Input: birdscanner2/run/hmmer/*.hmm, birdscanner2/run/hmmer/*.hmmer.out
# Version: tor 27 jun 2024 12:05:17
# Note: Current version assumes one .hmmer.out per genome.

script_dir=$(dirname "$0")
hmmer_dir=$(realpath "${script_dir}"/../../run/hmmer/)

if ls "${hmmer_dir}"/*.hmm &> /dev/null ; then
  for f in "${hmmer_dir}"/*.hmm ; do
    hmmer_out="${f%.hmm}.hmmer.out"
    genome_bn=$(basename "${f}")
    genome="${genome_bn%.hmm}"
    n_hmms=$(grep -c NAME "${f}")
    n_done=$(grep -v '#' "${hmmer_out}" | awk '{print $3}' | sort | uniq | wc -l)
    birth_date=$(stat -c "%W" "${hmmer_out}")
    if [[ "${birth_date}" -eq 0 ]] ; then
        now_date=$(date +'%F %H:%M:%S')
        echo "${genome}: ${n_done}/${n_hmms} (${now_date})"
    else
        now_date=$EPOCHSECONDS
        runtime=$((now_date-birth_date))
        echo -n "${genome}: ${n_done}/${n_hmms} "
        eval "echo  After $(date -ud "@$runtime" +'$((%s/3600/24)) days %H hours %M minutes %S seconds')"
    fi
  done
else
  echo "No .hmm files found in ${hmmer_dir}"
fi

