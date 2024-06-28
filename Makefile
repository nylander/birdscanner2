# Makefile for birdscanner2
# Last modified: fre jun 28, 2024  02:39
# Sign: JN

#UPPNR :=

#ifndef UPPNR
#$(error UPPNR is not set. Please run \"make account UPPNR=snic1234-5-678\" \(use your account nr\) or edit the Makefile and the config/cluster.yaml files and add your uppmax compute account nr. )
#endif

.PHONY: all run debug dryrun test report slurm-init slurm-run clean distclean

all: run

run:
	snakemake --jobs 4

debug:
	snakemake --jobs 4 --printshellcmds --debug-dag --notemp

dryrun:
	snakemake --jobs 4 --printshellcmds --debug-dag --notemp --dry-run

test: dryrun

report:
	snakemake --report birdscanner2-report.html

convert:
	bash workflow/scripts/bs2-convert.sh

slurm-test:
	snakemake --dry-run --printshellcmds --use-conda --profile rackham -j 200

slurm-run:
	snakemake --use-conda --profile rackham -j 200

clean:
	rm -rf .snakemake run slurm/stderr slurm/stdout slurm/__pycache__ slurm/err/bs2-convert.err slurm/logs/bs2-convert.out

distclean:
	rm -rf results data/genomes/*.gz data/references/*.fas .snakemake run birdscanner2-report.html slurm/stderr slurm/stdout slurm/__pycache__ slurm/err/bs2-convert.err slurm/logs/bs2-convert.out
