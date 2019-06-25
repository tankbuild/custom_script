#!/usr/bin/sh
#SBATCH -J pindel2vcf_male
#SBATCH -p unlimitq
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH -o /home/mwen/work/goldfish_longreads_mapping/structural_variants/pindel/male/pindel2vcf_male.output
#SBATCH -e /home/mwen/work/goldfish_longreads_mapping/structural_variants/pindel/male/pindel2vcf_male.error

## Procedure for structural vriants calling will pindel
# loading pindel and bcltools
module load bioinfo/pindel-0.2.5b8
# module load bioinfo/bcftools-1.6

# path to reference
reference=/home/mwen/work/genomes/goldfish/female/GCF_003368295.1_ASM336829v1_genomic.fna

# path to file
outdir=/home/mwen/work/goldfish_longreads_mapping/structural_variants/pindel/male ## 输入和输出路径相同
indir=$outdir

## calling SVs with pindel
time pindel -f $reference -i $indir/goldfish_male_config.txt -o $outdir/goldfish_male_pindel -T 16 -d 100 -N -I -k -l -g -q \
            --MIN_DD_CLUSTER_SIZE 10 --MIN_DD_BREAKPOINT_SUPPORT 10 --DD_REPORT_DUPLICATION_READS -M 10 -c ALL \
    && echo "** pindel SVs calling done ** " &&

# -d/--min_num_matched_bases
# only consider reads as evidence if they map with more than X bases to
# the reference. (default 30)


## converting to vcf file
/usr/local/bioinfo/src/Pindel/pindel-0.2.5b8/pindel2vcf -P goldfsih_male_pindel -r $reference -is 50 -e 10 \
                                                        -R goldfish-NCBI -d 2018/08/08 -G -v goldfish_male_pindel_all.vcf

# -e/--min_supporting_reads  The minimum number of supporting reads required for an event to be reported (default 1)
# -is/--min_size  The minimum size of events to be reported (default 1)
