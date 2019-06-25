#!/usr/bin/sh
#SBATCH -J samtools_stats
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH -o /home/mwen/work/goldfish_longreads_mapping/structural_variants/pindel/samtools_stats.output
#SBATCH -e /home/mwen/work/goldfish_longreads_mapping/structural_variants/pindel/samtools_stats.error

module load bioinfo/samtools-1.8

samtools flagstat /home/mwen/work/goldfish_poolsex_analysis/poolseq/results/duplicates_female.bam > samtools_stats_female.txt
samtools flagstat /home/mwen/work/goldfish_poolsex_analysis/poolseq/results/duplicates_male.bam > samtools_stats_male.txt