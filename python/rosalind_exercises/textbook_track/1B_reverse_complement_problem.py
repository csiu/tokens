## [1B] Reverse Complement Problem

s = "AAAACCCGGT"

## do something...
bp = {'A':'T',
      'T':'A',
      'G':'C',
      'C':'G'}

comp = [bp[s[i]] for i in range(0, len(s))]
comp.reverse()

## answer..
print ''.join(comp)
