class ParkingLot

  attr_reader :total_capacity

  def initialize(capacity)
    @total_capacity = capacity
  end

  def park!(car)
    raise MaxCapacityError unless can_park?
    raise DuplicateParkingError if car_parked?(car)
    ticket = Ticket.issue_ticket!(car)
    return ticket
  end

  def unpark!(ticket_id)
    raise NotFoundError unless Ticket.valid_ticket?(ticket_id)
    ticket = Ticket.fetch_ticket!(ticket_id)
    ticket.forfeit_ticket!
  end

  def status
    parking_lot_status_data = []
    Ticket.active_ticket_pool.each do |ticket_id, ticket|
      ticket_data = []
      ticket_data<<ticket.parked_slot.slot_number
      ticket_data<<ticket.parked_slot.car.registration_number
      ticket_data<<ticket.parked_slot.car.colour
      parking_lot_status_data<<ticket_data
    end
    return parking_lot_status_data
  end

  def get_parked_slot_number!(car_registration_no)
    return Ticket.get_issued_ticket_for_car!(car_registration_no)
  end

  def get_registration_numbers_for_colour(colour)
    return Ticket.active_tickets_for_car_colour(colour).map{ |ticket| ticket.parked_slot.car.registration_number }
  end

  def get_slot_numbers_for_colour(colour)
    return Ticket.active_tickets_for_car_colour(colour).map{ |ticket| ticket.parked_slot.slot_number }
  end

  def current_capacity
    return Ticket.tickets_currently_issued
  end

  def can_park?
    return current_capacity < @total_capacity
  end

  def car_parked?(car)
    Ticket.ticket_issued?(car)
  end

  def self.reset_parking_lot
    Ticket.reset_active_ticket_pool
    Slot.reset_slot_numbers_pool
  end

end