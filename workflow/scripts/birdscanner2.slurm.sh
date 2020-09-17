#! /bin/bash -l

#SBATCH -A #UPPMAXACCOUNTNR#
#SBATCH -J birdscanner2
#SBATCH -t 24:00:00
#SBATCH -p core
#SBATCH -n 10
#SBATCH -M rackham,snowy 
#SBATCH --output=birdscanner2.err

# Slurm script for birdscanner2
#
# Test by using:
#     sbatch --test-only birdscanner2.slurm.sh
#
# Start by using:
#     sbatch birdscanner2.slurm.sh
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
module load snakemake/5.10.0
module load hmmer/3.2.1-intel
module load blast/2.9.0+
module load pigz/2.4

cd birdscanner2

snakemake -j -p 

>&2 echo ""
>&2 echo ""
>&2 echo "birdscanner2 job should now have been submitted to cluster."
>&2 echo "Submission details, and any possible errors, are in the birdscanner2.err file."
>&2 echo "Monitor submitted jobs with with the 'jobinfo' command."
>&2 echo "When all nhmmer searches are finished, you should see outfiles"
>&2 echo "in folder birdscanner2/results."
>&2 echo ""
>&2 echo "Reached the end of the birdscanner2 slurm script."
