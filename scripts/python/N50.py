#!/usr/bin/env python3
# Author: Lee Katz <gzu2@cdc.gov>

import sys
from Bio import SeqIO
import argparse

# Find the N50: the contig size at half the expected genome
# size
def N50(fasta, expectedGenomeSize):
  lengths=[]
  with open(fasta, "rU") as handle:
    for record in SeqIO.parse(handle, "fasta"):
      lengths.append(len(record.seq))

  lengths = sorted(lengths)
  currentLength=0
  halfSize = int(expectedGenomeSize / 2)
  for contigSize in lengths:
    currentLength += contigSize
    if currentLength >= halfSize:
      return contigSize

  sys.exit("ERROR: we were not able to figure out an N50")

def main():
  #filename = sys.argv[1]
  #expectedGenomeSize = sys.argv[2]
  parser = argparse.ArgumentParser(description="Calculate N50 from a fasta file")
  parser.add_argument("fasta", type=str, nargs=1,
      help="A genome assembly in fasta format")
  parser.add_argument("N50", type=int, nargs=1,
      help="N50 in fasta format")
  args=parser.parse_args()

  print N50(args.fasta[0], args.N50[0])

if __name__=="__main__":
  main()
