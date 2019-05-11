# The Parking Lot

Implementing the parking lot in Ruby in the most beautiful object oriented way possible.

## Functionality Supported

The parking lot will be able to handle the following types of queries and respond in a fashion, as demonstrated by the following exhaustive examples : -



#### Creating a parking lot with a particular capacity
	`create_parking_lot 6`

#### Park a car with it's registration number and colour specified
	`park KA-01-HH-1234 White`

#### Unpark a car which was parked at a particular slot number
	`leave 4`

#### Get the big picture status of the Parking Lot
	`status`

#### List all car registration numbers where the car colour is as specified
	`registration_numbers_for_cars_with_colour White`

#### List all the slot numbers where the parked car is of the colour specified
	`slot_numbers_for_cars_with_colour White`
 
#### Get the slot number where a car with the specified registration number is parked
	`slot_number_for_registration_number KA-01-HH-3141`	





