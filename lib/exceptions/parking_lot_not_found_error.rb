class ParkingLotNotFoundError < StandardError

  def initialize(msg='Parking Lot has not been created. Create it first')
    super
  end

end

