# install.packages("devtools")
# library(devtools)
# devtools::install_github("INRA-LPGP/radsex-vis")

library(radsexvis)

# Plots a heatmap of distribution of sequences between sexes from a table generated with RADSex distribution
plot_sex_distribution(input_file_path="./distribution.tsv", output_file_path = "sex_distribution.png",
                      title = "Rad sequences distribution in two sexes", width = 8, height = 7, dpi = 300,
                      autoscale = FALSE, show.significance = TRUE,
                      significance.color = "red3", significance.threshold = 0.05,
                      color.scale.bins = c(0, 1, 5, 25, 100, 1000),
                      color.scale.colors = c("white", "navyblue"))

# # load sex distribution data
# sex_distribution = load_sex_distribution_table(input_file_path = "./distribution.tsv")
# sex_distribution_heatmap(data = sex_distribution, title = "Rad sequences distribution in two sexes", 
#                          show.significance = TRUE,
#                          significance.color = "red3", significance.threshold = 0.05,
#                          color.scale.bins = c(0, 1, 5, 25, 100, 1000),
#                          color.scale.colors = c("white", "navyblue"))
# Plots a heatmap of coverage from a table generated with RADSex subset, RADSex signif, or RADSex loci.
plot_coverage(input_file_path = "./sequences.tsv", output_file_path = "signif_coverage.png",
              popmap_file_path = "./ameirus_melas_popmap.csv", width = 10, height = 8, dpi = 300,
              title = "Coverage of radsex significant loci", min.coverage = 5, max.coverage = 150,
              distance.method = "euclidean", clustering.method = "ward.D",
              males.color = "dodgerblue3", females.color = "red3",
              coverage.palette = c("white", "royalblue2", "black", "gold2", "red3"),
              individual.names = TRUE, sequence.names = FALSE,
              individual.dendrogram = TRUE, sequence.dendrogram = TRUE)

# Generates a circular plot of RADSex mapping results in which each sector represents a linkage group 
# and the x-axis represents the position on the linkage group. The y-axis on the first track shows the 
# sex-bias of a sequence, and the second track shows the probability of association with sex of a sequence.
plot_genome_circular(mapping_file_path = "./mapping_yy.tsv", contig_lengths_file_path = "./ipunctatusYY_genome.fasta.fai",
                     chromosomes_names_file_path = "./chromosome_LG.tsv", plot.unplaced = TRUE,
                     output_file_path = "./circular_radsex.png", width = 1400, height = 1400, res = 100,
                     highlight = NULL, zoom.highlights = FALSE, zoom.ratio = 2,
                     zoom.suffix = " (zoom)", base.color = "white",
                     highlight.color = "grey80", point.size = 0.5,
                     color.sex.bias = TRUE, 
                     sex.bias.palette = c("firebrick1", "black", "dodgerblue2"), 
                     color.unmapped = TRUE, 
                     unmapped.palette = c(`0` ="dodgerblue3", `1` = "goldenrod1", `2` = "grey30"), 
                     signif.threshold = 0.05, sector.titles.expand = 1.9)

# Generates a manhattan plot of association with sex from RADSex mapping results.
plot_genome_manhattan(mapping_file_path = "./mapping_yy.tsv", contig_lengths_file_path = "./ipunctatusYY_genome.fasta.fai",
                      chromosomes_names_file_path = "./chromosome_LG.tsv", plot.unplaced = TRUE,
                      output_file_path = "manhattan_radsex.png", width = 14, height = 7, dpi = 300,
                      point.size = 0.5, signif.threshold = 0.05,
                      point.palette = c("dodgerblue3", "darkgoldenrod2"),
                      background.palette = c("grey85", "grey100"),
                      significance.line.color = "black", significance.line.type = 2,
                      significance.text.position = c(0.05, 0.05))
