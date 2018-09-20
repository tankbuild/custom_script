library(readr)

female_depth = read_delim("channel_result_coverage.tsv", 
                                "\t", escape_double = FALSE, col_names = FALSE, 
                                trim_ws = TRUE)
flag = which(substr(female_depth$X1,1,3)=='NC_')
female_depth_subset = female_depth[flag,]
str(female_depth)
str(female_depth_subset)
