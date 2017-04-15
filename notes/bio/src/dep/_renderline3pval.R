library(readr)
suppressPackageStartupMessages(library(dplyr))
library(tidyr)
library(ggplot2)

args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outfile <- args[2]
dbfile <- args[3]
mark <- args[4]

gg_color_hue <- function(n) {
  hues = seq(15, 375, length=n+1)
  hcl(h=hues, l=65, c=100)[1:n]
}

## Peaks should be from regions 1,2,3
## - bins the -log(pval) to nearest .1 decimal place
## - remove 0 (... which reps pvalue pf 1 (?))
## - does count of number of peaks per bin
## - plots count vs -log(pval)

samples <- readLines(dbfile)

sample_colors <- gg_color_hue(n = length(samples))
names(sample_colors) <- samples

dat <- read_tsv(infile, col_names = c(
  "chr", "start", "end", "score", "region",
  "s1", "s2", "s3", "p1", "p2", "p3"),
  col_types = cols(region  = col_character())
)
dat <- dat %>%
  unite("peak_id", c(chr, start, end), sep = "-") %>%
  select(peak_id, p1, p2, p3) %>%
  gather(Sample, p, -peak_id) %>%
  mutate(Sample = samples[as.integer(sub("p", "", Sample))])

dat %>%
  mutate(p_bin = round(p, digits = 1)) %>%
  group_by(Sample, p_bin) %>%
  summarise(count = n()) %>%
  filter(p_bin != 0) %>%
  ggplot(aes(x = p_bin,
             y = count,
             color = Sample,
             linetype = Sample
  )) +
  geom_point() +
  geom_line() +
  scale_x_continuous(breaks = round(
    seq(floor(min(dat$p)), ceiling(max(dat$p)), by = 0.5)
    ,1),
    minor_breaks = round(
      seq(min(dat$p), max(dat$p), by = 0.1)
      ,1)
  ) +
  scale_colour_manual(values = sample_colors) +
  xlab("-log(pvalue)") +
  ylab("Number of Peaks") +
  ggtitle(mark) +
  theme_bw()
ggsave(outfile)
