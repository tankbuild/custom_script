#!/bin/sh
#$ -M ming.wen@inra.fr
#$ -m be
#$ -N flattened_line_58930.bam
#$ -pe parallel_smp 16
#$ -l mem=4G
#$ -l h_vmem=8G

export PATH=/usr/local/bioinfo/bin/samtools/samtools-1.1:$PATH

samtools view -h -b L_goldfish_poolfemale_merged.bam flattened_line_58930 > flattened_line_58930_1.bam
samtools index flattened_line_58930_1.bam
