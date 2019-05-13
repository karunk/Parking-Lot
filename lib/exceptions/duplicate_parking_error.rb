class DuplicateParkingError < StandardError

  def initialize(msg='Sorry, a car with the same registration_number is already parked')
    super
  end

end

