#!/usr/bin/sh
#SBATCH -J speedseq_align_female
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH -o speedseq_align_female.output
#SBATCH -e speedseq_align_female.error

## Procedure for structural vriants calling will svaba
# loading svaba and bcltools
# module load bioinfo/samtools-1.9
# module load bioinfo/samblaster-v.0.1.24
speedseq="/home/mwen/work/tools/speedseq/bin/speedseq"
# module load bioinfo/bcftools-1.6

# path to reference
ref=/home/mwen/work/genomes/Amelas/male_chr/Ameiurus_melas.before_review.fa

# Reads directory
reads_dir=/home/mwen/work/amelas_poolsex_analysis/poolseq/reads
#female bamfile
# female_bam=/home/mwen/work/goldfish_poolsex_analysis/poolseq/results/groups_female.bam
# path to file
# outdir=/home/mwen/work/goldfish_longreads_mapping/structural_variants/svaba/female ## 输入和输出路径相同
# indir=$outdir

$speedseq align \
          -t 16 \
          -o female1 \
          -R "@RG\tID:female.S1\tSM:female\tLB:lib1" \
          $ref \
          $reads_dir/female_L001_R1.fastq.gz \
          $reads_dir/female_L001_R2.fastq.gz

$speedseq align \
          -t 16 \
          -o female2 \
          -R "@RG\tID:female.S2\tSM:female\tLB:lib1" \
          $ref \
          $reads_dir/female_L002_R1.fastq.gz \
          $reads_dir/female_L002_R2.fastq.gz
