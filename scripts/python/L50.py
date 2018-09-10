#!/usr/bin/env/ python3
# Author: Dillon Barker <dillon.barker@canada.ca>

from Bio import SeqIO
import argparse

def L50(fasta: str) -> int:
    """Calculate the minimum number of contigs whose lengths are greater than
    or equal half the total length of the assembly.

    fasta: Path to a FASTA formatted genome assembly
    """

    with open(fasta, 'r') as f:

        lengths = [len(contig.seq) for contig in SeqIO.parse(f, 'fasta')]

        sorted_lengths = sorted(lengths, reverse=True)

    total_length = sum(lengths)

    half_length = total_length // 2

    length_so_far = 0

    for i, contig_length in enumerate(sorted_lengths, 1):

        length_so_far += contig_length

        if length_so_far >= half_length:
            return i

def main():

    parser = argparse.ArgumentParser(description='Calculates L50 of a FASTA')

    parser.add_argument('fasta', help='A genome assembly in FASTA format')

    args = parser.parse_args()

    print(L50(args.fasta))

if __name__ == '__main__':
    main()

