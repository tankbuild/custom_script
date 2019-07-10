#!/usr/bin/sh
#SBATCH -J vcftobed
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH -o vcftobed.output
#SBATCH -e vcftobed.error

module load bioinfo/bedops-v2.4.35
module load bioinfo/bedtools-2.27.1

sortBed -i GCF_001660625.1_IpCoco_1.2_genomic.gff | gff2bed > GCF_001660625.1_IpCoco_1.2_genomic_sorted.bed
cat GCF_001660625.1_IpCoco_1.2_genomic_sorted.bed | awk -v OFS='\t' '{if($8 == "mRNA") print $1,$2,$3,$8,$10}' > GCF_001660625.1_IpCoco_1.2_genomic_mRNA.bed
cat ictalurus2Amelas.blast | awk -v OFS='\t' '/HiC_scaffold_22/ {print $1,$7,$8,$4,$2,$9,$10}' > lg22toictalurus.bed
bedtools intersect -f 0.5 -r -wao -a ~/work/amelas_poolsex_analysis/poolseq/results/lg22toIctalurus/lg22toictalurus.bed \
        -b ~/work/genomes/Amelas/ictalurus_punctatus/GCF_001660625.1_IpCoco_1.2_genomic_mRNA.bed | \
        awk '{if($13 != 0) print $0}' > lg22_annotated_genes.bed

cat lg22_annotated_genes.bed | awk -v OFS='\t' \
   'match($0, /.*(HiC_scaffold_[[:digit:]]+)[[:space:]]*([[:digit:]]*)[[:space:]]*([[:digit:]]*).*gene=(.*);.*/, m) {print m[1],m[2],m[3],m[4];}' | \
    sort -k2,2n | uniq > lg22_annotation.bed

cat lg22_annotation.bed | cut -f4 | sort | uniq > gene_on_lg22.txt
