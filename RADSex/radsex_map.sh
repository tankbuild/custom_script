#!/usr/bin/sh
#SBATCH -J map
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH -o /home/mwen/work/goldfishRad/RADSex/map.output
#SBATCH -e /home/mwen/work/goldfishRad/RADSex/map.error

# export PATH=/usr/local/bioinfo/src/Stacks/stacks-1.44/bin:$PATH
radsex=/home/mwen/work/tools/RadSex/bin/radsex
# Mapping sequences to a reference genome
# Sequences can be mapped to a reference genome using the map command:

$radsex map --input-file coverage_table.tsv --output-file mapping.tsv \
            --popmap-file /home/mwen/work/amelasRad/data/popmaps/carassius_auratus_popmap.csv \
            --genome-file /home/mwen/work/genomes/goldfish/female/GCF_003368295.1_ASM336829v1_genomic.fna \
            --min-quality 20 --min-frequency 0.1 --min-cov 5
