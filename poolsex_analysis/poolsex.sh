#!/usr/bin/sh
#SBATCH -J male_SVs_calling
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH -o /home/mwen/work/goldfish_poolsex_analysis/poolsex.output
#SBATCH -e /home/mwen/work/goldfish_poolsex_analysis/poolsex.error

module load system/Python-3.6.3

## procedure for poolsex analysis
# how to use it
# when you switch to another species, just modify rootdir, genome, reads, gffand also reference path
# sbatch poolsex.sh

# software required and installation
# 1 PoolSex
if [ ! -d /home/mwen/work/tools/PoolSex ]
then
    git clone https://github.com/INRA-LPGP/PoolSex.git
fi

# 2 PoolSex-analysis
if [ ! -d /home/mwen/work/tools/PoolSex-analyses ]
then
    git clone git@github.com:INRA-LPGP/PoolSex-analyses.git
    make
fi

# path to PoolSex to generate shell files for each part of the pipeline and submit them on an SGE or a SLURM scheduler
poolsex=/home/mwen/work/tools/PoolSex/poolsex.py

# path to PoolSex_analysis
poolsex_analysis=/home/mwen/work/tools/PoolSex-analyses/bin/poolsex

#root directory for poolsex analysis
rootdir=/home/mwen/work/goldfish_poolsex_analysis/poolseq

#check genome file
if [ ! -f $rootdir/genome/*.fasta ]
then
    ln -s /home/mwen/work/genomes/goldfish/female/GCF_003368295.1_ASM336829v1_genomic.fna $rootdir/genome/goldfish_genome.fasta
fi

# check reads is ready to use
if [ ! -f $rootdir/reads/*.gz ]
then
    readsdir=/home/mwen/work/Project_PhyloSex.280/Run_A_melas_-_C_auratus.10511/RawData
    ln -s $readsdir/C_auratus_femelle_S2_L001_R1_001.fastq.gz $rootdir/reads/female_L1_R1.fasta.gz
    ln -s $readsdir/C_auratus_femelle_S2_L001_R2_001.fastq.gz $rootdir/reads/female_L1_R2.fasta.gz
    ln -s $readsdir/C_auratus_femelle_S2_L002_R1_001.fastq.gz $rootdir/reads/female_L2_R1.fasta.gz
    ln -s $readsdir/C_auratus_femelle_S2_L002_R2_001.fastq.gz $rootdir/reads/female_L2_R2.fasta.gz
    ln -s $readsdir/C_auratus_male_S1_L001_R1_001.fastq.gz $rootdir/reads/male_L1_R1.fasta.gz
    ln -s $readsdir/C_auratus_male_S1_L001_R2_001.fastq.gz $rootdir/reads/male_L1_R2.fasta.gz
    ln -s $readsdir/C_auratus_male_S1_L002_R1_001.fastq.gz $rootdir/reads/male_L2_R1.fasta.gz
    ln -s $readsdir/C_auratus_male_S1_L002_R2_001.fastq.gz $rootdir/reads/male_L2_R2.fasta.gz
fi

# path to reference
reference=$rootdir/genome/goldfish_genome.fasta

# path to gff file
gff=/home/mwen/work/genomes/goldfish/female/GCF_003368295.1_ASM336829v1_genomic.gff

# path to reads
female_L1_R1=$rootdir/reads/female_L1_R1.fasta.gz
female_L1_R2=$rootdir/reads/female_L1_R2.fasta.gz
female_L2_R1=$rootdir/reads/female_L2_R1.fasta.gz
female_L2_R2=$rootdir/reads/female_L2_R2.fasta.gz
male_L1_R1=$rootdir/reads/male_L1_R1.fasta.gz
male_L1_R2=$rootdir/reads/male_L1_R2.fasta.gz
male_L2_R1=$rootdir/reads/male_L2_R1.fasta.gz
male_L2_R2=$rootdir/reads/male_L2_R2.fasta.gz

# run PoolSex
python $poolsex init -i $rootdir &&

python $poolsex run -i $rootdir &&

# run PoolSex-analyses
# generate output data with prefix goldfish_<freq-het>_<freq-hom>_<range-het>_<range-hom>_pool
$poolsex_analysis --input-file $rootdir/results/mpileup2sync_female_male.sync --output-prefix $rootdir/results/goldfish_0.5_1_0.2_0.05_pool \
                  --gff-file $gff --male-pool 1 --range-het 0.16

# # clean data
# python $poolsex.py clean -i $rootdir
