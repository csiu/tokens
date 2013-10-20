#!/usr/bin/env bash

## like tree function but has ignore capabilities using '-i' flag
## funcitons uses -prune option of find to do the ignoring
## USAGE: sh <script> [-i "dir1 dir2 ..."]

while getopts i: option
do
    case "${option}" in
	i) IGNORE=${OPTARG};;
    esac
done


if [[ $IGNORE == "" ]]; then
    IGNORE="^$"
else
    echo "ignoring="$IGNORE
fi

FIND_CMD=$(echo "find ." \
                $(echo ${IGNORE} | \
                    tr ' ' '\n'  | \
                        while read line ;
                        do
                            echo "-o -path ./$line -prune";
                        done) \
                " -o -print" | sed 's/-o//')

$FIND_CMD | awk -v pwd=$PWD 'BEGIN {print pwd} \
                           !/^\.$/ {for (i=1; i<NF; i++) { \
                                        printf("%4s", "|") \
                                        } \
                                    print "-- "$NF \
                                   }' FS='/'
