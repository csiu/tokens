import re

inputfile = '/Users/csiu/project/webCrawler/extractPrimer/test.txt'
primerStart = """5'"""
primerEnd = """3'"""

nucleotides = '[ATGCN]'

linePrimerEnding = re.compile(nucleotides + '$')
linePrimerStarting = re.compile('^' + nucleotides)

with open(inputfile, 'r') as f:
    for line in f:
        if primerStart in line:

            ## when primer is within same line
            if primerEnd in line:
                pStartIndex = line.index(primerStart)
                pEndIndex = line.index(primerEnd) + len(primerEnd)

                matchingObj = line[pStartIndex : pEndIndex]
                print matchingObj
                continue

            line = line.strip()
            ## when primer start is in middle of line
            ## and primer spans to second line
            if linePrimerEnding.search(line):
                ## part 1
                pStartIndex = line.index(primerStart)
                matchingObj = line[pStartIndex:]

                ## part 2
                line = f.next().strip()
                if linePrimerStarting.match(line):
                    if primerEnd in line:
                        pEndIndex = line.index(primerEnd) + len(primerEnd)

                        matchingObj += line[:pEndIndex]
                        print matchingObj

                continue

