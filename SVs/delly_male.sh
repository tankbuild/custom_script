#!/usr/bin/sh
#SBATCH -J male_SVs_calling
#SBATCH --cpus-per-task=16
#SBATCH -o /home/mwen/work/goldfish_longreads_mapping/structural_variants/delly/delly_male.output
#SBATCH -e /home/mwen/work/goldfish_longreads_mapping/structural_variants/delly/delly_male.error

## Procedure for structural vriants calling will delly
# loading delly and bcltools
module load bioinfo/delly_v0.7.8
# module load bioinfo/bcftools-1.6

# path to reference
reference=/home/mwen/work/genomes/goldfish/female/GCF_003368295.1_ASM336829v1_genomic.fna

# path to bamfile
male_bam=/home/mwen/work/goldfish_poolsex_analysis/poolseq/results/groups_male.bam

outdir=/home/mwen/work/goldfish_longreads_mapping/structural_variants/delly
indir=$outdir

# set directory for storing sex variant calling result
# if [ ! -d $outdir/female ]
# then mkdir -p $outdir/female
# fi

# if [ ! -d $outdir/male ]
# then mkdir -p $outdir/male
# fi

## calling SVs for female with delly
# variant calling
time delly call -g $reference -o $outdir/male.bcf $male_bam \
    && echo "** male variant calling done ** " &&
# genotyping SV sites
time delly call -g $reference -v $indir/male.bcf -o $outdir/male.geno.bcf $male_bam \
    && echo "** male SV sites genotyping done ** " &&
# applying SV filter of male
time delly filter -f germline -o $outdir/male.filter.bcf $indir/male.geno.bcf \
     && echo "** male SV filter done ** "