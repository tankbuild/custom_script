#!/usr/bin/sh
#SBATCH -J tomettes_blast
#SBATCH --cpus-per-task=16
#SBATCH -o /home/mwen/work/piranha/tomettes/localblast/tomettes_blast.output
#SBATCH -e /home/mwen/work/piranha/tomettes/localblast/tomettes_blast.error


# loading blast
module load bioinfo/blast-2.2.26

genome_ref_rename=herbivore_genome.fasta
query=gdf6_female_maculatus.fasta

# make a link to  reference
if [ ! -f $genome_ref_rename ]
then
	ln -s /home/mwen/work/genomes/piranha/herbivore/Piranha_herbivore_DiscovarDeNovo_assembly_male.fasta herbivore_genome.fasta
fi

# make database

if [ ! -f $genome_ref_rename.nhr ]
then
	/usr/local/bioinfo/src/NCBI_Blast/blast-2.2.26/bin/formatdb -i herbivore_genome.fasta -p F -V
fi

# bwa index genome
/usr/local/bioinfo/src/NCBI_Blast/blast-2.2.26/bin/blastall -p blastn -i $query -d herbivore_genome.fasta -e .001 -o result_gdf6.out

# if [ ! -f /tmp/foo.txt ]; then
#     echo "File not found!"
# fi
