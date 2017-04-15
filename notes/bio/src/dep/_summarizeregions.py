import sys
import pandas as pd

infile = sys.argv[1]
outfile = sys.argv[2]

'''
To be used after:
bedtools multiinter -i file1 file2 [file3 ...]
'''

df = pd.read_table(infile, header=None)
df.rename(columns={0: 'chrom',
                   1: 'start',
                   2: 'stop',
                   3: 'score',
                   4: 'region'
                  }, inplace=True)
df = df.groupby("region").region.count()
df.to_csv(outfile, sep="\t")
