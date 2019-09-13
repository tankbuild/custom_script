#!/bin/bash
#SBATCH -J kat
#SBATCH -o kat.output
#SBATCH -e kat.error
#SBATCH --mem=240G

#Purge any previous modules
module purge
module load bioinfo/jellyfish-2.2.10
module load system/Miniconda3-4.4.10
module load bioinfo/kat-2.4.1

#Load the application
Reads_d='/home/mwen/work/Project_GENOFISH.830/Run_10X_PANGA.13800/Analyse_DemultiplexData.53847'
jellyfish count -C -m 21 -s 100M -t 10 -o reads.jf <(zcat $Reads_d/PANGA1G_S1_L007_R1_001.fastq.gz) <(zcat $Reads_d/PANGA1G_S1_L007_R2_001.fastq.gz)
jellyfish count -C -m 21 -s 100M -t 10 -o genome.jf /home/mwen/work/genomes/panga/P.hypophthalmus/Pangasianodon_hypophthalmus.PHYPO1.1.dna.toplevel.fa
kat comp -t 16 -o comparison reads.jf genome.jf
kat plot spectra-cn -x 100 -o panga.spectra-cn.png -p png comparison.mx


# kat comp -t 32 -o pe_vs_assembly '/home/mwen/work/Project_GENOFISH.830/Run_10X_PANGA.13800/Analyse_DemultiplexData.53847/PANGA1G_S1_L007_R?_001.fastq.gz' \
#          /home/mwen/work/genomes/panga/P.hypophthalmus/Pangasianodon_hypophthalmus.PHYPO1.1.dna.toplevel.fa
