# The Parking Lot

Implementing the parking lot Ruby. Please see PDF for specifications.


### Installing
Go to the root directory of the project and run the following commands : 

To install gem dependencies and run the entire testing suite. This new testing suite is an exhaustive test of the parking lot system, having 100% test coverage as verified by simplecov.

```
bin/setup
```

## Running the Functional tests

To run against the pre-written functional test

```
bin/run_functional_tests
```

## Open CLI

Parking Lot supports a CLI interface to manually interact with the program. Run the following to open a CLI interface.

```
bin/parking_lot
```

## Use via Input Files

Parking Lot also supports usage via an input file. It will parse the fill and output the result on console. Usage : 

```
bin/parking_lot <input_file_location>
```

## Built With

* [Rspec](https://github.com/rspec/rspec-rails) - Testing Framework
* [simplecov](https://github.com/colszowka/simplecov) - Test Coverage Analysis
* [faker](https://rometools.github.io/rome/) - Gem to aid in writing tests








