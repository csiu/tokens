#!/usr/bin/env bash
SCRIPT=$0
USAGE="""Usage: sh ${SCRIPT} -f FILE -s SKIP 
Function:
Split file by s lines and send output to separate files

Example:
> File.txt
    Line 1
    Line 2
    Line 3
    Line 4
    Line 5
    Line 6

Skip=2
> File.txt.0
    Line 1
    Line 2
> File.txt.1
    Line 3
    Line 4
> File.txt.2
    Line 5
    Line 6
> File.txt.3

Options:
-h          print help message 
-f FILE     path to infile
-s SKIP     integer; skip this many lines and 
"""

## print usage if no args
if [ $# == 2 ]; then echo "${USAGE}" && exit 1 ; fi

## user can pass args in any order using flags
while getopts hf:s: option
do
    case "${option}" in
	h) echo "$USAGE" && exit;;
	f) f=${OPTARG};;
	s) skip=${OPTARG};;
    esac
done

## 1 line command needed to perform function
## before use, need to specify 'f' and 'skip'
s=$(expr $skip - 1); start=1; for i in $(seq 0 $(expr $(wc -l $f | sed 's/^[ \t]*//' | cut -d' ' -f1) / $skip)) ; do end=$(expr $start + $s) ; sed -n "$start,${end}p" $f > $f.$i; start=$(expr $end + 1) ; done