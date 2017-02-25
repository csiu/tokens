## [1D] Clump Finding Problem

genome = "CGGACTCGACAGATGTGAAGAAATGTGAAGACTGAGTGAAGAGAAGAGGAAACACGACACGACATTGCGACATAATGTACGAATGTAATGTGCCTATGGC"
k, L, t = 5, 75, 4

## do something...
l1, l2 = 0, L
k1, k2 = 0, k
clumps_dict = {}
first_round = True

while l2 <= len(genome):
    while first_round:
        while k2 <= l2:
            kmer = genome[k1:k2]
            try:
                clumps_dict[kmer] += 1
            except:
                clumps_dict[kmer] = 1
            k1 += 1
            k2 += 1

        answer = [ke for ke, v in clumps_dict.items() if v == t]

        first_round = False

    out_kmer = genome[l1:(l1 + k)]
    clumps_dict[out_kmer] -= 1
    if clumps_dict[out_kmer] == t: answer.append(out_kmer)

    l1 += 1
    l2 += 1

    in_kmer = genome[(l2 - k):l2]
    try:
        clumps_dict[in_kmer] += 1
    except:
        clumps_dict[in_kmer] = 1
    if clumps_dict[in_kmer] == t: answer.append(in_kmer)


## answer..
print ' '.join(list(set(answer)))
