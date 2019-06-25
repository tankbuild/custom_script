#!/usr/bin/sh
#SBATCH -J intersect_female
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH -o intersect_female.output
#SBATCH -e intersect_female.error

## vcftobed
module load bioinfo/bedtools-2.27.1

# intersect SVs
bedtools intersect -c -f 0.5 -r -a ./male/male_50_100000_sorted_len.bed -b ./female/female_50_100000_sorted_len.bed > male_intersect_female_c_f0.5_r.bed
cat male_intersect_female.bed | awk '{ if($10 == 0) print $0 }' > male_unique_sv.bed
