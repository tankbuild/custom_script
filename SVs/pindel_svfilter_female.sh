#!/usr/bin/sh
#SBATCH -J F_svfilter
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH -o /home/mwen/work/channel_catfish_poolseq/structural_variants/pindel/svfilter/F_svfilter.output
#SBATCH -e /home/mwen/work/channel_catfish_poolseq/structural_variants/pindel/svfilter/F_svfilter.error

# # Use SVFilter to filter pindel results
# loading pindel and bcltools
# module load bioinfo/pindel-0.2.5b8

# path to reference
reference=/home/mwen/work/genomes/Amelas/ictalurus_punctatus/ictalurus_punctatus_genome.fasta

# path to mpileup file
mpileup=/home/mwen/work/channel_catfish_poolseq/structural_variants/svdetect/female_norm.pileup

# path to chromosome length file
chr_length=/home/mwen/work/channel_catfish_poolseq/poolseq/results/channel_length.tsv

# path to svfilter tools
svfilter=/home/mwen/work/tools/SVFilter-1.0/bin

# path to results directory
root_folder=/home/mwen/work/channel_catfish_poolseq/structural_variants/pindel/female

for file in $root_folder/*.filter; do
	output=${file%%.filter}.svfilter
	echo "$(basename "$file" .filter) is being processed"
	$svfilter/gapfilter $file $reference 1 0.1
	echo "gapfilter is done"
done

echo "##################################################"

# if [[ $file =~ .*_D.filter.* ]]; then
# 	$svfilter/coveragefilter $file $reference $mpileup 100 0.8 3
# 	echo "coveragefilter is done"
# fi

for file in $root_folder/*_kept; do
	echo "depthfilter is processing"
	if [[ $file =~ .*_TD.filter_gapfilter_kept.* ]]; then
		$svfilter/depthfilter $file $chr_length $mpileup 1.5 1.5
		echo "depthfilter is done"
	else
		echo "no"
	fi
done
