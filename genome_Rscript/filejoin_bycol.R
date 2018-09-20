library(readr)
library(dplyr, warn.conflicts = FALSE)

setwd("/home/mwen/work/channel_catfish_poolseq/bamfile")
sync <- read_delim("sync.text", "\t", escape_double = FALSE,
                   col_names = FALSE, trim_ws = TRUE,
                   col_types = cols(
                     X1 = col_character(),
                     X2 = col_character(),
                     X3 = col_character(),
                     X4 = col_character(),
                     X5 = col_character()
                   ))
f_depth <- read_delim("f_depth.text", "\t", escape_double = FALSE,
                   col_names = FALSE, trim_ws = TRUE,
                   col_types = cols(
                     X1 = col_character(),
                     X2 = col_character(),
                     X3 = col_character()
                   ))
# m_depth <- read_delim("m_depth.text", "\t", escape_double = FALSE,
#                    col_names = FALSE, trim_ws = TRUE,
#                    col_types = cols(
#                      X1 = col_character(),
#                      X2 = col_character(),
#                      X3 = col_character()
#                    ))

m_depth <- suppressMessages(read_delim("m_depth.text", "\t", escape_double = FALSE,
                      col_names = FALSE, trim_ws = TRUE))
names(sync) = c("contig", "position", "ref", "f_alellefre", "m_alellefre")
names(f_depth) = c("contig", "position", "f_depth")
names(m_depth) = c("contig", "position", "m_depth")
sync2 = left_join(sync, f_depth, by = c("contig", "position"))
sync3 = left_join(sync2, m_depth, by = c("contig", "position"))
sync3[is.na(sync3)] = "0"
write.table(sync3, file="female_male_sync_depth.tsv",
            col.names = FALSE, sep = "\t")

