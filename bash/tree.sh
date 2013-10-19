#!/usr/bin/env bash
find . | awk -v pwd=$PWD 'BEGIN {print pwd} \
                        !/^\.$/ {for (i=1; i<NF; i++) { \
                                     printf("%4s", "|") \
                                     } \
                                 print "-- "$NF \
                                }' FS='/'
