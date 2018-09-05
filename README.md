# standard-measurements
Standard scripts for calculating standard genomic metrics

## scripts directory

These are the scripts to calculate standard metrics in any one language.

For any measurement, the script is named after its name (e.g., `N50.pl`). Within each script, the actual measurement is encapsulated in its own function which could be used in another script. The measurement function should be well commented.  There is at least one unit test per script in the tests directory.

### Current languages

* python
* perl

### Current scripts

* N50 ![python](images/python_icon.png) ![perl](images/perl_icon.png)

## Contributing

Please add a github issue detailing what you would like to contribute, and we will move the discussion there. Please keep in mind our ideals such as clear code and unit testing.

## tests directory

Each measurement or each script has its own unit test to make sure that everything is correct.
