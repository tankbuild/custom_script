#!/usr/bin/env Rscript

# how to use?
# Rscript --vanilla twofile_merge.R file1.tsv file2.tsv output.txt

library(readr)
library(dplyr, warn.conflicts = FALSE)

args = commandArgs(trailingOnly=TRUE)

file1 = suppressMessages(read_delim(args[1], "\t", 
                    escape_double = FALSE, col_names = FALSE, 
                    trim_ws = TRUE))

file2 = suppressMessages(read_delim(args[2], "\t", 
                                     escape_double = FALSE, col_names = FALSE, 
                                     trim_ws = TRUE))

full_join = full_join(file1,file2, by=c("X1","X2"))

write.table(full_join,file=args[3], quote = FALSE, sep = "\t",
            row.names = FALSE, col.names = FALSE, na = "0")
