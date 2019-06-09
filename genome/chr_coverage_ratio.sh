#!/usr/bin/sh
#SBATCH -J male_assembly2female_genome
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH -o /home/mwen/work/goldfish_longreads_mapping/male_assembly2genome/male_assembly2female_genome.output
#SBATCH -e /home/mwen/work/goldfish_longreads_mapping/male_assembly2genome/male_assembly2female_genome.error

cat /home/mwen/work/genomes/goldfish/female/GCF_003368295.1_ASM336829v1_genomic.fna.fai | cut -f1 | grep 'NC_03' | \
while read id; do awk -v name=${id} -v sum=0 '{if ($0~name && $3 >=1) sum+=1} END {print name,sum}' \
depth_samtools.txt >> chr_cov_ratio.txt; done
