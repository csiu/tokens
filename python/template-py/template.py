#!/usr/bin/env python
# Author:  Celia
# Purpose:
# Created:
from optparse import OptionParser
import sys
import os

usage = """ %prog [options] -i INFILE

"""

def main():
    parser = OptionParser(usage)
    parser.add_option("-i", dest="infile", action="store", type="string",
                      help="path to input file")

    ##get at the arguments
    (options, args) = parser.parse_args()

    ##make sure pat the infile exist
    if (options.infile == None):
        parser.print_help()
        sys.exit()
    if (not os.path.isfile(options.infile)):
        sys.stderr.write("error: '%s' is not a valid file\n" % options.infile)
        sys.exit()

    print "Hello world"

main()
