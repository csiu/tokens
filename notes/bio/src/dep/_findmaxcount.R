library(readr)
suppressPackageStartupMessages(library(dplyr))
library(tidyr)

args <- commandArgs(trailingOnly = TRUE)
outfile <- args[1]
infiles <- tail(args, -1)

max_count <- 0
for (infile in infiles) {
  dat <- read_tsv(infile, col_names = c(
    "chr", "start", "end", "score", "region",
    "s1", "s2", "s3", "p1", "p2", "p3"),
    col_types = cols(region  = col_character())
  ) %>%
    unite("peak_id", c(chr, start, end), sep = "-") %>%
    select(peak_id, p1, p2, p3) %>%
    gather(Sample, p, -peak_id) %>%
    #mutate(Sample = samples[as.integer(sub("p", "", Sample))]) %>%

    mutate(p_bin = round(p, digits = 1)) %>%
    group_by(Sample, p_bin) %>%
    summarise(count = n()) %>%
    filter(p_bin != 0)
  this_max <- max(dat$count)

  max_count <- ifelse(this_max > max_count, this_max, max_count)
}
writeLines(as.character(max_count), outfile)
