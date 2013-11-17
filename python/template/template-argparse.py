#!/usr/bin/env python
# Author:  Celia
# Created:
import argparse

usage = """ %s [options] -i INFILE

""" % (__file__)

def main():
    parser = argparse.ArgumentParser(description=usage)
    parser.add_argument('-i', '--infile', dest='infile',
                        action='store',
                        default=None,
                        type=str,
                        #choices=['','',''],
                        required=True,
                        help='path to input file')


    ##get at the arguments
    args = parser.parse_args()


    print "Hello %s!" % (args.infile)

main()
