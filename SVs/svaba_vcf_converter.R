# Read in svaba vcf file
options(stringsAsFactors = F)
svaba.sv.vcf <- "svaba_test.vcf"
svaba <- pipe(paste0('grep -v "#" ', svaba.sv.vcf))
cols <- colnames(read.table(pipe(paste0('grep -v "##" ', svaba.sv.vcf,' | grep "#"| sed s/#//')), header = TRUE, sep = '\t'))
cols <- sapply(cols, function(x) gsub("(mrkdp\\.)|(\\.bam)", "", x))
svaba_uniq <- read.table(args$svaba, col.names = cols, stringsAsFactors = FALSE)

get_sv_type <- function(x){
    # Find mate pair
    root <- gsub(":[12]", "", x)
    mate1 <- paste0(root, ":1")
    mate2 <- paste0(root, ":2")
    alt1 <- svaba_uniq %>% filter(ID == mate1) %>% .$ALT
    alt2 <- svaba_uniq %>% filter(ID == mate2) %>% .$ALT
    # Determine sv type based on breakpoint orientation
    if ((grepl("\\[", alt1) & grepl("\\[", alt2)) | (grepl("\\]", alt1) & grepl("\\]", alt2))){
        sv_type <- "INV"
        
    } else if (grepl("[a-z]\\[", alt1) & grepl("^\\]", alt2)){
        sv_type <- "DEL"
        
    } else if (grepl("^\\]", alt1) & grepl("[a-z]\\[", alt2)){
        sv_type <- "DUP/INS"
        
    } else{
        sv_type <- "UNKNOWN"
    }
    return(sv_type)
}

svaba_uniq$SVTYPE <- sapply(svaba_uniq$ID, get_sv_type)