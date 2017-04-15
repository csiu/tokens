import sys
import pandas as pd
from collections import Counter

infile = sys.argv[1]
outfile = sys.argv[2]

'''
To be used after like:
bedtools intersect -a A.bed -b ensembl.gtf -D a

input:

chr189406189453831,2,3111chr1protein_codinggene879584894689.- . gene_id "ENSG00000188976"; gene_name "NOC2L"; gene_source "ensembl_havana"; gene_biotype "protein_coding"; 477
chr190148190240531,2,3111chr1protein_codinggene901877911245.+ . gene_id "ENSG00000187583"; gene_name "PLEKHN1"; gene_source "ensembl_havana"; gene_biotype "protein_coding"; 529
chr193483193509631,2,3111chr1protein_codinggene934342935552.- . gene_id "ENSG00000188290"; gene_name "HES4"; gene_source "ensembl_havana"; gene_biotype "protein_coding"; 265


output:

overlap\tcount
1\t26
2\t21
3\t14
'''

overlaps = []
with open(infile) as f:
    for line in f:
        overlaps.append(line.strip().rsplit("\t", 1)[-1])

overlaps = Counter(overlaps).items()
overlaps.sort(key=lambda x: int(x[0]))

overlaps = pd.DataFrame(overlaps, columns=["overlap", "count"])
overlaps.to_csv(outfile, sep="\t", index=False)
