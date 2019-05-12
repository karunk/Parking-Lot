require 'car'
require 'slot'
require 'faker'
RSpec.describe Slot do

  describe 'slot number assignment' do
    before(:each) do 
      Slot.reset_slot_numbers_pool
    end

    it 'each slot is issued a slot number' do
      slot = Slot.new
      expect(slot.slot_number).to eql(1)
    end

    it 'each slot is issued a slot number in ascending order' do
      (1..Faker::Number.between(1, 500)).each do |i|
        slot = Slot.new
        expect(slot.slot_number).to eql(i)
      end
    end

    it 'slot number pool is replenished automatically after exhaustion' do
      (1..100).each do |i|
        slot = Slot.new
      end
      expect(Slot.peek_next_slot_number).to be_nil
      (101..1000).each do |i|
        slot = Slot.new
      end
      expect(Slot.peek_next_slot_number).to be_nil
      slot = Slot.new
      expect(Slot.peek_next_slot_number).to eql(1002)
    end

    it 'lowest slot number is assigned at all times' do
      assigned_slots = [nil]
      (1..150).each do |i|
        slot = Slot.new
        assigned_slots<<slot
      end
      assigned_slots[5].unpark!
      expect(Slot.peek_next_slot_number).to eql(5)
      slot = Slot.new
      expect(slot.slot_number).to eql(5)
      assigned_slots[77].unpark!
      assigned_slots[98].unpark!
      assigned_slots[34].unpark!
      next_three_slot_numbers = [34, 77, 98]
      next_three_slot_numbers.each do |slot_number|
        slot = Slot.new
        expect(slot.slot_number).to eql(slot_number)
      end
      expect(Slot.peek_next_slot_number).to eql(151)
    end

  end

  describe 'parking a car' do
    before(:each) do 
      Slot.reset_slot_numbers_pool
    end

    it 'marked as not vacant after parking' do
      slot = Slot.new
      car = Car.new('KA-01-HH-1233433332', 'White')
      slot.park!(car)
      expect(slot.vacant?).to be false
    end

    it 'marked as vacant after unparking' do
      slot = Slot.new
      car = Car.new('KA-01-HH-1233433332', 'White')
      slot.park!(car)
      slot.unpark!
      expect(slot.vacant?).to be true
    end

    it 'is initially vacant' do
      slot = Slot.new
      expect(slot.vacant?).to be true
    end
  end

end