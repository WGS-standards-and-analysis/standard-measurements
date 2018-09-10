#!/bin/bash

set -e
basedir=$(dirname $0)
thisscript=$(basename $0)
tmpdir=$(mktemp --directory $thisscript.XXXXXX)
L50=1

trap ' { rm -rf $tmpdir; } ' EXIT

# Push uncompressed data into the temporary directory
gunzip -c $basedir/data/2011C-3609.fasta.gz > $tmpdir/in.fasta

# Run L50
pythonL50=$(python3 $basedir/../scripts/python/L50.py $tmpdir/in.fasta)

# Test L50 values
if [ "$pythonL50" -ne "$L50" ]; then
	echo "ERROR: L50.py did not produce the expected result."
	exit 1
fi

echo "L50 tests passed!"
