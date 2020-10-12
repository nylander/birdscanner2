.PHONY: run

all: run

run:
	snakemake --jobs

debug:
	snakemake --jobs --printshellcmds --notemp --reason

dryrun:
	snakemake --jobs --printshellcmds --dry-run

report:
	snakemake --report birdscanner2-report.html

init:
	bash workflow/scripts/init.sh

clean:
	rm -rf .snakemake run results birdscanner2-report.html
