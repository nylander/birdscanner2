# Makefile for birdscanner2
# Last modified: 2025-11-03 16:56:28
# Sign: JN

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

rackham-run:
	snakemake --profile rackham

clean:
	rm -rf .snakemake run slurm/stderr slurm/stdout slurm/__pycache__ slurm/err/bs2-convert.err slurm/logs/bs2-convert.out

distclean:
	rm -rf results data/genomes/*.gz data/references/*.fas .snakemake run birdscanner2-report.html slurm/stderr slurm/stdout slurm/__pycache__ slurm/err/bs2-convert.err slurm/logs/bs2-convert.out
