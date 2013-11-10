## [1A] Frequent Words Problem

s = "ACGTTGCATGTCGCATGATGCATGAGAGCT"
k = 4

## do something...
my_kmers = {}
a, b = 0, k
while b <= len(s):
    kmer = s[a:b]
    try:
        my_kmers[kmer] += 1
    except:
        my_kmers[kmer] = 1
    a += 1
    b += 1

freq = 0
kmer_at_freq = []
for k, v in my_kmers.iteritems():
    if v > freq:
        kmer_at_freq = [k]
        freq = v
    elif v == freq:
        kmer_at_freq.append(k)

## answer..
print ' '.join(sorted(kmer_at_freq))
