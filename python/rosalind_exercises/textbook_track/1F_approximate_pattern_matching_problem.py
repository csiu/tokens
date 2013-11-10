## [1F] Approximate Pattern Matching Problem

pattern = "ATTCTGGA"
string  = "CGCCCGAATCCAGAACGCATTCCCATATTTCGGGACCACTGGCCTCCACGGTACGGACGTCAATCAAATGCCTAGCGGCTTGTGGTTTCTCCTACGCTCC"
mismatch_allowed = 3

##do something...
f1, f2 = 0, len(pattern)
answer = []

while f2 <= len(string):
    sum_mismatch = 0
    for i in range(0, len(pattern)):
        if pattern[i:i+1] != string[f1+i:f1+i+1]: 
            sum_mismatch += 1 
         
    if sum_mismatch <= mismatch_allowed: 
        answer.append(f1)
 
    f1 += 1
    f2 += 1

## answer..
for i in answer: print i,
