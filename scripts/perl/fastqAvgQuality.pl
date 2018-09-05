#!/usr/bin/env perl

# Author: Lee Katz <gzu2@cdc.gov>

use 5.005; # gunzip introduced to perl in 5.005
use strict;
use warnings;
use IO::Uncompress::Gunzip qw/$GunzipError/;

exit(main());

sub main{
  my($fastq)=@ARGV;

  if(!$fastq){
    die usage();
  }

  print avgFastqQuality($fastq);
  print "\n";

  return 0;
}

# Calculate the average quality of a Q33-based fastq file
sub avgFastqQuality{
  my($fastq)=@_;

  # Initialize the numerator and denominator for avg qual
  my $totalQual=0;
  my $numBases =0;

  # Read the file using pure perl gunzip
  my $in = new IO::Uncompress::Gunzip($fastq)
    or die "IO::Uncompress::Gunzip failed to read $fastq: $GunzipError\n";

  # loop through each 4-line entry
  while(my $id = $in->getline()){
    my $seq = $in->getline();
    my $plus= $in->getline();
    my $qual= $in->getline();
    chomp($qual); # make sure the newline doesn't get in the way

    # Keep track of how many bases we are looking at
    $numBases += length($qual);

    # Look at every base's quality score
    for my $char(split(//, $qual)){
      # The quality score of an individual base is the
      # character's numerical value, minus 33.
      my $thisQual = ord($char) - 33;
      # Add this value to the ongoing total.
      $totalQual += $thisQual;
    }
  }

  # Average quality: total quality divided by the count of
  # bases.
  return ($totalQual/$numBases);

}

sub usage{
  return "$0: returns the average quality of a fastq.gz file
  Usage: $0 file.fastq.gz
  ";
}

