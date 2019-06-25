#!/usr/bin/sh
#SBATCH -J vcftobed_female
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH -o vcftobed_female.output
#SBATCH -e vcftobed_female.error

## vcftobed
module load bioinfo/SURVIVOR-1.0.5

# Filter out SVs that SU < 10
cat multi_female.vcf | gawk 'match($0, /.*SU=([[:digit:]]*).*/, m) { if(m[1]>=10) print $0 }' > multi_female_SU10.vcf
# merge SVs
SURVIVOR vcftobed multi_female_SU10.vcf 50 100000 multi_female_50_100000.bed 
cat multi_female_50_100000.bed | sort -k1,1 -k2,2n | awk -v OFS='\t' '/DEL|DUP/ {print $0,($5-$2)}' | cut -f1,2,6,7,8,9,10,11,12 > female_50_100000_sorted_len.bed

#vcf file
#min size
#max size
#output file
