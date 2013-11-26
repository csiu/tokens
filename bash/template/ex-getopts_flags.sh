#!/usr/bin/env bash
SCRIPT=$0
USAGE="""Usage: <STDIN> | sh ${SCRIPT} -i INFILE [options]
Function:

Options:
-h          print help message 
-i INFILE   path to infile
-x VARX     ...
"""

## print usage if no args
if [ $# == 0 ]; then echo "${USAGE}" && exit 1 ; fi

## user can pass args in any order using flags
while getopts hi:x: option
do
    case "${option}" in
	h) echo "$USAGE" && exit;;
	i) INFILE=${OPTARG};;
	x) VARX=${OPTARG};;
    esac
done

echo "i="$INFILE
echo "x="$VARX
