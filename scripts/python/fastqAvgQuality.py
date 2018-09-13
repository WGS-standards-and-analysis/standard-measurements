#!/usr/bin/env python3

# Author: Dillon Barker <dillon.barker@canada.ca>

import argparse
import gzip


def avg_fastq_quality(fastq_gz: str) -> float:
    """Calculate the mean quality for a set of sequencing reads in gzipped
    FASTQ format with a quality offset of 33.

    fastq: Path to a gzip-compressed FASTQ formatted set of sequencing reads
    """

    total_length = 0
    total_quality = 0

    # Decompress gzipped text file
    with gzip.open(fastq_gz, mode='rt') as f:

        fastq_lines = [line.strip() for line in f]

    fastq_length = len(fastq_lines)

    # FASTQ records are groups of 4 lines:
    #
    # @seq_id       # Sequence identifier
    # GATTACA       # Nucleotide sequence
    # +             # Separator
    # !'H*GA(       # Phred quality scores (ASCII ordinal number, minus 33)
    records = (fastq_lines[i: i + 4] for i in range(0, fastq_length, 4))

    for name, sequence, _, qualities in records:

        read_length = len(sequence)

        read_total_quality = sum(ord(base) - 33 for base in qualities)

        total_length += read_length

        total_quality += read_total_quality

    return total_quality / total_length


def arguments():

    parser = argparse.ArgumentParser()

    parser.add_argument('fastq', help='Path to gzipped FASTQ file')

    return parser.parse_args()


def main():

    args = arguments()

    result = avg_fastq_quality(args.fastq)

    print(result)


if __name__ == '__main__':
    main()
