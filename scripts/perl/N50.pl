#!/usr/bin/env perl

# Author: Lee Katz <gzu2@cdc.gov>

use strict;
use warnings;
use Bio::SeqIO;
use List::Util qw/sum/;

exit(main());

sub main{
  my($fasta,$expectedLength)=@ARGV;

  if(!$fasta){
    die usage();
  }

  print N50($fasta, $expectedLength);
  print "\n";

  return 0;
}

# Find the N50 of an assembly.  The N50 is the size N such 
# that 50% of the genome is contained in contigs of size N
# or greater.
# params: fasta filename (string)
#         expected genome size (int)
# return int The N50 in bp.
sub N50($;$){
  my($fasta,$expectedGenomeLength)=@_;

  # Read the fasta file and sort the lengths
  my @lengths;
  my $in=Bio::SeqIO->new(-file=>$fasta);
  while(my $seq=$in->next_seq){
    push(@lengths,$seq->length);
  }
  @lengths = sort {$a<=>$b} @lengths;
  my $numSeqs=@lengths;

  # if the size is not provided, assume the size of the assembly is the genome size
  my $genomeSize = $expectedGenomeLength || sum(@lengths);
  my $halfGenomeSize=$genomeSize/2;

  # find the contig that resides at (size/2)
  my $currentGenomeLength=0;
  for(my $i=0;$i<$numSeqs;$i++){
    $currentGenomeLength+=$lengths[$i];
    if($currentGenomeLength>=$halfGenomeSize){
      return $lengths[$i];
    }
  }

  # If we have gone through ALL contigs and haven't
  # calculated the N50 yet, then something is wrong.
  die "ERROR: could not calculate the N50 from these lengths:\n"
      . join(" ",@lengths);
}

sub usage{
  return "$0: returns the N50 of a genome assembly.
  Usage: $0 file.fasta [genomeSize]
    where genome size is an expected genome size, in base pairs.

    Any standard sequence format (e.g., fasta, gbk) can be used.
  ";
}

