# plot poolseq data with Poolsexvis
# Cautions:
# 1. contig length file should not contain header
# 2. files' name should be exact the same as generated from pool-analysis tool
# 3. when giving chromosome file, bug will show up

# modified by Romain
# I found what caused the problem. You had "MT" in the chromosomes names file, 
# and thus the R package was trying to draw a sector for the mitochondria 
# (which is only 16kb and way too small to draw). As a habit, you should only put the names 
# of the chromosomes you want to draw in the chromosomes names file. Just in case, 
# I added a small fix to the package to check for "MT" in the chromosomes names.
# In addition, in the contig lengths file you should have the original contig names 
# (NC_XX and NW_XX) instead of "LG". With the last version of PoolSex, there should be 
# a file "genome_name.fasta.fai" in the genome folder of poolsex which you should just
# use as the contig lengths file.


# install.packages("devtools")
# library(devtools)
# devtools::install_github("INRA-LPGP/PoolSex-vis")

library(poolsexvis)

data = load_data_files(contig_lengths_file_path = "./ipunctatus_genome.fasta.fai",
                prefix = "channel_result",
                chromosomes_names_file_path = "./channel_LG_name.tsv")

# load_data_files(contig_lengths_file_path = "channel_length.tsv",
#                window_fst_file_path = "channel_result_window_fst.tsv",
#                window_snps_file_path = "channel_result_window_snp.tsv",
#                coverage_file_path = "channel_result_coverage.tsv",
#                chromosomes_names_file_path = "channel_LG_name.tsv",
#                position_fst_file_path = "channel_result_position_fst.tsv"
#                position_snps_file_path = "channel_result_position_snp.tsv"
#                plot.unplaced = TRUE)

draw_circos_plot(data, tracks = c("window_fst", "window_snp_males", "window_snp_females","coverage_ratio"),
                 output.file = "channel_circos.png", color.unplaced = TRUE)

draw_scaffold_plot(data, scaffold = "LG4", output.file = "channel_scaffold.png", coverage.type = "relative")
draw_scaffold_plot(data, scaffold = "LG4", output.file = "channel_scaffold_region.png", coverage.type = "relative", region = c(12000000, 25000000))
draw_scaffold_plot(data, scaffold = "LG4", output.file = "channel_scaffold1.png", tracks = c("window_snp_males", "coverage_males", "coverage_females", "combined_coverage"))
