#!/usr/bin/sh
#SBATCH -J fasta_seq_parse
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH -o /home/mwen/work/channel_catfish_poolseq/structural_variants/fasta_seq_parse.output
#SBATCH -e /home/mwen/work/channel_catfish_poolseq/structural_variants/fasta_seq_parse.error

module load bioinfo/samtools-1.8

# !/bin/bash
# how to use
# sbatch multifasta_2individuals.sh

genome_ref=/home/mwen/work/genomes/Amelas/ictalurus_punctatus/ictalurus_punctatus_genome.fasta

while read line
do
    if [[ ${line:0:1} == '>' ]]
    then
        outfile=${line#>}.fa
        echo $line > $outfile
    else
        echo $line >> $outfile
    fi
done < "$genome_ref"
