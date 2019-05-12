class Ticket

  attr_accessor :parked_slot

  @@active_ticket_pool = {}
  @@tickets_car_colour_map = {}
  @@ticket_car_map = {}

  def self.issue_ticket!(car)
    slot = Slot.new
    slot.park!(car)
    ticket = Ticket.new(slot)
    return ticket
  end

  def self.active_tickets_for_car_colour(colour)
    return @@tickets_car_colour_map[colour].map{ |ticket_id| fetch_ticket!(ticket_id) }
  end

  def self.fetch_ticket!(ticket_id)
    return @@active_ticket_pool[ticket_id]
  end

  def self.active_ticket_pool
    return @@active_ticket_pool
  end

  def self.active_ticket_pool_size
    return @@active_ticket_pool.length
  end

  def self.tickets_currently_issued
    self.active_ticket_pool_size
  end

  def self.valid_ticket?(ticket_id)
    return @@active_ticket_pool.key?(ticket_id)
  end

  def self.ticket_issued?(car)
    @@ticket_car_map.key?(car.registration_number)
  end

  def parked_car
    @parked_slot.car
  end

  def ticket_id
    self.validity? ? @parked_slot.slot_number : nil
  end

  def forfeit_ticket!
    @@active_ticket_pool.delete(self.ticket_id)
    @@tickets_car_colour_map[parked_car.colour].delete(self.ticket_id)
    @@ticket_car_map.delete(parked_car.registration_number)
    @parked_slot.unpark!
    @parked_slot = nil
  end

  def validity?
    !@parked_slot.nil?
  end

  def self.get_issued_ticket_for_car!(car_registration_number)
    raise StandardError.new('Not found') unless @@ticket_car_map.key?(car_registration_number)
    return @@ticket_car_map[car_registration_number]
  end

  private

  def initialize(parked_slot)
    @parked_slot = parked_slot
    @@active_ticket_pool[self.ticket_id] = self
    @@tickets_car_colour_map[parked_car.colour]||= [] 
    @@tickets_car_colour_map[parked_car.colour]<<self.ticket_id
    @@ticket_car_map[parked_slot.car.registration_number] = self.ticket_id
  end

  def self.reset_active_ticket_pool
    @@active_ticket_pool = {}
    @@tickets_car_colour_map = {}
    @@ticket_car_map = {}
  end

end



