import sys
import gzip
import re

infile  = sys.argv[1]
#outfile = sys.argv[2]

'''
Remove chr from start of file
'''

if (infile.endswith("gz")):
    outfile = infile + '.nochr.gz'
    with gzip.open(outfile, 'wb') as out:
        with gzip.open(infile, 'rb') as f:
            for l in f:
                out.write(re.sub("^chr", "", l))
else:
    outfile = infile + '.nochr'
    with open(outfile, 'w') as out:
        with open(outfile) as f:
            for l in f:
                out.write(re.sub("^chr", "", l))
