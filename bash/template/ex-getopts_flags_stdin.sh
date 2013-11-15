#!/usr/bin/env bash
SCRIPT=$0
USAGE="""Usage: <STDIN> | sh ${SCRIPT} [options]
Function:

Options:
-h         print help message 
-v         verbose; explain what is being done
-x VARX    ...
"""

## if STDIN does not exist or is empty; print usage & exit
if [ -t 0 ] ; then echo "$USAGE" && exit ; fi

STDIN=$(cat)
if [[ "$STDIN" == "" ]] ; then echo "$USAGE" ; fi

## default args
VERBOSE=false
VARX="DEFAULT"

## get args
while getopts hvx: option
do
  case "${option}" in
      h) echo "$USAGE" && exit;;
      v) VERBOSE=true;;
      x) VARX=${OPTARG};;
  esac
done

## do something...
echo "$STDIN" | while read line; do
    #echo "$line: do something with $VARX"

done
