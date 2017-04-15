library(ggplot2)

args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outfile <- args[2]
mytitle <- args[3]

dat <- read.delim(infile, sep="\t", header=TRUE)
ggplot(dat, aes(x = overlap, y = count)) +
  geom_point(alpha = 0.5) +
  ggtitle(mytitle) +
  theme_bw()
ggsave(outfile)
