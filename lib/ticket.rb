class Ticket

  attr_accessor :parked_slot

  @@active_ticket_pool = {}
  @@tickets_car_colour_map = {}

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

  def parked_car
    @parked_slot.car
  end

  def ticket_id
    self.validity? ? @parked_slot.slot_number : nil
  end

  def forfeit_ticket!
    @@active_ticket_pool.delete(self.ticket_id)
    @@tickets_car_colour_map[parked_car.colour].delete(self.ticket_id)
    @parked_slot.unpark!
    @parked_slot = nil
  end

  def validity?
    !@parked_slot.nil?
  end

  private

  def initialize(parked_slot)
    @parked_slot = parked_slot
    @@active_ticket_pool[self.ticket_id] = self
    @@tickets_car_colour_map[parked_car.colour]||= [] 
    @@tickets_car_colour_map[parked_car.colour]<<self.ticket_id
  end

  def self.reset_active_ticket_pool
    @@active_ticket_pool = {}
    @@tickets_car_colour_map = {}
  end
end



