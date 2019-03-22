#!/usr/bin/sh
#SBATCH -J process_distribution
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH -o /home/mwen/work/goldfishRad/RADSex/process_distrib.output
#SBATCH -e /home/mwen/work/goldfishRad/RADSex/process_distrib.error

# export PATH=/usr/local/bioinfo/src/Stacks/stacks-1.44/bin:$PATH
radsex=/home/mwen/work/tools/RadSex/bin/radsex

# Computing the coverage table
# The first step of RADSex is to create a table of coverage for the dataset using the process command:

$radsex process --input-dir /home/mwen/work/goldfishRad/samples \
                --output-file coverage_table.tsv --threads 16 --min-cov 1

# Computing the distribution of sequences between sexes
# After generating the coverage table, the distrib command is used to compute the distribution of sequences between sexes:

$radsex distrib --input-file coverage_table.tsv --output-file distribution.tsv \
                --popmap-file /home/mwen/work/amelasRad/data/popmaps/carassius_auratus_popmap.csv \
                --min-cov 5
