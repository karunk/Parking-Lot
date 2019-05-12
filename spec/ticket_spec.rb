require 'ticket'
require 'slot'
require 'car'
require 'faker'

RSpec.describe Ticket do

  def unique_registration_number
    return Faker::Name.initials(2).to_s+'-'+Faker::Number.between(0, 99).to_s+'-'+Faker::Name.initials(2).to_s+'-'+Faker::Number.number(4).to_s 
  end

  let(:colour) { Faker::Color.color_name.capitalize }
  let(:registration_number) { unique_registration_number }
  let(:car) { Car.new(registration_number, colour) }
  let(:slot) { Slot.new }
  subject { Ticket.new(car, slot) }

  it "to identify a parked car and a parking lot slot" do
    expect(subject.parked_car).to be_instance_of(Car)
    expect(subject.parked_car).to equal(car)

    expect(subject.parking_lot_slot).to be_instance_of(Slot)
    expect(subject.parking_lot_slot).to equal(slot)
  end

end