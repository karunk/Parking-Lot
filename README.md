# The Parking Lot 
### by Karun

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



### Design

The basic theme and objective for this design was to make the different entities in the parking lot as abstract as possible. All entities represent the different real world entites which makeup a real world simplistic parking lot.

* Parking Lot
  - Allows to park a car in a slot and assigns a ticket to the car
  - Collects a ticket and lets the car to be unparked from a slot
  - Maintains check on current occupation limit / capacity
  - Get slot number of parked car when car registration number is given
  - Run various queries on the active ticket pool
  
* Slot
  - Park car in a slot
  - Unpark car from the slot
  - Internally handles the assignment of proper slot number
  
* Car
  - For car information represntational purposes

* Ticket
  - Maintains an active ticket pool to help in various quries
  - Constructs a ticket based on slot assigned, car information

There are some other peripheral entities like CommandProcessor, Command Parser which have the responsibility of translating the user instructions to something which the Parking Lot entity can understand. 



