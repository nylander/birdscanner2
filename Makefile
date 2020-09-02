.PHONY: run

all: run

dryrun:
	snakemake -j -p -n

run:
	snakemake -j -p

clean:
	rm -rf .snakemake run/plast/* run/hmmer/* run/tmp/* results/genes/* results/genomes/*
