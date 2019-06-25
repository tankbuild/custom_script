#!/bin/sh
#SBATCH -J insert_size_male
#SBATCH --mem=42G
#SBATCH -o /home/mwen/work/goldfish_longreads_mapping/structural_variants/insert_size_male.output
#SBATCH -e /home/mwen/work/goldfish_longreads_mapping/structural_variants/insert_size_male.error

module purge

module load bioinfo/picard-2.18.2

java -Xmx40G \
-jar $PICARD \
CollectInsertSizeMetrics \
I=/home/mwen/work/goldfish_poolsex_analysis/poolseq/results/duplicates_male1.bam \
O=insert_size_male1.txt \
H=insert_size_histogram_male.pdf