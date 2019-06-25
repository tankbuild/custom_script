#!/usr/bin/sh
#SBATCH -J female_SVs_calling
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH -o /home/mwen/work/channel_catfish_poolseq/structural_variants/pindel/female/pindel_female.output
#SBATCH -e /home/mwen/work/channel_catfish_poolseq/structural_variants/pindel/female/pindel_female.error

## Procedure for structural vriants calling will pindel
# loading pindel and bcltools
module load bioinfo/pindel-0.2.5b8
# module load bioinfo/bcftools-1.6

# path to reference
reference=/home/mwen/work/genomes/Amelas/ictalurus_punctatus/ictalurus_punctatus_genome.fasta

# path to file
outdir=/home/mwen/work/channel_catfish_poolseq/structural_variants/pindel/female/ ## output path
indir=$outdir

# set directory for storing sex variant calling result
# if [ ! -d $outdir/fefemale ]
# then mkdir -p $outdir/fefemale
# fi

# if [ ! -d $outdir/female ]
# then mkdir -p $outdir/female
# fi

## calling SVs for fefemale with pindel
# variant calling
time pindel -f $reference -T 16 -i $indir/channel_female_config.txt -c ALL -o $outdir/channel_female_pindel \
    && echo "** pindel SVs calling done ** "
