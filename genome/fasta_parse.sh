#!/usr/bin/sh
#SBATCH -J fasta_seq_parse
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH -o /home/mwen/work/channel_catfish_poolseq/structural_variants/fasta_seq_parse.output
#SBATCH -e /home/mwen/work/channel_catfish_poolseq/structural_variants/fasta_seq_parse.error

module load bioinfo/samtools-1.8

# !/bin/bash
# how to use
# sbatch fasta_parse.sh /path/to/seq_name_file.text

#$1 path to file containing sequence names to extract

genome_ref=/home/mwen/work/genomes/Amelas/ictalurus_punctatus/ictalurus_punctatus_genome.fasta

while IFS= read -r seq_name
do
    samtools faidx $genome_ref $seq_name > $seq_name.fa
done < "$1"

# # Example of seq_name_file.text
# NC_030416.1
# NC_030417.1
# NC_030418.1
# NC_030419.1
# NC_030420.1
# NC_030421.1
# NC_030422.1
# NC_030423.1
# NC_030424.1
