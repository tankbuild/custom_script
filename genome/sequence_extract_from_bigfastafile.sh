#!/usr/bin/sh
#SBATCH -J extract_sequence
#SBATCH --cpus-per-task=16
#SBATCH -o /home/mwen/work/piranha/tomettes/localblast/extract_sequence.output
#SBATCH -e /home/mwen/work/piranha/tomettes/localblast/extract_sequence.error


# loading blast
module load bioinfo/samtools-1.8

# path to reference and file containing sequence name to be extracted
genome_ref_rename=herbivore_genome.fasta
to_be_extractedfile=to_be_extracted.txt

# check if reference fasta indexed or not
if [ ! -f $genome_ref_rename.fai ]
then
	samtools faidx $genome_ref_rename
fi

# extract sequences in batch
xargs samtools faidx $genome_ref_rename < $to_be_extractedfile > extracted_seqs.fa

# # extract one sequence
# samtools faidx $genome_ref_rename flattened_line_1998 > flattened_line_1998.fa


# if [ ! -f /tmp/foo.txt ]; then
#     echo "File not found!"
# fi

# # format of to_be_extracted.txt
# flattened_line_1998
# flattened_line_1226
# flattened_line_10549
# flattened_line_55310

# Use bedtools getfasta extract portions of a FASTA entry
# Requires the regions of interest be in BED format.
# $ head Homo_sapiens.GRCh38_CpG_Islands.bed
# 1 10413 11207
# 1 28687 29634
# 1 51546 51882
# 1 121270 121549

# The sequences of interest are extracted like this:
# $ bedtools getfasta -fi Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa -bed Homo_sapiens.GRCh38_CpG_Islands.bed -fo Homo_sapiens.GRCh38_CpG_Islands.fasta
