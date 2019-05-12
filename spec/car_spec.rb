require 'car'
require 'faker'

RSpec.describe Car do

  def unique_registration_number
  	return Faker::Name.initials(2).to_s+'-'+Faker::Number.between(0, 99).to_s+'-'+Faker::Name.initials(2).to_s+'-'+Faker::Number.number(4).to_s 
  end

  let(:colour) { Faker::Color.color_name.capitalize }
  let(:registration_number) { unique_registration_number }
  subject { Car.new(registration_number, colour) }

  it "to have a registration number and colour specified" do
  	expect(subject.registration_number).to eql(registration_number)
  	expect(subject.colour).to eql(colour)
  end

  it "to have car id specified" do
  	expect(subject.car_id).to be
  end

  it "to have registration number equal to car id" do
  	expect(subject.car_id).to eql(subject.registration_number)
  end

end