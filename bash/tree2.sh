#!/usr/bin/env bash

## like tree function but has ignore capabilities using '-i' flag
## funcitons uses grep -v

while getopts i: option
do
    case "${option}" in
	i) IGNORE=${OPTARG};;
    esac
done


if [[ $IGNORE == "" ]]; then
    IGNORE="^$"
else
    IGNORE=`echo $IGNORE | sed 's/^/^.\//; s/\/$//'`
    echo "ignoring="$IGNORE
fi

find . | grep -v $IGNORE | awk -v pwd=$PWD 'BEGIN {print pwd} \
                                          !/^\.$/ {for (i=1; i<NF; i++) { \
                                                       printf("%4s", "|") \
                                                       } \
                                                   print "-- "$NF \
                                                  }' FS='/'
