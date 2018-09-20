library(readr)
library(ggplot2)
library(cowplot)

# sex_locus <- c("NC_030419.1", "NC_030423.1", "NC_030442.1")
sex_locus <- c()
sex_locus_color <- "darkred"

min_cov = 10

species_list <- c("esox_lucius",
                  "esox_lucius_dup",
                  "astyanax_mexicanus_1g_2f",
                  "astyanax_mexicanus_f_2f",
                  "astyanax_mexicanus_f_1g",
                  "astyanax_mexicanus_cave",
                  "coregonus",
                  "ictalurus_punctatus",
                  "ameiurus_melas")

for (i in 1:length(species_list)) {

    species <- species_list[i]

    data <- read_delim(paste0("/home/rferon/work/code/poolsexvis/tests/genes_files/", species, "_genes.tsv"),
                       "\t", escape_double = FALSE, trim_ws = TRUE)

    data <- subset(data, data$Cov_males_corr >= min_cov & data$Cov_females_corr >= min_cov)
    data$Contig[which(substr(data$Contig, 1, 2) != "NC")] = "Unplaced"
    data$Ratio_corr <- log(data$Cov_males_corr / data$Cov_females_corr, 2)
    data$Sex_locus <- (data$Contig %in% sex_locus)
    data$Contig[which(substr(data$Contig, 1, 2) != "NC")] = "Unplaced"
    data$Ratio_snp <- log((1 + data$Snp_males) / (1 + data$Snp_females), 2)


    max_y <- 1.1 * max(max(abs(data$Ratio_corr)), 1)
    ylim <- c(-max_y, max_y)
    step <- (ylim[2] - ylim[1]) / 40

    g <- ggplot(data, aes(x = Contig, y = Ratio_corr)) +
        geom_hline(yintercept = log(1, 2), color = "grey70", linetype = 1) +
        geom_jitter(size = 0.5, aes(color = Sex_locus), width = 0.25) +
        scale_x_discrete(name = "Contig") +
        scale_y_continuous(name = expression(paste("log"[2], "(M:F) coverage corrected", sep="")),
                           limits =  ylim)+
        theme(axis.text.x = element_text(angle = 90), legend.position = "none") +
        geom_hline(yintercept = log(2, 2), color = "dodgerblue3", linetype = 2) +
        geom_text(x = 1.5, y = 1 + step, label = "M:F = 2", color = "dodgerblue3") +
        geom_hline(yintercept = log(1.5, 2), color = "dodgerblue3", linetype = 2) +
        geom_text(x = 1.5, y = log(1.5, 2) + step, label = "M:F =3/2", color = "dodgerblue3") +
        geom_hline(yintercept = log(0.5, 2), color = "firebrick2", linetype = 2) +
        geom_text(x = 1.5, y = log(0.5, 2) + step, label = "M:F = 1/2", color = "firebrick2") +
        geom_hline(yintercept = log(2/3, 2), color = "firebrick2", linetype = 2) +
        geom_text(x = 1.5, y = log(2/3, 2) + step, label = "M:F = 2/3", color = "firebrick2") +
        scale_color_manual(name = element_blank(), values = c("TRUE"=sex_locus_color, "FALSE"="black"),
                           breaks = c("TRUE"), labels = c("Sex locus"))

    max_y <- 1.1 * max(max(abs(data$Ratio_snp)), 1)
    ylim <- c(-max_y, max_y)
    step <- (ylim[2] - ylim[1]) / 40

    h <- ggplot(data, aes(x = Contig, y = Ratio_snp)) +
        geom_hline(yintercept = log(1, 2), color = "grey70", linetype = 1) +
        geom_jitter(size = 0.5, aes(color = Sex_locus), width = 0.25) +
        scale_x_discrete(name = "Contig") +
        scale_y_continuous(name = expression(paste("log"[2], "(M:F) SNP", sep="")),
                           limits =  ylim)+
        theme(axis.text.x = element_text(angle = 90), legend.position = "none") +
        scale_color_manual(name = element_blank(), values = c("TRUE"=sex_locus_color, "FALSE"="black"),
                           breaks = c("TRUE"), labels = c("Sex locus"))

    combined <- plot_grid(g + theme(axis.text.x = element_blank(), axis.title.x = element_blank()), h, ncol = 1, align = "v")

    ggsave(paste0("/home/rferon/work/code/poolsexvis/tests/figures/genes/", species, ".png"), combined, width = 12, height = 12)

}

