#! /bin/bash -l

#SBATCH -J birdscanner2-init
#SBATCH -t 24:00:00
#SBATCH -p core
#SBATCH -n 10
#SBATCH -M rackham,snowy 
#SBATCH --output=birdscanner2-init.err

# Slurm script for birdscanner2-init
#
# Test by using:
#     sbatch -A <accountnr> --test-only workflow/scripts/birdscanner2-init.slurm.sh
#
# Start by using:
#     sbatch -A <accountnr> workflow/scripts/birdscanner2-init.slurm.sh
#
# Stop by using:
#     scancel 1234
#     scancel -i -u $USER
#     scancel --state=pending -u $USER
#
# Monitor by using:
#    jobinfo -u $USER -M snowy,rackham
#    sinfo -p devel
#    squeue
#

module load bioinfo-tools
module load hmmer/3.2.1-intel
module load gnuparallel

make init

>&2 echo ""
>&2 echo ""
>&2 echo "birdscanner2-init job should now have been submitted to cluster."
>&2 echo "Submission details, and any possible errors, are in the birdscanner2-init.err file."
>&2 echo "Monitor submitted jobs with with the 'jobinfo' command."
>&2 echo "When all nhmmer searches are finished, you should see outfiles"
>&2 echo "in folder birdscanner2/run/tmp/."
>&2 echo ""
>&2 echo "Reached the end of the birdscanner2-init slurm script."
