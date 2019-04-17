#!/bin/sh
#BATCH -J unmapped_reads_poolseq
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH -o /home/mwen/work/Scyliorhinus_canicula/poolsex.output
#SBATCH -e /home/mwen/work/Scyliorhinus_canicula/poolsex.error

module load system/Python-3.6.3

## procedure for poolsex analysis
# how to use it
# when you switch to another species, just modify rootdir, genome, reads, gffand also reference path
# sbatch poolsex.sh

# prepare folder for poosex analysis in current directory
if [ ! -d ./poolseq ]
then
    mkdir -p poolseq/genome
    mkdir -p poolseq/reads
fi

#root directory for poolsex analysis
rootdir=$(pwd)/poolseq

# software required and installation
# path to directory for installing tools
toolsdir=/home/mwen/work/tools

# 1 PoolSex
if [ ! -d $toolsdir/PoolSex ]
then
    cd $toolsdir  # to the directory to install PoolSex tools
    git clone git@github.com:tankbuild/PoolSex.git
fi

# 2 PoolSex-analysis
if [ ! -d $toolsdir/PSASS ]
then
    cd "$toolsdir"  # to the directory to install PoolSex-analysis tools
    git clone https://github.com/RomainFeron/PSASS.git
    cd ./PSASS
    module load compiler/gcc-7.2.0
    make
fi

#bach to working directory
cd "$rootdir"  #back to the root directory to run script

# path to PoolSex to generate shell files for each part of the pipeline and submit them on an SGE or a SLURM scheduler
poolsex=$toolsdir/PoolSex/poolsex.py

# path to PoolSex_analysis
psass=$toolsdir/PSASS/bin/psass

#check genome file
if [ ! -f $rootdir/genome/*.fasta ]
then
    ln -s /home/mwen/work/Scyliorhinus_canicula/male_unmapped_reads_reassembly/male_unmapped/scaffolds.fasta $rootdir/genome/dogfish_genome.fasta
fi

# check reads is ready to use
if [ ! -f $rootdir/reads/*.gz ]
then
    readsdir=/home/mwen/work/Project_PhyloSex.280/Run_pool-14poissons-Run3.15030/RawData
    ln -s $readsdir/S-cani-F_GATCTATC-ATGAGGCT-BHGWY2DSXX_L001_R1.fastq.gz $rootdir/reads/female_L001_R1.fastq.gz
    ln -s $readsdir/S-cani-F_GATCTATC-ATGAGGCT-BHGWY2DSXX_L001_R2.fastq.gz $rootdir/reads/female_L001_R2.fastq.gz
    ln -s $readsdir/S-cani-M_CATAATAC-TTCTAACG-BHGWY2DSXX_L001_R1.fastq.gz $rootdir/reads/male_L001_R1.fastq.gz
    ln -s $readsdir/S-cani-M_CATAATAC-TTCTAACG-BHGWY2DSXX_L001_R2.fastq.gz $rootdir/reads/male_L001_R2.fastq.gz
fi

# path to reference
reference=$rootdir/genome/dogfish_genome.fasta

# path to gff file
# gff=/home/mwen/work/genomes/goldfish/female/GCF_003368295.1_ASM336829v1_genomic.gff

# run PoolSex
python $poolsex init -i $rootdir &&

python $poolsex run -i $rootdir &&

# path to popoolation
# /usr/local/bioinfo/src/PoPoolation2/popoolation2_1201/mpileup2sync.jar

# run PoolSex-analyses
# generate output data with prefix goldfish_<freq-het>_<freq-hom>_<range-het>_<range-hom>_pool
until [ -f $rootdir/results/mpileup2sync_female_male.sync ]
do
	$psass analyze --input-file $rootdir/results/mpileup2sync_female_male.sync --output-prefix $rootdir/results/dogfish_0.5_1_0.1_0.05_pool \
	               --male-pool 2 --range-het 0.1 --range-hom 0.05
done
