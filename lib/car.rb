class Car

  attr_reader :registration_number, :colour, :car_id
  alias car_id registration_number

  def initialize(registration_number, colour)
    @registration_number = registration_number
    @colour = colour
  end

end