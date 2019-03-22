#!/usr/bin/sh
#SBATCH -J radtags
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH -o /home/mwen/work/goldfishRad/RADSex/radtags.output
#SBATCH -e /home/mwen/work/goldfishRad/RADSex/radtags.error

# export PATH=/usr/local/bioinfo/src/Stacks/stacks-1.44/bin:$PATH
module load compiler/gcc-4.9.1
module load bioinfo/stacks-2.2
process_radtags -f /home/mwen/work/Project_PhyloSex.280/Run_Auratus.5657/RawData/RADauratus_NoIndex_L002_R1.fastq.gz \
                -i gzfastq -o /home/mwen/work/goldfishRad/samples \
                -b /home/mwen/work/amelasRad/data/barcodes/carassius_auratus_barcodes.csv \
                -c -q -r -e sbfI
