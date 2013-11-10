## [1C] Pattern Matching Problem
 
pattern = "ATAT" 
text = "GATATATGCATATACTT"

##do something...
a, b = 0, len(pattern)

while b <= len(text):
    x = text[a:b]
    if x == pattern: print a,
    a += 1
    b += 1 
