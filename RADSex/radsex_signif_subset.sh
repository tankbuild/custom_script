#!/usr/bin/sh
#SBATCH -J signif_subset
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH -o /home/mwen/work/goldfishRad/RADSex/signif_subset.output
#SBATCH -e /home/mwen/work/goldfishRad/RADSex/signif_subset.error

# export PATH=/usr/local/bioinfo/src/Stacks/stacks-1.44/bin:$PATH
radsex=/home/mwen/work/tools/RadSex/bin/radsex

# Extracting sequences significantly associated with sex
# Sequences significantly associated with sex can be obtained with the signif command:

$radsex signif --input-file /home/mwen/work/goldfishRad/RADSex/coverage_table.tsv --output-file sequences.tsv \
               --popmap-file /home/mwen/work/amelasRad/data/popmaps/carassius_auratus_popmap.csv \
               --min-cov 5

# Extracting a subset of the coverage matrix
# usually for extracting sex bias radtags

$radsex subset --input-file coverage_table.tsv --output-file male_bias_squences_12_0.fasta \
               --popmap-file /home/mwen/work/amelasRad/data/popmaps/carassius_auratus_popmap.csv \
               --min-cov 5 --min-males 12 --max-females 0 \
               --output-format fasta
