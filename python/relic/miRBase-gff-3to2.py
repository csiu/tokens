#!/usr/bin/env python
# Author:  csiu
# Created: 2015-01-20
import argparse
import sys
import os
import re

usage = """Reformat miRBase gff3 -> gff2

Details
=======
1. change header
   - keep top 8 lines
   - replace ":" with "   "
2. keep only lines with "miRNA_primary_transcript"
   - these are the hairpin precursor sequences
   - they do not represent the full primary transcript,
   - rather a predicted stem-loop portion that includes the precursor-miRNA
   - (thus discard mature sequences labelled "miRNA")
3. rename "miRNA_primary_transcript" to "miRNA"
4. replace info column
   - from:   ID=MI0022705;Alias=MI0022705;Name=hsa-mir-6859-1
   - to:     ACC="MI0022705"; ID="hsa-mir-6859-1";
   - note: ACC value is from Alias
"""

def main(gff3_file, gff2_file):

    ## keep top 8 lines of header
    header_counter = 0

    with open(gff2_file, 'w') as out:
        #out = sys.stdout
        with open(gff3_file) as f:
            for line in f:

                ## proces header lines
                if line.startswith('#'):
                    if header_counter < 8:
                        if line.startswith('##gff-version 3'):
                            out.write('##gff-version 2\n')
                        else:
                            line = re.sub(r'(# [a-zA-Z0-9\-]+):', r'\1  ', line)
                            out.write(line)
                        header_counter += 1

                ## process data lines
                else:
                    col = line.split('\t')
                    if col[2] == 'miRNA_primary_transcript':

                        info = col[8].strip().split(';')
                        info_acc = info[1].split('=')[1]
                        info_id  = info[2].split('=')[1]

                        col[2] = 'miRNA'
                        col[8] = 'ACC="%s"; ID="%s";\n' % (info_acc, info_id)

                        out.write('\t'.join(col))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=usage, formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument('--gff3', dest='gff3',
                        required=True,
                        help='path to miRBase gff3 input file')

    ##get at the arguments
    args = parser.parse_args()

    outfile = re.sub('\.gff3$', '.gff2', args.gff3)

    ## do something..
    main(args.gff3, outfile)
