#!/usr/bin/sh
#SBATCH -J male_SVs_calling
#SBATCH --cpus-per-task=16
#SBATCH -o /home/mwen/work/channel_catfish_poolseq/structural_variants/delly/delly_male.output
#SBATCH -e /home/mwen/work/channel_catfish_poolseq/structural_variants/delly/delly_male.error

## Procedure for structural vriants calling will delly
# loading delly and bcltools
module load bioinfo/delly_v0.7.8
# module load bioinfo/bcftools-1.6

# set path to input and output directory

outdir=/home/mwen/work/channel_catfish_poolseq/structural_variants/delly ## 输入路径
indir=$outdir


# applying SV filter of male
time delly filter -f germline -o $outdir/male.filter.bcf $indir/male.geno.bcf \
    && echo "** male SV filter done ** "
# applying SV filter of female
time delly filter -f germline -o $outdir/female.filter.bcf $indir/female.geno.bcf \
    && echo "** female SV filter done ** "
