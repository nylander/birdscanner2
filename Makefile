# Makefile for birdscanner2
# Last modified: tis okt 28, 2025  03:32
# Sign: JN

#UPPNR :=

#ifndef UPPNR
#$(error UPPNR is not set. Please run \"make account UPPNR=snic1234-5-678\" \(use your account nr\) or edit the Makefile and the config/cluster.yaml files and add your uppmax compute account nr. )
#endif

.PHONY: all run debug dryrun report slurm-init slurm-run clean distclean

all: run

run:
	snakemake --jobs

debug:
	snakemake --jobs --printshellcmds --notemp --reason

dryrun:
	snakemake --jobs --printshellcmds --dry-run

report:
	snakemake --report birdscanner2-report.html

convert:
	bash workflow/scripts/bs2-convert.sh

slurm-run:
	snakemake --profile slurm -j 200

#account:
#	sed -i 's/#SNICACCOUNT#/$(UPPNR)/' config/cluster.yaml ; \
#	sed -i '/^UPPNR/ s/$$/ $(UPPNR)/' $(lastword $(MAKEFILE_LIST))

clean:
	rm -rf .snakemake run slurm/stderr slurm/stdout slurm/__pycache__ slurm/err/bs2-convert.err slurm/logs/bs2-convert.out

distclean:
	rm -rf results data/genomes/*.gz data/references/*.fas .snakemake run birdscanner2-report.html slurm/stderr slurm/stdout slurm/__pycache__ slurm/err/bs2-convert.err slurm/logs/bs2-convert.out
