require 'byebug'
RSpec.describe Command::Processor do

  let(:command_processor) { Command::Processor.new }
  let(:commands) { 
    [
      "create_parking_lot 6",
      "park KA-01-HH-1234 White",
      "park KA-01-HH-9999 White",
      "park KA-01-BB-0001 Black",
      "park KA-01-HH-7777 Red",
      "park KA-01-HH-2701 Blue",
      "park KA-01-HH-3141 Black",
      'leave 4',
      'park KA-01-P-333 White',
      'park DL-12-AA-9999 White',
      'registration_numbers_for_cars_with_colour White',
      'slot_numbers_for_cars_with_colour White',
      'slot_number_for_registration_number KA-01-HH-3141',
      'slot_number_for_registration_number MH-04-AY-1111'
    ] 
  }
  let(:outputs) {
    [
      "Created a parking lot with 6 slots",
      "Allocated slot number: 1",
      "Allocated slot number: 2",
      "Allocated slot number: 3",
      "Allocated slot number: 4",
      "Allocated slot number: 5",
      "Allocated slot number: 6",
      "Slot number 4 is free",
      "Allocated slot number: 4",
      "Sorry, parking lot is full",
      "KA-01-HH-1234, KA-01-HH-9999, KA-01-P-333",
      "1, 2, 4",
      "6",
      "Not found"
    ]
  }
  it "Processes raw instructions" do
    (0..commands.length-1).each do |index|
      output = command_processor.process!(commands[index])
      expect(output.strip).to be == (outputs[index])
    end
  end

  it "Raises error when Parking Lot is created more than one time" do
    command_processor.process!("create_parking_lot 6")
    output = command_processor.process!("create_parking_lot 6")
    expect(output).to be == "Parking Lot is already initialized"
  end

  it "Raises error when car is parked before Parking Lot is created" do
    output = command_processor.process!("park KA-01-HH-3141 Black")
    expect(output).to be == "Parking Lot has not been created. Create it first"
  end

  it "Raises error when wrong arguments are given as input" do
    command_processor.process!("create_parking_lot 6")
    output = command_processor.process!("park KA-01-HH-3141")
    expect(output).to be == "Invalid Command. Please try again"
  end

  it "Raises error when wrong commands are given as input" do
    output = command_processor.process!("create_parking_welot 6")
    expect(output).to be == "Invalid Command. Please try again"
  end

end