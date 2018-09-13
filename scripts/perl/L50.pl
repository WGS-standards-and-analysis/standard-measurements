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

  print L50($fasta, $expectedLength);
  print "\n";

  return 0;
}

# Find the L50 of an assembly.  The L50 is the 
# number of contigs whose lengths are greater
# than or equal to half of the total length of
# the assembly.
# params: fasta filename (string)
#         expected genome size (int)
# return int The L50 in bp.
sub L50($;$){
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

  # find how many contigs are below L/2
  my $currentGenomeLength=0;
  for(my $i=0;$i<$numSeqs;$i++){
    $currentGenomeLength+=$lengths[$i];
    if($currentGenomeLength>=$halfGenomeSize){
      return ($numSeqs - $i);
    }
  }

  # If we have gone through ALL contigs and haven't
  # calculated the L50 yet, then something is wrong.
  die "ERROR: could not calculate the L50 from these lengths:\n"
      . join(" ",@lengths);
}

sub usage{
  return "$0: returns the L50 of a genome assembly.
  Usage: $0 file.fasta [genomeSize]
    where genome size is an expected genome size, in base pairs.

    Any standard sequence format (e.g., fasta, gbk) can be used.
  ";
}

