#!/usr/bin/sh
#SBATCH -J svtyper_female
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH -o svtyper_female.output
#SBATCH -e svtyper_female.error

## Procedure for structural vriants calling
module load bioinfo/svtyper-v0.5.2
module load system/R-3.5.3

# genotyping
svtyper-sso \
    --core 2 \
    -B female_merged.bam \
    -l female_merged.bam.json \
    -i multi_female.vcf
    > multi_female.gt.vcf

/usr/local/bioinfo/src/svtyper/venv_svtyper-0.5.2/bin/lib_stats.R female_merged.bam.json female_merged.bam.json.pdf

