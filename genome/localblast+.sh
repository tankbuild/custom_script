#!/bin/sh
#$ -M ming.wen@inra.fr
#$ -m be
#$ -N goldfish_genome_blastn
#$ -pe parallel_smp 16
#$ -l mem=4G
#$ -l h_vmem=8G

# make database
/usr/local/bioinfo/src/NCBI_Blast+/ncbi-blast-2.6.0+/bin/makeblastdb -in carAur03.sm.fa -hash_index -parse_seqids -dbtype nucl

# make blast
/usr/local/bioinfo/src/NCBI_Blast+/ncbi-blast-2.6.0+/bin/blastn -query Carassin_8_DiscovarDeNovo_assembly.fasta -db carAur03.sm.fa -max_target_seqs 1 -outfmt 6 -evalue 1e-40 -out male_blast2genome
