# Makefile for birdscanner2
# Last modified: tis okt 20, 2020  12:57
# Sign: JN

#UPPNR :=

#ifndef UPPNR
#$(error UPPNR is not set. Please run \"make account UPPNR=snic1234-5-678\" \(use your account nr\) or edit the Makefile and the config/cluster.yaml files and add your uppmax compute account nr. )
#endif

.PHONY: all run debug dryrun report slurm-init slurm-run clean

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
	snakemake --profile slurm -j 100

#account:
#	sed -i 's/#SNICACCOUNT#/$(UPPNR)/' config/cluster.yaml ; \
#	sed -i '/^UPPNR/ s/$$/ $(UPPNR)/' $(lastword $(MAKEFILE_LIST))

clean:
	rm -rf .snakemake run results birdscanner2-report.html slurm/stderr slurm/stdout slurm/__pycache__
