import sys

'''
infile  = Homo_sapiens.GRCh37.75.gtf (ensembl GTF gene set file)
outfile = Homo_sapiens.GRCh37.75.gtf.tss

FILTER
- keep only lines that are "protein_coding" "gene"

MUTATE
- make it so that interval is start-start
- append old end to the end of the attributes field
'''

infile = sys.argv[1]
outfile = infile + '.tss'

with open(outfile, 'w') as out:
    with open(infile) as f:
        for l in f:
            if l.startswith('#'):
                continue

            l = l.strip().split('\t')

            ## keep only source=="protein_coding" and "feature"=="gene"
            if l[1] == "protein_coding" and l[2] == "gene":

                ## replace <end> with <start>, so interval is <start>-<start>
                ## append the old <end> to the end of the <attributes> field
                end = l[4]
                l[4] = l[3]
                l[-1] = l[-1] + ' end "%s";' % end

                out.write('\t'.join(l) + '\n')
