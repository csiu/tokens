import sys

infile  = sys.argv[1]
outfile  = sys.argv[2]
filter_distance = sys.argv[3]

dat = []
with open(infile) as f:
    for line in f:
        line = line.strip().split("\t")
        info = line[16]
        olap = line[-1]
        gene_id = [i.split(" ")[1].split('"')[1] for i in info.split(';') if i.startswith("gene_id")][0]
        dat.append((gene_id, int(olap)))

if filter_distance != 0:
    dat = filter(lambda x: x[1] > filter_distance, dat)

dat = set(map(lambda x: x[0], dat))

with open(outfile) as out:
    for i in dat:
        out.write(i + "\n")
