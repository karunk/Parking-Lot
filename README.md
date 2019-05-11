# The Parking Lot

Implementing the parking lot in Ruby in the most beautiful object oriented way possible.

## Functionality Supported

The parking lot will be able to handle the following types of queries and respond in a fashion, as demonstrated by the following exhaustive examples : -



#### 1. Creating a parking lot with a particular capacity
`create_parking_lot 6`

#### 2. Park a car with it's registration number and colour specified
`park KA-01-HH-1234 White`

#### 3. Unpark a car which was parked at a particular slot number
`leave 4`

#### 4. Get the big picture status of the Parking Lot
`status`

#### 5. List all car registration numbers where the car colour is as specified
`registration_numbers_for_cars_with_colour White`

#### 6. List all the slot numbers where the parked car is of the colour specified
`slot_numbers_for_cars_with_colour White`
 
#### 7. Get the slot number where a car with the specified registration number is parked
`slot_number_for_registration_number KA-01-HH-3141`	



## Design
The parking lot has **5 entities** which interact to solve the task of parking a car.

#### 1. The Parking Lot Manager (PLM)
* Translate human commands into actionables on the parking lot
* Translate data from the parking lot to human readable output
* Translate human readable data into something which is understood by the parking lot
* Create a new parking lot
* Only interact with the ticket, the parking lot and the car 

#### 2. The Parking Lot
* Park the car
* Unpark the car
* Query the cars parked

#### 3. The Car
* Has information about the car

#### 4. The Ticket
* Has information about the car and the assigned slot in the parking lot

#### 5. The Slot
* Park the car in the slot
* Unpark the car from the slot




