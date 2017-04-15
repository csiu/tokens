import sys
import re

infile  = sys.argv[1]
region  = sys.argv[2]
outfile = '%s.%s_region' % (infile, re.sub(" ", "", region))

with open(outfile, 'w') as out:
    with open(infile) as f:
        for l in f:
            region_in_question = l.split('\t')[4]
            if region_in_question == region:
                out.write(l)
