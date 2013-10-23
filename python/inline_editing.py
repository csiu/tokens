## in-line editing of a file
## [reference: unutbu; stackoverflow:7633485]
import fileinput
import sys

for line in fileinput.input('file-to-be-edited.txt', inplace=True):
    line = line.rstrip()
    sys.stdout.write('%s\tLINE_END\n' % line)
