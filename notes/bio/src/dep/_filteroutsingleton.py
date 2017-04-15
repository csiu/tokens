import sys
import re

infile  = sys.argv[1]
outfile = '%s.non_singleton' % infile

with open(outfile, 'w') as out:
    with open(infile) as f:
        for l in f:
            score_in_question = l.split('\t')[3]
            if score_in_question != "1":
                out.write(l)
