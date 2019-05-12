require 'min_heap'

class Slot

	attr_accessor :slot_number, :car

	@@slot_numbers_pool = MinHeap.new
	@@max_slot_number_issued = nil

	def self.peek_next_slot_number
    return @@slot_numbers_pool.peek_min
	end

  def initialize
  	self.car = nil
  	issue_slot_number
  end

  def park!(car)
  	self.car = car
  end

  def unpark!
  	self.car = nil
  	return_slot_number_to_pool
  end

  def vacant?
  	return self.car.nil?
  end

  private

	def issue_slot_number
		replenish_slot_number_pool if @@slot_numbers_pool.peek_min.nil?
		self.slot_number = @@slot_numbers_pool.extract_min
		@@max_slot_number_issued = @@max_slot_number_issued.nil? ? self.slot_number : [@@max_slot_number_issued, self.slot_number].max
	end

	def return_slot_number_to_pool
		@@slot_numbers_pool << self.slot_number
		self.slot_number = nil
	end

  def replenish_slot_number_pool
  	@@max_slot_number_issued = 0 if @@max_slot_number_issued.nil?
    for i in @@max_slot_number_issued+1..@@max_slot_number_issued+100
      @@slot_numbers_pool<<i
    end
  end

  def self.reset_slot_numbers_pool
  	@@slot_numbers_pool = MinHeap.new
  	@@max_slot_number_issued = nil
  end

end