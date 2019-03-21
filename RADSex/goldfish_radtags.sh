#!/usr/bin/sh
#SBATCH -J poolsex_channel
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH -o /home/mwen/work/yy_channel_catfish/channel_pool/poolsex.output
#SBATCH -e /home/mwen/work/yy_channel_catfish/channel_pool/poolsex.error

# export PATH=/usr/local/bioinfo/src/Stacks/stacks-1.44/bin:$PATH
module load compiler/gcc-4.9.1
module load bioinfo/stacks-2.2
process_radtags -f /home/mwen/work/Project_PhyloSex.280/Run_Auratus.5657/RawData/RADauratus_NoIndex_L002_R1.fastq.gz -i gzfastq -o /home/mwen/work/goldfishRad/samples -b /home/mwen/work/amelasRad/data/barcodes/carassius_auratus_barcodes.csv -c -q -r -e sbfI
