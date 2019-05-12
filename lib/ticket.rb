class Ticket

  attr_reader :parked_car, :parking_lot_slot

  def initialize(car, slot)
    @parked_car = car
    @parking_lot_slot = slot
  end

end