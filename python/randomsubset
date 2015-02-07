#!/usr/bin/env python
# Author:  csiu
# Created: 2015-02-06
import argparse
import sys
import random
import linecache
usage = """Grab n random lines from infile
"""
def main(infile, n):
  wc = sum(1 for line in open(infile))
  if n > wc: n = wc/2

  for i in range(0,n):
    x = random.choice(range(1,wc+1))
    sys.stdout.write(linecache.getline(infile, x))


if __name__ == '__main__':
  parser = argparse.ArgumentParser(description=usage,
                                   formatter_class=argparse.RawTextHelpFormatter)
                                   
  parser.add_argument('-i', '--infile', dest='infile',
                      required=True,
                      help='path to input file')
  parser.add_argument('-n', dest='n',
                      default=10,
                      help='number of lines to pull')

  ##get at the arguments
  args = parser.parse_args()

  ## do something..
  main(args.infile, args.n)
