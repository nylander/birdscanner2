#!/usr/bin/env perl
#===============================================================================
=pod


=head2

         FILE: bs2-gather-genes.pl

        USAGE: ./bs2-gather-genes.pl --outdir=out  inputfolders
               ./bs2-gather-genes.pl -o genes  b1/results/genomes/Ainor_genome  b2/results/genomes/CcervF_genome
               ./bs2-gather-genes.pl -o genes  $(find */results/genomes -mindepth 1 -type d)

  DESCRIPTION: Gather genes from parsed nhmmer output. The script takes
               folder names as input, where it expects fasta files named
               <genomename>.<geneid>.fas (e.g. AbucgeM.12236.fas).
               The script will then gather the same geneid from all
               genomes and concatenate them to files named <geneid>.fas.
               These files are written to the directory given by the
               --outdir option.

      OPTIONS: -o, --outdir=<dir>  Output directory (created if not present). Mandatory.

 REQUIREMENTS: ---

         BUGS: ---

        NOTES: ---

       AUTHOR: Johan Nylander (JN), johan.nylander@nrm.se

      COMPANY: NBIS/NRM

      VERSION: 1.0

      CREATED: 2019-04-12 16:12:21

     REVISION: ons 21 maj 2025 09:50:00

=cut


#===============================================================================

use strict;
use warnings;
use Getopt::Long;
use File::Basename;

exec("perldoc", $0) unless (@ARGV);

my $outdir = q{};
my $VERBOSE = 0;

GetOptions(
    "outdir=s" => \$outdir,
    "verbose!" => \$VERBOSE,
    "help"     => sub { exec("perldoc", $0); exit(0); },
);

if ($outdir) {
    if (! -d $outdir) {
        print "Creating directory $outdir.\n" if $VERBOSE;
        unless (mkdir $outdir) {
            die "Unable to create $outdir\n";
        }
    }
    else {
        print "Adding files to directory $outdir.\n" if $VERBOSE;
    }
}
else {
    die "Error: need a name for the output directory (-o name)\n";
}

my %gene_file_hash = ();

while (my $dir = shift(@ARGV)) {
    if ( ! -d $dir ) {
        die "Can not find directory $dir: $!\n";
    }
    my @fasta_files = <$dir/*.fas>; # Assuming file ends in .fas
    if ( ! @fasta_files ) {
        die "Error: could not find .fas files in $dir\n";
    }
    my $bn = basename($dir);
    print "Looking for .fas files in $bn\n" if $VERBOSE;
    foreach my $filename (@fasta_files) {
        my ($name, $path, $suffix) = fileparse($filename, '.fas');  # Assumes file named "n.geneid.fas"
        my ($n, $geneid) = split /\./, $name; # Assumes "n.geneid"
        if ( ! $geneid ) {
            die "Error: could not extract gene id from file $filename in dir $dir. Assuming format label.geneid.fas\n";
        }
        push @{$gene_file_hash{$geneid}}, $filename;
    }
}

foreach my $gene (keys %gene_file_hash) {
    print "Writing .fas file for $gene\n" if $VERBOSE;
    my $outfile = $outdir . '/' . $gene . '.fas';
    open my $OUTFILE, ">", $outfile or die "Could not open file $outfile for writing $!\n";
    foreach my $infile (@{$gene_file_hash{$gene}}) {
        open my $INFILE, "<", $infile or die "Could not open file $infile for reading: $!\n";
        while (<$INFILE>) {
            print $OUTFILE $_;
        }
        close($INFILE);
    }
    close($OUTFILE);
}

