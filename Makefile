.PHONY: run

all: run

run:
	snakemake -j -p

dryrun:
	snakemake -j -p -n

clean:
	rm -rf .snakemake run results
