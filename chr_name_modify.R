library(readr)

depth_snp_file_path = "/home/mwen/work/channel_catfish/snp_depth/data2plot/channel_depth_snp1.tsv"
chr_name_file_path = "/home/mwen/work/channel_catfish/snp_depth/data2plot/channel_chr_name.tsv"

depth_snp = suppressMessages(read_delim(depth_snp_file_path, "\t", escape_double = FALSE, col_names = FALSE,  trim_ws = TRUE))
chr_name = suppressMessages(read_delim(chr_name_file_path, "\t", escape_double = FALSE, col_names = FALSE,  trim_ws = TRUE))

names(depth_snp) = c("contig", "position", "male_depth", "female_depth", "male_snp", "female_snp")
names(chr_name) = c("contig", "chr")
rownames(chr_name) = chr_name$contig

which(depth_snp$contig %in% chr_name$contig)
depth_snp[which(depth_snp$contig %in% chr_name$contig), "contig"] = chr_name[depth_snp$contig,"chr"]

rownames(chr_name) = NULL

write.table(x = depth_snp, file = "channel_depth_snp.tsv", quote = FALSE, sep = "\t", row.names = FALSE)
