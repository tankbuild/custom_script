#!/bin/sh
#SBATCH -J chr_ex_re
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH -o chrexre.output
#SBATCH -e chrexre.error

module load bioinfo/samtools-0.1.19

#sinSch6b
less GCA_011952095.1_sinSch6b_genomic_male.fna | sed 's/\(CM.*linkage group \)\(LG.*\), whole genome shotgun sequence/\2/g' > sinSch6b_ASM_rename.fasta
less sinSch6b_ASM_rename.fasta | grep '>LG*' | sed 's/>//g' | xargs samtools faidx sinSch6b_ASM_rename.fasta > sinSch6b_ASM_chr.fasta
