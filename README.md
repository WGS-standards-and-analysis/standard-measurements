# standard-measurements
Standard scripts for calculating standard genomic metrics

## scripts directory

These are the scripts to calculate standard metrics in any one language.

For any measurement, the script is named after its name (e.g., `N50.pl`). Within each script, the actual measurement is encapsulated in its own function which could be used in another script. The measurement function should be well commented.  There is at least one unit test per script in the tests directory.

### Current scripts

Language icons appear next to each script to indicate availability

* L50 ![python](images/python_icon.png)
* N50 ![python](images/python_icon.png) ![perl](images/perl_icon.png)
* Average fastq quality score ![perl](images/perl_icon.png)

## Contributing

Please add a github issue detailing what you would like to contribute, and we will move the discussion there. Please keep in mind our ideals such as clear code and unit testing.

### Some specific ideals

* Clear coding
  * Comments
  * Combined commands on multiple lines are not good
  * The metric must be self-contained in a function
* Must be thread-compatible. In other words, any two instances of the same script cannot collide.
* Standard bioinformatics libraries are allowed: BioPerl, BioPython
* Language specific ideals
  * Python
    * must be compatible with v3.7 or above
  * Perl
    * must be compatible with v5.26 or above
* Supply a clear and distinct unit test.  Some test data are under `data` under the tests directory.

[![Build Status](https://travis-ci.com/WGS-standards-and-analysis/standard-measurements.svg?branch=master)](https://travis-ci.com/WGS-standards-and-analysis/standard-measurements)
