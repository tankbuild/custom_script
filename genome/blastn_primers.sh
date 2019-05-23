#!/usr/bin/sh
#SBATCH -J blastn
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH -o /home/mwen/work/goldfish_primer/blastn_amelas.output
#SBATCH -e /home/mwen/work/goldfish_primer/blastn_amelas.error


/usr/local/bioinfo/src/NCBI_Blast+/ncbi-blast-2.6.0+/bin/blastn -query /home/mwen/work/goldfish_primer/goldfish_qPCR_primers.fasta \
                                                                -db /home/mwen/work/genomes/goldfish/male/Carassin_8_DiscovarDeNovo_assembly.fasta \
                                                                -max_target_seqs 10 -task blastn-short -word_size 18 -outfmt 6 -evalue 100 -out primer2mgenome.blast
