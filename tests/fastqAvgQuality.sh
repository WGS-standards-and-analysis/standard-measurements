#!/bin/bash

# Tests all fastq average quality scripts

set -e
basedir=$(dirname $0)
thisscript=$(basename $0)
tmpdir=$(mktemp --directory $thisscript.XXXXXX)
trap ' { rm -rf $tmpdir; } ' EXIT

# Rounding to the millionths place
R1qual=37.787117
R2qual=35.684931
R1="$basedir/data/CFSAN023471_truncated_1.fastq.gz"
R2="$basedir/data/CFSAN023471_truncated_2.fastq.gz"

# Run N50 and round to the millionths place
perlR1Qual=$(perl $basedir/../scripts/perl/fastqAvgQuality.pl $R1)
perlR1Qual=$(printf "%0.6f" $perlR1Qual)
perlR2Qual=$(perl $basedir/../scripts/perl/fastqAvgQuality.pl $R2)
perlR2Qual=$(printf "%0.6f" $perlR2Qual)

pyR1Qual=$(python3 $basedir/../scripts/python/fastqAvgQuality.py $R1)
pyR1Qual=$(printf "%0.6f" $pyR1Qual)
pyR2Qual=$(python3 $basedir/../scripts/python/fastqAvgQuality.py $R2)
pyR2Qual=$(printf "%0.6f" $pyR2Qual)

# Test N50 values
if (( $(echo "$perlR1Qual != $R1qual" | bc -l) )); then
  echo "ERROR: fastqAvgQual.pl did not produce the expected result on R1."
  exit 1
fi
if (( $(echo "$perlR2Qual != $R2qual" | bc -l) )); then
  echo "ERROR: fastqAvgQual.pl did not produce the expected result on R2."
  exit 1
fi

if (( $(echo "$pyR1Qual != $R1qual" | bc -l) )); then
  echo "ERROR: fastqAvgQual.py did not produce the expected result on R1."
  exit 1
fi
if (( $(echo "$pyR2Qual != $R2qual" | bc -l) )); then
  echo "ERROR: fastqAvgQual.py did not produce the expected result on R2."
  exit 1
fi

echo "Fastq average quality tests passed!"
