#!/bin/sh
#SBATCH -J gbff2gff3
#SBATCH --cpus-per-task=4
#SBATCH -o /home/aherpin/work/bsb/gbff2gff.output
#SBATCH -e /home/aherpin/work/bsb/gbff2gff.error

module purge
module load system/perl-5.10.1

perl ~/work/tools/BioPerl-1.7.7/bin/bp_genbank2gff3 bsb.gbff.gz > bsb.gff3
