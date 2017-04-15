# author: csiu
# date: Monday Nov 2, 2015
import sys

"""
USAGE: python <this-script>.py INFILE

Split file by chromosome
- Assumes is tab separated
- Assumes more than 1 columns
- Assumes first column is sorted and is chromosome field
- Assumes chromosomes are sorted
"""

original_file = sys.argv[1]
with open(original_file) as f:
    prev_chrom = ""
    for line in f:
        now_chrom, _ = line.split('\t', 1)

        if now_chrom != prev_chrom:
            if 'out' in locals(): out.close()

            ## start new file
            outfile = original_file + '.' + now_chrom
            out = open(outfile, 'w')

            prev_chrom = now_chrom
        
        out.write(line)

out.close()

