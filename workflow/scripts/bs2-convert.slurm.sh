#! /bin/bash -l

#SBATCH -J bs2-convert
#SBATCH -t 24:00:00
#SBATCH -p core
#SBATCH -n 10
#SBATCH -M rackham,snowy 
#SBATCH --output=bs2-convert.err

# Slurm script for bs2-convert
#
# Test by using:
#     sbatch -A <accountnr> --test-only workflow/scripts/bs2-convert.slurm.sh
#
# Start by using:
#     sbatch -A <accountnr> workflow/scripts/bs2-convert.slurm.sh
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

make convert

>&2 echo ""
>&2 echo ""
>&2 echo "bs2-convert job should now have been submitted to cluster."
>&2 echo "Submission details, and any possible errors, are in the bs2-convert.err file."
>&2 echo "Monitor submitted jobs with with the 'jobinfo' command."
>&2 echo "When all processing are finished, you should see outfiles"
>&2 echo "in folder birdscanner2/run/tmp/."
>&2 echo ""
>&2 echo "Reached the end of the bs2-convert slurm script."
