#!/usr/bin/env bash

## user can pass args in any order using flags
while getopts x:y:z: option
do
    case "${option}" in
	x) VARX=${OPTARG};;
	y) VARY=${OPTARG};;
	z) VARZ=${OPTARG};;
    esac
done

echo "x="$VARX
echo "y="$VARY
echo "z="$VARZ
