require 'parking_lot'

RSpec.describe ParkingLot do

  def unique_registration_number
    return Faker::Name.initials(2).to_s+'-'+Faker::Number.between(0, 99).to_s+'-'+Faker::Name.initials(2).to_s+'-'+Faker::Number.number(4).to_s 
  end

  def pick_colour
    Faker::Color.color_name.capitalize
  end

  let(:parking_lot_capacity) { Faker::Number.between(1, 1000) }
  let(:car) { Car.new(unique_registration_number, pick_colour) }

  describe "Parking Lot Capacity" do
    before(:each) do 
      ParkingLot.reset_parking_lot
    end

    it "Parking Lot has a defined maximum capacity" do
      parking_lot = ParkingLot.new(parking_lot_capacity)
      expect(parking_lot.total_capacity).to eq(parking_lot_capacity)
    end

    it "Parking Lot current capacity is incremented everytime a car is parked" do
      parking_lot = ParkingLot.new(parking_lot_capacity)
      previous_parking_lot_current_capcity = parking_lot.current_capacity
      parking_lot.park!(car)
      expect(parking_lot.current_capacity).to eq(previous_parking_lot_current_capcity+1)
    end

    it "Parking Lot current capacity is decremented everytime a car is unparked" do
      parking_lot = ParkingLot.new(parking_lot_capacity)
      ticket = parking_lot.park!(car)
      previous_parking_lot_current_capcity = parking_lot.current_capacity
      parking_lot.unpark!(ticket.ticket_id)
      expect(parking_lot.current_capacity).to eq(previous_parking_lot_current_capcity-1)
    end

    it "Parking more cars than maximum capacity raises an exception" do
      parking_lot = ParkingLot.new(parking_lot_capacity)
      (1..parking_lot_capacity).each do |i|
        car = Car.new(unique_registration_number, pick_colour)
        parking_lot.park!(car)
      end
      expect{ parking_lot.park!(car) }.to raise_error(StandardError, "Sorry, parking lot is full")
    end

  end

  describe "Parking Lot Status" do
    before(:each) do 
      ParkingLot.reset_parking_lot
    end

    it "Gives information about all the cars parked in the parking lot" do 
      parking_lot = ParkingLot.new(parking_lot_capacity)
      expected_status_data = []
      (1..parking_lot_capacity).each do |i|
        car = Car.new(unique_registration_number, pick_colour)
        tmp_data = [i, car.registration_number, car.colour]
        expected_status_data<<tmp_data
        parking_lot.park!(car)
      end
      expect(parking_lot.status).to be
      expect(parking_lot.status).to be == (expected_status_data)
    end
  end

  describe "Parking Lot Queries" do
    before(:each) do 
      ParkingLot.reset_parking_lot
    end

    it "Reports the parked slot number when a car is actually parked" do
      parking_lot = ParkingLot.new(parking_lot_capacity)
      (1..parking_lot_capacity).each do |i|
        car = Car.new(unique_registration_number, pick_colour)
        ticket = parking_lot.park!(car)
        expect(parking_lot.get_parked_slot_number!(car.registration_number)).to eql(ticket.parked_slot.slot_number)
      end
    end

    it "Raises an exception when no such car with give registration number is parked in the lot" do
      parking_lot = ParkingLot.new(parking_lot_capacity)
      expect{ parking_lot.get_parked_slot_number!(car.registration_number) }.to raise_error(StandardError, "Not found")
    end

    it "Reports all the registration numbers of all cars of a particular colour" do
      parking_lot = ParkingLot.new(parking_lot_capacity)
      colour_hash = {}
      (1..parking_lot_capacity).each do |i|
        car = Car.new(unique_registration_number, pick_colour)
        colour_hash[car.colour]||=[]
        colour_hash[car.colour]<<car.registration_number
        parking_lot.park!(car)
      end
      colour_hash.each do |colour, registration_numbers|
        expect(parking_lot.get_registration_numbers_for_colour(colour)).to be == (registration_numbers)
      end
    end

    it "Reports all the slot numbers of all cars of a particular colour" do
      parking_lot = ParkingLot.new(parking_lot_capacity)
      colour_hash = {}
      (1..parking_lot_capacity).each do |i|
        car = Car.new(unique_registration_number, pick_colour)
        colour_hash[car.colour]||=[]
        ticket_id = parking_lot.park!(car).ticket_id
        colour_hash[car.colour]<<ticket_id
      end
      colour_hash.each do |colour, slot_numbers|
        expect(parking_lot.get_slot_numbers_for_colour(colour)).to be == (slot_numbers)
      end
    end

  end

  describe "Parking in the Parking Lot" do
    before(:each) do 
      ParkingLot.reset_parking_lot
    end

    it "Raises an exception when an already parked car is parked again" do
      parking_lot = ParkingLot.new(parking_lot_capacity)
      ticket_id = parking_lot.park!(car).ticket_id
      expect{ parking_lot.park!(car) }.to raise_error(StandardError, "Sorry, a car with the same registration_number is already parked")
    end

    it "Parks the car and reflects it in all the Parking Lot queries" do
      parking_lot = ParkingLot.new(parking_lot_capacity)
      ticket = parking_lot.park!(car)
      ticket_id = ticket.ticket_id
      expect(parking_lot.get_parked_slot_number!(car.registration_number)).to eql(ticket.parked_slot.slot_number)
      expect(parking_lot.get_registration_numbers_for_colour(car.colour)).to include(car.registration_number)
      expect(parking_lot.get_slot_numbers_for_colour(car.colour)).to include(ticket_id)
    end
  end

  describe "Unparking in the Parking Lot" do
    before(:each) do 
      ParkingLot.reset_parking_lot
    end

    it "Raises an exception when an already unparked car is unparked again" do
      parking_lot = ParkingLot.new(parking_lot_capacity)
      ticket_id = parking_lot.park!(car).ticket_id
      parking_lot.unpark!(ticket_id)
      expect{ parking_lot.unpark!(ticket_id) }.to raise_error(StandardError, "Not found")
    end

    it "Unparks the car and reflects it in all the Parking Lot queries" do
      parking_lot = ParkingLot.new(parking_lot_capacity)
      ticket_id = parking_lot.park!(car).ticket_id
      parking_lot.unpark!(ticket_id)
      expect{parking_lot.get_parked_slot_number!(car.registration_number)}.to raise_error(StandardError, "Not found")
      expect(parking_lot.get_registration_numbers_for_colour(car.colour)).not_to include(car.registration_number)
      expect(parking_lot.get_slot_numbers_for_colour(car.colour)).not_to include(ticket_id)
    end
    
  end



end