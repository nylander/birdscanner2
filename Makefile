.PHONY: run

all: run

run:
	snakemake -j -p

debug:
	snakemake -j -p --notemp --reason

dryrun:
	snakemake -j -p -n

clean:
	rm -rf .snakemake run results
