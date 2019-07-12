#!/usr/bin/sh
#SBATCH -J vcftobed_female
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH -o vcftobed_female.output
#SBATCH -e vcftobed_female.error

## vcftobed
module load bioinfo/SURVIVOR-1.0.5

# Extracting deletions
cat multi_female.vcf | awk -v OFS='\t' '/<DEL>/ {print $0}' > female_del.vcf
# contig,start,end,svtype,length,su,pe,SR
cat female_del.vcf | gawk -v OFS='\t' 'match($0, /SVTYPE=(DEL).*SVLEN=-([[:digit:]]*).*SU=([[:digit:]]*);PE=([[:digit:]]*);SR=([[:digit:]]*).*/, m) { print $1,$2,$2+m[2],m[1],m[2],m[3],m[4],m[5]; }' > female_del.bed
# calculating SU mean
cat female_del.bed | awk -v sum=0 '{sum += $6} END {print sum/NR}'
# merge SVs
SURVIVOR vcftobed multi_female_SU10.vcf 50 100000 multi_female_50_100000.bed
cat multi_female_50_100000.bed | sort -k1,1 -k2,2n | awk -v OFS='\t' '/DEL|DUP/ {print $0,($5-$2)}' | cut -f1,2,6,7,8,9,10,11,12 > female_50_100000_sorted_len.bed

#vcf file
#min size
#max size
#output file
