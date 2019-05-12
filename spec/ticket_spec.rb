require 'ticket'
require 'slot'
require 'car'
require 'faker'
RSpec.describe Ticket do

  def unique_registration_number
    return Faker::Name.initials(2).to_s+'-'+Faker::Number.between(0, 99).to_s+'-'+Faker::Name.initials(2).to_s+'-'+Faker::Number.number(4).to_s 
  end

  def pick_colour
    Faker::Color.color_name.capitalize
  end

  let(:car) { Car.new(unique_registration_number, pick_colour) }

  describe "Issuing a Ticket" do
    before(:each) do 
      Ticket.reset_active_ticket_pool
    end

    it "A ticket is issued to a car which is being parked" do
      ticket = Ticket.issue_ticket!(car)
      expect(ticket).to be
      expect(ticket).to be_an_instance_of(Ticket)
    end

    it "Active Ticket Pool (ATP) size increases when a ticket is issued" do
      expect(Ticket.active_ticket_pool).to be_an_instance_of(Hash)
      expect(Ticket.active_ticket_pool_size).to eql(0)
      ticket = Ticket.issue_ticket!(car)
      expect(Ticket.active_ticket_pool_size).to eql(1)
    end

    it "Ticket being issued is maintained in Active Ticket Pool (ATP)" do
      ticket = Ticket.issue_ticket!(car)
      expect(Ticket.active_ticket_pool).to have_key(ticket.ticket_id)
      expect(Ticket.active_ticket_pool[ticket.ticket_id]).to equal(ticket)
    end

    it "A slot is occupied when a ticket is issued" do
      ticket = Ticket.issue_ticket!(car)
      expect(ticket.parked_slot).to be_an_instance_of(Slot)
      expect(ticket.parked_slot.vacant?).to be false
      expect(ticket.parked_slot.slot_number).to be
    end

  end

  describe "Forfeiting a Ticket" do
    before(:each) do 
      Ticket.reset_active_ticket_pool
    end

    it "Ticket being forfeited is removed from Active Ticket Pool (ATP)" do
      ticket = Ticket.issue_ticket!(car)
      expect(Ticket.active_ticket_pool).to have_key(ticket.ticket_id)
      ticket.forfeit_ticket!
      expect(Ticket.active_ticket_pool).to_not have_key(ticket.ticket_id)
    end

    it "Active Ticket Pool (ATP) size decreases when a ticket is forfeited" do
      ticket = Ticket.issue_ticket!(car)
      expect(Ticket.active_ticket_pool_size).to eql(1)
      ticket.forfeit_ticket!
      expect(Ticket.active_ticket_pool_size).to eql(0)
    end

    it "A slot is freed and the car is unparked when a ticket is forfeited" do
      slot_number_issued = Slot.peek_next_slot_number
      ticket = Ticket.issue_ticket!(car)
      expect(Slot.peek_next_slot_number).to_not eql(ticket.parked_slot.slot_number)
      expect(slot_number_issued).to eql(ticket.parked_slot.slot_number)
      ticket.forfeit_ticket!
      expect(Slot.peek_next_slot_number).to eql(slot_number_issued)
      expect(ticket.parked_slot).to be nil
    end

    it "Invalidates the ticket" do
      ticket = Ticket.issue_ticket!(car)
      expect(ticket.validity?).to be (true)
      ticket.forfeit_ticket!
      expect(ticket.validity?).to be (false)
    end

  end

  describe "Ticket Id" do

    it "Ticket Id is generated when a ticket is issued" do
      ticket = Ticket.issue_ticket!(car)
      expect(ticket.ticket_id).to be 
    end

    it "Ticket Id is equal to the slot number where car is parked" do
      ticket = Ticket.issue_ticket!(car)
      expect(ticket.ticket_id).to eql(ticket.parked_slot.slot_number)
      expect(ticket.ticket_id).to eql(Slot.peek_next_slot_number-1)
    end

    it "Ticket Id is Nil when a ticket is forfeited" do
      ticket = Ticket.issue_ticket!(car)
      ticket.forfeit_ticket!
      expect(ticket.ticket_id).to be nil
    end 

  end

  describe "Fetching Tickets" do
    before(:each) do 
      Ticket.reset_active_ticket_pool
    end

    it "A ticket can be fetched by a ticket id" do
      ticket = Ticket.issue_ticket!(car)
      expect(ticket).to be == (Ticket.fetch_ticket!(ticket.ticket_id))
    end

    it "All tickets assigned to cars of a particular colour can be fetched" do
      color_map = {}
      (1..1000).each do |i|
        car = Car.new(unique_registration_number, pick_colour)
        color_map[car.colour]||=[]
        color_map[car.colour] << Ticket.issue_ticket!(car)
      end
      color_map.each do |key, value|
        expected_list_of_car_registration_nos = color_map[key].map{ |ticket| ticket.parked_slot.car.registration_number }
        expected_list_of_slot_numbers = color_map[key].map{ |ticket| ticket.parked_slot.slot_number }

        actual_list_of_car_registration_nos = Ticket.active_tickets_for_car_colour(key).map{ |ticket| ticket.parked_slot.car.registration_number }
        actual_list_of_slot_numbers = Ticket.active_tickets_for_car_colour(key).map{ |ticket| ticket.parked_slot.slot_number }

        expect(actual_list_of_car_registration_nos).to be == expected_list_of_car_registration_nos
        expect(actual_list_of_slot_numbers).to be == expected_list_of_slot_numbers
      end
    end

  end

end