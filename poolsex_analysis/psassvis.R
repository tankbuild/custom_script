# plot poolseq data with Poolsexvis
# Cautions:
# 1. contig length file should not contain header
# 2. files' name should be exact the same as generated from pool-analysis tool
# 3. when giving chromosome file, bug will show up
# 4. if you do not want to plot all circle track lab with prefix "LG", you can just leave the last chromosome
# with "LG".
# 5. chromosome or contig length shoud greater than 500kb.

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
# devtools::install_github("RomainFeron/PSASS-vis")


library(psassvis)

data = load_data_files(contig_lengths_file_path = "./goldfish_genome.fasta.fai",
                       prefix = "goldfish_r500_psass",
                       chromosomes_names_file_path = "./chromosome_LG.tsv")

# load_data_files(contig_lengths_file_path = "amelas_length.tsv",
#                window_fst_file_path = "amelas_result_window_fst.tsv",
#                window_snps_file_path = "amelas_result_window_snp.tsv",
#                coverage_file_path = "amelas_result_coverage.tsv",
#                chromosomes_names_file_path = "amelas_LG_name.tsv",
#                position_fst_file_path = "amelas_result_position_fst.tsv"
#                position_snps_file_path = "amelas_result_position_snp.tsv"
#                plot.unplaced = TRUE)

draw_circos_plot(data, tracks = c("window_fst", "window_snp_males", "window_snp_females","depth_ratio"),
                 output.file = "goldfish_psass.png")
draw_circos_plot(data, tracks = c("window_snp_males", "window_snp_females","depth_ratio"),
                 output.file = "goldfish_psass.png")

draw_scaffold_plot(data, scaffold = "LG22", output.file = "goldfish_psass_LG22.png", tracks = c("window_snp_males", "window_snp_females"))
draw_scaffold_plot(data, scaffold = "LG47", output.file = "goldfish_psass_LG47.png", tracks = c("window_snp_males", "window_snp_females"))
draw_scaffold_plot(data, scaffold = "LG27", output.file = "amelasYY_psass_LG27.png", tracks = c("window_snp_males", "window_snp_females"))
draw_scaffold_plot(data, scaffold = "LG4", output.file = "amelasYY_psass_LG4_2.png")
draw_scaffold_plot(data, scaffold = "LG4", output.file = "amelasYY_psass_LG4_3.png", region = c(15000000, 27000000))
draw_scaffold_plot(data, scaffold = "LG4", output.file = "amelasYY_psass_LG4.png", coverage.type = "relative", region = c(12000000, 25000000))
draw_scaffold_plot(data, scaffold = "LG4", output.file = "amelas_scaffold1.png", tracks = c("window_snp_males", "coverage_males", "coverage_females", "combined_coverage"))

draw_manhattan_plot(data, output.file = "amelasyy_psass_fst_manhattan.png")
draw_manhattan_plot(data, output.file = "goldfish_psass_male.snp_manhattan.png", track = "window_snp_males")
draw_manhattan_plot(data, output.file = "goldfish_psass_female.snp_manhattan.png", track = "window_snp_females")

