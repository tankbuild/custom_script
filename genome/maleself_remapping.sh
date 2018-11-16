#!/usr/bin/sh
#SBATCH -J tomettes_remapping
#SBATCH --cpus-per-task=16
#SBATCH -o /home/mwen/work/piranha/tomettes/maleself_remapping/tomettes_remapping.output
#SBATCH -e /home/mwen/work/piranha/tomettes/maleself_remapping/tomettes_remapping.error


# loading bwa samtools and picard
module load bioinfo/bwa-0.7.17
module load bioinfo/samtools-1.8
module load bioinfo/picard-2.18.2
module load system/Java8
# path to reference
reference=/home/mwen/work/piranha/tomettes/genome/herbivore_genome.fasta

# reads
L1_R1=/home/mwen/work/piranha/tomettes/reads/tomettes_male_L1_R1.fastq.gz
L1_R2=/home/mwen/work/piranha/tomettes/reads/tomettes_male_L1_R2.fastq.gz
L2_R1=/home/mwen/work/piranha/tomettes/reads/tomettes_male_L2_R1.fastq.gz
L2_R2=/home/mwen/work/piranha/tomettes/reads/tomettes_male_L2_R2.fastq.gz

outdir=/home/mwen/work/piranha/tomettes/ ## root directory
indir=$outdir

# bwa index genome
bwa index $reference

# remap reads from two lanes to reference genome separately
bwa mem -t 16 $reference $L1_R1 $L1_R2 | samtools view -buS - > $outdir/maleself_remapping/tomattes_L1.bam
bwa mem -t 16 $reference $L2_R1 $L2_R2 | samtools view -buS - > $outdir/maleself_remapping/tomattes_L2.bam

# sort bamfile
samtools sort -o $outdir/maleself_remapping/tomattes_L1_sorted.bam $indir/maleself_remapping/tomattes_L1.bam
samtools sort -o $outdir/maleself_remapping/tomattes_L2_sorted.bam $indir/maleself_remapping/tomattes_L2.bam

# merge bamfile
samtools merge $outdir/maleself_remapping/tomattes_merged.bam $indir/maleself_remapping/tomattes_L1_sorted.bam $indir/maleself_remapping/tomattes_L2_sorted.bam

# picard mark duplicates
java -Xmx20G -Djava.io.tmpdir=$outdir/maleself_remapping/tmp -jar /usr/local/bioinfo/src/picard-tools/picard-2.18.2/picard.jar \
     MarkDuplicates I=$indir/maleself_remapping/tomattes_merged.bam O=$outdir/maleself_remapping/tomettes_no_duplicates.bam \
     M=$outdir/maleself_remapping/tomettes_duplicates.txt TMP_DIR=$outdir/maleself_remapping/tmp \
     MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 REMOVE_DUPLICATES=true
