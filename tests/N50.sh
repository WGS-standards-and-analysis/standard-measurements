#!/bin/bash

# Tests all N50 scripts

set -e
basedir=$(dirname $0)
thisscript=$(basename $0)
tmpdir=$(mktemp --directory $thisscript.XXXXXX)
N50=3051854
trap ' { rm -rf $tmpdir; } ' EXIT

# Push uncompressed data into the temporary directory
gunzip -c $basedir/data/2011C-3609.fasta.gz > $tmpdir/in.fasta

# Run N50
perlN50=$(perl $basedir/../scripts/perl/N50.pl $tmpdir/in.fasta 5412686)
pythonN50=$(python3 $basedir/../scripts/python/N50.py $tmpdir/in.fasta 5412686)

# Test N50 values
if [ "$perlN50" -ne "$N50" ]; then
  echo "ERROR: N50.pl did not produce the expected result."
  exit 1
fi
if [ "$pythonN50" -ne "$N50" ]; then
  echo "ERROR: N50.py did not produce the expected result."
  exit 1
fi

echo "N50 tests passed!"
