#!/usr/bin/sh
#SBATCH -J lumpyexpress_female
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH -o lumpyexpress_female.output
#SBATCH -e lumpyexpress_female.error

## Procedure for structural vriants calling will svaba
module load bioinfo/lumpy-v0.2.13
module load bioinfo/sambamba_v0.6.7

# merge bamfile from multi library
sambamba merge female_merged.bam female1.bam female2.bam
sambamba index female_merged.bam
sambamba merge female_splitters_merged.bam female1.splitters.bam female2.splitters.bam
sambamba index female_splitters_merged.bam
sambamba merge female_discordants_merged.bam female1.discordants.bam female2.discordants.bam
sambamba index female_discordants_merged.bam

rm female1.bam female2.bam female1.bam.bai female2.bam.bai
rm female1.splitters.bam female2.splitters.bam female1.splitters.bam.bai female2.splitters.bam.bai
rm female1.discordants.bam female2.discordants.bam female1.discordants.bam.bai female2.discordants.bam.bai

lumpyexpress \
    -B female_merged.bam \
    -S female_splitters_merged.bam \
    -D female_discordants_merged.bam \
    -o multi_female.vcf
