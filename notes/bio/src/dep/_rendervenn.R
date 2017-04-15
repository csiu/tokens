suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(VennDiagram))

args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outfile <- args[2]
samples <- readLines(args[3])

dat <- read.delim(infile, sep="\t", header=FALSE, col.names = c("region", "count"))

v <- function(x, dat=dat){
  dat %>% filter(region == x)  %>% .$count
}

r1 <- v(1, dat)
r2 <- v(2, dat)
r3 <- v(3, dat)
r12 <- v("1,2", dat)
r23 <- v("2,3", dat)
r13 <- v("1,3", dat)
r123 <- v("1,2,3", dat)

venn.plot <- draw.triple.venn(r1 + r12 + r13 + r123,
                              r2 + r23 + r12 + r123,
                              r3 + r13 + r23 + r123,
                              r12 + r123,
                              r23 + r123,
                              r13 + r123,
                              r123,
                              #category = c("First", "Second", "Third"),
                              category = samples,
                              fill = c("darkblue", "#7A21DB", "darkorange"),
                              cex = 2,
                              cat.cex = 1.5)
png(outfile)
grid.draw(venn.plot)
dev.off()
